Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436F303A26;
	Mon, 23 Feb 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862531; cv=none; b=GKzsC9Bmo5vbYyq8q/XrT80DVL9Mz0IYKKFEVG3P+Gd0/FsGemLlkduhWRPeX64boM035HTE59rQOzzgHHeW3k0Lng+LrrrMV6gepUkAS3oxsbiklEWmXZuCy6byCMGzFD9cJ9x8z1Bz9K+QDJ1ssTCEvA/YATTrNXy9HuT7dIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862531; c=relaxed/simple;
	bh=ghcauBkoo/jQ0qHNXUYp82lwJ47JwCuqh/RwAg7/o9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qNQAIJ9Udd0j3r2PqPCoeZANH1kBESJszn1GXF+8/+SxPIyvpLrJilAUhpJnuMBc1r6qfm7wKaqmwMfS44il9tTWb/8ZB86dPYLeu6yLQq+IW7FfPng+6vTTxSbAvJQKvrnaePmOKHi02HrKMeuc/xpCQQTkEfhEQ8DWfKUISf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eUEk7obF; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eUEk7obF"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404611;
	Mon, 23 Feb 2026 23:56:55 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 27/37] r8169: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:56:52 +0800
Message-Id: <1771862212-89945-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b37cb1809cckunmb80f2457987f88
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1DHVZKS0wZGE9KT0hIQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eUEk7obF35KX3vz8VQlKv7vucQqWkLIn3vs+Somj/Gor67P4F2kKVjZX5S1k014qpr5Ze26ECoTJQeAv4pjJdVM+m/aHCKvtF/ogzRaFwvDcfN//SDHozU4fNVq6gqKRZdH36by5PGA9MUttKfykIqnIXF61lr8iLTjju6ZiOe4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Jty+Oys8Xh4YOyfLyh3sXEOFZn/MSFkx47AtlS+dRik=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: davem@davemloft.net
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2f7d980..e8dd1ef 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5337,7 +5337,7 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+	return pcim_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
 }
 
 static void rtl_read_mac_address(struct rtl8169_private *tp,
-- 
2.7.4

