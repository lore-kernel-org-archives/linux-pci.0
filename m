Return-Path: <SRS0=HtbM=ZC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75462C17443
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 03:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4265E2067B
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 03:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355206;
	bh=63nU4fdCgX2p8UUb5OJm+yB5Xgb0CqU3zNEb9oVmn4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPg3eNH1bjHS3XtATUz6LFhhZ1i6PctFS3gZnoSxQIOj57/balnzmYIPqthNrwkY9
	 zDKR879jcCP4KDzoKL+fCTVsQHBeib5JR26c98ApXxTRaNW25jL8bks2ApjEyB9B4D
	 XU5SNf3y2mufzjYpivc/l9coUJyhKJ4dDyDOzjts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfKJCpp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfKJCpo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431D421D7F;
        Sun, 10 Nov 2019 02:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353944;
        bh=63nU4fdCgX2p8UUb5OJm+yB5Xgb0CqU3zNEb9oVmn4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULg3zxWEHUW58PIhgr0ocODVJZU/+KQp4VvUTmb3UR3/iFNxZ/ziHBQIRiA/jVEdr
         RRjIBsEOV9O6fWm4/8FAY/2Xf9J/t+JtquY+fEJ9WwrQV1RRbpvKJjXNpZCit3B1zU
         Tfh4VzMCEAkaUdm1UUw+b1P+2+rBUxhBHPqHbGTg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 002/109] PCI/ACPI: Correct error message for ASPM disabling
Date:   Sat,  9 Nov 2019 21:43:54 -0500
Message-Id: <20191110024541.31567-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
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
index eb857d6ea1fef..96911360a28e7 100644
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

