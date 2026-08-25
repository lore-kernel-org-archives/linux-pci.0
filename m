Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBC33ADAC
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667349; cv=none; b=NZIOtGTOpep6YvT1RPD+P5onhQKGbDFcpCqpjj9gT4iHpFSe5tZbwKUJhP/wfo6RoOJXOwWkNuzDJprBtJ+CRL7uy//BxxKFp9bDMw/V8u2Vko9UfhkAJWse/VFJK+g1vkCkoShiRrG00fRJhPoKV0j8SPGjntm/5Y01bJ6B72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667349; c=relaxed/simple;
	bh=N8dfMV2RTxCE7arhbl2EaVyOwVpkyAhCuc/xfSBqTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O68S8QvH1qLwFObsTosYf5vNDbR+kBArAqtknloPtY8t/kIgJ5Fl5WAGos0lMPWj7NSf3GVxpAXsAQ+G5bPxGN/joCZv3Ne8Kgkh+1qTqtM06Z7lgIhGprg0YC+zc3N/sVv6jXJiaBMvhQn/S3zPLidgPTG1bhWDS3rupn9VC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk6BRX9b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk6BRX9b"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so5104815b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787667347; x=1788272147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGI8avUDsdCwdcQZ5iPHHrLahXfIYCIB9Ws1YZ5JElk=;
        b=Rk6BRX9bSC7P8j2tsSdB4hGDOyFdfqUti7h+0lq2rqiz8fWK9iS5DptYelTguEXn5e
         Pe4fNYi2COyl1VpyhMx5OYFuGqx0O3UErJ7TqEWsV7v0E+w0p6y5hZVzfgrYz4ybmdtJ
         TXZ508d/62gg6myXfA4sIpL3j3hsOgTWBNVmYZguNrEpcNJNKC+cQ0vGTAEgjffogb4E
         dzvUYO3s5YaIeDwthv/2sFETkUrdQCjZaujfPnJSzsbkUSzu8moL4uYhnVxnDVAsDJbC
         Or9qYKWmSntcptXYnppLvijY5ZYL9bCC24uFdDgiwVd0MjBBHhX6LgYLjyc1LXttb9Jd
         maWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667347; x=1788272147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGI8avUDsdCwdcQZ5iPHHrLahXfIYCIB9Ws1YZ5JElk=;
        b=Xh4j51var+4lT5tfGbHJnWBRUBM+FohftCHRJNInWrCtP3JN/o6vD9g/CJMUQB0Oby
         5yIXYbpTMRKgYHTi6/+LNPtcwU97H9hEhKrPb64IoIMr/OyX6eGq/xEGPN27PriliQGF
         vShSDcr+rXiXoha8b/+uTB6BPo+ETEzPn7XNrqxhiUc3HzX23oW7EVFCyjbSa0NV68wy
         BMQPOy/CgqHHyfIwd9LcmSEP5zv9zhYFuvJu16iKRw77AIQIVcGWdCBPw5zXyVEjDBCI
         V4pbR57fl/aDf8Njqhj2ATCC1vTohzOlSrfFBBBUnRjQZPmKPFjEWql2dmb5T5+GAeZ8
         6Hmw==
X-Forwarded-Encrypted: i=1; AHgh+RreKOHXjfu2U2/Vm5maJg4YO/vlUNjw/nJnL29R2hvNI3ont0hynHs+5V9Kxxdo8xfn25mC8mdQklI=@vger.kernel.org
X-Gm-Message-State: AFuF++lvT/eY2YDTIjz5R/PUNTpZOQTkpMtwJ9vEOCmhxyOSUb9F0ZZV
	GzsCAW4NDCc4Jsu0owaBxxEeVGdawLiTG8FDYyq+6JE8DzxTbNTcsPdK
X-Gm-Gg: AR+sD127auOMUHU0khp5GqX03E66AbfFmXe79e86HW9AvzC9PdSYri3OUMReklr92k3
	V798tGxPWdQyMrzAhtMJpYFHu5VCf4hSavhv40qAw2/x/lgfSX6oidkfYduYezX30qcxrx3fle9
	j63Db6ziJNfQnen1jYNP/fn6EiuDTieQ9zMoekFqwpXCRVHxcy2jJQxtrkYrr5cIs5jsH10ueKt
	4/NSAP+esrN6IBIq36ReXw05GC1aDsVOeq4VLRQ8dX9QJQT67xyaBrPszpg6+N8nhTAzsrmbiaQ
	w3ntzhQ0bhQ0yWpRygL6tkWvDC59mRHYdJ/CZL/kzDLsGIpTmt+HvWLhm3YYT+4k/w1V9gqcLWD
	limly5I6VLUTZOmPM+FiB+2Vup4Zt54QLjCQx1TBHG3toNVPhvIfl7WjFaDHCKkot43XOqX8BJA
	odBLBQRkePwcD+5STtE58tpTI0mpH4fyOjeABxK1Q0sucCG9zzOXh6ETKZxNCwOeTBRjc3Q7KCb
	FdMNqJdLaMMM1Et+vsJy9vIYTz9qS24fSrVFSmK4uOoaLIfmAZ3
X-Received: by 2002:a05:6a00:928f:b0:851:ba04:ca02 with SMTP id d2e1a72fcca58-851fa070bf3mr58592115b3a.16.1787667346530;
        Tue, 25 Aug 2026 07:15:46 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed5034sm3122767b3a.1.2026.08.25.07.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:15:45 -0700 (PDT)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	Zhijian Han <hanzhijian1991@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: imx6: fix endpoint init error handling
Date: Tue, 25 Aug 2026 22:15:26 +0800
Message-ID: <20260825141526.3911472-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_add_pcie_ep() ignores the return value of imx_pcie_host_init(), so
a failure to enable the clocks, regulators, or PHY during endpoint
initialization goes unnoticed and the driver proceeds to initialize the
endpoint against unpowered hardware.

It also returns directly without releasing the host resources when
dw_pcie_ep_init() or dw_pcie_ep_init_registers() fails, leaking the
clocks, regulators, and PHY that imx_pcie_host_init() acquired.

Check the return value of imx_pcie_host_init() and register
imx_pcie_host_exit() with devm_add_action_or_reset() so the host
resources are released through the devres framework, which unregisters
the EPC device before powering the hardware off.  This mirrors the root
port path, where dw_pcie_host_init() releases these resources through
the same framework.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.org/
Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
v3:
- Add Fixes: and Cc: stable tags

v2:
- Use devm_add_action_or_reset() for imx_pcie_host_exit() instead of
  calling it directly on the error paths, so the EPC device is
  unregistered before the hardware is powered off

 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b..f0fb4e1b0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1488,6 +1488,11 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx_pcie_host_exit_action(void *data)
+{
+	imx_pcie_host_exit(data);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1634,7 +1639,20 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
 
-	imx_pcie_host_init(pp);
+	ret = imx_pcie_host_init(pp);
+	if (ret)
+		return ret;
+
+	/*
+	 * Tear the host resources down via a devm action so that, on probe
+	 * failure, the EPC device created by dw_pcie_ep_init() is
+	 * unregistered (also via devres) before the clocks, regulators and
+	 * PHY are switched off.
+	 */
+	ret = devm_add_action_or_reset(dev, imx_pcie_host_exit_action, pp);
+	if (ret)
+		return ret;
+
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
