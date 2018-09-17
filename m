Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91747ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 13:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F6214C5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 13:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457F6214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeIQS6g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:58:36 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:57960 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbeIQS6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 14:58:36 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAD3_5OWrJ9b97WlCg--.378S2;
        Mon, 17 Sep 2018 21:31:06 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 07/16] x86/pci: Add Hygon Dhyana support to PCI and north bridge
Date:   Mon, 17 Sep 2018 21:30:58 +0800
Message-Id:
 <c1455a08e2551e7f06318b0d73448a3cd5f23ba8.1537182523.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAD3_5OWrJ9b97WlCg--.378S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15KF18Xry8ZFWUCw4fGrg_yoWrKrWDpr
        W5Xrs5Xr4rWr47Wa98trWUXrs8ZF1vkayfCrW3Cw1Sq3WDuF15Xrsavw1ay3ZFya1DXa1r
        Ja95J3WrJa18tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JULTmhUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917133058.KXZkxOnQHU0-zvvTUO7-PRXzaCgFYw7cdxPrNFdNLN4@z>

As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
platform, so add Hygon Dhyana support to the PCI and north bridge
subsystem by using the code path of AMD family 17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/amd_nb.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 arch/x86/pci/amd_bus.c   |  6 ++++--
 include/linux/pci_ids.h  |  2 ++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..3e2ea18 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -61,6 +61,21 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id hygon_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
+	{}
+};
+
+const struct pci_device_id hygon_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id hygon_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
 	u16 i = 0;
 	struct amd_northbridge *nb;
 	struct pci_dev *root, *misc, *link;
+	const struct pci_device_id *root_ids = NULL;
+	const struct pci_device_id *misc_ids = NULL;
+	const struct pci_device_id *link_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		root_ids = amd_root_ids;
+		misc_ids = amd_nb_misc_ids;
+		link_ids = amd_nb_link_ids;
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		root_ids = hygon_root_ids;
+		misc_ids = hygon_nb_misc_ids;
+		link_ids = hygon_nb_link_ids;
+	}
 
 	if (amd_northbridges.num)
 		return 0;
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, amd_nb_misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
 		i++;
 
 	if (!i)
@@ -218,11 +246,11 @@ int amd_cache_northbridges(void)
 	link = misc = root = NULL;
 	for (i = 0; i != amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, amd_root_ids);
+			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, amd_nb_misc_ids);
+			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, amd_nb_link_ids);
+			next_northbridge(link, link_ids);
 	}
 
 	if (amd_gart_present())
@@ -263,9 +291,15 @@ bool __init early_is_amd_nb(u32 device)
 {
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
+	const struct pci_device_id *misc_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		misc_ids = amd_nb_misc_ids;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
 
 	device >>= 16;
-	for (id = amd_nb_misc_ids; id->vendor; id++)
+	for (id = misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
@@ -277,7 +311,8 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 649bdde..bfa50e6 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -93,7 +93,8 @@ static int __init early_root_info_init(void)
 		vendor = id & 0xffff;
 		device = (id>>16) & 0xffff;
 
-		if (vendor != PCI_VENDOR_ID_AMD)
+		if (vendor != PCI_VENDOR_ID_AMD &&
+		    vendor != PCI_VENDOR_ID_HYGON)
 			continue;
 
 		if (hb_probes[i].device == device) {
@@ -390,7 +391,8 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 
 	early_root_info_init();
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983..8a0841c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2561,6 +2561,8 @@
 
 #define PCI_VENDOR_ID_AMAZON		0x1d0f
 
+#define PCI_VENDOR_ID_HYGON		0x1d94
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
-- 
2.7.4

