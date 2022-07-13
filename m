Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3CAC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 13 Jul 2022 11:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGML0c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGML0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 07:26:31 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490A1020BC
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 04:26:29 -0700 (PDT)
X-QQ-mid: bizesmtp77t1657711582tlmsmvuo
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 13 Jul 2022 19:26:16 +0800 (CST)
X-QQ-SSF: 01400000002000B0H000B00A0000000
X-QQ-FEAT: pMHwdq3i9JMsailkGshShnW7pFTKuVbbOeXzT+jumiSt8NkNehyB6StF725dz
        6dw9w78YsFKw8HAszTPvO2Oap3j+8MdluuxSLusTcIHZQZ6pJVhNiQqcQn4URvmw1yVeGfj
        tEWmQCp56Cm4qXOeUArZMrz2vGOludPB6oAI9CBHS9ajk479LqpbJQVEfp/SZlrGIw+Mhhv
        TJ68zDBQweaEjXpMi6dXQjo8Q/XTyL4pcXrN6Hf8FyQL2kYfe+YYaQFG8yQOgUT5YlocS+i
        i9XDymtyc9Dr0tNZh8C2+PivqcjifAJrivl9gJsFo5KEtVZe6u2O8xpapveHZQqXut1Urhx
        RpLJf6EMZjoNibJfeKURx9PmvR3MmW2PMA843Js8zWrSdhjcLQ5AmHgYHSVVM6dtfmiNF6i
X-QQ-GoodBg: 2
From:   Manyi Li <limanyi@uniontech.com>
To:     bhelgaas@google.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manyi Li <limanyi@uniontech.com>
Subject: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT indicates ASPM is unsupported
Date:   Wed, 13 Jul 2022 19:26:12 +0800
Message-Id: <20220713112612.6935-1-limanyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Startup log of ASUSTeK X456UJ Notebook show:
[    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
[   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
[   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
[   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
[   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
[   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5

Signed-off-by: Manyi Li <limanyi@uniontech.com>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b7424c9bc..b173d3c75ae7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1359,6 +1359,7 @@ void pcie_no_aspm(void)
 	if (!aspm_force) {
 		aspm_policy = POLICY_DEFAULT;
 		aspm_disabled = 1;
+		aspm_support_enabled = false;
 	}
 }
 
-- 
2.20.1



