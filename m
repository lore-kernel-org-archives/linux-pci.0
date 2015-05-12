Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 May 2015 15:03:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v6 0/2] pci: drop msi disable on shutdown
Message-ID: <1431431730-25164-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fam Zheng noticed that pci shutdown disables msi and msix of a device.  This
was intended to fix kexec with fusion devices but is no longer necessary, and
can in theory be harmful.

See individual patches for the detailed explanation.

Please review, and consider for 4.2.

Eric, I would especially appreciate your feedback - I did my best
to update the commit logs with answers to questions you raised
on v5.

changes from v5:
	rebased on top of pci/msi
	fixed commit log, including comments by Bjorn
	and adding explanation to address comments/questions by Eric
	dropped stable Cc, this patch does not seem to qualify for stable
changes from v4:
        Yijing Wang <wangyijing@huawei.com> noted that
        early fixups rely on pci_msi_off.
        Split out the functionality and move off the
        required part to run early during pci_device_setup.
Changes from v3:
        fix a copy-and-paste error in
          pci: drop some duplicate code
        other patches are unchanged
        drop Cc stable for now
Changes from v2:
        move code from probe to device enumeration
        add patches to unexport pci_msi_off


Michael S. Tsirkin (2):
  PCI/MSI: Don't disable MSI/MSI-X at shutdown
  PCI/MSI: Make pci_msi_shutdown(), pci_msix_shutdown() static

 include/linux/pci.h      | 4 ----
 drivers/pci/msi.c        | 4 ++--
 drivers/pci/pci-driver.c | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

-- 
MST

