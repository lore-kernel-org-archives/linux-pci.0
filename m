Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34428C433F5
	for <linux-pci@archiver.kernel.org>; Fri, 17 Sep 2021 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6B5611F2
	for <linux-pci@archiver.kernel.org>; Fri, 17 Sep 2021 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbhIQMJK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbhIQMJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 08:09:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655FC061766
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 05:07:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y132so7158688wmc.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0kvqA0wuxQmopnKHsCmdexov5ip8nocVce6janujzYU=;
        b=e1c3wVpDLZJ2J0HN4+1Pk9UfPnD/H4ms1v3TL5WEiVcF3jzyGBgqr0fInzFfngFIqA
         7S1myJu/GbYESaTsKCnfLIpMVPXu0+SidhKy9G9Gmneh5DJDlkddIBk6s0qtzJUH63Dz
         +B+ptX4qJwXrtO8o7oWaBVGi3RLt6dvqAnwrBKWQ0gTXXnZYsJusGqgR0huW7HdvvGve
         8aF8V9zdQ+CBfiSVudF3+KlntI37bSl7QP92AYvdcE4D+H5/hXa/aWq0rxrzVDFdT6C4
         0guviljc3QZx3ta4+aTS/dldtGB2MXr5la/wVJb1R04SHMaURuxzHKNeOBgPcx22k+ML
         fOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0kvqA0wuxQmopnKHsCmdexov5ip8nocVce6janujzYU=;
        b=O8Rg2oBYiafBLbNqb5B4s7jEEzXF/ufUpnazu7sS+/m4iyOed59gX1RIroukbiSsNl
         1QPg07ygEo9QmP7fBrGX1Xe/lneL289DPqLLQlk3gvvzf9HLFnY1ZfilMPyVI/47OGfk
         iWSj+M9ozvETj1s6Keef4CRmuqQwBeUQt1HKbfMdi/CkHa21NpJmQrjRtekmnvCJwDvl
         4VLzoQvl6xuXBosapwUrxYf++1KoOaREy6NqIzbEl8XOmA701fHodNRzgTBHhGs7bJqM
         qFyOU6wrUhHFnbRIjDBqh3cOFktYzgs3LZgbbXxSbVEdS+eJf+CdrOe8Y1f3ozEC8iuj
         XXhg==
X-Gm-Message-State: AOAM530SAwIeVxySmhj9DV1Xa0o48HSlbIneYaU1M6O9fBQnHKJJeS05
        YQFceFkx91GhINUx+VJncjaR2l920dk=
X-Google-Smtp-Source: ABdhPJwfjn/w/eAQytOQ55rutv3ypcy4/JnC1l9iGN34HKMO0tHOEEkDlLnXInDsJ/eSn6kkyKlnzA==
X-Received: by 2002:a05:600c:4f52:: with SMTP id m18mr14567789wmq.34.1631880459465;
        Fri, 17 Sep 2021 05:07:39 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:4442:2fdb:9dcf:b83? (p200300ea8f08450044422fdb9dcf0b83.dip0.t-ipconnect.de. [2003:ea:8f08:4500:4442:2fdb:9dcf:b83])
        by smtp.googlemail.com with ESMTPSA id k4sm6461405wrv.24.2021.09.17.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:07:39 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI/VPD: Add simple sanity check to pci_vpd_size()
Message-ID: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
Date:   Fri, 17 Sep 2021 14:07:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have a problem with a device where each VPD read returns 0x33 [0].
This results in a valid VPD structure (except the tag id) and
therefore pci_vpd_size() scans the full VPD address range.
On an affected system this took ca. 80s.

That's not acceptable, on the other hand we may not want to re-add
the old tag checks. In addition these tag check still wouldn't be able
to avoid the described scenario 100%.
Instead let's add a simple sanity check on the number of found tags.
A VPD image conforming to the PCI spec can have max. 4 tags:
id string, ro section, rw section, end tag.

[0] https://lore.kernel.org/lkml/20210915223218.GA1542966@bjorn-Precision-5520/

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 4be248901..75e48df2e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -56,6 +56,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 {
 	size_t off = 0, size;
 	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
+	int num_tags = 0;
 
 	/* Otherwise the following reads would fail. */
 	dev->vpd.len = PCI_VPD_MAX_SIZE;
@@ -66,6 +67,10 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
 			goto error;
 
+		/* We can have max 4 tags: STRING_ID, RO, RW, END */
+		if (++num_tags > 4)
+			goto error;
+
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
-- 
2.33.0


