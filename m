Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFB26E6FB
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192340; cv=none; b=XnOrR1etq/i+1U6dfAX6novL2vsx/jWSHqfSSpEvCf2H3Yx/rXHnjsnRlwaGt20c/fofnItXazCDXZO3NWKEp3Ip+4xzkMLwsA3jfIClKmNvzrhctronsEzXscUQSx6T8lVJdY/UngU8Xv2nJG8i1aUuJD45iov4L/+kyEkAa4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192340; c=relaxed/simple;
	bh=5m2pAtLwQAG5n3tjRHX6phbB0BVWp/5Ljs87oOwdj8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBVWfV97+Sg7zAdqxLSuHJPMXPs9FXQ3DtGnddzJEa4nKiMTyRJ9KrdHuHuXTX5nC7F0L03RvLMzQfiuXbfu+aBC1ho99IfG4Q+uyf9jMe3hHRgtbsfIIt3hfRw2flq8zuFoPswgOQjxv72ysHqpSyOPkIk15LQbz2+3IDnykdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iii85N5P; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iii85N5P"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230d228372so1092736b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192338; x=1769797138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWeU1UwAO4pe3zvezy5Kiy+/X4gvo5C+nKCDnSN6RYs=;
        b=Iii85N5Pi/y/INIcmqQdLiO2X9IdeQaJKJLNO8jGLxiuIIspC2f3zmjCxi3GaLbLCQ
         dI9knMV0dNphJwPAUlc0a22V8SA0tNlMLSJdBTclPixLlYGPkjnGSDqP0KtQwKgR25c5
         DDl61Zaytny/zEIikAsrCrNLi2KZqGpAvwIcB0Tk45AkIPqz3ef3/RFC7JI4F2gCCx5i
         OCg5bpaqwYVkrW+m1UmofH0oSeONcL95YDJVP26osTbLLuKL+d56UiX/oR5+Z2/fQy7p
         pWPEi4YHmRMvAhl4GPDFOUGtpMBAp6bnpUawmTiqqyye8jf5HeNXdXLtfWo7H7FYB7Oz
         tguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192338; x=1769797138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWeU1UwAO4pe3zvezy5Kiy+/X4gvo5C+nKCDnSN6RYs=;
        b=PzZCXmV0t7XKlHqo2Tio7n1bDPHq5FvIGLjmhZKp2aFrqv9jaLgBU4PyFTyvK8QnGt
         9iT46ztd+FttBEO9o1dOdTeWUYGmIpderomNIdieLqgwoVGGDejqL/rw0xblPFB1GBm/
         W5VanZyVPOtKuwkyQ7CVMpYY49IW+lB5mM/We8e/UdR7F8obn7Hgpd5p6CTOHGqoFqxV
         wpv0RO7g1tJJNWAeLueCJvuqGQy069WVoLjg4Ou8AFVcGspedsc+h0VtV6oFp0xY4Yna
         3olOJBOK95+9VKvzEJglLCc2qDqJYnoNXFt6qQqsRYb5Oy4rxCaNxa9oFHAHJGOGLxVe
         daHg==
X-Gm-Message-State: AOJu0YwquDIBU/eL1ufLfQqDCKZC6SPtbinvH9XhnH6tAWCWTLUxAFVV
	9NmSO5pfQ1ONcbBJw06EZPGk4xtkfsTbisx/w8Uvs/j7PHQ5dD1YqTIq
X-Gm-Gg: AZuq6aLerL3Mxw6vokz4i6zHHjQt0silU5ogSawA2abSJaRUMX3XVTSzMGiExsoMoP4
	NwmdiHYihCZg/ocf/X2MrqMcFqpZrVhnuF4EJ0LH2d8XQuOmuH3+570VJuuPoV7rrfktCHS+foX
	1NX3r1Obkt4Rsh9jfpbbsdrRSEuQkbv/+n0dhGYxpKVRre+xgb6gkYDr9LoZwMD8g1mixh1/LFw
	LHnJ9ykU90vdhAVCyTgmLQBYOKFXXTRMScXr+jQamXzcbcbOZMQKgAvz1zmWvcScjVzc32RbVHL
	iXFoxGeh1vfC7EV20QfaJsE1JOsuKthWlFv3U4ozZJjnGbTxQgrumi+ab8QRDlWtl7ld1P/EAmx
	mppc8alcewsqnzS/tVSOMQGkI/6vgkHaaVKXmOx81erX9iaY7pdhvVd3LspdL81wI1O3pCysLgP
	/CTxTYwJHCAKHslVIL9h1VzK/p
X-Received: by 2002:a05:6a00:e0a:b0:81e:63b9:5830 with SMTP id d2e1a72fcca58-823215d894cmr1814046b3a.18.1769192337818;
        Fri, 23 Jan 2026 10:18:57 -0800 (PST)
Received: from junjungu-PC.localdomain ([188.253.124.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873fa99sm2737765b3a.58.2026.01.23.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:18:57 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 24 Jan 2026 02:18:49 +0800
Subject: [PATCH] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIi7c2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMT3YLkzPjM3Aoz3TRL8xRzAwsL85S0ZCWg8oKi1LTMCrBR0bG1tQD
 csCPOWgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769192332; l=1059;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=5m2pAtLwQAG5n3tjRHX6phbB0BVWp/5Ljs87oOwdj8o=;
 b=c1kmFZYTjUboD6aDt5uIFJ4j1wdUwKwQCWHZWpd6SRlVQvVyjHEumpT4BDWjLBheMuh5h0/MJ
 gOEw7yXl6kNAAkxZ6ysWS9FtiCJsvPbL0qMBG7hJkMn20pzp7jVkVau
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In imx_pcie_probe, np is obtained by of_parse_phandle() and must
be released with of_node_put() when it is no longer needed.
Add the missing of_node_put() after of_address_to_resource() to fix the
leak.

Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1d8677d7de04..3ae02712d3f0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1675,6 +1675,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		struct resource res;
 
 		ret = of_address_to_resource(np, 0, &res);
+		of_node_put(np);
 		if (ret) {
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return ret;

---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20260124-pci_imx6-f97d70887dfc

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

