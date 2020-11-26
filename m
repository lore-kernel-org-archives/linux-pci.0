Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AABDC56202
	for <linux-pci@archiver.kernel.org>; Thu, 26 Nov 2020 01:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B7B20770
	for <linux-pci@archiver.kernel.org>; Thu, 26 Nov 2020 01:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWDiV514"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgKZBSd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKZBSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 20:18:32 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DDE206C0;
        Thu, 26 Nov 2020 01:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606353512;
        bh=dHtsajsDbPsgVqpRmx+WnSBsoLEytPlLs/JejUB6Lak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWDiV514kYZAJ8LqOnSg0lx8mF65C0l6BBXC37tQPw75NgIiXHTsF99RBsgn+V585
         jFeazWAVDUUrGxM7T02b6+qEIZkpzA97ZODChDBh2xeop5bJff8uQtHvIVKYXFMp5Y
         07S+B4TIvNmxRCnFsc/RdPwVdjo2ikPcwbnYZbnE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
Date:   Wed, 25 Nov 2020 19:18:12 -0600
Message-Id: <20201126011816.711106-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126011816.711106-1-helgaas@kernel.org>
References: <20201126011816.711106-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Downstream Ports may support DPC regardless of whether they support AER
(see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
"pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
depends on the AER Capability.

dpc_probe() previously failed if:

  !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
  !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law

so it succeeded if:

  pcie_aer_is_native() || pcie_ports_dpc_native

Fail dpc_probe() if the device has no AER Capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Olof Johansson <olof@lixom.net>
---
 drivers/pci/pcie/dpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba86a317..ed0dbc43d018 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
+	if (!pdev->aer_cap)
+		return -ENOTSUPP;
+
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-- 
2.25.1

