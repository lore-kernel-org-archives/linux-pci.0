Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC536F405;
	Mon, 27 Apr 2026 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262029; cv=none; b=LnuwxK6nXHzFiIF2XDbSfw+miJF1Q+D5h40Zf+ZcPdjCi5OAh7Krb1V0uif8NDgE8SVj9GNwlr+Uj1bdqYYo5P8Opm/RSDT6AhxsE+s56C2jgnSyUx2ie7SNFQH2/QhdpRRx87YJewOd9Dau4Twux7hgoo2rrp+FdJbLZ+FFsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262029; c=relaxed/simple;
	bh=jsEb1yLjA2XTL0QV8lS7eXoA5i4gmq03FD7bi6mGHC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsAOzZVFOXHubFLVG0Hl3iQXLrLst+qRi8H7tJ/9NW7R7PD+QC+IYFNvdyx7/EJPFdzk61WHKdQnlekT7DWbr1BUJoXR4ivnmgApRBXBUQxz8GoRv+yZr2cvqYClx5QiDkE/cQ3dqzKWlJvA2iDYH0+ipSgdgoWwW0zwrMhGcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW7RDIri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW7RDIri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29E1C2BCB8;
	Mon, 27 Apr 2026 03:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262029;
	bh=jsEb1yLjA2XTL0QV8lS7eXoA5i4gmq03FD7bi6mGHC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AW7RDIri5j6c1te6kR0SWB2Mqdw70uESFJPnqpN44RskdAaXg1lnYqrJjU0qLMVY4
	 Sh0vNRv8DT7EQX9MLmNhF0Tm+z0N7Bckjcbb0nzdu2+P7w9rkwSZiyQTJh98R2rLpI
	 azJDQTX2DdDLw38kfF5o3iu7X1glsEC5FG3C+/RaYdU3RM+1G3HPabfzTkixl2NS2d
	 MviLr0RmTGHT+HuP7xKK6KYtTdAQsa9ZczHJ/2aLmbNmNadalEu2UIf1Q/Vt54PC7V
	 vQBp4F2CyepWQJ7g+d40P2LrXdd+fUZzIAeQnL+qbGhUt+mkb56pIpn0hajG68oAkD
	 7miqXPnAfLzJA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 3/5] PCI/PM: Run bridge power up actions as part of restore phase
Date: Sun, 26 Apr 2026 22:53:39 -0500
Message-ID: <20260427035341.1425576-4-superm1@kernel.org>
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

Suspend resume actions will check the state of the device and whether
bus PM should be skipped.  These same actions make sense during hibernation
image restore.  Apply them there as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bfb521eb0eed7..793af4af2971b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1273,10 +1273,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.43.0

