Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FF1FF7C5;
	Wed, 23 Sep 2026 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193512; cv=none; b=FqqBO7MI1b6Q+7YAufVznR79jR3A2pJTECZyw8AivjvNKJ5dUIOokybpQoypYGrO7WUb30lyt+TebqRaYqqBxqZn7bNwlzQZBH8CjiVyJB1rCLthkbnnVM3bqZxFJ4A32A4FdTKoM+kGxvsOutevy4XfzjZ6Maiwe45ibvSpO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193512; c=relaxed/simple;
	bh=gtRswGSO6BfGzzBK55dTPdffOFRfljjow58FmVThMMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShXMqmYCeBOARUtRUa/jn8YTlFc9cnBow9YzL0cRI8isBdnh/mVN/WR8YgK8sJYNcsMgj1PiNotkdpWLLFZ9DCdRUWgtLT3wgEMFhrh6cL83rBTIolI6PiS8/N9rolutwtx4z7/rffgkzeYy8Jmin5JYkKvLzC/W6f3PTXBa1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSgWCpXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSgWCpXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326601F000FF;
	Wed, 23 Sep 2026 19:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790193511;
	bh=Oc2c8KHRCPZFuYbcZkQZuUACAFU7rPrmqI+qxHiACvs=;
	h=From:To:Cc:Subject:Date;
	b=LSgWCpXABceUBpg8G5iXGfromoFhSlW4sqViXKsSkC0/wMZosCqkeNgl64F8Qt7uz
	 4dHpNDmeBfEjNCvPkRFMFJPJhWb2vQ04xiGBKzi8GqHJZt0guKFjzE/map77uIb121
	 EGSvqMCVocTzfAhWol8YtB77V43RLX9B4S4B+iC1t+uzhyLfmPTM/p+D5lXwo4GiIB
	 DA/rIQZ+d5yRPyvdIKxoesr8Dlw5nDqTCZ5M20r8RyaGEAYa9jSeE7U3Mtun6IQYkU
	 noZb4+llnwXj2IH2OKZ94zTUem9O3jyBOhJJjUCVaNcZ0tD+h+d170rGFq3VSQ7jbK
	 J+sQflVuDEIgA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
Date: Wed, 23 Sep 2026 14:57:20 -0500
Message-ID: <20260923195719.1933175-2-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI Express Capability begins at 0x48.  Link Capabilities is a 32-bit
register at offset 0xc, and Link Status is a 16-bit register at offset
0x12:

  Link Capabilities is at 0x48 + 0xc  = 0x54
  Link Status       is at 0x48 + 0x12 = 0x5a

Previously the driver read Link Capabilities with a 16-bit read from
XTL_RC_PCIE_CFG_LINK_CAPS (0x56), which incorrectly read just the upper
half of the register.  When a hotplug-capable port has no link during
probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
width from unrelated bits and requests the wrong interconnect bandwidth.

Correct the Link Capabilities usage by adding a XTL_RC_PCIE_CAP definition
for the base of the PCIe Capability, using the existing PCI_EXP_LNKCAP
(0xc) and PCI_EXP_LNKSTA (0x12) offsets so they're easily searchable, and
reading the entire 32 bits of Link Capabilities.

Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
Based-on-patch-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

This fixes a real bug, so I'd like to get this in pci/next for v7.4.  I
can't test this though, so need a review and test from somebody with the
hardware.

 drivers/pci/controller/pcie-tegra264.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
index 653136db401e..c97576ab4a31 100644
--- a/drivers/pci/controller/pcie-tegra264.c
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -49,8 +49,7 @@
 #define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
 
 /* XTL registers */
-#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56
-#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
+#define XTL_RC_PCIE_CAP				0x48	/* PCIe Capability */
 
 #define XTL_RC_MGMT_PERST_CONTROL		0x218
 #define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
@@ -118,11 +117,11 @@ static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
 	 * possible, so this is as good as it gets for now.
 	 */
 	if (pcie->link_up) {
-		value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
+		value = readw(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA);
 		speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
 		width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
 	} else {
-		value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CAPS);
+		value = readl(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKCAP);
 		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, value);
 		width = FIELD_GET(PCI_EXP_LNKCAP_MLW, value);
 	}
@@ -263,7 +262,7 @@ static bool tegra264_pcie_supports_hotplug(struct tegra264_pcie *pcie)
 static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
 				  enum pci_bus_speed *speed)
 {
-	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
+	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA);
 
 	if (value & PCI_EXP_LNKSTA_DLLLA) {
 		if (speed)
-- 
2.53.0

