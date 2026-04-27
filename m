Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F93659F7;
	Mon, 27 Apr 2026 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262027; cv=none; b=P3lnWmXiwSoYs62YexCsQYVuu6tHvzP5g9zI0C7Xn1rLSIsq9w8ZjjS8MxQRGhcOOK2kkDs33VZTUCYfk820X533W7rKbc/bo7NjdEV9gANrw46Hokt6fF9iOowue0bx15pS206j0d72rw4n+YZ8l85yaEuexlNhLbB3fJKL5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262027; c=relaxed/simple;
	bh=wzBG0w2sgd6l6ANTHLzOSqnr9bLkcENBQXCiLA4GCiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwDkI+HnLRqP73AaEOHleBJ8q3vwY+uHiQuO4rF6BK8fAj4A/qJQdl6KjVXFaenfVoqetR1gtXc4gY+Mzz3ex3JdDmVCxRH50TMuHBQembTwk/VBrnNHcFOievRg1Wq+IK2SDCkhD9tFxKQ8NirP3azhn2W1n6uMAcf34FdfFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjV3TWEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjV3TWEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC947C2BCB7;
	Mon, 27 Apr 2026 03:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262027;
	bh=wzBG0w2sgd6l6ANTHLzOSqnr9bLkcENBQXCiLA4GCiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjV3TWEgFWFKkvt5KhYBneIWX5gsLvn97BcAIM/ez88yZ4ImhhjahBwjNPKXN3kdb
	 s3IlkDweSidUY/fZ65F00KlIyJ4JMYmYbW0+xeSc83PMzq11pvKig2ZjsGV555AL2g
	 9yva1T8xPSO6Ql9WM91hSgjLXmhEka7g2N9UGYBxt2qy4qoVWdN6Y7FHG9Sjt3vWOZ
	 Mhxd59gjRxt9VTE3z3MLfYCDOPm2kt5ajC2da4gYvVw0NMADX7w5V0RslZhoC5j5dy
	 Ga6QRpbfq/WXNCijtcU0/ZwI56JOKVQ7Osns3V63qdRQXjRkGvOZOp2mvShF5oqpc3
	 hw3gJJXM8QuZQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 1/5] PCI/PM: Disable device wakeups when halting or powering off system
Date: Sun, 26 Apr 2026 22:53:37 -0500
Message-ID: <20260427035341.1425576-2-superm1@kernel.org>
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
2.43.0

