Return-Path: <SRS0=w5mv=VW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA79C76190
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD5C22BE8
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EOZ/BMGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGYV2J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:28:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42339 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfGYV2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 17:28:09 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so69981260iob.9
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=3RH1zSlyd07j64FiG6c56vosTfF67VZPnHTjO5XPI6w=;
        b=EOZ/BMGIWOdAj5Vnd3MYOVEz3cefj8pjrEdXl5iPoQCB2A7GPF+woWHVnm8k9xigez
         g3xjAsmtfn7Z95N8JtEYM19jcXGgmOmAF/TMVLY81K++RkiZhRJxxw6z/Zi6cj0P2crZ
         6jbUWGZ0OGzThcxAVxOLtSlRgAOUkMhWP5n8DdY7wDDGBMVTmsrv3aXCP8nX2TpQFMFO
         t+6JzAzXDmpSUtQMjbRfX9qtceI7QH1nY00yBmhS5Avtu1VLBBkKzAkphHjSLBDzmiyR
         R/+U6LN++pbSDZBytpZoLkKkmY9FfQNPqxVckN+KnwzUnC5NqJeLQsrxYS4y9Tp+TRrB
         1fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=3RH1zSlyd07j64FiG6c56vosTfF67VZPnHTjO5XPI6w=;
        b=LSffySRnhIZE2KBVdUdE92++5cQgAooSwuRr9T3sN2OMedJv8kFWyA2TVlQXRFChlD
         6YNXW2sTyBNoaMuHGoQ7CyNMY0GtfYG/usgBi9C0Uar4HAfw+5o/0fUUEZ/UfgYaMgp1
         8YAHgU0nhYLIyJzOf4svRgdgSwyG3gCZxS5Zr0fkRaEy8qIGOGy1dx0qDzeUTMvtnNeE
         hyxxEy0Xb5XQyzavpu+llTPLzEviRdytSu3LP2lCQ3it+0afMhiGbmLy6vg6UHFB/FIw
         DazLUxx3MNqylxiO7ZDkxxAlPBgg+0ot6QW0ooIzHFPrJvGkdSSjEJhh3iJAcgpF+XmF
         Jq/g==
X-Gm-Message-State: APjAAAXIQX6QpUA1lSMsibhNr85X93TurlFjOaFWm3xfFvbxo9htIK73
        c1Wq/X99fPeN1Eq+myjj7RVg9WYfQC4=
X-Google-Smtp-Source: APXvYqwcgbG8zch7ZKO4A5O8SJtdUcK7Nhlw2/y/EAEaxhmIHdnGrBKmHWDCbVWOWssqVb37HE40xg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr18868186ion.239.1564090088618;
        Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id t14sm41996376ioi.60.2019.07.25.14.28.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:28:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, wesley@sifive.com
Subject: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wesley Terpstra <wesley@sifive.com>

This is part of adding support for RISC-V systems with PCIe host 
controllers that support message-signaled interrupts.

Signed-off-by: Wesley Terpstra <wesley@sifive.com>
[paul.walmsley@sifive.com: wrote patch description; split this
 patch from the arch/riscv patch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab92409210a..beb3408a0272 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || X86 || RISCV
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.22.0

