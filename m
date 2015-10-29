Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35154 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbbJ2WWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 18:22:50 -0400
Subject: [PATCH v2 0/7] SR-IOV fixes and cleanup
To: Alexander Duyck <aduyck@mirantis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2015 17:22:47 -0500
Message-ID: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is basically a revision of Alex's recent series:
http://lkml.kernel.org/r/20151027204607.14626.59671.stgit@localhost.localdomain

I squashed some fixes into the original patch, dropped two, and split
the rest up a little differently:

  iov: Update virtfn_max_buses to validate offset and stride
    Folded into the patch it fixed

  iov: Reset resources to 0 if totalVFs increases after enabling ARI
    Dropped on the theory that the resource allocation code
    should already handle this case

  iov: Fix sriov_enable exception handling path
    Split into a couple patches to make it easier to review

  iov: Variable and loop cleanup for sriov_disable and sriov_enable
    Dropped for readability

  iov: Update sriov_enable to correctly handle offset and stride
    Split into the piece that removes code made redundant by "PCI: Set
    SR-IOV NumVFs to zero after enumeration" and the piece that fixes
    the bug (using offset/stride before setting numVFs)

This is all on my pci/virtualization branch, and I'm still hoping to
merge this for v4.4.

---

Alexander Duyck (7):
      PCI: Set SR-IOV NumVFs to zero after enumeration
      PCI: Remove redundant validation of SR-IOV offset/stride registers
      PCI: Remove VFs in reverse order if virtfn_add() fails
      PCI: Reorder pcibios_sriov_disable()
      PCI: Wait 1 second between disabling VFs and clearing NumVFs
      PCI: Fix sriov_enable() error path for pcibios_enable_sriov() failures
      PCI: Set NumVFs before computing how many buses VFs require


 drivers/pci/iov.c |  100 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 51 deletions(-)
