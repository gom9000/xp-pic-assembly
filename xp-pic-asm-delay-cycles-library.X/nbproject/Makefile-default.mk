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
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=lib
DEBUGGABLE_SUFFIX=
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=src/xp-delay-cycles-2500.asm src/xp-delay-cycles-10000.asm src/xp-delay-cycles-100000.asm src/xp-delay-cycles-1250000.asm src/xp-delay-cycles-25000.asm src/xp-delay-cycles-250000.asm src/xp-delay-cycles-2500000.asm src/xp-delay-cycles-5000.asm src/xp-delay-cycles-50000.asm src/xp-delay-cycles-500000.asm src/xp-delay-cycles-5000000.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/xp-delay-cycles-2500.o ${OBJECTDIR}/src/xp-delay-cycles-10000.o ${OBJECTDIR}/src/xp-delay-cycles-100000.o ${OBJECTDIR}/src/xp-delay-cycles-1250000.o ${OBJECTDIR}/src/xp-delay-cycles-25000.o ${OBJECTDIR}/src/xp-delay-cycles-250000.o ${OBJECTDIR}/src/xp-delay-cycles-2500000.o ${OBJECTDIR}/src/xp-delay-cycles-5000.o ${OBJECTDIR}/src/xp-delay-cycles-50000.o ${OBJECTDIR}/src/xp-delay-cycles-500000.o ${OBJECTDIR}/src/xp-delay-cycles-5000000.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/xp-delay-cycles-2500.o.d ${OBJECTDIR}/src/xp-delay-cycles-10000.o.d ${OBJECTDIR}/src/xp-delay-cycles-100000.o.d ${OBJECTDIR}/src/xp-delay-cycles-1250000.o.d ${OBJECTDIR}/src/xp-delay-cycles-25000.o.d ${OBJECTDIR}/src/xp-delay-cycles-250000.o.d ${OBJECTDIR}/src/xp-delay-cycles-2500000.o.d ${OBJECTDIR}/src/xp-delay-cycles-5000.o.d ${OBJECTDIR}/src/xp-delay-cycles-50000.o.d ${OBJECTDIR}/src/xp-delay-cycles-500000.o.d ${OBJECTDIR}/src/xp-delay-cycles-5000000.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/xp-delay-cycles-2500.o ${OBJECTDIR}/src/xp-delay-cycles-10000.o ${OBJECTDIR}/src/xp-delay-cycles-100000.o ${OBJECTDIR}/src/xp-delay-cycles-1250000.o ${OBJECTDIR}/src/xp-delay-cycles-25000.o ${OBJECTDIR}/src/xp-delay-cycles-250000.o ${OBJECTDIR}/src/xp-delay-cycles-2500000.o ${OBJECTDIR}/src/xp-delay-cycles-5000.o ${OBJECTDIR}/src/xp-delay-cycles-50000.o ${OBJECTDIR}/src/xp-delay-cycles-500000.o ${OBJECTDIR}/src/xp-delay-cycles-5000000.o

# Source Files
SOURCEFILES=src/xp-delay-cycles-2500.asm src/xp-delay-cycles-10000.asm src/xp-delay-cycles-100000.asm src/xp-delay-cycles-1250000.asm src/xp-delay-cycles-25000.asm src/xp-delay-cycles-250000.asm src/xp-delay-cycles-2500000.asm src/xp-delay-cycles-5000.asm src/xp-delay-cycles-50000.asm src/xp-delay-cycles-500000.asm src/xp-delay-cycles-5000000.asm


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f648a
MP_LINKER_DEBUG_OPTION=-r=ROM@0xF00:0xFFF -r=RAM@SHARE:0x70:0x70 -r=RAM@SHARE:0xF0:0xF0 -r=RAM@GPR:0x165:0x16F -r=RAM@SHARE:0x170:0x170 -r=RAM@SHARE:0x1F0:0x1F0
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/xp-delay-cycles-2500.o: src/xp-delay-cycles-2500.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-2500.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-2500.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-2500.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-2500.o\" \"src/xp-delay-cycles-2500.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-2500.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-2500.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-10000.o: src/xp-delay-cycles-10000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-10000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-10000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-10000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-10000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-10000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-10000.o\" \"src/xp-delay-cycles-10000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-10000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-10000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-100000.o: src/xp-delay-cycles-100000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-100000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-100000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-100000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-100000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-100000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-100000.o\" \"src/xp-delay-cycles-100000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-100000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-100000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-1250000.o: src/xp-delay-cycles-1250000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-1250000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-1250000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-1250000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-1250000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-1250000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-1250000.o\" \"src/xp-delay-cycles-1250000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-1250000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-1250000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-25000.o: src/xp-delay-cycles-25000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-25000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-25000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-25000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-25000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-25000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-25000.o\" \"src/xp-delay-cycles-25000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-25000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-25000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-250000.o: src/xp-delay-cycles-250000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-250000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-250000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-250000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-250000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-250000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-250000.o\" \"src/xp-delay-cycles-250000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-250000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-250000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-2500000.o: src/xp-delay-cycles-2500000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-2500000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-2500000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-2500000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-2500000.o\" \"src/xp-delay-cycles-2500000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-2500000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-2500000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-5000.o: src/xp-delay-cycles-5000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-5000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-5000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-5000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-5000.o\" \"src/xp-delay-cycles-5000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-5000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-5000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-50000.o: src/xp-delay-cycles-50000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-50000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-50000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-50000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-50000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-50000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-50000.o\" \"src/xp-delay-cycles-50000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-50000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-50000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-500000.o: src/xp-delay-cycles-500000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-500000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-500000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-500000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-500000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-500000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-500000.o\" \"src/xp-delay-cycles-500000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-500000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-500000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-5000000.o: src/xp-delay-cycles-5000000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-5000000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-5000000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-5000000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-5000000.o\" \"src/xp-delay-cycles-5000000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-5000000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-5000000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/src/xp-delay-cycles-2500.o: src/xp-delay-cycles-2500.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-2500.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-2500.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-2500.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-2500.o\" \"src/xp-delay-cycles-2500.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-2500.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-2500.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-10000.o: src/xp-delay-cycles-10000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-10000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-10000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-10000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-10000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-10000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-10000.o\" \"src/xp-delay-cycles-10000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-10000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-10000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-100000.o: src/xp-delay-cycles-100000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-100000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-100000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-100000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-100000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-100000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-100000.o\" \"src/xp-delay-cycles-100000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-100000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-100000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-1250000.o: src/xp-delay-cycles-1250000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-1250000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-1250000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-1250000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-1250000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-1250000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-1250000.o\" \"src/xp-delay-cycles-1250000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-1250000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-1250000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-25000.o: src/xp-delay-cycles-25000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-25000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-25000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-25000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-25000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-25000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-25000.o\" \"src/xp-delay-cycles-25000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-25000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-25000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-250000.o: src/xp-delay-cycles-250000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-250000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-250000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-250000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-250000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-250000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-250000.o\" \"src/xp-delay-cycles-250000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-250000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-250000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-2500000.o: src/xp-delay-cycles-2500000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-2500000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-2500000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-2500000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-2500000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-2500000.o\" \"src/xp-delay-cycles-2500000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-2500000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-2500000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-5000.o: src/xp-delay-cycles-5000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-5000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-5000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-5000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-5000.o\" \"src/xp-delay-cycles-5000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-5000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-5000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-50000.o: src/xp-delay-cycles-50000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-50000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-50000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-50000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-50000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-50000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-50000.o\" \"src/xp-delay-cycles-50000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-50000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-50000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-500000.o: src/xp-delay-cycles-500000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-500000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-500000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-500000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-500000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-500000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-500000.o\" \"src/xp-delay-cycles-500000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-500000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-500000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/xp-delay-cycles-5000000.o: src/xp-delay-cycles-5000000.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000000.o.d 
	@${RM} ${OBJECTDIR}/src/xp-delay-cycles-5000000.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/xp-delay-cycles-5000000.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/xp-delay-cycles-5000000.lst\" -e\"${OBJECTDIR}/src/xp-delay-cycles-5000000.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/xp-delay-cycles-5000000.o\" \"src/xp-delay-cycles-5000000.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/xp-delay-cycles-5000000.o"
	@${FIXDEPS} "${OBJECTDIR}/src/xp-delay-cycles-5000000.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: archive
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_AR} $(MP_EXTRA_AR_PRE) -c dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_AR} $(MP_EXTRA_AR_PRE) -c dist/${CND_CONF}/${IMAGE_TYPE}/xp-pic-asm-delay-cycles-library.X.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}     
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
