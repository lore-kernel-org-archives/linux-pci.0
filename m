Return-Path: <SRS0=tDEs=D6=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=tDEs=D6=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v3 0/7] SR-IOV Enablement on PowerVM
Date: Wed,  3 Jan 2018 11:16:26 -0600
Message-Id: <20180103171633.94499-1-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series will enable SR-IOV on PowerVM. A specific set of
lids for PFW/PHYP is required. They are planned to release with
920 at the moment.

For IBM internal testers let me know of a system you want to test on
and we can put on the lids required or we can provide a system to run
the tests.

This patch depends on the three patches:
988fc3ba5653278a8c14d6ccf687371775930d2b
dae7253f9f78a731755ca20c66b2d2c40b86baea
608c0d8804ef3ca4cda8ec6ad914e47deb283d7b

v1 - Initial Patch
v2 - Addressed Alexey and Russell's comments
v3 - Unify the call of .error_detected()

Bryant G. Ly (7):
  platform/pseries: Update VF config space after EEH
  powerpc/kernel: Add uevents in EEH error/resume
  platforms/pseries: Set eeh_pe of EEH_PE_VF type
  powerpc/kernel Add EEH operations to notify resume
  powerpc/kernel: Add EEH notify resume sysfs
  pseries/pci: Associate PEs to VFs in configure SR-IOV
  pseries/setup: Add Initialization of VF Bars

 arch/powerpc/include/asm/eeh.h               |   2 +
 arch/powerpc/include/asm/pci-bridge.h        |   5 +-
 arch/powerpc/include/asm/pci.h               |   2 +
 arch/powerpc/kernel/eeh.c                    |  59 ++++++++++
 arch/powerpc/kernel/eeh_driver.c             |   8 +-
 arch/powerpc/kernel/eeh_sysfs.c              |  46 +++++++-
 arch/powerpc/kernel/pci_of_scan.c            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  68 +----------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 132 ++++++++++++++++++++-
 arch/powerpc/platforms/pseries/pci.c         | 151 +++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/setup.c       | 164 +++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_core.c           |   3 +
 include/linux/pci.h                          |  36 ++++++
 13 files changed, 605 insertions(+), 73 deletions(-)

-- 
2.14.3 (Apple Git-98)
