Return-Path: <SRS0=dq5y=CA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E5CC433DF
	for <linux-pci@archiver.kernel.org>; Sat, 22 Aug 2020 00:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1412067C
	for <linux-pci@archiver.kernel.org>; Sat, 22 Aug 2020 00:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H4j8Sbac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHVAKl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHVAKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 20:10:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFEC061573;
        Fri, 21 Aug 2020 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UV45px4ZIhGAV9MDXqTwix33q6Zo13Yicz1hPoFWUV8=; b=H4j8Sbac/tusrMja9EvJ8Pmj2J
        GyXQKrojjhnrir0AfsUOmtXM3XG1y18L64SNUf7FnHkHoUi+8J+zBF2bi2gQo0SFJttY/GbLr9E9Q
        MOZq3Sl68aEdz9VNR27FkZo5IArlFbkILTj/QIJ4qQYiCS1c1thpToK0b2+7H6rusiLQDlCXRwsy3
        spurNzTvQlkFVrwLAFzuA8rHVh9WmY5w87oGGpI7vPjocb+7Qp1oU/QdO5sM0Z9tFHpM3vJ31DC4k
        z/u43JsThgw7qKJtV27RdawRcZXB6z6Z6WjpqIprycMnD1reUaya6XpkDLC/iUOB/02yI/16lUfpz
        mG3dJESw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9H79-0004HB-Cm; Sat, 22 Aug 2020 00:10:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     stable <stable@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adam Borowski <kilobyte@angband.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] x86/pci: fix intel_mid_pci.c build error when ACPI is not
 enabled
Message-ID: <ea903917-e51b-4cc9-2680-bc1e36efa026@infradead.org>
Date:   Fri, 21 Aug 2020 17:10:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when CONFIG_ACPI is not set/enabled by adding
the header file <asm/acpi.h> which contains a stub for the function
in the build error.

../arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
  acpi_noirq_set();

Fixes: a912a7584ec3 ("x86/platform/intel-mid: Move PCI initialization to arch_init()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org	# v4.16+
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jesse Barnes <jsbarnes@google.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
Found in linux-next, but applies to/exists in mainline also.

v2:
- add Reviewed-by: and Acked-by: tags
- drop alternatives

 arch/x86/pci/intel_mid_pci.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200813.orig/arch/x86/pci/intel_mid_pci.c
+++ linux-next-20200813/arch/x86/pci/intel_mid_pci.c
@@ -33,6 +33,7 @@
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
+#include <asm/acpi.h>
 
 #define PCIE_CAP_OFFSET	0x100
 

