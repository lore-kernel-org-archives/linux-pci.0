Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A719C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFD0218A1
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549925742;
	bh=ZhRxEp9WNhE3yzMFnOonscjkSmwRIyF643uiLMom3TM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=wX2e/Ol41VBpKuqmZiu7KZoD5W2V4jrbB5XI4VU2aeZ2bEMyJVYH9v9icdGSjIZLK
	 prL3XuqymprxkQgcOcaHRQRV4VhInlz/yuuNQVYmQVG4Kbr8CRzwY30TMdHmYGblDB
	 aSrrxatY741yCHZe4prOun/2uFVC/iO2r8r/W2i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBKWzm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfBKWzl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 17:55:41 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5D92083B;
        Mon, 11 Feb 2019 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549925740;
        bh=ZhRxEp9WNhE3yzMFnOonscjkSmwRIyF643uiLMom3TM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=STKH6PceXjVHGZCZAMKWz+EEBmN9g+E9X/B4s/k3O6GpQ0Ll893eu7LMWnGI+0ocC
         e0yYakF2AwdwOJJkbBtHi7ihs+Vk7HkWmy2CiCESmiZJt/R0WnhS2Zo64Z3G/OSJBH
         CNobCPbGqVT5796YJPqcz+a0ZDZyC+DpwoGAOTC0=
Subject: [PATCH v1 1/2] PCI/ASPM: Use LTR if already enabled by platform
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 16:55:39 -0600
Message-ID: <154992573941.7864.17514554950814966890.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

RussianNeuroMancer reported that the Intel 7265 wifi on a Dell Venue 11 Pro
7140 table stopped working after wakeup from suspend and bisected the
problem to 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't
have LTR").  David Ward reported the same problem on a Dell Latitude 7350.

After af8bb9f89838 ("PCI/ACPI: Request LTR control from platform before
using it"), we don't enable LTR unless the platform has granted LTR control
to us.  In addition, we don't notice if the platform had already enabled
LTR itself.

After 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't have
LTR"), we avoid using LTR if we don't think the path to the device has LTR
enabled.

The combination means that if the platform itself enables LTR but declines
to give the OS control over LTR, we unnecessarily avoided using ASPM L1.2.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201469
Fixes: 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR")
Fixes: af8bb9f89838 ("PCI/ACPI: Request LTR control from platform before using it")
Reported-by: RussianNeuroMancer <russianneuromancer@ya.ru>
Reported-by: David Ward <david.ward@ll.mit.edu>
CC: stable@vger.kernel.org	# v4.18+
---
 drivers/pci/probe.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..c46a3fcb341e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2071,11 +2071,8 @@ static void pci_configure_ltr(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCIEASPM
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	u32 cap;
 	struct pci_dev *bridge;
-
-	if (!host->native_ltr)
-		return;
+	u32 cap, ctl;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -2084,22 +2081,35 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
 
-	/*
-	 * Software must not enable LTR in an Endpoint unless the Root
-	 * Complex and all intermediate Switches indicate support for LTR.
-	 * PCIe r3.1, sec 6.18.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		dev->ltr_path = 1;
-	else {
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
+	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+			dev->ltr_path = 1;
+			return;
+		}
+
 		bridge = pci_upstream_bridge(dev);
 		if (bridge && bridge->ltr_path)
 			dev->ltr_path = 1;
+
+		return;
 	}
 
-	if (dev->ltr_path)
+	if (!host->native_ltr)
+		return;
+
+	/*
+	 * Software must not enable LTR in an Endpoint unless the Root
+	 * Complex and all intermediate Switches indicate support for LTR.
+	 * PCIe r4.0, sec 6.18.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    ((bridge = pci_upstream_bridge(dev)) &&
+	      bridge->ltr_path)) {
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_LTR_EN);
+		dev->ltr_path = 1;
+	}
 #endif
 }
 

