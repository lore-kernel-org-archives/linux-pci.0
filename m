Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36268 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbJWFGD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:03 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 21/29] mn10300: Remove pcibios_enable_device function
Date: Fri, 23 Oct 2015 06:03:54 +0100
Message-Id: <1445576642-29624-22-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcibios_enable_device is now identical to the generic version
in non arch specific code, so we can delete this one.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/mn10300/unit-asb2305/pci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 37a22a5..c9fc19d 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -398,14 +398,6 @@ char *__init pcibios_setup(char *str)
 	return str;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	int err;
-
-	err = pci_enable_resources(dev, mask);
-	return err;
-}
-
 /*
  * disable the ethernet chipset
  */
-- 
2.6.2

