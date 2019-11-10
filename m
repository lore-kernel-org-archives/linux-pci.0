Return-Path: <SRS0=HtbM=ZC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77009C17443
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 02:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293721019
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354478;
	bh=iuc+CW/MwNh7Z3Nj4jlGrhbfNy6HZQZso3XrQC80OqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P5zWKuJRR8AqRcxFA/7R3JAmKe06N1YtvulBa0xm2Wj05hb9JNU+Fvi5ai8GJOSe+
	 esERdcUZxKuPCR1ervNhof0oxonUwMVHYgP5fRhiGZeDJvnEhvVT5pvk6xE8oycMYt
	 AecPe2Mqw98YW5qacXmbTO5eRskk6Wc2ivKFLpEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfKJCug (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfKJCug (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Nov 2019 21:50:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F4122790;
        Sun, 10 Nov 2019 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354235;
        bh=iuc+CW/MwNh7Z3Nj4jlGrhbfNy6HZQZso3XrQC80OqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdiMwsVZwVePbsIIxtX07h1/sFJa3PlQg1l0aPPZZs6Q0zjMK+/5L5YWXNxDA7Z8s
         oidI/vC7Ie2cE3ZtIHEpD9Hema8iQpbTFbj5s2hWiVae7CEhvwHORMcPmhkKr30sL3
         eyDG94AyWaup14X5O2VOVH5DlcgSYYC0gf7rsB7E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 02/40] PCI/ACPI: Correct error message for ASPM disabling
Date:   Sat,  9 Nov 2019 21:49:54 -0500
Message-Id: <20191110025032.827-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
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
index 3b0b4bd67b71b..4031ec8024cee 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -454,8 +454,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
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

