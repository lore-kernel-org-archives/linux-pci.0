Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ethan Zhao <ethan.zhao@oracle.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gleb@kernel.org, pbonzini@redhat.com,
	kvm@vger.kernel.org, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com, david.vrabel@citrix.com
Cc: alex.williamson@redhat.com, alexander.h.duyck@intel.com,
	ethan.kernel@gmail.com, Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH v4 0/4 resend] Introduce device assignment flag operation helper function 
Date: Tue,  9 Sep 2014 10:21:24 +0800
Message-Id: <1410229288-31829-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set introduces three PCI device flag operation helper functions
when set pci device PF/VF to assigned or deassigned status also check it.
and patch 2,3,4 apply these helper functions to KVM,XEN and PCI.

v2: simplify unnecessory ternary operation in function pci_is_dev_assigned().
v3: amend helper function naming.
v4: fix incorrect type in return expression warning found by Fengguang Wu.

Appreciate suggestion from
alex.williamson@redhat.com,
david.vrabel@citrix.com,
alexander.h.duyck@intel.com

Resend for v3.18 building.

Thanks,
Ethan
---
Ethan Zhao (4):
  PCI: introduce helper functions for device flag operation
  KVM: use pci device flag operation helper functions
  xen-pciback: use pci device flag operation helper function
  PCI: use device flag operation helper function in iov.c

 drivers/pci/iov.c                  |    2 +-
 drivers/xen/xen-pciback/pci_stub.c |    4 ++--
 include/linux/pci.h                |   13 +++++++++++++
 virt/kvm/assigned-dev.c            |    2 +-
 virt/kvm/iommu.c                   |    4 ++--
 5 files changed, 19 insertions(+), 6 deletions(-)

