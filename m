Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794A38F227;
	Mon, 27 Apr 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323036; cv=none; b=VXIUNdtGjGXaaldg8Sv68FUiYrT4I2YlffHYhOpY1ZEgt6pGGdEnbz1jAIj7aTNuGtGJfvV7Gld4qqWY7D1K2XFZYPKCWdL7BSKDfJKSqaoGBRfIFcFk50b+0h8hXKw4GKv03+lRlIygD6nJ4VN4BqUTBcB61m15+EaGREtQhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323036; c=relaxed/simple;
	bh=UPXBiRd4SA5eur21yzpLr7D++JspS8VTBQMuLpFCYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awkMjGrZvV3iajghUY38GxRB3jhKDdaaaENIgSg8PnrNcQ7SqvbLm2wag+Gm42rAKHzvJvTof3zKytJKO02rWGAAubzUk+hodq4E4OsEvRtFiY3NffOWWtGTt/GCOCKVTsmhP7eSIy8jIGt8YBZcLt73J9Z7qFuK4Cw1+vPBI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I87S6JtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I87S6JtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A29C2BCB8;
	Mon, 27 Apr 2026 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323035;
	bh=UPXBiRd4SA5eur21yzpLr7D++JspS8VTBQMuLpFCYlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I87S6JtS9kwHbfdWDF3DQr40oj+RFfnCWDfp5LDfGnYzJsvBR+o6U5L2QywyuHOMi
	 h6ogMUGq5A3mUygVBonyG+PdRaWmGup7+u2q1M2wz9fdIvxyOfP+n/UJVc5eUgjN4k
	 tRWaN0gI6ZaOF0dgJtvACF51VibBB16WIi6D66tR+7Vw2k1uLHBioJ5o2lsnXesQIt
	 XNTfBoieoNweTvitLIX9mH4ENjI2OJ619cNO9tvHKiot3IFTyl32HELcpLrxD2mIyS
	 5mavBHFd6vZ3K0G6KImwa8LaRO7YkcpkiXapXfuUFkB4WsGSttiUuLC/TEM6Q12033
	 BfpjO3qo8ckXA==
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
Subject: [PATCH v2 2/6] PCI/PM: Disable device wakeups when halting or powering off system
Date: Mon, 27 Apr 2026 15:50:20 -0500
Message-ID: <20260427205024.254677-3-superm1@kernel.org>
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

PCI devices can be configured as wakeup sources from low power states.
However, when the system is powering off such wakeups are not expected
and may lead to spurious behavior.

ACPI r6.5, section 16.1.5 notes:

    "Hardware does allow a transition to S0 due to power button press
     or a Remote Start."

This implies that wakeups from PCI devices should not be relied upon
in these states. To align with this expectation and avoid unintended
wakeups, disable device wakeup capability during these transitions.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2bfefd8db5260..a43ee7bbfb3f5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1166,6 +1166,9 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	if (device_may_wakeup(dev) && system_state == SYSTEM_POWER_OFF)
+		device_set_wakeup_enable(dev, false);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-- 
2.53.0

