Return-Path: <SRS0=UhFO=WB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89C433FF
	for <linux-pci@archiver.kernel.org>; Mon,  5 Aug 2019 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7B2216B7
	for <linux-pci@archiver.kernel.org>; Mon,  5 Aug 2019 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565038368;
	bh=epBBzigvGgwT7lARsKbxLwOppbEAFmOzIcevnWxXMS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PrejuMjtIabG8EgyyGjFmKU89Jb6vMBsBlMP/w90mypDfHqPVcGxByEVfd1jcVp9/
	 edhI92UdRymCNcAEasJmynaD8Mp/hdWwI2bna3hfC04mqEOhlGJc9BRLB/T9YhSwTz
	 yzoW9U/jLmhZTQAXPm7vGPz5HuV9QRYzaPts1lWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfHEUwr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbfHEUwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 16:52:34 -0400
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E3720C01;
        Mon,  5 Aug 2019 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565038353;
        bh=epBBzigvGgwT7lARsKbxLwOppbEAFmOzIcevnWxXMS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4D1Z8jFkVOoB9lCnWIf7NJeAeat3GCb9SNcr13hOplr+02a6/tTQ+4SQT4m3Vjtw
         FYCdoWqcYeqTjrgke3ZfCHOgcDJJyt62LMuRwZtoibq1THl4CkAPK6FprKeyF4dt49
         CU5lpoJILd0jqRQuf6VTAqVGfDqovQALkQRNmabY=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] PCI / PM: Check for error when reading PME status
Date:   Mon,  5 Aug 2019 15:52:12 -0500
Message-Id: <20190805205214.194981-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805205214.194981-1-helgaas@kernel.org>
References: <20190805205214.194981-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_check_pme_status() reads the Power Management capability to determine
whether a device has generated a PME.  The capability is in config space,
which is accessible in D0, D1, D2, and D3hot, but not in D3cold.

If we call pci_check_pme_status() on a device that's in D3cold, config
reads fail and return ~0 data, which we erroneously interpreted as "the
device has generated a PME".

000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
avoided many of these problems by avoiding pci_check_pme_status() if we
think the device is in D3cold.  However, it is not a complete fix because
the device may go to D3cold after we check its power state but before
pci_check_pme_status() reads the Power Management Status Register.

Return false ("device has not generated a PME") if we get an error response
reading the Power Management Status Register.

Fixes: 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 984171d40858..af6a97d7012b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2008,6 +2008,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
 
 	pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
 	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
+	if (pmcsr == (u16) PCI_ERROR_RESPONSE)
+		return false;
+
 	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
 		return false;
 
-- 
2.22.0.770.g0f2c4a37fd-goog

