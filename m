Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F663371890;
	Mon, 27 Apr 2026 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262030; cv=none; b=GA9LgxBzW/sE5Y8e7K6hpu7YI6xLjQbomm+iSgrlJIkClB/G+Xq0vGmdY6PO2xF3lqq9TfYJBvncx3NlbsQptAZ8jabWAnGVNURm3hDmJiLvNm9fzrRWpXKGfMED6RJm8NIznNDbKhrFHwkC28AW0Z6pfYT9qQMNzDw+uj9HcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262030; c=relaxed/simple;
	bh=3xNfFpNHx12AUoJYARfmg2BOBQiezqeRp4beGxmTQDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFmCRDLWd/oMoBkt/yE9Dgq//+SKIL6vjWz8ogeecerWZKWWGs6Im3gMuL6P5XtjRtaNu4I82OaAYeMO8fpCdAnnNcB5l9V/wT/sPaGLYNNQ5F26LdG7sX4n2zsHkiWEXZUB4d4f6UJFpLefbpewKN3NqyeVWWova1GNlagBD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYYFoHJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYYFoHJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C01C2BCB7;
	Mon, 27 Apr 2026 03:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262030;
	bh=3xNfFpNHx12AUoJYARfmg2BOBQiezqeRp4beGxmTQDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYYFoHJlKnpRxsLCc5GDmZs7j31bPU5jxYFfPsd+2R2godQeeJFYuEi9UcG89K1Eh
	 rjVgRBXLphnJzoTambIPSyEo0VLANodzj5zwBLn24yoW6twCf4GA7quxnszXwl7wm9
	 tQe7GtgCh6uhVy2yNr27YTGTr7m/KckmhTOCQNXBVDv6Mt31hadH5gBb46P5CwU5JD
	 Mnidh+AvWbtnJU2uvFzb5AzMOwckwGC0/fjeCMp0sMlgr2jE0FUyb+cw8AEkNgfJPq
	 ZleNF8jSlPZqf0J5hOwTiLAzTkhO/JDWT8upjvs8ENFNrU/v+5ooDA88InUT3GgguL
	 b765HnnACCWDw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 4/5] PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
Date: Sun, 26 Apr 2026 22:53:40 -0500
Message-ID: <20260427035341.1425576-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035341.1425576-1-superm1@kernel.org>
References: <20260427035341.1425576-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices with no subordinate should be put into D3 during hibernate, but
devices that have bridge_d3 set should also be put to sleep during
hibernate. Adjust the check in pci_pm_poweroff_noirq() to use
pci_power_manageable() to cover those as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 793af4af2971b..3c82d818ee15b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1254,7 +1254,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
+	if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	/*
-- 
2.43.0

