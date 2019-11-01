Return-Path: <SRS0=mg7z=YZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FCCCA9ED1
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1328218DE
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572641197;
	bh=TCp0l1jH9H1lbEk8p88U/LHDGbUuuVhCEFyPIpUQiNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E+ZKbnoZvX5hA3lLieij/+VAOQT2OhKpgRhFgdkCBPBjO2LW1xAxo9JG0787VS7wa
	 gGrWHtefMy2Aw/Ug5u3dL5h2mWGp0O8Tih51CWMTT81Z5P1j8u4Bk2A6uGUTOlWlaw
	 7wSt3JZV+GZgZ3haTcA02HenOx8woSHXpW418u4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKAUqh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfKAUqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:46:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296B3217D9;
        Fri,  1 Nov 2019 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641196;
        bh=TCp0l1jH9H1lbEk8p88U/LHDGbUuuVhCEFyPIpUQiNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJJVklLmffG1e2WqY/JuLruwMrGeInDMpbAnrVeEiihp9VbUcr15VqezHanPZSAJU
         /IOzzWegGrgcbDfE4hG38Pq3odAHfQAfUpr0G89TgAlY+tg3Mh9ygxNcJpFb4DZWiB
         Wvh37lSCTWpLozIibjYfwAj7ZDOLCAILtovR4QDE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/6] PCI/PM: Expand PM reset messages to mention D3hot (not just D3)
Date:   Fri,  1 Nov 2019 15:45:54 -0500
Message-Id: <20191101204558.210235-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
References: <20191101204558.210235-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_pm_reset() resets a device by putting it in D3hot and bringing it back
to D0.  Clarify related messages to mention "D3hot" explicitly instead of
just "D3".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cd96874ae76d..a9d3653ef960 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4605,7 +4605,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
 }
 /**
  * pcie_wait_for_link - Wait until link is active or inactive
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

