Return-Path: <SRS0=1eKq=YC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB2C47404
	for <linux-pci@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EBE2190F
	for <linux-pci@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661659;
	bh=qL8doCvFG2dqwmIvj9dzbxGepFbqsoz5/Woj99/nbXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvr3iYWVPiuh3BSL72lZElSygLLcDBs0AFSlse9PvjXAHYGIEHUiLhccaTKiO5iZq
	 3xkwmxesFbSfqFPArBrT4XFxW0pfixvj7Ug3iew+OmnKjbp618OBLFvKLLxqdJOkFV
	 Rztv+Tt/ReXdpTkR0vxxQGwRNbKWxAzQAyOeMgh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfJIWyS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbfJIWyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:54:17 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845C1218DE;
        Wed,  9 Oct 2019 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661656;
        bh=qL8doCvFG2dqwmIvj9dzbxGepFbqsoz5/Woj99/nbXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCYBpDSEqgTFPHA35CvDGN8KQKfOHRdEpExO7VVi8wm1f8GSnzrDu65OcL3Mt4VWh
         f6HZiyd5NYVqocLLFtSJkWie5M11dO/UkI4zWm+RtB32xxbf03jxTh6U96DwG/ZKeW
         jSG5Cw8wMVCtpgBzaKnuUyECwzVB9t67O1qC0h+0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state() private
Date:   Wed,  9 Oct 2019 17:53:54 -0500
Message-Id: <20191009225354.181018-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
References: <20191009225354.181018-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These interfaces:

  void pci_restore_pri_state(struct pci_dev *pdev);
  void pci_restore_pasid_state(struct pci_dev *pdev);

are only used in drivers/pci and do not need to be seen by the rest of the
kernel.  Most them to drivers/pci/pci.h so they're private to the PCI
subsystem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h       | 4 ++++
 include/linux/pci-ats.h | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ae84d28ba03a..e6b46d2b9846 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -458,14 +458,18 @@ static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *dev);
+void pci_restore_pri_state(struct pci_dev *pdev);
 #else
 static inline void pci_pri_init(struct pci_dev *dev) { }
+static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_PASID
 void pci_pasid_init(struct pci_dev *dev);
+void pci_restore_pasid_state(struct pci_dev *pdev);
 #else
 static inline void pci_pasid_init(struct pci_dev *dev) { }
+static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_IOV
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 963c11f7c56b..5d62e78946a3 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -23,21 +23,16 @@ static inline int pci_ats_page_aligned(struct pci_dev *dev)
 #ifdef CONFIG_PCI_PRI
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
-void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
-#else /* CONFIG_PCI_PRI */
-static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
 int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
-void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
 static inline int pci_max_pasids(struct pci_dev *pdev)
-- 
2.23.0.581.g78d2f28ef7-goog

