Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885597;
	b=Jl2ZCZK6sGjqw8+sxhTzN1zyA7pJ7i1lb3esSq8RmpWXzAE0Ow1ed82+NKNkGbfO+y86
	 cK/c7oOt3tpFQOWQDt9JUfHXlksCnc1KDxSAKYyD30DgJ0p3wQrK30WsdVA4DMNtAHLi3
	 Jmhgsk17VrF2bZe+/prKcajdd3A77EsCpCJXVUNfSmrhyz9qljll5dEqrsIu7FrGH/sQM
	 422prlqP1vdR6x2yZHplgOZly4Ub0LWfjTZE59bG1YMVvjxcVzMNuXd6jp0ISyt/jCQs/
	 xho+qGAJdYykwzr5N49VOM9Ev5B+TDuWGtN7V3aMtwhbElioPT+fzBNExqnKJ8oiIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885597;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YbssYQbB4JLy0vSiuD/hwT+UYW+ej74pKnIb9aaZiqk=;
	b=Bm2BmVzBny3nilF7BXTRpoPGK0RQJ/XrqY0j4UcqT335TFYRbn7ZpK7Ujy8vXCjGbuJS
	 3yGIS1ks8dGqfchIpQVRX5V2iDEJSNymmzaA681FZFGJ3qimtZewNKtp4201ZyNsdq5j/
	 MFl6lsQi5dXceRA/0+GtG6tgIQF1i7T+Lm0LwD7SQfurvvqXAhD8tm+Cu4UVSVc2BpkyA
	 HqPT7CA2cW0EA4zuTodEBRc5/+1Wc8baM35Bhvsw5b7at2H3Xw+lgLXVCIWebYbtCLBvo
	 4X2vj8R0leVMfFfghgJa937lAgKPY1Mpfx/kCUwcNBfLFrt9h8raFRwMAbLsJ4+s2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=I2tEcOSE;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E61606D815;
	Thu,  5 Nov 2026 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E61606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=I2tEcOSE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=PoEgush9aFsqQlzS0lqV9IGVwSbPS6uQnjHBJkFkonc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I2tEcOSE8UhVS1D0BuOUUBWKxpEf0PxJPfZ5ke7jkfCfNehogOU2eixVXh1g9Bvdz
	 kT9SI4XcNt1JO9Ll+BTVVVaoUkiketIV10mr/8BpQph9k/FFUO7dDsXlKek6BxEaeF
	 FVonW6WE1QYr6L2I+1DtMj4/1+5EkrgjS3j/6+bAoqPR0Ug5mbJFY24R3XDSfcktHs
	 zDDgpTUSbkYZO1PVwwcLJOcAMTL8bB3xesDSzC/dE7T8j6jvNOG1NLKFToj+XGI6uY
	 VI1Ggd88vE9wLA6rqUZ2W+by8RnYcuniYMOLTejAU7+RMylUXv8Qs/tigI4ufF4nN8
	 0qSs8Y4ryXdcw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A9BB17E0C39;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EE4BC48003D; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:16 +0100
Subject: [PATCH v9 8/9] PCI: dw-rockchip: Set broken L1SS resume flag
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-8-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=PoEgush9aFsqQlzS0lqV9IGVwSbPS6uQnjHBJkFkonc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZbT8DYydnK1H+vhzDkeZihraJeSXlrcR
 f43OEulWH2SgokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaXFEP/1piWnY13VMQD5+HXTGoxklRz8Of/4yzLfGzQbZyZglyoaZKS1CIdOo/Mf5TiUn06pN
 6aPKL45MThnVfl/IU+wV3sZOBOu/1/1FWeawIrgcKr9Jlo5MyuNsmXrssx6E+E9YazzG6X22v1a
 X9v7ethg9Sk3g/3TXHvyHgP5as02IVlw3MXYS6JR55tzirg2/iaMDDe0BQBkb7OgRl8Vd1TLTcq
 z6SmPhxS1kXglKFMBswrGj8IYLlG3rmR8tFgzBxDMPEkn8wPa400pu+2DevlqxBvLHJAIECe9qw
 W09/65qjxNdp6U3KwYbda2h9B6VwLmIYaew6xZSPGWasPDD2IuoxCZTYUEs/YJY0hIj2xRjn01x
 e693akWrTIEBW/9ERDzAmVBNwZl26HayK66xJrkEUq81lLMIulsn3ZO8PIY9JJTkiK8nRqA4Mmg
 oh2zrelWj2Bj7m3rMQR1QbYHDDpXORPt0kpDwJN3fZr7SN0RcPgxAzIp6pnRnfzD0pgjz8o6z6p
 hJasrR867gaFh/u67Ir/Z5+/PfphZkfqQqDlWjLKgPeABm074xdQlLXL4Z7j1XvHa+aTzwOOMOZ
 IIzVAMuxXAU0EBJdxRKCfeQqxkfIBA+SyIXIgqjOPFxPAS1U/0kBieKlCjpzuTv9Gr271+Fc51L
 9lBDUgDzgE+suB+uEH9gqRQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

During system suspend, the Rockchip RC driver effectively powers off the
controller. If the link is in L1SS and the endpoint asserts CLKREQ# to
exit L1SS, the time required to wake the system and restore the
PHY/REFCLK may exceed the L1SS exit timing (L10_REFCLK_ON +
T_COMMONMODE), resulting in Link Down (LDn) and a reset of the endpoint.
Set broken_l1ss_resume flag to indicate this limitation to the PCIe
framework. This results in pci_suspend_retains_context() returning false
and PCIe client can avoid relying on device state being preserved
during system suspend.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d8968743732c..a603475d4450 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -448,6 +448,11 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	pp->bridge->broken_l1ss_resume = true;
+}
+
 static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -487,6 +492,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.post_init = rockchip_pcie_host_post_init,
 	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 

-- 
2.53.0

