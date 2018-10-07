Return-Path: <SRS0=ld9y=MT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8382AC00449
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 03:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53E20882
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 03:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Df7TT4UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED53E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeJGLCX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 7 Oct 2018 07:02:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJGLCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Oct 2018 07:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GcsFwBsTlRGg/ymaDk01OYInWyg4O77CuATR9BiGVRA=; b=Df7TT4UMOwTKwXuuhJ6gyk1gV
        mbm/io3yJZTTGOCf7x1er1g2NlAXwqH4H5aobjHS5Qg7GpBe8+YrIV7xtRaKRADg0DjFztc0dAo7D
        BztgT0B+ec6GjtKV+4Yd1KvxEjGllantpK0PesB2M1UO5r6NmiO6jDF1Bqq0xM+mnCgCuV7YJcPt5
        3LYcNdwrhC7U56QrFYwKKv9Z6aHARwDO7OxNkWxsEsLX+vWfvTsabdkY3upA0mtxtldBlaXMRcqcS
        UWab5lj2ex8Z/X3WmJVViENvuB/iHgsDFqRjL7b8nOJ19SIR3+0hYLnhvMQveCVjWuqtvR+9LsPbk
        DlyVTqXRg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g90BG-0004QT-Nc; Sun, 07 Oct 2018 03:56:34 +0000
To:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PCI: expand the "PF" acronym in Kconfig help text
Message-ID: <fceb7567-dae1-f393-b2e9-bce6e1fa5159@infradead.org>
Date:   Sat, 6 Oct 2018 20:56:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Tell users what a PCI PF is in the PCI_PF_STUB config help text.

Fixes: a8ccf8a66663 ("PCI/IOV: Add pci-pf-stub driver for PFs that only enable VFs")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/pci/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-419-rc6.orig/drivers/pci/Kconfig
+++ lnx-419-rc6/drivers/pci/Kconfig
@@ -73,9 +73,9 @@ config PCI_PF_STUB
 	depends on PCI_IOV
 	help
 	  Say Y or M here if you want to enable support for devices that
-	  require SR-IOV support, while at the same time the PF itself is
-	  not providing any actual services on the host itself such as
-	  storage or networking.
+	  require SR-IOV support, while at the same time the PF (Physical
+	  Function) itself is not providing any actual services on the
+	  host itself such as storage or networking.
 
 	  When in doubt, say N.
 


