Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54473C3F68F
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D524670
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4tit3Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANUzi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:55:38 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45842 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANUzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 15:55:38 -0500
Received: by mail-yw1-f65.google.com with SMTP id d7so10018280ywl.12
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEuO1nxCHKuiLLjHxP48N8E1+Z7HypDPPQV+NYI/Cw0=;
        b=A4tit3Osmys/EnM8OACBQ7dShX7f9WcDSE4A2Bj6b3P2CMsTz+oQi+ccEgnj7KeLIk
         IRev0a9lauiojfYEH54G00DU8pzBL8UUsQXCLxHT0/rPQoUUWWs1xWOa33rosjvhupUZ
         NMnLbhEPRYeqBl41hyvy4Zw3z71ujHDDhM7THWI6XYUq8j4dLgegSFvtbM+hrCzRjjw7
         Ll6KoGRLvYW994UN26fwh4jIGD5QSfBITeVspWkW30CH0YNRaVI9+DW8fqanjDFrVbas
         iLnstrgLrhfuY32B0MPhRMbi3LV3pg6/MB7byOI+6gvtq6lyuKu3p8c4lMpyub6Y+SO4
         YtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEuO1nxCHKuiLLjHxP48N8E1+Z7HypDPPQV+NYI/Cw0=;
        b=Bz4Es5j4arZzkDtX1L1KIs/aOmCFf45inXPxSgt8EWTcFrvqOQ++CUoGnpfwf1TGac
         kna/RMUqijv8K+mNX/pzmqbl4As1oX7TzLrkDBksI5Tws9ZBJ8+fBtr14fcLHBA5Enys
         p6mPgQAMNtidnDmkdiHZ4m8/HpuxaYbKCRX2gaNRahqOF6NzXJ6zCn9fI55TAFxhFQ3J
         R9LXTvC9LMych/uOzHXCFLlberQWXSfOKFVHLpjGS4+0dJCYbT9n9BsXdzT94EFKW5Vj
         xZk3ADXkbppc9cz5/KRYb8LWRGEj3jx8c1JZXY10gsdMAcdrmpv8fnLPGBIpSEyzlyD7
         r/8g==
X-Gm-Message-State: APjAAAW9hTVTU1dQAdavLNxJUZ4tzgedeQ+Q1jpGGUvCr0yNFP8/yw6X
        tMorVGTso246ZI6ZBOA8+p8=
X-Google-Smtp-Source: APXvYqy75xMfQZQ2jIQuHOmDKwEXEMJZJheuIn+a5Dw/XW8sWECyHamE9HnFp/enPD6oVN1Ez3xtXg==
X-Received: by 2002:a81:b701:: with SMTP id v1mr20164856ywh.54.1579035337392;
        Tue, 14 Jan 2020 12:55:37 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
        by smtp.gmail.com with ESMTPSA id a189sm7440521ywh.92.2020.01.14.12.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:55:36 -0800 (PST)
From:   Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] pci: add ATS quirk for navi14 board (v2)
Date:   Tue, 14 Jan 2020 15:55:23 -0500
Message-Id: <20200114205523.1054271-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114205523.1054271-1-alexander.deucher@amd.com>
References: <20200114205523.1054271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some harvest configurations, a driver needs to properly initialize
some of the caches on the GPU for instances that are harvested
(parts of the chip that are disabled due to silicon flaws).  For navi
we implemented this in the vbios, but it appears some boards went
to production with an older vbios.  Add a quirk for this board.

The necessary code to fix this up is too complex to add
as a quirk.

v2: use revision id.  Only revision 0xc5 should be affected.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6569dacbb48b..f7a5e1c3c523 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5087,6 +5087,12 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 		pci_info(pdev, "disabling ATS\n");
 		pdev->ats_cap = 0;
 		break;
+	case 0x7340:
+		if (pdev->revision == 0xc5) {
+			pci_info(pdev, "disabling ATS\n");
+			pdev->ats_cap = 0;
+		}
+		break;
 	default:
 		break;
 	}
@@ -5096,6 +5102,8 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+/* AMD Navi14 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.24.1

