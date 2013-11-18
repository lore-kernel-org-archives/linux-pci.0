Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 0/2] PCIe Capability accessor fixes [stable backports]
To: stable@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, linux-pci@vger.kernel.org,
	Amos Kong <kongjianjun@gmail.com>,
	Adam Lee <adam.lee@canonical.com>,
	linux-kernel@vger.kernel.org, Yuval Mintz <yuvalmin@broadcom.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Thomas Renninger <trenn@suse.de>
Date: Mon, 18 Nov 2013 12:17:38 -0700
Message-ID: <20131118191723.26774.53479.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following two patches fix issues reported by Yuval Mintz
<yuvalmin@broadcom.com> and Adam Lee <adam.lee@canonical.com>.

These backports are for 3.10.x and 3.11.x.

3.4.x and earlier stable kernels do not need these fixes because they
do not have the pcie_capability_*() accessors.

---

Bjorn Helgaas (2):
      PCI: Allow PCIe Capability link-related register access for switches
      PCI: Support PCIe Capability Slot registers only for ports with slots


 drivers/pci/access.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
