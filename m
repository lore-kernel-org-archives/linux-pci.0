Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE3394498;
	Mon, 27 Apr 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323039; cv=none; b=cq1YSMbOp6eXJo64KUvUW0S22nMMs2C4TrzY51LSfLRa6oQPsJ9iamt+Ig2jFjv7aWu+yeS8ksi+PzhG0TtJIV1aFQw7+xYlNxkMC6qH9HoRnl6gMsrr2atpkCWKAOQhHZYeCu54VP4m1IRU7gNkP+gnz3BfsMsgMDgSbf9MOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323039; c=relaxed/simple;
	bh=sPxWKehtBU3nSAf+5nl2keVUjdobnlSMeJkZWg4OaSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOVZKv6VusQmpGquZV72B0j92PaefL6e2M8niIH51cCeQHSbmh2mScYAoeqpBNjkCgWfUp3XGHqUV+RsspY5d8QO+LcKXiL33+4Q7yLL6N9ofns+l1g52rjAaUW+kHEOxzrKqgvIiyZlPsBdgp3JLb4x2L15BvQHWYD3Si0R3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcarLd6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcarLd6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BA9C2BCF6;
	Mon, 27 Apr 2026 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323037;
	bh=sPxWKehtBU3nSAf+5nl2keVUjdobnlSMeJkZWg4OaSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcarLd6/nnG2tygmqd/sUdWwKPT++xf0ZGc9rdkq3frrAJ0KDUn/votKnSvknQkbU
	 Ia4r9U6ou/L8a+y2tyuaBO6T1MMXk8K8TLvLXKXqA75Pla9i8GWafzDyaRb0sncGPy
	 7EBlpiAmUHObkUG8iUpu+mVQfEqAGwFt1C8B4k1RiWMdM3H/jITGUNVpVrPzUjB1Lu
	 gMcBIGOSmQKQmRWUZQ2nt09MkLcLHqlyJVpBPKmIqtF8TYzMRnVPCYre8aufznug4k
	 vWx4ooFYXX65JiMUWiWWrafZOUwHjjjDy5Ohgljpg22oqwBMQIWZF5ym8mHMqRikig
	 n2vFaUuRjasPA==
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
Subject: [PATCH v2 4/6] PCI/PM: Run bridge power up actions as part of restore phase
Date: Mon, 27 Apr 2026 15:50:22 -0500
Message-ID: <20260427205024.254677-5-superm1@kernel.org>
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
2.53.0

