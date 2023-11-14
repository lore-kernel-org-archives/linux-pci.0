Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D05C072A2
	for <linux-pci@archiver.kernel.org>; Tue, 14 Nov 2023 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjKNN4m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Nov 2023 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjKNN4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 08:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F7D51;
        Tue, 14 Nov 2023 05:56:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E42C43391;
        Tue, 14 Nov 2023 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699970193;
        bh=IyFpJ4IPW+04Qg7uetnTuAVDseZG4Zu5u7tnsvS+xhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeWpsd+8blmriSQBMZBlDg9HTiPOqC/TQjd6pKDcunLzqR3jShDyFDuVGX3o+W+XL
         Qoas/TI4ZoSf+VvVCy+P07qZYXvxi7ChCBAtOpvPnbQinxnLfLcuAuTbeAOpTkbOuQ
         i8wswos2HLxVIWnBf2h2TXvEL8GoEUBo47tOC/L2ugI/3E+n7o+q+N5+mqYJOBpgnY
         +UpX+ekmhHjqTIQDRuTjxbdrsokfqOrV5SdFdKfOzRvpTLvEMGsBjJM6Ns/kuFAArc
         PpdVsvyLFgEZJ1jFRzTWNb0rwCc82mDHeIZ806JJ3F+rGx/KyHm+KiumEl5rD92iFh
         couZyIiRK1mWQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r2tu3-0008PZ-0I;
        Tue, 14 Nov 2023 14:56:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/6] PCI/ASPM: Add lockdep assert to link state helper
Date:   Tue, 14 Nov 2023 14:55:53 +0100
Message-ID: <20231114135553.32301-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114135553.32301-1-johan+linaro@kernel.org>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a lockdep assert to the locked disable link state helper which
should only be called with a pci_bus_sem read lock held.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 19b7256d2dc9..ef2e7a186f57 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1090,6 +1090,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
+	lockdep_assert_held_read(&pci_bus_sem);
+
 	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
-- 
2.41.0

