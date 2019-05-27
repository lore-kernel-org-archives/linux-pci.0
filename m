Return-Path: <SRS0=A182=T3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778BDC072B1
	for <linux-pci@archiver.kernel.org>; Mon, 27 May 2019 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1962133F
	for <linux-pci@archiver.kernel.org>; Mon, 27 May 2019 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="VqwvkcvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfE0Wzc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 May 2019 18:55:32 -0400
Received: from alpha.anastas.io ([104.248.188.109]:38787 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfE0Wzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 18:55:31 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B39507F8F8;
        Mon, 27 May 2019 17:55:29 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1558997730; bh=EGTrKlRnXu1zsiLLv/Fv7FG8sil5S0AhH+klcU6GwLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqwvkcvWp/trIH5YpoUrAzABha0yzNIWlGAref5cHUdPyV0T9AT1LRqhH7FIHLTiG
         V8lWTqSIy+6XYRbQs4CwYl0MAZZ+p7AZ7NF6GOLOwzmS6bYUvgF8FcG1BD35cnDb/x
         dthc/61hOFXawSlPOyBX1ORVUh4z76RY9qxnXVMEhh60RZpVGM/I8hah9bpGfSqABv
         aDEs+d3pqH4hiZPmIGGadb2bPl5Z62+LECh7UWgtBu4prOTii4qKiw3Utx/arS6nwJ
         vh/mAM0Pc47HBmAbKQWDX/+iliAkwQ5lfEtFinbRqU49r+gNToqCfGHF62g7y1xls+
         t3ihSnB4b3S9g==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/3] powerpc/64: Enable pcibios_after_init hook on ppc64
Date:   Mon, 27 May 2019 17:55:20 -0500
Message-Id: <20190527225521.5884-3-shawn@anastas.io>
In-Reply-To: <20190527225521.5884-1-shawn@anastas.io>
References: <20190527225521.5884-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the pcibios_after_init hook on all powerpc platforms.
This hook is executed at the end of pcibios_init and was previously
only available on CONFIG_PPC32.

Since it is useful and not inherently limited to 32-bit mode,
remove the limitation and allow it on all powerpc platforms.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/include/asm/machdep.h | 3 +--
 arch/powerpc/kernel/pci_64.c       | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2f0ca6560e47..2fbfaa9176ed 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -150,6 +150,7 @@ struct machdep_calls {
 	void		(*init)(void);
 
 	void		(*kgdb_map_scc)(void);
+#endif /* CONFIG_PPC32 */
 
 	/*
 	 * optional PCI "hooks"
@@ -157,8 +158,6 @@ struct machdep_calls {
 	/* Called at then very end of pcibios_init() */
 	void (*pcibios_after_init)(void);
 
-#endif /* CONFIG_PPC32 */
-
 	/* Called in indirect_* to avoid touching devices */
 	int (*pci_exclude_device)(struct pci_controller *, unsigned char, unsigned char);
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9d8c10d55407..fba7fe6e4a50 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -68,6 +68,10 @@ static int __init pcibios_init(void)
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
 
+	/* Call machine dependent post-init code */
+	if (ppc_md.pcibios_after_init)
+		ppc_md.pcibios_after_init();
+
 	return 0;
 }
 
-- 
2.20.1

