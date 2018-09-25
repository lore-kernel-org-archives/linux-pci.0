Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF9C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B112086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 14:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B112086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeIYUyQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:54:16 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:45318 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729231AbeIYUyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 16:54:16 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowADn75MlSqpboMHiDA--.140S2;
        Tue, 25 Sep 2018 22:46:04 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, bhelgaas@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 1/2] x86/amd_nb: Add vendor checking for strict function access
Date:   Tue, 25 Sep 2018 22:45:01 +0800
Message-Id: <487d8078708baedaf63eb00a82251e228b58f1c2.1537885177.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180924152448.GE20187@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn> <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn> <20180924152448.GE20187@zn.tnic>
X-CM-TRANSID: swCowADn75MlSqpboMHiDA--.140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWrtr4DKFyfKF43Aw1fZwb_yoW8Wr1rpF
        ZrJFn7WFs5Was3Z3s5tr4kur48AF4DK3Wxt3yUGw1fJF1DZFy7Xrsakw1Skw1jqr4kKFyr
        tFZI9a10qF10yaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoZ2-UUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To prevent further PCI device ids checking in early_gart_iommu_check
which cannot happen both on Hygon and Intel platform, the function
amd_gart_present should return if it's not a AMD CPU.

Also only AMD or Hygon CPU should use the functionality provided by
early_is_amd_nb.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/amd_nb.h | 3 +++
 arch/x86/kernel/amd_nb.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index fddb6d2..1ae4e57 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 
 static inline bool amd_gart_present(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
 	/* GART present only on Fam15h, upto model 0fh */
 	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
 	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..b51c6b1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -264,6 +264,10 @@ bool __init early_is_amd_nb(u32 device)
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return false;
+
 	device >>= 16;
 	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
-- 
2.7.4

