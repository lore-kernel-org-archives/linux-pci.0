Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D01391505;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969983; cv=none; b=kDY4KJmx13OyAE5p80orVHDVoOi1SD+fARWFGZ/agL/r5n2FkLdt9h0hGJhFCLj1LzLTMhBl8tAh2nkOshK6Xw/IEJDTyKFHbQ34DNGLQy7tJfS5K0NlyLzbplfENuAECa4Uv+Kc6PSs/ewWng2mhVWjfOBWZPck+p6/n7w6I0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969983; c=relaxed/simple;
	bh=n76bC0OFZuIke5PPRBy9dZzd6qq2zxK+J3IhfPNXrPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqjJUg3kMcY7WZntP0lY3cul6H+FCyI6t7AzLMgrD3pfp/ohrbBKTXsbG6Umlk9UOsYvzPtty0tIdnUvd7nBNU0t+PTbe9U8NIhgWOzvoLFu5RFn+zGfUapkpe6hmXQw70G+ptbsVdX9tskENBPQ3f/suPH+XhfcNDBMtTS2UwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7oyw03k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7oyw03k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D4DC2BD00;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784969983;
	bh=n76bC0OFZuIke5PPRBy9dZzd6qq2zxK+J3IhfPNXrPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s7oyw03kUpbJdIq31AkE37wD1SGuFDNq7cgV2o9Ikm2yAMfvyEU/tQ2VYpo5nZg8c
	 QyprzfmVaV9xlhMcRGAw0GuMgd89B7Rjwe/ynx/jbpMD+RHb1kxiFU+2gE3Xf/SYal
	 GNXcV2A4gXr0nDZ1bxaHMj9F7vR+zJwpsOCGwRg3frdF559wP+1ajwdrEselihsFJ3
	 IPKWlVym3i27Pa+4uTk40vH1eL7TGbzbM05cTLvD+HjCA8QPT7JYyv76OkaSPSgnVM
	 rfH6vzjIxBjxMhJ3m07ouHcOzAnFmRfpRGTlVtYxcktlkjsQKeKrupAxQGnFycvwD7
	 /WwXujh2iyy/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C0C53219;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 25 Jul 2026 10:59:17 +0200
Subject: [PATCH 5/6] PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
In-Reply-To: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ESW4WZ2Gmyx1Q1J/bfntG851pFg9myw00QxfynrufIc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqZHr8txpz9yA/RvyAhKnC8f78s7QZAAQC6FBiK
 zJg8MLnkJqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamR6/AAKCRBVnxHm/pHO
 9Si2CACbnfK3zT6X0gL1KX8QxvgnvEbH5Lo0d6o+o3sikAXDbZFueZ5H5IgmRJJ2giTrXZf2WOZ
 bG4Uf15QB+relNpiK0fDM2x85dOWAp0x06LrEPeI/316UdiEqJB3rG8n8q/P+iGzCnf99lPx6aX
 cKXEg3K0beVzj9skJRv/8PlS7rJUxI+f1hFUQOmnb3YEUjOZMe6hRW0M1qyvudqa98gzLPqKb8k
 wzRFXSz0yHiP17IIx/7SNASnSP9etUmGzJ9IpUKvF830NiV2iRr48VGgMXxZkq7akPA1EboBlZy
 iPQHb9uX5BPvuud4fUUwmfwVZoi4lUTq9UUAy8mMod0pYbv/
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

TC9563 Reference Manual calls DSP3 as VDSP (Virtual Downstream Port). Hence
name it as such to avoid ambiguity.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 28e9ec3e172a..f1179737f221 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -80,7 +80,7 @@ enum tc9563_pwrctrl_ports {
 	TC9563_USP,
 	TC9563_DSP1,
 	TC9563_DSP2,
-	TC9563_DSP3,
+	TC9563_VDSP,
 	TC9563_ETHERNET,
 	TC9563_MAX
 };
@@ -328,8 +328,8 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
 	case TC9563_DSP2:
 		port_access = 0x8;
 		break;
-	case TC9563_DSP3:
-		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
+	case TC9563_VDSP:
+		dev_dbg(dev, "Tx amplitude tuning not supported for VDSP\n");
 		return 0;
 	default:
 		return -EINVAL;
@@ -368,8 +368,8 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
 		port_access = 0x8;
 		lane_access = 0x1;
 		break;
-	case TC9563_DSP3:
-		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
+	case TC9563_VDSP:
+		dev_dbg(dev, "DFE tuning not supported for VDSP\n");
 		return 0;
 	default:
 		return -EINVAL;
@@ -612,10 +612,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			break;
 
 		/*
-		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
+		 * The integrated Ethernet MAC Endpoint under VDSP is a single
 		 * device whose functions share the same config registers.
 		 */
-		if (port == TC9563_DSP3) {
+		if (port == TC9563_VDSP) {
 			struct device_node *eth __free(device_node) =
 					of_get_next_available_child(child, NULL);
 			if (eth) {

-- 
2.43.0


