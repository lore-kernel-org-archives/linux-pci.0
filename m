Return-Path: <SRS0=HtbM=ZC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D0FC17445
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52214215EA
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353624;
	bh=Qm0LlYR6QOexdgjcFK6pfnyQ30ddksaltJsl7gtvWFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCW/o/MEHZPIuMuqlfF7x0rzU7pywNNSoNgDUF5Yk0sEM3SKk5bLAcr3JZEibg1Dl
	 0eoihhmuA7FsAYwe6dbYd8UECOiZ9pZghg3waEbMWM/Si3ByLBm/XhfldxCK0s6rnP
	 N/iMByelqnuRB+jrIO9puu2lNlOKRWP9XodE3CB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKJCkW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfKJCkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25A821882;
        Sun, 10 Nov 2019 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353621;
        bh=Qm0LlYR6QOexdgjcFK6pfnyQ30ddksaltJsl7gtvWFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOow2KplG4BUYD4wL6cpragRj5tipDaUWpGvAChwUmAtw7jRNS7jBBcoUYltCtp3w
         sDF+X4Tp2vo1E+nkr4/h24qbA/y2PHpKgQ58OTr4UfmHmGZhgwy8tXt9/kbE6eEXe9
         PtQIzUflT5GMOaeBGhjpe4zfTx+VFBYTxUer1lmc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 006/191] PCI/ACPI: Correct error message for ASPM disabling
Date:   Sat,  9 Nov 2019 21:37:08 -0500
Message-Id: <20191110024013.29782-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sinan Kaya <okaya@kernel.org>

[ Upstream commit 1ad61b612b95980a4d970c52022aa01dfc0f6068 ]

If _OSC execution fails today for platforms without an _OSC entry, code is
printing a misleading message saying disabling ASPM as follows:

  acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

We need to ensure that platform supports ASPM to begin with.

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_root.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035ded955..e465e720eab20 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -455,8 +455,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+		dev_info(&device->dev, "_OSC failed (%s)%s\n",
+			 acpi_format_exception(status),
+			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
 		*no_aspm = 1;
 		return;
 	}
-- 
2.20.1

