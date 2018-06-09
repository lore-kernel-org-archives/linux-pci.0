Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        tony.luck@intel.com, bp@alien8.de, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        zhangpanyong@hygon.cn
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 00/11] Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:20:10 +0800
Message-Id: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As a new x86 CPU Vendor, Chengdu Haiguang IC Design Co., Ltd (Hygon)
is a Joint Venture between AMD and Haiguang Information Technology Co.,
Ltd., and aims at providing high performance x86 processor for China
server market.

The first generation Hygon's processor(Dhyana) originates from AMD
technology and shares most of the architecture with AMD's family 17h,
but with different CPU Vendor ID("HygonGenuine")/PCIE Device Vendor ID
(0x1D94)/Family series number(Family 18h).

To enable the support of Linux kernel to Hygon's CPU, we added a new
vendor type (X86_VENDOR_HYGON, with value of 9) in arch/x86/include/
asm/processor.h, and shared most of kernel support codes with AMD
family 17h.

These patches have been applied and tested successfully in Hygon's
Dhyana SoC silicon. Also tested on AMD's EPYC (Family 17h) processor
works fine and makes no harm to existing codes.

Thanks.

Pu Wen (11):
  x86/cpu: Add support for Hygon's Dhyana Family 18h processor
  x86/pci: Add support for Hygon's Dhyana Family 18h processor
  x86/cpu/bug: Add support for Hygon's Dhyana Family 18h processor
  x86/perf: Add support for Hygon's Dhyana Family 18h processor
  x86/mce: Add support for Hygon's Dhyana Family 18h processor
  x86/kvm: Add support for Hygon's Dhyana Family 18h processor
  x86/xen: Add support for Hygon's Dhyana Family 18h processor
  driver/acpi: Add support for Hygon's Dhyana Family 18h processor
  driver/cpufreq: Add support for Hygon's Dhyana Family 18h processor
  driver/edac: Add support for Hygon's Dhyana Family 18h processor
  tools/cpupower: Add support for Hygon's Dhyana Family 18h processor

 arch/x86/events/amd/core.c                         | 10 ++++++++
 arch/x86/events/amd/uncore.c                       |  7 ++---
 arch/x86/events/core.c                             |  1 +
 arch/x86/include/asm/kvm_emulate.h                 |  4 +++
 arch/x86/include/asm/nospec-branch.h               |  4 +--
 arch/x86/include/asm/processor.h                   |  3 ++-
 arch/x86/include/asm/virtext.h                     |  5 ++--
 arch/x86/kernel/alternative.c                      |  4 +++
 arch/x86/kernel/amd_nb.c                           | 11 +++++++-
 arch/x86/kernel/apic/apic.c                        | 13 ++++++++--
 arch/x86/kernel/cpu/amd.c                          | 14 +++++++++-
 arch/x86/kernel/cpu/bugs.c                         | 30 ++++++++++++----------
 arch/x86/kernel/cpu/common.c                       |  1 +
 arch/x86/kernel/cpu/intel_cacheinfo.c              |  9 ++++---
 arch/x86/kernel/cpu/mcheck/mce-severity.c          |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c                   | 16 +++++++++---
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |  3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c                 |  3 ++-
 arch/x86/kernel/cpu/mtrr/main.c                    |  2 +-
 arch/x86/kernel/cpu/perfctr-watchdog.c             |  2 ++
 arch/x86/kernel/smpboot.c                          |  4 ++-
 arch/x86/kvm/emulate.c                             |  8 +++++-
 arch/x86/pci/amd_bus.c                             |  6 +++--
 arch/x86/pci/irq.c                                 |  1 +
 arch/x86/xen/pmu.c                                 | 12 ++++++---
 drivers/acpi/acpi_pad.c                            |  1 +
 drivers/acpi/processor_idle.c                      |  1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  5 +++-
 drivers/cpufreq/amd_freq_sensitivity.c             |  9 +++++--
 drivers/edac/amd64_edac.c                          | 20 ++++++++++++++-
 drivers/edac/amd64_edac.h                          |  4 +++
 drivers/edac/mce_amd.c                             |  4 ++-
 include/linux/pci_ids.h                            |  2 ++
 tools/power/cpupower/utils/cpufreq-info.c          |  6 +++--
 tools/power/cpupower/utils/helpers/cpuid.c         |  6 +++--
 tools/power/cpupower/utils/helpers/helpers.h       |  2 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  3 ++-
 37 files changed, 183 insertions(+), 56 deletions(-)

-- 
2.7.4

