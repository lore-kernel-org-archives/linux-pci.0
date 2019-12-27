Return-Path: <SRS0=rySr=2R=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4325C2D0DC
	for <linux-pci@archiver.kernel.org>; Fri, 27 Dec 2019 01:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A57E208C4
	for <linux-pci@archiver.kernel.org>; Fri, 27 Dec 2019 01:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btjOcsmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfL0B1y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:27:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0B1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2019 20:27:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so13980698pfg.12
        for <linux-pci@vger.kernel.org>; Thu, 26 Dec 2019 17:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRlWtIcQUsLKShnJr6O+2Jcc7yVY+hw3WSlirQFQtWs=;
        b=btjOcsmzB3eli/6pjctJta/MabRyX8p1QS6dwLFAxMubblG9fXM8Bf7onRm+8ZDxXU
         SOsq7s5EreR2eT+mDSaLjY61yRlndP8HeEAhUp7ezBMFy+K/way9A54AMsn2JgGuaIuP
         STn5JbYY+xgWbvXLOAOhsosDu3SQrCzB5qDrFaB9EWG3/s1eFdYWVgLMtc+pOSgWM5jX
         EPTGIkidysOVI3UCiTtUw69zbGG8pd+jVt8SE5eTBu8kKWNp/TpmDsU8U67DWKfS41Cj
         K5u8AtWCGBB5hCGLOwSDa4RICEtQshr5kwkVVYNLJRTvh4ent9GFXM8bvRXtVnZnUGfW
         Y6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRlWtIcQUsLKShnJr6O+2Jcc7yVY+hw3WSlirQFQtWs=;
        b=a5mcyOxAUCN1tFNMUx5lbkpJEUZyT89mkZp28LNTLCR6PXzqhtqBpnxgaAa3wVgFYZ
         4XT4jAa3p9iStetHMHOWw1ipglJIkUu+Ar7ItRJKHSEOPOkA63CQOC6I6zDDLP6NxRfd
         67Eq7VI1zCp+9rffwrkm0NFTKSV1Bsx1pAxI+KEtx2HY6+6uewLzvxl6egpU22eZhn26
         FPtjHe2utWCkDzg8v4h+pQWoxBx/Vl+DDv+j9cS0VApjdI17AxqKoMVSNh60UoA5N26w
         9yr1vWnTYvJrCtsAwq32n4F2NTNXfGGzwkXfaeptSUS/RcV2aOpwuWJXaMvIcRZfCq00
         k4pQ==
X-Gm-Message-State: APjAAAX52ugyXAN0Ca8O5pvNEPjKCfKHQJVoJRXF1tLGxwDWhjSuoJHo
        xMfwXLUHkvubXRRMo5ixPTLUlZ2VxbU=
X-Google-Smtp-Source: APXvYqxh78dSzfk4bN9uQtL+xMtUE95dpqDcuu+Cy1dcRpt9DnzYP8G4XdfL7ANBtCsLOLGzENG0Bw==
X-Received: by 2002:a63:7311:: with SMTP id o17mr49136128pgc.29.1577410072994;
        Thu, 26 Dec 2019 17:27:52 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s21sm16769185pfe.20.2019.12.26.17.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:27:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>, stable@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM
Date:   Thu, 26 Dec 2019 17:27:17 -0800
Message-Id: <20191227012717.78965-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There exists non-bridge PCIe devices with PCI_VENDOR_ID_QCOM, so limit
the fixup to only affect the relevant PCIe bridges.

Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Stan, I picked up all the suggested device id's from the previous thread and
added 0x1000 for QCS404. I looked at creating platform specific defines in
pci_ids.h, but SDM845 has both 106 and 107... Please let me know if you would
prefer that I do this anyway.

 drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5ea527a6bd9f..138e1a2d21cc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1439,7 +1439,13 @@ static void qcom_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, PCI_ANY_ID, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
-- 
2.24.0

