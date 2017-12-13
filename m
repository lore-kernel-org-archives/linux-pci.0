Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 0/7] SR-IOV Enablement on PowerVM
Date: Wed, 13 Dec 2017 09:32:35 -0600
Message-Id: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
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

Bryant G. Ly (7):
  platform/pseries: Update VF config space after EEH
  powerpc/kernel: Add uevents in EEH error/resume
  platforms/pseries: Set eeh_pe of EEH_PE_VF type
  powerpc/kernel Add EEH operations to notify resume
  powerpc/kernel: Add EEH notify resume sysfs
  pseries/pci: Associate PEs to VFs in configure SR-IOV
  pseries/setup: Add Initialization of VF Bars

 arch/powerpc/include/asm/eeh.h               |   1 +
 arch/powerpc/include/asm/pci-bridge.h        |   5 +-
 arch/powerpc/include/asm/pci.h               |   2 +
 arch/powerpc/kernel/eeh_driver.c             |   9 +-
 arch/powerpc/kernel/eeh_sysfs.c              |  46 ++++++-
 arch/powerpc/kernel/pci_of_scan.c            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |   3 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 192 ++++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/pci.c         | 156 +++++++++++++++++++++-
 arch/powerpc/platforms/pseries/setup.c       | 183 +++++++++++++++++++++++++
 10 files changed, 589 insertions(+), 10 deletions(-)

-- 
2.14.3 (Apple Git-98)
