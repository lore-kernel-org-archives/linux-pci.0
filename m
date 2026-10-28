Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208137;
	b=SSU9LAvsg9uTRbZ5CWZLIFGitAmc0CkBMXgYzZ3AuPfbLbHC2z8w5aZQ+e/D1o2A6T6j
	 BHkMtgvDlDsFxQw4/+h+2S8IMKgkZh2JNagG/u6euJ7kI/s8+aRv7oIPXH32lnmZNiUSk
	 8yoYQ2BVbRDCF89K+VK7vIKx/tI2Mqa2mmHyxjcWhROz8RK45yET+vwnWRjN2TCcA+vBA
	 Go78P+APMw6ElZ5+cQupD/z7nzgYFS7e9X3+HoXZ6B+1fQGIW4ggo+9Dv5GwU6aYTfOvk
	 nvICV4dFa8EGA7ESgyHQqGqV6M4bFFGv5j1PqNn1tjdPfz6u4IL5qHMcZ1tpeHXPSBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208137;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=aEidZhhwrUTXM+w//HuRFj73DcC7JXQmjVuX6ImPa8s=;
	b=gGC9iCBGvfdqA/lUw7TNa9OyEjvAyr8BclyloU7lKIyxIiwYxlE/i9wDyF3MHi8Lwxld
	 Q7X8evz0yCbXzF1lt8/YIl+6ek6GugdXuCsBD9eAISu+ioKqr1tgAS0ySGul8pYW1HzuI
	 irXgkrLspGYfvLbyYIQJfNM5h5LaMA++Y+FmAGHyLKzmBvNQjYGVb2UcsEQ2r0KT5fWAz
	 MMjVqq3lHcgp1Sdh+OOTXKkOb/WyXdNx09MGxaIrhvRfLS9qFtuOp6FiuTvVKt6qbH8y7
	 m9t9kPP78Q/LIGRYq98+eUggb8OLWA6COaM86gw2tsqsHZcuUI9MzxZ8V3v4ptHlSaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wzASiMoH;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AF606A320;
	Wed, 28 Oct 2026 17:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184AF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wzASiMoH
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jFDgm4h7nzMllK;
	Wed, 28 Oct 2026 18:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793208132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aEidZhhwrUTXM+w//HuRFj73DcC7JXQmjVuX6ImPa8s=;
	b=wzASiMoHJgrnu7bDADILYsqNfmDoiA/XX5pdjZmVXWwytYUzznUc3fW+MPdigdk/J7wEqo
	yMKN5pGSLVI9OJ/sWdqmaJ4dueWshUEYsqQOro9tRPuUlKEUkPrKzTs6Ch9wsI9uu1doRs
	VkZdtu7rdMv3Tg71YEVkAqhVQQCCT8f8Pm9Lo6qCbcgl/8P9DqUls9lj3k1ex241FBYgE2
	v/sCrtR7V1PzJDOpnUWunFY8mmJ8iLzbmIVSlLQKAdTMd5G2kEje/D1ZBkjgrvZclacMvp
	Ah4S3fJEWRCYi326XrUuOydX+zhan4PeYnjjEhiBfkU95pcKmADmBoAN7XbYpw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Isolate 256B MRRS limit only to R-Car Gen4 SoC PCIe controller
Date: Wed, 28 Oct 2026 18:21:49 +0100
Message-ID: <20261028172208.20948-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z9r3xg88h8dic7b4tqnqsnpiz5oj7bko
X-MBO-RS-ID: 099760863b7ed2d34d7

The R-Car Gen5 SoC PCIe4 controller is not affected by the 256B MRRS
limitation that was present on R-Car Gen4 SoC PCIe controller. Apply
the 256B MRRS limitation workaround to R-Car Gen4 SoC PCIe controller
only. For details of the 256B MRRS limitation, please refer to commit
f0a5c6bd797c ("PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes") .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 9a64a9f4ab0d1..1e4405181eef3 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,7 @@ struct rcar_gen4_pcie_drvdata {
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
+	bool mrrs_256b_limit;
 };
 
 struct rcar_gen4_pcie {
@@ -663,7 +664,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	if (pp->bridge)
+	if (rcar->drvdata->mrrs_256b_limit && pp->bridge)
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 
 	reset_control_assert(rcar->perst);
@@ -1136,6 +1137,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
+	.mrrs_256b_limit = true,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
@@ -1144,6 +1146,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
+	.mrrs_256b_limit = true,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
@@ -1152,6 +1155,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
+	.mrrs_256b_limit = true,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
@@ -1160,6 +1164,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
+	.mrrs_256b_limit = true,
 };
 
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
-- 
2.53.0

