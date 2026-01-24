Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D72BD0B
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769276321; cv=none; b=qgYWMqIFJHWJYjcYpvrYbcAJLObkbsc4UBhIt8edg6wnCUYTgQ5W7naqIxjDyiFNOSse728tiJ4Pn1YUY2kTdFaRkLsU89gVOvrUo0PMoFH2yXjBRHkoyzYSVpyr30fLYoL7IGe4OMV2cyFgONelvWD0hegJBTajsrUE9wAICTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769276321; c=relaxed/simple;
	bh=N8BJ2XoL6RWsSMDXgT3y0d3NEwsWENvOGYzbokKPriQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLNXr4xDZN8lN/O+kGIsWCngAdqQoe9Frp/nWpcdWCiZcUsU4Hujc4xjKisoWmbK5Mu5ID8vo8SiIgepRnYF9E7H3NFlbZzcjbWZlXXmkdZhsRjtn+XRYMm4TxCc8A1D7wNQkwlXhMYfMKK6qErN3xiXGG6FZJvraInRYjJEzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdJPUkX3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdJPUkX3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6c922850cso341088185a.2
        for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 09:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769276319; x=1769881119; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hu27MEk2joWcihG8erKat/1jVTiWwwVOoOBwBr4PT6E=;
        b=gdJPUkX3MDe2FlgUMq2MJjFppM7vcXqV0Nbl+277E0QKGTizxCflsRJ25SmwQNhxIh
         KrhCy2XGQZMaru71bfzFrmYnlUDooz6h+03/CGZQTrCit6L14l33iQeK6fAtXF2b+mk9
         jmuf7TW9mNInZzBIn8dgxmT1ggpLDBlKQTKs+OvvUbZiaIpbh8xXPEQXKM3q5+Cf3EkF
         owgyeWQYfBmv0DCdtHALGn8lhCKd0A2L3NIosemgz0pLYU5CWCXK17bORZTCEsIEcnoZ
         Y6nOPatFEt0YRbvnTLrSXFSeTXnEmIbDcipWnarvuKOnbSNqJ1onoORJVWzQm5AlEgAB
         viHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769276319; x=1769881119;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu27MEk2joWcihG8erKat/1jVTiWwwVOoOBwBr4PT6E=;
        b=a30X1bGBNKTinlXfmmO2cTWN81cggwQXroA9/idaV4lW4jtpQNJ6GfPDjUI+heowLq
         YTc3A279Jekv/RFZda7crHLjXA+OOjvtcp+TKteD2ZAegwnSpS0NnT14yNvcSSlUpZA2
         7ceSw7mvCfcVP3f/1NK7d7Nr+mwrwwu9BxHAhtXstOi+VGwLqmyDnqby7OglLgtd2BHf
         Ug/e1x9Ei414C/MCBJTSJu5euCn5Yw0sr46CiinZWMkTrGZJchoHkqMtS8HceC4DNgyv
         FTo5D60Dbp7IoyOOO/BuPZ8dNS3wM2+IsqjpFuqDhCMy/JzHyncGWg2EfCisez3w5wPW
         TiTw==
X-Gm-Message-State: AOJu0YxvgESnmcYlyzTZ2DlbEwKnn0gZvLFwe47Nu+xXI1PByBZxS7us
	UWWdE+niIEkW5Zp6blPbIt3UT0ykmPOG1QmsFBzBva8ECafCmgC/MQpkkexx4fn99lc=
X-Gm-Gg: AZuq6aJjEu1PqMBNQye4Mux9pwR/SVNirNc+dU76dp67FIkSf4F1kzv37E+VgcDbSb3
	8MlYK7mik0/cyPJ1Q68+8K1RG1KsKI2EIgrMRborKnMEll5/XTpJOVpkwrb8/kwet/KTMdtW4Y4
	5gp/HtAtXMZFpAAznPPD2+lrCy1NjMLU7QVF/2vm/LvjUSWxeTiYm1+QQy6Jzoo82Cph/WuYmcx
	/uscES10G2P6oKItb4UGmkjzo96Hqq3PYSDqqrFPNz/3Ps8JZFB/SJZ8b6HnNWDp69pQcIBQOrf
	Cq2hTgaZJjmsCYLOa38r5DTJm+EgleqRkMVa9UgK/zhoV7lYZ337R2rJ9KhFXobIRFew98LcxYv
	8q2Gwu3bmAkgXCjrlnXUUED2e6IQyi8CpQ2jn7/0ShOoK9/gZU7qZnbQzpNUtw2csxNGoSWNdy0
	xPcUV7r6r53Agl7nW9bGiAIbMD
X-Received: by 2002:a05:6a00:744e:b0:823:3056:c2e6 with SMTP id d2e1a72fcca58-8233056d753mr1391339b3a.67.1769269376898;
        Sat, 24 Jan 2026 07:42:56 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318666c16sm5093118b3a.24.2026.01.24.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 07:42:56 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 24 Jan 2026 23:42:45 +0800
Subject: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHTodGkC/23MQQrDIBCF4auEWdeiNtWkq96jhBLUSQZqDFokJ
 Xj32qy7/B+Pb4fkIrkEt2aH6DIlCksNeWrAzOMyOUa2NkguFReyZauhJ/lNMey11bzrtEUD9b5
 Gh7Qd1GOoPVN6h/g55Cx+6x8kCyaYwvaiezRXofh98iO9ziZ4GEopX1OB0H+gAAAA
X-Change-ID: 20260124-pci_imx6-f97d70887dfc
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Trent Piepho <tpiepho@impinj.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769269369; l=1739;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=N8BJ2XoL6RWsSMDXgT3y0d3NEwsWENvOGYzbokKPriQ=;
 b=h6ad2YkaTwuh/K5r3ATTlVSOlDZhd2RIYTIws/ygz/DGkZChc07DnBrwAdCZ7SBoQUMA+VBAI
 YHNWHD+cMCrBBP0h/b47zCHs4WZV2TsrS6/fjuhJKNurMo7ouhPSHlC
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In imx_pcie_probe, np is obtained by of_parse_phandle() and must be
released when it's no longer needed. However, it doesn't release the
reference, which cuases a reference leak.
Fix this by using the __free(device_node) cleanup handler to release the
reference when it goes out of scope.

Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Use __free(device_node) clean handler to fix the leak.
- Link to v1: https://lore.kernel.org/r/20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1d8677d7de04..f459d05ecd7d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1643,7 +1643,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx_pcie *imx_pcie;
-	struct device_node *np;
 	struct device_node *node = dev->of_node;
 	int i, ret, domain;
 	u16 val;
@@ -1670,7 +1669,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		pci->pp.ops = &imx_pcie_host_dw_pme_ops;
 
 	/* Find the PHY if one is defined, only imx7d uses it */
-	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
+	struct device_node *np __free(device_node) =
+		of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
 		struct resource res;
 

---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20260124-pci_imx6-f97d70887dfc

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

