Return-Path: <SRS0=UrI8=B6=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=UrI8=B6=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linuxppc-devel@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v4 0/3] Prepartion for SR-IOV PowerVM Enablement
Date: Tue, 31 Oct 2017 09:47:21 -0500
Message-Id: <20171031144724.27808-1-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

v1 - Initial patch
v2 - Addressed Bjorn's comment on creating a highly platform
     dependent global exported symbol.
v3 - Based patch off linux-ppc/master
v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request

Bryant G. Ly (3):
  powerpc/kernel: Separate SR-IOV Calls
  pseries: Add PSeries SR-IOV Machine dependent calls
  pci/iov: Expose VF drivers Auto Probe Globally

 arch/powerpc/include/asm/machdep.h           |  7 ++++++
 arch/powerpc/include/asm/pci-bridge.h        |  4 +---
 arch/powerpc/kernel/eeh_driver.c             |  4 ++--
 arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
 arch/powerpc/kernel/pci_dn.c                 |  6 -----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
 arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci.c         | 31 ++++++++++++++++++++++----
 drivers/pci/iov.c                            | 12 ++++++++++
 include/linux/pci.h                          |  2 ++
 11 files changed, 119 insertions(+), 33 deletions(-)

-- 
2.13.5 (Apple Git-94)
