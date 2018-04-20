Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [pci PATCH v8 0/4] Add support for unmanaged SR-IOV
From: Alexander Duyck <alexander.h.duyck@intel.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Date: Fri, 20 Apr 2018 12:28:08 -0400
Message-ID: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series is meant to add support for SR-IOV on devices when the VFs are
not managed by the kernel. Examples of recent patches attempting to do this
include:
virto - https://patchwork.kernel.org/patch/10241225/
pci-stub - https://patchwork.kernel.org/patch/10109935/
vfio - https://patchwork.kernel.org/patch/10103353/
uio - https://patchwork.kernel.org/patch/9974031/

Since this is quickly blowing up into a multi-driver problem it is probably
best to implement this solution as generically as possible.

This series is an attempt to do that. What we do with this patch set is
provide a generic framework to enable SR-IOV in the case that the PF driver
doesn't support managing the VFs itself.

I based my patch set originally on the patch by Mark Rustad but there isn't
much left after going through and cleaning out the bits that were no longer
needed, and after incorporating the feedback from David Miller. At this point
the only items to be fully reused was his patch description which is now
present in patch 3 of the set.

This solution is limited in scope to just adding support for devices that
provide no functionality for SR-IOV other than allocating the VFs by
calling pci_enable_sriov. Previous sets had included patches for VFIO, but
for now I am dropping that as the scope of that work is larger then I
think I can take on at this time.

v2: Reduced scope back to just virtio_pci and vfio-pci
    Broke into 3 patch set from single patch
    Changed autoprobe behavior to always set when num_vfs is set non-zero
v3: Updated Documentation to clarify when sriov_unmanaged_autoprobe is used
    Wrapped vfio_pci_sriov_configure to fix build errors w/o SR-IOV in kernel
v4: Dropped vfio-pci patch
    Added ena and nvme to drivers now using pci_sriov_configure_unmanaged
    Dropped pci_disable_sriov call in virtio_pci to be consistent with ena
v5: Dropped sriov_unmanaged_autoprobe and pci_sriov_conifgure_unmanaged
    Added new patch that enables pci_sriov_configure_simple
    Updated drivers to use pci_sriov_configure_simple
v6: Defined pci_sriov_configure_simple as NULL when SR-IOV is not enabled
    Updated drivers to drop "#ifdef" checks for IOV
    Added pci-pf-stub as place for PF-only drivers to add support
v7: Dropped pci_id table explanation from pci-pf-stub driver
    Updated pci_sriov_configure_simple to drop need for err value
    Fixed comment explaining why pci_sriov_configure_simple is NULL
v8: Dropped virtio from the set, support to be added later after TC approval

Cc: Mark Rustad <mark.d.rustad@intel.com>
Cc: Maximilian Heyne <mheyne@amazon.de>
Cc: Liang-Min Wang <liang-min.wang@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>

---

Alexander Duyck (4):
      pci: Add pci_sriov_configure_simple for PFs that don't manage VF resources
      ena: Migrate over to unmanaged SR-IOV support
      nvme: Migrate over to unmanaged SR-IOV support
      pci-pf-stub: Add PF driver stub for PFs that function only to enable VFs


 drivers/net/ethernet/amazon/ena/ena_netdev.c |   28 -------------
 drivers/nvme/host/pci.c                      |   20 ----------
 drivers/pci/Kconfig                          |   12 ++++++
 drivers/pci/Makefile                         |    2 +
 drivers/pci/iov.c                            |   31 +++++++++++++++
 drivers/pci/pci-pf-stub.c                    |   54 ++++++++++++++++++++++++++
 include/linux/pci.h                          |    3 +
 include/linux/pci_ids.h                      |    2 +
 8 files changed, 106 insertions(+), 46 deletions(-)
 create mode 100644 drivers/pci/pci-pf-stub.c

--
