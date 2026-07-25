Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B22391513;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969983; cv=none; b=ISbb6Kh3/6rfnIX4+cmkZZM54Xj+ynfkFBh4IQIbFSeQlB0nCNPWPYCfrhMlQBrSDjiQLTQkT+m7MvM2PygT1X+LfPfjvc1RjiH1c8kxE5g6hlEsg0rffkeOBRgHaaceqZu0thllXxL7h/+nSvJAVAQKu6oEoqu5/Kl00eF+RUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969983; c=relaxed/simple;
	bh=mUFcY7Ucvkqa0Ukxu85HKc8cAHh68+ylRnL7IKPsVQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnjaQfzqqIcWKv29IGMm/2RxAk3n/9JgbIgwp5kn14TKV06BeusjpWUfqMzKlNfJNAnYA4CSm5Lexu2solscFmfoccQGUbhZ7hgECY9gSLi+dgFl8tBl6HQ/kLofGDJy2HjqZTP0d4kUfe1RQW6YMLadE0txapD/Ls4IZlH32Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ0osC1u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ0osC1u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E414EC4AF0C;
	Sat, 25 Jul 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784969983;
	bh=mUFcY7Ucvkqa0Ukxu85HKc8cAHh68+ylRnL7IKPsVQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IQ0osC1uoGdCz2rMEFT3stROJyHe6IZWrJ3jWd2re7kEluicKDobpoiGDJ968g49d
	 xYVxH3kHE1exk2JJUz84et3PaqPVOOCmEMuUJP2YcC6+3mbWDzf3U7OrQubZRbR+cm
	 yItTW24SJ3DORYwS52hCNZexQOCudFIT4NQXHXTEoEgQwqbfNU9+wvyB8m3V+xX3Dg
	 qjSM5XuGYngZqT1ZdpdMoC3FCEBoBXCKw84l9tEptCwwsQLxgScRIvZzOeU+QBtqWS
	 4ivgxIS1B6Ngz6zTC1mQ99AwC5Oxi3d1nrd+H9+r4yPJjbR2d/YDAJkVVEUNezw5L+
	 c8kdN20S+TQPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1609C53209;
	Sat, 25 Jul 2026 08:59:42 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 25 Jul 2026 10:59:14 +0200
Subject: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/ecxH7WNWbI7kGxlGTagbRtkJaVRNHl2xR/seTMJO/c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqZHr7jKmdMtuHO0GC8dPK2xrKIW1K+ct1FcSAw
 yx2meup4AiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamR6+wAKCRBVnxHm/pHO
 9WdgCACM1InRnx+D0thXR+EDXhVP/VoRB6w6hNq0SBHArGqWSgpISTRvzDU51mRZnmq2X3QhvbK
 RWYrHo+L2skFvfEWrqBDmtDIhvZzBFKtaGVlCJe0CoUKrPcwvvpLCnFsKjDVU0jaH+GOVSZZ7b3
 AXypsK9hLOU0i8HHYFkjDJ+4CSlI50/l8jbzOpGmwO+boNp65OMir0uT3/l3+W27EGnFtpRobpS
 Bh/NGPKjdteGVNxk+yFTkWyHFV8NGszw6beJ/dAX3QUh32zcOFkeIxxPcPDQmLfJj4OBuE2LuXc
 pVpBS2gI3yx9/qWvSZSonVkbog6pbr3IacOuueNQzQ0bxvgP
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
config registers for configuring settings such as ASPM. The Endpoint
device has 2 physical functions and those 2 functions share the same
settings.

Hence, parse the Endpoint node under DSP3 instead of parsing both the
functions. The existing parsing logic also has one OOB issue as parsing
both functions will result in accessing past the tc9563_pwrctrl->cfg array.

Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 488e1ec34a7f..482e82e433dd 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -596,12 +596,17 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
 		if (ret)
 			break;
-		/* Embedded ethernet device are under DSP3 */
+
+		/*
+		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
+		 * device whose functions share the same config registers.
+		 */
 		if (port == TC9563_DSP3) {
-			for_each_child_of_node_scoped(child, child1) {
-				port++;
+			struct device_node *eth __free(device_node) =
+					of_get_next_available_child(child, NULL);
+			if (eth) {
 				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
-								child1, port);
+								eth, TC9563_ETHERNET);
 				if (ret)
 					break;
 			}

-- 
2.43.0


