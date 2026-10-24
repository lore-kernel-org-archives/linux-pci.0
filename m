Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792803768;
	b=AnkN3Cu0KsIuxXKKGMbmKCtthKgtMhphY32sjlqAQv3RkpWFkiOuBx9DkcZvfvtqrCzd
	 WFBtHYamJo3Xvar8e4qPU9gJsNmhaWLqRFKohZsyLXe5ZkmYXHZUF0XAvdL71T8ZZZAut
	 G8DZDNK6KYHkXeP3l7BoCC+G9n3p0KkfVT7E4zyTm9c8vgayqkOuIGFvIUiGXd8y08UOM
	 G6tfK5EVnFVM40zDxsHFRYHvMSTVS+iMyo6U/lDdQM8CevifonQGVue0qwWOR/v6vvDcD
	 JHSTw37FIudaBw/F08lVRxBsQVXF/jqmjOLBhkoRYx0nngCdX+VGl0CvtfDETd5O7+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803768;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=omGL6LcMhGREa1S5q4pFujxAG/NXDja8zf9xS2NZp5Y=;
	b=ii3C1o2/GBKnKbv8HhDsoZHgIFo6kFGUG3TpOw/Nhhf4psW72R4Uek99W0+pm6XGtAPC
	 5P0HfmOjhoiqAU/EFSOqcBfeOyGbtw6+QGLpk0EhWH8qPmCSwGVd3EImCRWR1TDhRaIOh
	 QqhsXtSHufxwmmGuKKQB65kA70vzq9ZMhg/IrMSSjufd7xhg0h97zBPbNjHYZQcYYts8m
	 a/T+w2TOLUnCphWNiUSlX3Cicpn/8ZFedHCDUYXST9aRGhvEuJcvmGTyWuthGrY74AK/L
	 af5WbC2MKgYHC+JnTWkcGsTKApr/lPxqIzCJlXKABQeGz3y/STnjEb64sbhazgn5+Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJ93YXdH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7196606A31A;
	Sat, 24 Oct 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJ93YXdH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792803767;
	b=zIZQSDVPrkbMX6ntSfQ0jG9XCG5cj01b0obgEVr1qyEfPIsFhXFQgyV5cEO47FqQQfif
	 c7Ors3Yxji4E5HHlq5oNKQ5OhT4G5PDoY8BBH/G1yQxDtiFx+TURpM5Yr6aytg3kd+Pwc
	 Vxx0vTewKG9su85y6uvNgEqANeHVxUXgyxx2KyztDlkHdRVsOZGpBiAqQnBn0sEHh4Kxb
	 8se5F9vFFUUml4e/FPdpqApwBojJdEpH/P5HHYnSygLfVRQJ1Ol7P/Ok5GG632Amb3nBj
	 tKfNQfdwGm/QV7ms/vWJP8d7frnPLZjhAPhG4Bku1Ox9oA1ROtLVH52PVePBZ72ytZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792803767;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=omGL6LcMhGREa1S5q4pFujxAG/NXDja8zf9xS2NZp5Y=;
	b=CjP2C/GOZZntud2HWUMkdnw0oM9cPssnhX4BAYh57j30jC/AuL7aoACW7RcyhxWbCPhq
	 ZKduBVLbbdGI48KinhGMEXSq0SaEZC7u40AIjuLr+ZLo6XqGxwRP8kUw8mtmO/Jgjg2GJ
	 Ur4eljNdRhBA2ZElegZpuAfB2GRfJPNuCIeyriqOo1BuLyA+6u8vm2YsR3CxU+2gXg8QD
	 MPWKwa78oXpFQrmbfcbGRvQsFuNl3gw0mqKlzFQyQrZQKDy5u0qEV/87+IWQkDtojtHsj
	 lUjhJ9FYCD6sPaumGdz8GUM0Qk4vgBqxZPpJqtjR05qWUSE/8HkIunMg8z1sRY44H2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C89C71F01825;
	Sat, 24 Oct 2026 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792803767;
	bh=omGL6LcMhGREa1S5q4pFujxAG/NXDja8zf9xS2NZp5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GJ93YXdHwFqu6Lsy9cSI74DVafUS1RrKGVdU1MenjUVoc9cP00PVsMQdvPsSGYpKl
	 jWrmZSzD2j2+WBLOAkM4PyLKsdsLerBcmKGIn3fnI/TVUKz5cE8z+mGzTReNlwr7Xh
	 pb49StYa19LzNU/M4QS80afgh/yvFWtKSkeUnlDgNnWDDk/say7UqtNuM7GCMBC1q3
	 1E7tCWJPVxnytN7olYLlA4qFzhrfdFy71cHwW6eZe3LzRwbHxJR62kV8GOdbs3dwcw
	 6Wn5ZxFY87jB+RQLEc4g1Wy7dUOo9NMDXEjawS+JbP/jW86c009nrE5teNBqdOwlrk
	 rX3w5Vhw+6mjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 493C944691;
	Sat, 24 Oct 2026 01:02:46 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 24 Oct 2026 04:02:43 +0300
Subject: [PATCH RFC 1/2] PCI: rockchip-host: Retry link training that times
 out
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
Message-Id: <20261024-rockchip-pcie-resume-v1-1-58e54a5cf5f1@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
In-Reply-To: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2899; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=XyiyrHT+pm4QSQTgMimlGl6CYo9QtiIPmsWqK8gJ4SM=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFl3mLfkvz242aLCc9kGMaUY60fpTxlnm+nuqd7PImudz
 zGF7556RykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZiI4CRGhjvf9A4u3tt4JNBi
 2qysDcdeC+u/XX/soP6jr8vXf/hZ6nuNkWFtyEdT+bgjFXO5zrGdSjbXjDS2Y66bwXex9P81rY/
 md1gB
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

On a Kobol Helios64 the JMB585 SATA controller sometimes does not train
the link on resume from s2idle. The 500 ms poll times out and
resume_noirq() returns -ETIMEDOUT. On v7.3-rc7 with the mainline DT
this happened in the 14th of 14 cycles, and the system did not resume.

When training times out, bring the port up again, at most twice. Each
attempt initializes the PHYs again and, where PERST# is wired, holds it
low for at least 100 ms. Without an endpoint, probe now gives up after
three attempts, in about 2.1 s instead of 0.7 s.

Print the LTSSM state with the timeout message.

With the patch, one such timeout showed LTSSM 0x10, and the first retry
trained the link.

Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/pci/controller/pcie-rockchip-host.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5b071bdc4f90..b4499fc3f90b 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -325,7 +325,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 				 status, PCIE_LINK_UP(status), 20,
 				 500 * USEC_PER_MSEC);
 	if (err) {
-		dev_err(dev, "PCIe link training gen1 timeout!\n");
+		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_DEBUG_OUT_0) &
+			 PCIE_CLIENT_DEBUG_LTSSM_MASK;
+		dev_err(dev, "PCIe link training gen1 timeout! (LTSSM %#x)\n",
+			status);
 		goto err_power_off_phy;
 	}
 
@@ -377,6 +380,26 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	return err;
 }
 
+#define ROCKCHIP_PCIE_INIT_RETRIES	2
+
+/* Pulse PERST# and train again when the link does not come up */
+static int rockchip_pcie_init_port_retry(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+	int i, err;
+
+	for (i = 0; ; i++) {
+		err = rockchip_pcie_host_init_port(rockchip);
+		if (err != -ETIMEDOUT || i == ROCKCHIP_PCIE_INIT_RETRIES)
+			break;
+		dev_info(dev, "link training retry %d\n", i + 1);
+	}
+
+	if (!err && i)
+		dev_info(dev, "link up after %d retries\n", i);
+	return err;
+}
+
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -881,7 +904,7 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	if (err)
 		goto err_disable_0v9;
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_init_port_retry(rockchip);
 	if (err)
 		goto err_pcie_resume;
 
@@ -938,7 +961,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_set_vpcie;
 	}
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_init_port_retry(rockchip);
 	if (err)
 		goto err_vpcie;
 

-- 
2.43.0


