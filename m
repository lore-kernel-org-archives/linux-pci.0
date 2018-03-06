Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [pci PATCH v3 0/3] Add support for unmanaged SR-IOV
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, dwmw@amazon.co.uk
Date: Tue, 06 Mar 2018 11:29:08 -0800
Message-ID: <20180306192423.3153.42741.stgit@localhost.localdomain>
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

I have included the authors of the original 4 patches above in the Cc here.
My hope is to get feedback and/or review on if this works for their use
cases.

My hope is that for now the pci-stub and uio driver approaches can be
addressed using the current patch that enables vfio-pci support. The only
limitation is that it is also setting the taint flag until we have a better
solution.

v2: Reduced scope back to just virtio_pci and vfio-pci
    Broke into 3 patch set from single patch
    Changed autoprobe behavior to always set when num_vfs is set non-zero
v3: Updated Documentation to clarify when sriov_unmanaged_autoprobe is used
    Wrapped vfio_pci_sriov_configure to fix build errors w/o SR-IOV in kernel

Cc: Mark Rustad <mark.d.rustad@intel.com>
Cc: Maximilian Heyne <mheyne@amazon.de>
Cc: Liang-Min Wang <liang-min.wang@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>

---

Alexander Duyck (3):
      pci-iov: Add support for unmanaged SR-IOV
      vfio: Add support for unmanaged or userspace managed SR-IOV
      virtio_pci: Add support for unmanaged SR-IOV on virtio_pci devices


 Documentation/ABI/testing/sysfs-bus-pci |   24 +++++++++++++
 drivers/pci/iov.c                       |   37 +++++++++++++++++++
 drivers/pci/pci-driver.c                |    2 +
 drivers/pci/pci-sysfs.c                 |   29 +++++++++++++++
 drivers/pci/pci.h                       |    4 ++
 drivers/vfio/pci/vfio_pci.c             |   59 +++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c      |    4 ++
 include/linux/pci.h                     |    1 +
 8 files changed, 158 insertions(+), 2 deletions(-)

--
