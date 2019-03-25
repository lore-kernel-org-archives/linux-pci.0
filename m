Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F33BC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E424E2085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR7kJa2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfCYLlX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfCYLlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so9751892wrq.1;
        Mon, 25 Mar 2019 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUcTd4ffmxmZqw1aKgP9LKIf3+lH96Q0sGddIMfmQuA=;
        b=dR7kJa2lr2hLomOYI3IDf3O2+SmxJa+ixIMdj35R1Q2M2SlgKo6TCiYoK0xE+C/oc9
         CBDMbR0hTIFCrXV8xR2HxkYQGUcOhV6eJc2nPqXjMyuTr3VFSjHsCePMDwyvsdlRfJKC
         SslMm6XZLV0sqGVnt5AqeXQN6DsehnclhY5vuoN1r6dBkaWQa7wOggcgpQ8U9+6pj6Qj
         S9pfNXpb1edrxhaREFgXtZffeSOkVk+ZPtdrbJNYF29MZzVmEjuFEMLp+2x7O+anK06c
         D16yXAlwWr6DIiAghFXmdu2/4XBGc2+Rn5na1iCX/PeZIv9AHefg0Sr32zh3GICKcYDq
         4LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUcTd4ffmxmZqw1aKgP9LKIf3+lH96Q0sGddIMfmQuA=;
        b=lefnxRDFWnHUrdIvR4vh3G9pai0mihpuRVuZWNjMO2A9zn5rJh+4ILH2ldMR3iPx6h
         8uzFT8+hUbiLal2+SzpUsRd9GOQwUfss7fX3RxD8gnwvrRZonVmy88ojDgC+xRDkyGQr
         j22hzQsYyjC8IE5s4uTJa/aojVmJdXTkl7jW1bGbJONAG/jH1OI5WE/D97Mz7I2VA6u0
         va6TiTBPwKAEMHjUr7CAGxjUIP5WJ96sCjQoX4VPT5MSiZkRxloCev7hikBy2J7qmboy
         8HPwcwfludaJf9Zb47Opm9Z9aV3ADcQDEF4ACEx+i71nBt/Euo0c8gXGT0dT3RjICQBh
         VDyQ==
X-Gm-Message-State: APjAAAXWXrn0hY1AzWRq1fu7vCEBuDl/OHU/xC95/bNQoROpiMscBAve
        iluT2oABUces9spkYemUh4zexqG8
X-Google-Smtp-Source: APXvYqwnWXZnXB0yNIPnbfR5h4+I+vQdheNZ7shqfeUJIp17tDpsWVF5xiE+Zq2xmkyJ2cjTE6y2Mg==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr3726230wrp.9.1553514080589;
        Mon, 25 Mar 2019 04:41:20 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:19 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V4 5/6] PCI: rcar: Clean up debug messages
Date:   Mon, 25 Mar 2019 12:41:00 +0100
Message-Id: <20190325114101.10198-5-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325114101.10198-1-marek.vasut@gmail.com>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Drop useless casts from debug messages, they are no longer needed
due to the data type cleanup.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
V2: - Bundle this patch with other cleanups before resending
    - Add R-B from Geert
V3: Add Wolfram's R-B
V4: No change
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 96210768e774..c6013f95bdb2 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -284,8 +284,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	else if (size == 2)
 		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
 
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)*val);
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
 
 	return ret;
 }
@@ -304,8 +304,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)val);
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
 
 	if (size == 1) {
 		shift = BITS_PER_BYTE * (where & 3);
-- 
2.20.1

