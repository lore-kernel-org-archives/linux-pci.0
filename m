Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA238E5FE;
	Mon, 27 Apr 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323038; cv=none; b=ccFOgXKEb+PIsA/F+3jatp6PsGsAOyq+GSMfbZNyuwq0miHBO9Qx3ARMgXiZ1tzQhtLW8id18YHSbn2iPtqdMktDQs22T/MHIDenJlkM49hPFEs33kAssCS5ap7NB520xjAohiIq6GE7tmGTkZc8y36PFX/8LtilWZBOd9COmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323038; c=relaxed/simple;
	bh=Mvuxmuva0kDNJ/mqs+2loiDl+jGybnJOzh2+SFptSyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIxduReS7uVqsw9PPKZVhLbhEzB0HTwsJV3MTH/bw/9d2OauWdR3u6o5TsJmLXppUu0K/jHvEEU1C7f1t97WPnm8YAMHds3GAG1hc8qjcQfG9FVsNc8MUd7G9u8Xi7CLaxft1g3g489DsghcuISz+jMK5atyM7GVQ2HvLvvhrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPIK3IGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPIK3IGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E10C2BCB5;
	Mon, 27 Apr 2026 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323038;
	bh=Mvuxmuva0kDNJ/mqs+2loiDl+jGybnJOzh2+SFptSyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPIK3IGYVtrFovBfacNIdpfayOVHrn5TKQ0L/cjBUkVUm90twM7hOxkO8JflwmFPA
	 RiMD37yohHQK3sRv6DXriMLWV6tzNE8I8QTdmkIyFPJJ2SPPuRBlY9iypGDDMg0tUh
	 ryfUo3WUXJrUUDZzaei5VJwa6i7pShejyNI7sh/9LdIEJxVhGBUOWfOjs/KA2FOl7C
	 0JMklnhkQklpx1BJK4fq9oCP51ZGZfRJ5yRHlTakp/raTLJwNS6YxlcnTBtDzt9rA6
	 VLoHM8sTCie+eB27qSSNKUTtCJ3EtEZpV64XCIefqtuLNP+DgGNYa0ranRhTorGKQb
	 DUOvls6Rpb9TA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v2 5/6] PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
Date: Mon, 27 Apr 2026 15:50:23 -0500
Message-ID: <20260427205024.254677-6-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427205024.254677-1-superm1@kernel.org>
References: <20260427205024.254677-1-superm1@kernel.org>
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
2.53.0

