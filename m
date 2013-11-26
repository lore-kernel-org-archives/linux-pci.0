Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 6.77.broadband6.iol.cz ([88.101.77.6]:52312 "EHLO
	dhcp-26-207.brq.redhat.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757418Ab3KZUho (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 15:37:44 -0500
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tejun Heo <tj@kernel.org>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Mark Lord <kernel@start.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 01/11] PCI/MSI/s390: Fix single MSI only check
Date: Tue, 26 Nov 2013 10:09:50 +0100
Message-Id: <4a3fc109c984d74340d70f0053ec7e3d3263939a.1385399393.git.agordeev@redhat.com>
In-Reply-To: <cover.1385399393.git.agordeev@redhat.com>
References: <cover.1385399393.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple MSIs have never been supported on s390 architecture,
but the platform code fails to report single MSI only.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/pci/pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index f17a834..c79c6e4 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -427,6 +427,8 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
 	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
 		return -EINVAL;
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
 	msi_vecs = min(nvec, ZPCI_MSI_VEC_MAX);
 	msi_vecs = min_t(unsigned int, msi_vecs, CONFIG_PCI_NR_MSI);
 
-- 
1.7.7.6

