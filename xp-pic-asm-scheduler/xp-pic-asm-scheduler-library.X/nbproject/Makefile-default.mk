#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=lib
DEBUGGABLE_SUFFIX=
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=lib
DEBUGGABLE_SUFFIX=
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=src/scheduler-init.asm src/scheduler-loop.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/scheduler-init.o ${OBJECTDIR}/src/scheduler-loop.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/scheduler-init.o.d ${OBJECTDIR}/src/scheduler-loop.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/scheduler-init.o ${OBJECTDIR}/src/scheduler-loop.o

# Source Files
SOURCEFILES=src/scheduler-init.asm src/scheduler-loop.asm



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f648a
MP_LINKER_DEBUG_OPTION= 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/scheduler-init.o: src/scheduler-init.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/scheduler-init.o.d 
	@${RM} ${OBJECTDIR}/src/scheduler-init.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/scheduler-init.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/scheduler-init.lst\" -e\"${OBJECTDIR}/src/scheduler-init.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/scheduler-init.o\" \"src/scheduler-init.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/scheduler-init.o"
	@${FIXDEPS} "${OBJECTDIR}/src/scheduler-init.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/scheduler-loop.o: src/scheduler-loop.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/scheduler-loop.o.d 
	@${RM} ${OBJECTDIR}/src/scheduler-loop.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/scheduler-loop.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/scheduler-loop.lst\" -e\"${OBJECTDIR}/src/scheduler-loop.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/scheduler-loop.o\" \"src/scheduler-loop.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/scheduler-loop.o"
	@${FIXDEPS} "${OBJECTDIR}/src/scheduler-loop.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/src/scheduler-init.o: src/scheduler-init.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/scheduler-init.o.d 
	@${RM} ${OBJECTDIR}/src/scheduler-init.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/scheduler-init.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/scheduler-init.lst\" -e\"${OBJECTDIR}/src/scheduler-init.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/scheduler-init.o\" \"src/scheduler-init.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/scheduler-init.o"
	@${FIXDEPS} "${OBJECTDIR}/src/scheduler-init.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/scheduler-loop.o: src/scheduler-loop.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/scheduler-loop.o.d 
	@${RM} ${OBJECTDIR}/src/scheduler-loop.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/scheduler-loop.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/scheduler-loop.lst\" -e\"${OBJECTDIR}/src/scheduler-loop.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/scheduler-loop.o\" \"src/scheduler-loop.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/scheduler-loop.o"
	@${FIXDEPS} "${OBJECTDIR}/src/scheduler-loop.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: archive
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_AR} $(MP_EXTRA_AR_PRE) -c dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_AR} $(MP_EXTRA_AR_PRE) -c dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
