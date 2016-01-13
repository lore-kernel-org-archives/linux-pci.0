Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Jan 2016 01:13:53 +0100
Message-ID: <CAJZ5v0hVieQ-1nT9rcOmSQfgNVpiB3wZMCyoCWT-sTunEu7_XA@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.5-rc1, part1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.5-rc1-1

to receive the first batch of power management and ACPI updates for
v4.5-rc1 with top-most commit a889f766dbb7d016b858e4dd157b06587fdb570f

 Merge branch 'powercap'

on top of commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc

 Linux 4.4

As far as the number of commits goes, ACPICA takes the lead
this time, followed by cpufreq and the device properties
framework changes.

The most significant new feature is the debugfs-based interface
to the ACPICA's AML debugger added in the previous cycle and
a new user space tool for accessing it.

On the cpufreq front, the core is updated to handle governors
more efficiently, particularly on systems where a single cpufreq
policy object is shared between multiple CPUs, and there are
quite a few changes in drivers (intel_pstate, cpufreq-dt etc).

The device properties framework is updated to handle built-in
(ie. included in the kernel itself) device properties better,
among other things by adding a fallback mechanism that will
allow drivers to provide default properties to be used in
case the plaform firmware doesn't provide the properties
expected by them.

The Operating Performance Points (OPP) framework gets new DT
bindings and debugfs support.

A new cpufreq driver for ST platforms is added and the ACPI
driver for AMD SoCs will now support the APM X-Gene ACPI I2C
device.

The rest is mostly fixes and cleanups all over.

Specifics:

 - Add a debugfs-based interface for interacting with the ACPICA's
   AML debugger introduced in the previous cycle and a new user
   space tool for that, fix some bugs related to the AML debugger
   and clean up the code in question (Lv Zheng, Dan Carpenter,
   Colin Ian King, Markus Elfring).

 - Update ACPICA to upstream revision 20151218 including a number
   of fixes and cleanups in the ACPICA core (Bob Moore, Lv Zheng,
   Labbe Corentin, Prarit Bhargava, Colin Ian King, David E Box,
   Rafael Wysocki).

   In particular, the previously added erroneous support for the
   _SUB object is dropped, the concatenate operator will support
   all ACPI objects now, the Debug Object handling is improved,
   the SuperName handling of parameters being control methods is
   fixed, the ObjectType operator handling is updated to follow
   ACPI 5.0A and the handling of CondRefOf and RefOf is updated
   accordingly, module-level code will be executed after loading
   each ACPI table now (instead of being run once after all tables
   containing AML have been loaded), the Operation Region handlers
   management is updated to fix some reported problems and a the
   ACPICA code in the kernel is more in line with the upstream
   now.

 - Update the ACPI backlight driver to provide information on
   whether or not it will generate key-presses for brightness
   change hotkeys and update some platform drivers (dell-wmi,
   thinkpad_acpi) to use that information to avoid sending double
   key-events to users pace for these, add new ACPI backlight
   quirks (Hans de Goede, Aaron Lu, Adrien Schildknecht).

 - Improve the ACPI handling of interrupt GPIOs (Christophe Ricard).

 - Fix the handling of the list of device IDs of device objects
   found in the ACPI namespace and add a helper for checking if
   there is a device object for a given device ID (Lukas Wunner).

 - Change the logic in the ACPI namespace scanning code to create
   struct acpi_device objects for all ACPI device objects found in
   the namespace even if _STA fails for them which helps to avoid
   device enumeration problems on Microsoft Surface 3 (Aaron Lu).

 - Add support for the APM X-Gene ACPI I2C device to the ACPI
   driver for AMD SoCs (Loc Ho).

 - Fix the long-standing issue with the DMA controller on Intel
   SoCs where ACPI tables have no power management support for
   the DMA controller itself, but it can be powered off automatically
   when the last (other) device on the SoC is powered off via ACPI
   and clean up the ACPI driver for Intel SoCs (acpi-lpss) after
   previous attempts to fix that problem (Andy Shevchenko).

 - Assorted ACPI fixes and cleanups (Andy Lutomirski, Colin Ian King,
   Javier Martinez Canillas, Ken Xue, Mathias Krause, Rafael Wysocki,
   Sinan Kaya).

 - Update the device properties framework for better handling of
   built-in properties, add support for built-in properties to
   the platform bus type, update the MFD subsystem's handling
   of device properties and add support for passing default
   configuration data as device properties to the intel-lpss MFD
   drivers, convert the designware I2C driver to use the unified
   device properties API and add a fallback mechanism for using
   default built-in properties if the platform firmware fails
   to provide the properties as expected by drivers (Andy Shevchenko,
   Mika Westerberg, Heikki Krogerus, Andrew Morton).

 - Add new Device Tree bindings to the Operating Performance Points
   (OPP) framework and update the exynos4412 DT binding accordingly,
   introduce debugfs support for the OPP framework (Viresh Kumar,
   Bartlomiej Zolnierkiewicz).

 - Migrate the mt8173 cpufreq driver to the new OPP bindings
   (Pi-Cheng Chen).

 - Update the cpufreq core to make the handling of governors
   more efficient, especially on systems where policy objects
   are shared between multiple CPUs (Viresh Kumar, Rafael Wysocki).

 - Fix cpufreq governor handling on configurations with
   CONFIG_HZ_PERIODIC set (Chen Yu).

 - Clean up the cpufreq core code related to the boost sysfs knob
   support and update the ACPI cpufreq driver accordingly (Rafael
   Wysocki).

 - Add a new cpufreq driver for ST platforms and corresponding
   Device Tree bindings (Lee Jones).

 - Update the intel_pstate driver to allow the P-state selection
   algorithm used by it to depend on the CPU ID of the processor it
   is running on, make it use a special P-state selection algorithm
   (with an IO wait time compensation tweak) on Atom CPUs based on
   the Airmont and Silvermont cores so as to reduce their energy
   consumption and improve intel_pstate documentation (Philippe
   Longepe, Srinivas Pandruvada).

 - Update the cpufreq-dt driver to support registering cooling
   devices that use the (P * V^2 * f) dynamic power draw formula
   where V is the voltage, f is the frequency and P is a constant
   coefficient provided by Device Tree and update the arm_big_little
   cpufreq driver to use that support (Punit Agrawal).

 - Assorted cpufreq driver (cpufreq-dt, qoriq, pcc-cpufreq,
   blackfin-cpufreq) updates (Andrzej Hajda, Hongtao Jia,
   Jacob Tanenbaum, Markus Elfring).

 - cpuidle core tweaks related to polling and measured_us
   calculation (Rik van Riel).

 - Removal of modularity from a few cpuidle drivers (clps711x,
   ux500, exynos) that cannot be built as modules in practice
   (Paul Gortmaker).

 - PM core update to prevent devices from being probed during
   system suspend/resume which is generally problematic and may
   lead to inconsistent behavior (Grygorii Strashko).

 - Assorted updates of the PM core and related code (Julia Lawall,
   Manuel Pégourié-Gonnard, Maruthi Bayyavarapu, Rafael Wysocki,
   Ulf Hansson).

 - PNP bus type updates (Christophe Le Roy, Heiner Kallweit).

 - PCI PM code cleanups (Jarkko Nikula, Julia Lawall).

 - cpupower tool updates (Jacob Tanenbaum, Thomas Renninger).

Thanks!


---------------

Aaron Lu (2):
      ACPI / scan: set status to 0 if _STA failed
      ACPI / video: Add a quirk to force acpi-video backlight on
SAMSUNG 530U4E/540U4E

Adrien Schildknecht (1):
      ACPI / video: driver must be registered before checking for keypresses

Andrew Morton (1):
      include/linux/property.h: fix build issues with gcc-4.4.4

Andrzej Hajda (1):
      cpufreq-dt: fix handling regulator_get_voltage() result

Andy Lutomirski (2):
      ACPI / bus: Tidy up _OSC error spacing
      ACPI / bus: Show _OSC UUID when _OSC fails

Andy Shevchenko (23):
      device property: always check for fwnode type
      device property: rename helper functions
      device property: refactor built-in properties support
      device property: keep single value inplace
      device property: improve readability of macros
      device property: return -EINVAL when property isn't found in ACPI
      device property: Fallback to secondary fwnode if primary misses
the property
      mfd: core: propagate device properties to sub devices drivers
      mfd: intel-lpss: Pass HSUART configuration via properties
      x86/platform/iosf_mbi: Remove duplicate definitions
      device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
      Revert "ACPI / LPSS: allow to use specific PM domain during ->probe()"
      ACPI / LPSS: allow to use specific PM domain during ->probe()
      ACPI / LPSS: do delay for all LPSS devices when D3->D0
      ACPI / LPSS: power on when probe() and otherwise when remove()
      device property: add spaces to PROPERTY_ENTRY_STRING macro
      device property: avoid allocations of 0 length
      ACPI / LPSS: override power state for LPSS DMA device
      dmaengine: dw: platform: power on device on shutdown
      dmaengine: dw: return immediately from IRQ when DMA isn't in use
      Revert "dmaengine: dw: platform: provide platform data for Intel"
      ACPI / LPSS: change 'does not have' to 'has' in comment
      PM / clk: don't leave clocks enabled when driver not bound

Bartlomiej Zolnierkiewicz (1):
      PM / OPP: Fix parsing of opp-microvolt and opp-microamp properties

Bob Moore (25):
      ACPICA: exmutex: General cleanup, restructured some code
      ACPICA: Core: Major update for code formatting, no functional changes
      ACPICA: Split interpreter tracing functions to a new file
      ACPICA: acpiexec: Add support for AML files containing multiple tables
      ACPICA: Disassembler/tools: Support for multiple ACPI tables in one file
      ACPICA: iasl/acpiexec: Update input file handling and verification
      ACPICA: Revert "acpi_get_object_info: Add support for ACPI 5.0
_SUB method."
      ACPICA: Add comment explaining _SUB removal
      ACPICA: acpiexec/acpinames: Update for error checking macros
      ACPICA: Concatenate operator: Add extensions to support all ACPI objects
      ACPICA: Debug Object: Cleanup output
      ACPICA: Debug object: Fix output for a NULL object
      ACPICA: Update for output of the Debug Object
      ACPICA: getopt: Comment update, no functional change
      ACPICA: Add new exception code, AE_IO_ERROR
      ACPICA: iasl/Disassembler: Support ASL ElseIf operator
      ACPICA: Parser: Add constants for internal namepath function
      ACPICA: Parser: Fix for SuperName method invocation
      ACPICA: Update parameter type for ObjectType operator
      ACPICA: Update internal #defines for ObjectType operator. No
functional change
      ACPICA: Update for CondRefOf and RefOf operators
      ACPICA: Cleanup code related to the per-table module level improvement
      ACPICA: Add "root node" case to the ACPI name repair code
      ACPICA: Add per-table execution of module-level code
      ACPICA: Update version to 20151218

Chen Yu (1):
      cpufreq: governor: Fix negative idle_time when configured with
CONFIG_HZ_PERIODIC

Christophe Le Roy (1):
      PNP: Add Broadwell to Intel MCH size workaround

Christophe RICARD (3):
      ACPI: Rename acpi_gsi_get_irq_type to acpi_dev_get_irq_type and
export symbol
      ACPI / gpio: Add irq_type when a GPIO is used as an interrupt
      ACPI / spi: attach GPIO IRQ from ACPI description to SPI device

Colin Ian King (4):
      ACPICA: Debugger: Remove unnecessary status check
      ACPICA: Tools: Add spacing and missing options in acpibin tool
      ACPI / SBS: fix inconsistent indenting inside if statement
      ACPI, PCI, irq: remove redundant check for null string pointer

Dan Carpenter (2):
      ACPI / debugger: remove some unneeded conditions
      ACPI / debugger: copy_to_user doesn't return errors

David E. Box (1):
      ACPICA: Fix SyncLevel support interaction with method auto-serialization

Hans de Goede (5):
      ACPI / video: Add a acpi_video_handles_brightness_key_presses() helper
      dell-wmi: Use acpi_video_handles_brightness_key_presses()
      thinkpad_acpi: Use acpi_video_handles_brightness_key_presses()
      ACPI / video: Add a module option to disable the reporting of keypresses
      ACPI / video: Add quirks for the Dell Vostro V131

Heikki Krogerus (2):
      device property: helper macros for property entry creation
      device property: the secondary fwnode needs to depend on the primary

Heiner Kallweit (1):
      PNP: respect PNP_DRIVER_RES_DO_NOT_CHANGE when detaching

Hongtao Jia (1):
      cpufreq: qoriq: Register cooling device based on device tree

Jacob Tanenbaum (3):
      cpupower: rework the "cpupower frequency-info" command
      cpupower: fix how "cpupower frequency-info" interprets latency
      cpufreq: pcc-cpufreq: update default value of cpuinfo_transition_latency

Jarkko Nikula (1):
      PCI / PM: Fix small typo in documentation

Javier Martinez Canillas (1):
      ACPI: Fix build errors due objects compiled unconditionally

Julia Lawall (2):
      PCI / PM: constify pci_platform_pm_ops structure
      powercap: constify powercap_zone_ops and
powercap_zone_constraint_ops structures

Ken Xue (1):
      ACPI / PM: Support D3 COLD device in old BIOS for ZPODD

LABBE Corentin (1):
      ACPICA: Add "const" to some functions that return fixed strings

Lee Jones (2):
      cpufreq: st: Provide runtime initialised driver for ST's platforms
      dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation

Loc Ho (2):
      ACPI / APD: Add APM X-Gene ACPI I2C device support
      i2c: dw: Add APM X-Gene ACPI I2C device support

Lukas Wunner (3):
      ACPI / scan: Fix acpi_bus_id_list bookkeeping
      ACPI / utils: Add acpi_dev_present()
      ACPI: Fix white space in a structure definition

Lv Zheng (19):
      ACPICA: Debugger: Convert some mechanisms to OSPM specific
      ACPICA: Debugger: Fix runtime stub issues of ACPI_DEBUGGER_EXEC
using different stub mechanism
      ACPI / debugger: Add IO interface to access debugger functionalities
      tools/power/acpi: Add userspace AML interface support
      ACPI / debugger: Add module support for ACPI debugger
      ACPI / debugger: Fix an issue a flag is modified without locking
      ACPI / debugger: Fix a redundant mutex unlock issue in acpi_aml_open()
      ACPICA: Linuxize: reduce divergences for 20151218 release
      ACPICA: Namespace: Fix wrong error log
      ACPICA: Debugger: reduce old external path format
      ACPICA: Namespace: Add scope information to the simple object
repair mechanism
      ACPICA: Namespace: Add String -> ObjectReference conversion support
      ACPICA: Events: Deploys acpi_ev_find_region_handler()
      ACPICA: Events: Uses common_notify for address space handlers
      ACPICA: Utilities: Reorder initialization code
      ACPICA: Events: Fix an issue that region object is re-attached
to another scope when it is already attached
      ACPICA: Events: Split acpi_ev_associate_reg_method() from region
initialization code
      ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure
no _REG evaluations can happen during OS early boot stages
      ACPICA: Events: Introduce ACPI_REG_DISCONNECT invocation to
acpi_ev_execute_reg_methods()

Manuel Pégourié-Gonnard (1):
      PM / core: fix typo in documentation

Markus Elfring (3):
      blackfin-cpufreq: Change return type of cpu_set_cclk() to that
of clk_set_rate()
      blackfin-cpufreq: Mark cpu_set_cclk() as static
      ACPICA: Debugger: Remove some unecessary NULL checks

Maruthi Bayyavarapu (1):
      PM / Domains: export symbols to add/remove devices from genpd

Mathias Krause (1):
      ACPI / PNP: constify device IDs

Mika Westerberg (6):
      device property: Take a copy of the property set
      driver core: platform: Add support for built-in device properties
      driver core: Do not overwrite secondary fwnode with NULL if it is set
      mfd: intel-lpss: Add support for passing device properties
      mfd: intel-lpss: Pass SDA hold time to I2C host controller driver
      i2c: designware: Convert to use unified device property API

Paul Gortmaker (3):
      drivers/cpuidle: make cpuidle-clps711x.c explicitly non-modular
      drivers/cpuidle: make cpuidle-ux500.c explicitly non-modular
      drivers/cpuidle: make cpuidle-exynos.c explicitly non-modular

Philippe Longepe (3):
      cpufreq: intel_pstate: Configurable algorithm to get target pstate
      cpufreq: intel_pstate: Account for non C0 time
      cpufreq: intel_pstate: Account for IO wait time

Pi-Cheng Chen (6):
      cpufreq: mt8173: add CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag
      cpufreq: mt8173: remove redundant regulator_get_voltage() call
      cpufreq: mt8173: check return value of regulator_get_voltage() call
      cpufreq: mt8173: Move resources allocation into ->probe()
      PM / OPP: Set cpu_dev->id in cpumask first
      cpufreq: mt8173: migrate to use operating-points-v2 bindings

Prarit Bhargava (1):
      ACPICA: acpi_get_sleep_type_data: Reduce warnings

Punit Agrawal (3):
      devicetree: bindings: Add optional dynamic-power-coefficient property
      cpufreq-dt: Supply power coefficient when registering cooling devices
      cpufreq: arm_big_little: Add support to register a cpufreq cooling device

Rafael J. Wysocki (10):
      MAINTAINERS: Add an entry for the PM core
      cpufreq: governor: Use lockless timer function
      PM / runtime: Add new helper for conditional usage count incrementation
      cpufreq: Make cpufreq_boost_supported() static
      cpufreq: acpi-cpufreq: Simplify boost-related code
      cpufreq: Simplify core code related to boost support
      ACPI / OSL: Add kerneldoc comments to memory mapping functions
      ACPICA: Drop Linux-specific waking vector functions
      ACPI / PCI: Simplify acpi_penalize_isa_irq()
      PM / sleep: Add support for read-only sysfs attributes

Rik van Riel (3):
      cpuidle,x86: increase forced cut-off for polling to 20us
      cpuidle,menu: use interactivity_req to disable polling
      cpuidle,menu: smooth out measured_us calculation

Sinan Kaya (2):
      ACPI, PCI, irq: remove interrupt count restriction
      ACPI, PCI, irq: remove interrupt number restriction

Srinivas Pandruvada (1):
      Documentation: cpufreq: intel_pstate: enhance documentation

Strashko, Grygorii (1):
      PM / sleep: prohibit devices probing during suspend/hibernation

Thomas Renninger (3):
      cpupower: Fix precedence issue
      cpupower: Provide STATIC variable in Makefile for debug builds
      cpupower: Do not analyse offlined cpus

Ulf Hansson (1):
      PM / runtime: Re-init runtime PM states at probe error and driver unbind

Viresh Kumar (16):
      PM / OPP: Add debugfs support
      PM / OPP: Add "opp-supported-hw" binding
      PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
      PM / OPP: Remove 'operating-points-names' binding
      PM / OPP: Rename OPP nodes as opp@<opp-hz>
      ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>
      PM / OPP: Add missing doc comments
      cpufreq: ondemand: Update sampling rate only for concerned policies
      cpufreq: ondemand: Work is guaranteed to be pending
      cpufreq: governor: Pass policy as argument to ->gov_dbs_timer()
      cpufreq: governor: initialize/destroy timer_mutex with 'shared'
      cpufreq: governor: replace per-CPU delayed work with timers
      cpufreq: ondemand: update update_sampling_rate() to make it more efficient
      PM / OPP: Parse 'opp-supported-hw' binding
      PM / OPP: Parse 'opp-<prop>-<name>' bindings
      PM / OPP: Use snprintf() instead of sprintf()

---------------

 Documentation/cpu-freq/intel-pstate.txt            | 241 ++++--
 Documentation/cpu-freq/pcc-cpufreq.txt             |   4 +-
 Documentation/devicetree/bindings/arm/cpus.txt     |  17 +
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  91 +++
 Documentation/devicetree/bindings/opp/opp.txt      | 132 +++-
 Documentation/power/pci.txt                        |   2 +-
 Documentation/power/runtime_pm.txt                 |   6 +
 MAINTAINERS                                        |  11 +
 arch/arm/boot/dts/exynos4412.dtsi                  |  28 +-
 arch/x86/Kconfig                                   |   3 +-
 arch/x86/include/asm/iosf_mbi.h                    |  51 +-
 arch/x86/platform/atom/punit_atom_debug.c          |   7 +-
 arch/x86/platform/intel-quark/imr.c                |  28 +-
 drivers/acpi/Kconfig                               |  17 +-
 drivers/acpi/Makefile                              |   9 +-
 drivers/acpi/acpi_apd.c                            |  16 +-
 drivers/acpi/acpi_dbg.c                            | 804 +++++++++++++++++++++
 drivers/acpi/acpi_lpss.c                           | 213 +++++-
 drivers/acpi/acpi_pnp.c                            |   2 +-
 drivers/acpi/acpi_video.c                          |  76 +-
 drivers/acpi/acpica/Makefile                       |   4 +-
 drivers/acpi/acpica/acapps.h                       |  58 +-
 drivers/acpi/acpica/acdebug.h                      |  41 +-
 drivers/acpi/acpica/acevents.h                     |  11 +-
 drivers/acpi/acpica/acglobal.h                     |   8 +-
 drivers/acpi/acpica/aclocal.h                      |  12 +-
 drivers/acpi/acpica/acmacros.h                     |  11 -
 drivers/acpi/acpica/acnamesp.h                     |  12 +-
 drivers/acpi/acpica/acobject.h                     |   7 +-
 drivers/acpi/acpica/acopcode.h                     |  10 +-
 drivers/acpi/acpica/acparser.h                     |   8 +-
 drivers/acpi/acpica/acutils.h                      |  26 +-
 drivers/acpi/acpica/amlcode.h                      |   5 +-
 drivers/acpi/acpica/dbcmds.c                       |  11 +-
 drivers/acpi/acpica/dbdisply.c                     |  96 ++-
 drivers/acpi/acpica/dbfileio.c                     | 123 +---
 drivers/acpi/acpica/dbinput.c                      | 122 +---
 drivers/acpi/acpica/dbnames.c                      |   2 +-
 drivers/acpi/acpica/dbstats.c                      |   1 +
 drivers/acpi/acpica/dbtest.c                       |   2 +-
 drivers/acpi/acpica/dbutils.c                      |   1 +
 drivers/acpi/acpica/dbxface.c                      |  93 +--
 drivers/acpi/acpica/dsargs.c                       |   7 +-
 drivers/acpi/acpica/dscontrol.c                    |  10 +-
 drivers/acpi/acpica/dsdebug.c                      |   5 +-
 drivers/acpi/acpica/dsfield.c                      |  39 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |  39 +-
 drivers/acpi/acpica/dsmthdat.c                     |  20 +-
 drivers/acpi/acpica/dsobject.c                     |  19 +-
 drivers/acpi/acpica/dsopcode.c                     |  21 +-
 drivers/acpi/acpica/dsutils.c                      |  45 +-
 drivers/acpi/acpica/dswexec.c                      |  35 +-
 drivers/acpi/acpica/dswload.c                      |  10 +-
 drivers/acpi/acpica/dswload2.c                     |  10 +-
 drivers/acpi/acpica/dswscope.c                     |   1 +
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   1 +
 drivers/acpi/acpica/evgpeutil.c                    |   1 +
 drivers/acpi/acpica/evhandler.c                    | 165 +++--
 drivers/acpi/acpica/evmisc.c                       |   5 +-
 drivers/acpi/acpica/evregion.c                     | 114 ++-
 drivers/acpi/acpica/evrgnini.c                     | 115 +--
 drivers/acpi/acpica/evxface.c                      |   9 +-
 drivers/acpi/acpica/evxfregn.c                     |  38 +-
 drivers/acpi/acpica/exconfig.c                     |   8 +-
 drivers/acpi/acpica/exconvrt.c                     |   9 +-
 drivers/acpi/acpica/excreate.c                     |  20 +-
 drivers/acpi/acpica/exdebug.c                      | 403 ++---------
 drivers/acpi/acpica/exdump.c                       |   6 +-
 drivers/acpi/acpica/exfield.c                      |  74 +-
 drivers/acpi/acpica/exfldio.c                      |  35 +-
 drivers/acpi/acpica/exmisc.c                       |  49 +-
 drivers/acpi/acpica/exmutex.c                      |  82 ++-
 drivers/acpi/acpica/exnames.c                      |   4 +-
 drivers/acpi/acpica/exoparg1.c                     |  33 +-
 drivers/acpi/acpica/exoparg2.c                     |  12 +-
 drivers/acpi/acpica/exoparg3.c                     |  25 +-
 drivers/acpi/acpica/exoparg6.c                     |   1 +
 drivers/acpi/acpica/exprep.c                       |  25 +-
 drivers/acpi/acpica/exregion.c                     |  13 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |  10 +-
 drivers/acpi/acpica/exresop.c                      |  43 +-
 drivers/acpi/acpica/exstore.c                      |  17 +-
 drivers/acpi/acpica/exstorob.c                     |   7 +-
 drivers/acpi/acpica/exsystem.c                     |   6 +-
 drivers/acpi/acpica/extrace.c                      | 377 ++++++++++
 drivers/acpi/acpica/exutils.c                      |   7 +-
 drivers/acpi/acpica/hwesleep.c                     |   4 +-
 drivers/acpi/acpica/hwgpe.c                        |   6 +-
 drivers/acpi/acpica/hwsleep.c                      |   4 +-
 drivers/acpi/acpica/hwxface.c                      |  24 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  97 +--
 drivers/acpi/acpica/nsconvert.c                    | 105 ++-
 drivers/acpi/acpica/nsdump.c                       |   5 +-
 drivers/acpi/acpica/nseval.c                       |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   3 +-
 drivers/acpi/acpica/nsload.c                       |  18 +-
 drivers/acpi/acpica/nsnames.c                      |   6 +-
 drivers/acpi/acpica/nsparse.c                      |   5 +-
 drivers/acpi/acpica/nsprepkg.c                     |  10 +-
 drivers/acpi/acpica/nsrepair.c                     |  19 +-
 drivers/acpi/acpica/nsrepair2.c                    |  24 +-
 drivers/acpi/acpica/nssearch.c                     |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   8 +-
 drivers/acpi/acpica/nsxfeval.c                     |   4 +-
 drivers/acpi/acpica/nsxfname.c                     |  39 +-
 drivers/acpi/acpica/nsxfobj.c                      |   6 +-
 drivers/acpi/acpica/psargs.c                       |  19 +-
 drivers/acpi/acpica/psloop.c                       |  12 +-
 drivers/acpi/acpica/psopcode.c                     | 606 ++++++++--------
 drivers/acpi/acpica/psparse.c                      |   8 +-
 drivers/acpi/acpica/psutils.c                      |   4 +-
 drivers/acpi/acpica/pswalk.c                       |   1 +
 drivers/acpi/acpica/rsaddr.c                       |   4 +-
 drivers/acpi/acpica/rscalc.c                       |  81 ++-
 drivers/acpi/acpica/rscreate.c                     |  32 +-
 drivers/acpi/acpica/rsdump.c                       |   6 +
 drivers/acpi/acpica/rslist.c                       |   9 +-
 drivers/acpi/acpica/rsmisc.c                       |  22 +-
 drivers/acpi/acpica/rsutils.c                      |  42 +-
 drivers/acpi/acpica/rsxface.c                      |   2 +-
 drivers/acpi/acpica/tbdata.c                       |   1 +
 drivers/acpi/acpica/tbinstal.c                     |   4 +-
 drivers/acpi/acpica/tbprint.c                      |   1 +
 drivers/acpi/acpica/tbutils.c                      |  10 +-
 drivers/acpi/acpica/tbxfload.c                     |   3 +-
 drivers/acpi/acpica/utaddress.c                    |   5 +-
 drivers/acpi/acpica/utcopy.c                       |  23 +-
 drivers/acpi/acpica/utdecode.c                     |  32 +-
 drivers/acpi/acpica/utdelete.c                     |   5 +-
 drivers/acpi/acpica/uterror.c                      |  10 +-
 drivers/acpi/acpica/utfileio.c                     | 334 ---------
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |  67 --
 drivers/acpi/acpica/utinit.c                       |   1 -
 drivers/acpi/acpica/utmath.c                       |  10 +-
 drivers/acpi/acpica/utmisc.c                       |  11 +-
 drivers/acpi/acpica/utmutex.c                      |  22 +-
 drivers/acpi/acpica/utnonansi.c                    |   4 +-
 drivers/acpi/acpica/utobject.c                     |  24 +-
 drivers/acpi/acpica/utosi.c                        |  11 +-
 drivers/acpi/acpica/utownerid.c                    |  12 +-
 drivers/acpi/acpica/utpredef.c                     |   6 +-
 drivers/acpi/acpica/utprint.c                      |  15 +-
 drivers/acpi/acpica/utresrc.c                      |   8 +-
 drivers/acpi/acpica/utstate.c                      |   3 +
 drivers/acpi/acpica/utstring.c                     |   9 +
 drivers/acpi/acpica/uttrack.c                      |  50 +-
 drivers/acpi/acpica/utxface.c                      |   2 -
 drivers/acpi/acpica/utxferror.c                    |   1 +
 drivers/acpi/acpica/utxfinit.c                     |  47 +-
 drivers/acpi/acpica/utxfmutex.c                    |   6 +-
 drivers/acpi/bus.c                                 |  10 +-
 drivers/acpi/gsi.c                                 |  21 +-
 drivers/acpi/internal.h                            |   8 +
 drivers/acpi/osl.c                                 | 277 ++++++-
 drivers/acpi/pci_irq.c                             |   3 -
 drivers/acpi/pci_link.c                            | 132 +++-
 drivers/acpi/property.c                            |  10 +-
 drivers/acpi/resource.c                            |  26 +
 drivers/acpi/sbs.c                                 |   6 +-
 drivers/acpi/scan.c                                |  24 +-
 drivers/acpi/sleep.c                               |   4 +-
 drivers/acpi/sleep.h                               |   6 +
 drivers/acpi/utils.c                               |  31 +
 drivers/acpi/video_detect.c                        |  17 +
 drivers/base/base.h                                |   2 +
 drivers/base/core.c                                |   5 +-
 drivers/base/dd.c                                  |  60 +-
 drivers/base/platform.c                            |  25 +
 drivers/base/power/clock_ops.c                     |   1 +
 drivers/base/power/common.c                        |   2 +-
 drivers/base/power/domain.c                        |   2 +
 drivers/base/power/main.c                          |  17 +
 drivers/base/power/opp/Makefile                    |   1 +
 drivers/base/power/opp/core.c                      | 336 ++++++++-
 drivers/base/power/opp/cpu.c                       |   3 +-
 drivers/base/power/opp/debugfs.c                   | 219 ++++++
 drivers/base/power/opp/opp.h                       |  53 +-
 drivers/base/power/power.h                         |   2 +
 drivers/base/power/runtime.c                       |  50 +-
 drivers/base/property.c                            | 495 ++++++++++---
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  24 +-
 drivers/cpufreq/arm_big_little.c                   |  41 ++
 drivers/cpufreq/blackfin-cpufreq.c                 |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |  14 +-
 drivers/cpufreq/cpufreq.c                          |  28 +-
 drivers/cpufreq/cpufreq_conservative.c             |   6 +-
 drivers/cpufreq/cpufreq_governor.c                 | 146 ++--
 drivers/cpufreq/cpufreq_governor.h                 |  18 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |  61 +-
 drivers/cpufreq/intel_pstate.c                     |  73 +-
 drivers/cpufreq/mt8173-cpufreq.c                   | 135 +++-
 drivers/cpufreq/pcc-cpufreq.c                      |   2 +
 drivers/cpufreq/qoriq-cpufreq.c                    |  24 +
 drivers/cpufreq/sti-cpufreq.c                      | 294 ++++++++
 drivers/cpuidle/cpuidle-clps711x.c                 |   8 +-
 drivers/cpuidle/cpuidle-exynos.c                   |   5 +-
 drivers/cpuidle/cpuidle-ux500.c                    |   5 +-
 drivers/cpuidle/governors/menu.c                   |   6 +-
 drivers/dma/dw/core.c                              |   9 +-
 drivers/dma/dw/platform.c                          |  29 +-
 drivers/gpio/gpiolib-acpi.c                        |  33 +-
 drivers/gpio/gpiolib.c                             |   4 +-
 drivers/gpio/gpiolib.h                             |   3 +-
 drivers/i2c/busses/i2c-designware-baytrail.c       |  17 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  51 +-
 drivers/mfd/intel-lpss-acpi.c                      |  19 +-
 drivers/mfd/intel-lpss-pci.c                       |  44 +-
 drivers/mfd/intel-lpss.c                           |  16 +-
 drivers/mfd/intel-lpss.h                           |   2 +
 drivers/mfd/mfd-core.c                             |   7 +
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci.c                                  |   4 +-
 drivers/pci/pci.h                                  |   2 +-
 drivers/platform/x86/dell-wmi.c                    |   6 +-
 drivers/platform/x86/thinkpad_acpi.c               |   2 +-
 drivers/pnp/driver.c                               |   6 +-
 drivers/pnp/quirks.c                               |   1 +
 drivers/powercap/intel_rapl.c                      |  14 +-
 drivers/powercap/powercap_sys.c                    |  18 +-
 drivers/spi/spi.c                                  |   3 +
 drivers/thermal/intel_quark_dts_thermal.c          |  61 +-
 drivers/thermal/intel_soc_dts_iosf.c               |  43 +-
 include/acpi/acexcep.h                             |   6 +-
 include/acpi/acpi_bus.h                            |   6 +-
 include/acpi/acpiosxf.h                            |  18 +-
 include/acpi/acpixf.h                              |  55 +-
 include/acpi/actypes.h                             |   6 +-
 include/acpi/platform/aclinux.h                    |   2 +
 include/acpi/platform/aclinuxex.h                  |  10 +
 include/acpi/video.h                               |   6 +
 include/linux/acpi.h                               |  72 ++
 include/linux/cpufreq.h                            |   6 -
 include/linux/device.h                             |   1 +
 include/linux/mfd/core.h                           |   5 +
 include/linux/platform_device.h                    |   5 +
 include/linux/pm_opp.h                             |  22 +
 include/linux/pm_runtime.h                         |   5 +
 include/linux/powercap.h                           |   4 +-
 include/linux/property.h                           | 107 ++-
 kernel/power/main.c                                |  17 +-
 kernel/power/power.h                               |   9 +
 tools/power/acpi/Makefile                          |  16 +-
 tools/power/acpi/common/getopt.c                   |   2 +
 .../acpi/os_specific/service_layers/oslibcfs.c     |   3 +
 tools/power/acpi/tools/acpidbg/Makefile            |  27 +
 tools/power/acpi/tools/acpidbg/acpidbg.c           | 438 +++++++++++
 tools/power/acpi/tools/acpidump/apfiles.c          |  13 +
 tools/power/cpupower/Makefile                      |  19 +
 tools/power/cpupower/bench/Makefile                |   8 +-
 tools/power/cpupower/utils/cpufreq-info.c          | 246 +++----
 tools/power/cpupower/utils/cpuidle-info.c          |  16 +-
 tools/power/cpupower/utils/cpupower-info.c         |   9 +-
 tools/power/cpupower/utils/cpupower-set.c          |  10 +-
 tools/power/cpupower/utils/helpers/topology.c      |   2 +-
 260 files changed, 7312 insertions(+), 3389 deletions(-)
