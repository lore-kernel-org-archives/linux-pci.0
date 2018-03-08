Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:40738 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeCHTAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 14:00:43 -0500
Subject: [pci PATCH v4 0/4] Add support for unmanaged SR-IOV
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Date: Thu, 08 Mar 2018 11:00:40 -0800
Message-ID: <20180308185507.5433.98830.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
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

Cc: Mark Rustad <mark.d.rustad@intel.com>
Cc: Maximilian Heyne <mheyne@amazon.de>
Cc: Liang-Min Wang <liang-min.wang@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>

---

Alexander Duyck (4):
      pci-iov: Add support for unmanaged SR-IOV
      virtio_pci: Add support for unmanaged SR-IOV on virtio_pci devices
      ena: Migrate over to "unmanaged SR-IOV" support
      nvme: Migrate over to "unmanaged SR-IOV" support


 Documentation/ABI/testing/sysfs-bus-pci      |   25 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   30 ++-----------------
 drivers/nvme/host/pci.c                      |   22 ++------------
 drivers/pci/iov.c                            |   42 ++++++++++++++++++++++++++
 drivers/pci/pci-driver.c                     |    2 +
 drivers/pci/pci-sysfs.c                      |   29 ++++++++++++++++++
 drivers/pci/pci.h                            |    4 ++
 drivers/virtio/virtio_pci_common.c           |    3 ++
 include/linux/pci.h                          |    1 +
 9 files changed, 110 insertions(+), 48 deletions(-)

--
