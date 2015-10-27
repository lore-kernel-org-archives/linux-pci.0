Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35262 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965499AbbJ0Uwf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 16:52:35 -0400
Received: by pasz6 with SMTP id z6so232618108pas.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 13:52:35 -0700 (PDT)
Subject: [PATCH 4/5] iov: Variable and loop cleanup for sriov_disable and
 sriov_enable
From: Alexander Duyck <aduyck@mirantis.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2015 13:52:33 -0700
Message-ID: <20151027205233.14626.98836.stgit@localhost.localdomain>
In-Reply-To: <20151027204607.14626.59671.stgit@localhost.localdomain>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is just a minor cleanup to go through and group all of the
variables into one declaration instead of a long string of single
declarations for each int.  It also changes the direction for a couple
loops as we are able to loop with less code this way as testing against 0
can be done as a part of the decrement operation.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/pci/iov.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index cecc242c1af0..c0fc88fa7c4d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -241,15 +241,11 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
-	int rc;
-	int i;
-	int nres;
 	u16 offset, stride, initial;
 	struct resource *res;
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
-	int bars = 0;
-	int bus;
+	int rc, i, nres, bars, bus;
 
 	if (!nr_virtfn)
 		return 0;
@@ -271,8 +267,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (!offset || (nr_virtfn > 1 && !stride))
 		return -EIO;
 
-	nres = 0;
-	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+	for (nres = 0, bars = 0, i = PCI_SRIOV_NUM_BARS; i--;) {
 		bars |= (1 << (i + PCI_IOV_RESOURCES));
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (res->parent)
@@ -366,13 +361,13 @@ err_pcibios:
 
 static void sriov_disable(struct pci_dev *dev)
 {
-	int i;
 	struct pci_sriov *iov = dev->sriov;
+	int i = iov->num_VFs;
 
 	if (!iov->num_VFs)
 		return;
 
-	for (i = 0; i < iov->num_VFs; i++)
+	while (i--)
 		virtfn_remove(dev, i, 0);
 
 	pcibios_sriov_disable(dev);

