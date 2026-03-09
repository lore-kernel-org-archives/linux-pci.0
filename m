Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C0A26B742;
	Mon,  9 Mar 2026 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032423; cv=none; b=Tfs9A0Xxy4cjoH7UrSz1i0F1L1gMWvL8reAtA69c7syK31/EHMKEyWS0iFCS6pV35RPD8g9akhAjjPVP7fEifbuZM1TybXSDrRyyCrxf3JEoGRn3BT7AmKpGTyyVmX+ttiSNjYOHjBSkEaopMhKmawcDbvc55Gy9AZKNf5AOmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032423; c=relaxed/simple;
	bh=ayCgtB9zMgsE+W33btw4vHTnJ+BwPYF1bU5rNqi5RG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXiRebX9Sw7f3AVb6WR3R4z/t51oBfx67cyEhE9Wt9UqMXfOajRmxloLPFYESWZFDdiDVsx731s7iIFg3Cb5aVMNYgyKpk6ZiQzPVsxD7Wf/2HTrxjdpJHw1nX0tRP7kBchKHX13Vlx1Vf/UIDTwp3VLLmbMZAHb0Q/7HpEcuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5B91650;
	Sun,  8 Mar 2026 22:00:13 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9153F7BD;
	Sun,  8 Mar 2026 22:00:19 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pci@vger.kernel.org
Cc: herve.codina@bootlin.com,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] PCI: of: Reduce severity of missing of_root error message
Date: Sun,  8 Mar 2026 23:59:30 -0500
Message-ID: <20260309045930.21531-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm64 kernels are frequently built dual ACPI/DT, and then boot in ACPI
mode. In this case, there won't be an of_root, except for rare DT
described PCIe boards.

As a result, users in the common case see this high priority worrying
message, despite the machine working as expected.

Reduce this message to pr_debug() to avoid unnecessary noise.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..4115017f4139 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		pr_debug("of_root node is NULL, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.53.0

