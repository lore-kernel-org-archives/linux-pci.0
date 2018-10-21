Return-Path: <SRS0=lW7W=NB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3804CECDE43
	for <linux-pci@archiver.kernel.org>; Sun, 21 Oct 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D02083E
	for <linux-pci@archiver.kernel.org>; Sun, 21 Oct 2018 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNi/Dw27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39D02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeJUXVr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:21:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJUXVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Oct 2018 19:21:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so7847982wmc.5
        for <linux-pci@vger.kernel.org>; Sun, 21 Oct 2018 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xSCqZqkPK0YOLPv7f/lHKaCtZWEgT5sn82AEHp2g220=;
        b=RNi/Dw27p5Wt2uQnnBbAvodUc4XJjYa4lpboZuCAdYYCNeDhgdA/5/HorlkI6SHXkw
         slk9oAMRHGNQ8mB+sefrxkt5ER6hQELa0dcyWzj07QlZqVVQK7CV+XN3n1FrvZO0XS0q
         uSycRKr3vl8yQjM3LrJew+Q1FWjpFAt8MAsn9o2B/JlrNS8dm5uC+unIW8GERH51uaLJ
         +X0PjCZ2PEIx8wM1lmmKxoFCFdtdi26t7ZabCTH0rcpFkpaNsbUOkFIRu3RdFAwejYT5
         YbrpvTurJoLVau3/1fFLWyk8VZtbZZ7UqyYcdwUPtW/UL0kPvRuxHKm/oic1m9+Da3wZ
         AfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xSCqZqkPK0YOLPv7f/lHKaCtZWEgT5sn82AEHp2g220=;
        b=e1+0yqXHVVXoE5JBpaJ1AOCCLwJ5zWhdIPLFgldONRmJCv8xPOmiwrlWygTmURRTNY
         +LZUqV8NYQQtRBSZq2O7AYUliuqC5YEOeuFe6V+FPyR/WNov9CmCxfmUqSynv1KaXZk2
         LM2r16k9SY8r31NkbPg2gre/C6QTJQtCZafeNKmF+aycLlyRDeRfhRbqDXMv79g6sxOY
         ISohY6PtJTiiNkv7xoZHDd+8hbwZdExl6ZZ0FcWJTCTTe9LvcGzwJHuVddnjCOJLY3Md
         LD9YR/VJicNHmiadNtG8+IvaVKoRTbURQ+DZlg9deUvJTx0lm9O4wxJSB+OTnjFWv+WD
         vO5w==
X-Gm-Message-State: ABuFfojbcUk5tvPf9VfL/UOkHjH7NzM6E/D4MpLEEo7OPOw+4XT3S//T
        Yxl8tRzlaxfi9Ucr3+GoOv7TXadrNEE=
X-Google-Smtp-Source: ACcGV62dhwkwus8GAVYBdCKEP0PCukf6npdWlhFq+4Y19bVmbbLyUJElG8un2J1x0Vl9OcwcRMzb8w==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr12947779wme.0.1540134427789;
        Sun, 21 Oct 2018 08:07:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:3006:9cbf:497e:31c2? (p200300EA8BD43F0030069CBF497E31C2.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:3006:9cbf:497e:31c2])
        by smtp.googlemail.com with ESMTPSA id j6-v6sm17705478wru.20.2018.10.21.08.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 08:07:06 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: make pci_set_mwi a dummy for PCIe devices
Message-ID: <0599e4ea-55ce-9aba-d5af-1625a3db0701@gmail.com>
Date:   Sun, 21 Oct 2018 17:06:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Memory-Write-Invalidate isn't applicable for PCIe devices, therefore
make the MWI functions a dummy and don't even write to the (dummy)
PCI config space registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d068f11d0..fb63b3d89 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4137,6 +4137,9 @@ int pci_set_mwi(struct pci_dev *dev)
 	int rc;
 	u16 cmd;
 
+	if (pci_is_pcie(dev))
+		return 0;
+
 	rc = pci_set_cacheline_size(dev);
 	if (rc)
 		return rc;
@@ -4203,6 +4206,9 @@ void pci_clear_mwi(struct pci_dev *dev)
 #ifndef PCI_DISABLE_MWI
 	u16 cmd;
 
+	if (pci_is_pcie(dev))
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (cmd & PCI_COMMAND_INVALIDATE) {
 		cmd &= ~PCI_COMMAND_INVALIDATE;
-- 
2.19.1

