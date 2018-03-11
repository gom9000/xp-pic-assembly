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
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=src/task_100ms_action.asm src/task_10ms_action.asm src/task_1s_action.asm src/task_250ms_action.asm src/task_2ms_action.asm src/task_2s_action.asm src/task_500ms_action.asm src/task_50ms_action.asm src/xp-scheduler-library-test.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/task_100ms_action.o ${OBJECTDIR}/src/task_10ms_action.o ${OBJECTDIR}/src/task_1s_action.o ${OBJECTDIR}/src/task_250ms_action.o ${OBJECTDIR}/src/task_2ms_action.o ${OBJECTDIR}/src/task_2s_action.o ${OBJECTDIR}/src/task_500ms_action.o ${OBJECTDIR}/src/task_50ms_action.o ${OBJECTDIR}/src/xp-scheduler-library-test.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/task_100ms_action.o.d ${OBJECTDIR}/src/task_10ms_action.o.d ${OBJECTDIR}/src/task_1s_action.o.d ${OBJECTDIR}/src/task_250ms_action.o.d ${OBJECTDIR}/src/task_2ms_action.o.d ${OBJECTDIR}/src/task_2s_action.o.d ${OBJECTDIR}/src/task_500ms_action.o.d ${OBJECTDIR}/src/task_50ms_action.o.d ${OBJECTDIR}/src/xp-scheduler-library-test.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/task_100ms_action.o ${OBJECTDIR}/src/task_10ms_action.o ${OBJECTDIR}/src/task_1s_action.o ${OBJECTDIR}/src/task_250ms_action.o ${OBJECTDIR}/src/task_2ms_action.o ${OBJECTDIR}/src/task_2s_action.o ${OBJECTDIR}/src/task_500ms_action.o ${OBJECTDIR}/src/task_50ms_action.o ${OBJECTDIR}/src/xp-scheduler-library-test.o

# Source Files
SOURCEFILES=src/task_100ms_action.asm src/task_10ms_action.asm src/task_1s_action.asm src/task_250ms_action.asm src/task_2ms_action.asm src/task_2s_action.asm src/task_500ms_action.asm src/task_50ms_action.asm src/xp-scheduler-library-test.asm


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f648a
MP_LINKER_DEBUG_OPTION= 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/task_100ms_action.o: src/task_100ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_100ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_100ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_100ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_100ms_action.lst\" -e\"${OBJECTDIR}/src/task_100ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_100ms_action.o\" \"src/task_100ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_100ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_100ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_10ms_action.o: src/task_10ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_10ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_10ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_10ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_10ms_action.lst\" -e\"${OBJECTDIR}/src/task_10ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_10ms_action.o\" \"src/task_10ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_10ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_10ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_1s_action.o: src/task_1s_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_1s_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_1s_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_1s_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_1s_action.lst\" -e\"${OBJECTDIR}/src/task_1s_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_1s_action.o\" \"src/task_1s_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_1s_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_1s_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_250ms_action.o: src/task_250ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_250ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_250ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_250ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_250ms_action.lst\" -e\"${OBJECTDIR}/src/task_250ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_250ms_action.o\" \"src/task_250ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_250ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_250ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_2ms_action.o: src/task_2ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_2ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_2ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_2ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_2ms_action.lst\" -e\"${OBJECTDIR}/src/task_2ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_2ms_action.o\" \"src/task_2ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_2ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_2ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_2s_action.o: src/task_2s_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_2s_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_2s_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_2s_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_2s_action.lst\" -e\"${OBJECTDIR}/src/task_2s_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_2s_action.o\" \"src/task_2s_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_2s_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_2s_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_500ms_action.o: src/task_500ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_500ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_500ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_500ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_500ms_action.lst\" -e\"${OBJECTDIR}/src/task_500ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_500ms_action.o\" \"src/task_500ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_500ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_500ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_50ms_action.o: src/task_50ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_50ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_50ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_50ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_50ms_action.lst\" -e\"${OBJECTDIR}/src/task_50ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_50ms_action.o\" \"src/task_50ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_50ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_50ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-scheduler-library-test.o: src/xp-scheduler-library-test.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-scheduler-library-test.o.d 
	@${RM} ${OBJECTDIR}/src/xp-scheduler-library-test.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-scheduler-library-test.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-scheduler-library-test.lst\" -e\"${OBJECTDIR}/src/xp-scheduler-library-test.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-scheduler-library-test.o\" \"src/xp-scheduler-library-test.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-scheduler-library-test.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-scheduler-library-test.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/src/task_100ms_action.o: src/task_100ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_100ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_100ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_100ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_100ms_action.lst\" -e\"${OBJECTDIR}/src/task_100ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_100ms_action.o\" \"src/task_100ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_100ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_100ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_10ms_action.o: src/task_10ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_10ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_10ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_10ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_10ms_action.lst\" -e\"${OBJECTDIR}/src/task_10ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_10ms_action.o\" \"src/task_10ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_10ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_10ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_1s_action.o: src/task_1s_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_1s_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_1s_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_1s_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_1s_action.lst\" -e\"${OBJECTDIR}/src/task_1s_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_1s_action.o\" \"src/task_1s_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_1s_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_1s_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_250ms_action.o: src/task_250ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_250ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_250ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_250ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_250ms_action.lst\" -e\"${OBJECTDIR}/src/task_250ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_250ms_action.o\" \"src/task_250ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_250ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_250ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_2ms_action.o: src/task_2ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_2ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_2ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_2ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_2ms_action.lst\" -e\"${OBJECTDIR}/src/task_2ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_2ms_action.o\" \"src/task_2ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_2ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_2ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_2s_action.o: src/task_2s_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_2s_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_2s_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_2s_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_2s_action.lst\" -e\"${OBJECTDIR}/src/task_2s_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_2s_action.o\" \"src/task_2s_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_2s_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_2s_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_500ms_action.o: src/task_500ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_500ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_500ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_500ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_500ms_action.lst\" -e\"${OBJECTDIR}/src/task_500ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_500ms_action.o\" \"src/task_500ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_500ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_500ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/task_50ms_action.o: src/task_50ms_action.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/task_50ms_action.o.d 
	@${RM} ${OBJECTDIR}/src/task_50ms_action.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/task_50ms_action.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/task_50ms_action.lst\" -e\"${OBJECTDIR}/src/task_50ms_action.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/task_50ms_action.o\" \"src/task_50ms_action.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/task_50ms_action.o"
	@${FIXDEPS} "${OBJECTDIR}/src/task_50ms_action.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-scheduler-library-test.o: src/xp-scheduler-library-test.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-scheduler-library-test.o.d 
	@${RM} ${OBJECTDIR}/src/xp-scheduler-library-test.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-scheduler-library-test.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-scheduler-library-test.lst\" -e\"${OBJECTDIR}/src/xp-scheduler-library-test.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-scheduler-library-test.o\" \"src/xp-scheduler-library-test.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-scheduler-library-test.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-scheduler-library-test.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  ../xp-pic-asm-scheduler-library.X/dist/default/debug/xp-pic-asm-scheduler-library.X.lib  
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_SIMULATOR=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   ..\xp-pic-asm-scheduler-library.X\dist\default\debug\xp-pic-asm-scheduler-library.X.lib  
else
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  ../xp-pic-asm-scheduler-library.X/dist/default/production/xp-pic-asm-scheduler-library.X.lib 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-scheduler-library-test.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   ..\xp-pic-asm-scheduler-library.X\dist\default\production\xp-pic-asm-scheduler-library.X.lib  
endif


# Subprojects
.build-subprojects:
	cd /D ../xp-pic-asm-scheduler-library.X && ${MAKE}  -f Makefile CONF=default


# Subprojects
.clean-subprojects:
	cd /D ../xp-pic-asm-scheduler-library.X && rm -rf "build/default" "dist/default"

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
