Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5F3B14A7
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637843; cv=none; b=cJ5mSDAVkCYHJibwab7pDGGXqxcsjF9H5p0nP3WI22hcRxdUrUJ34wGySYXMCRuBxsw+FKdohEzBsGSRt22E1Mi4RoLcxGZ+JVvxOP4Y2e8a+scjPQf+Ih6iEaHvlvRiGZ9UL4ce3HWk4PXbZ5MebBWiRO1EKnj7wGxWgNpDBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637843; c=relaxed/simple;
	bh=qZd7FKre5dmrKvcADqZAyXBMS/3CytHy0dsIUnnFeGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbUtHQwtNAUi4T1+Fd7WW7IJGdCTePbHw+FdiQu5r20CI5X/oOkRQ4b4ve6AfEkglQZj4B9ZTBp+16GhY8hPNyRSTZzqwyvlGSTua07QmPrlDiobxaC7ufm0aY5YVTojCXnnn5gWE0aoWEA9O+gpSAxz72X1YuWoogjkftDk6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHMD+w+Y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHMD+w+Y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso4159785a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787637841; x=1788242641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQdyTi/FS8Kj61goZufr0DmEJyM53G/+OIGRH28vBGc=;
        b=tHMD+w+Y8z1r2dj3iE8KMoJiBBudoBvO0Pt10rit+8UUqeZOF1RJciANIQ7i8pdyBv
         2WiOXRDBJijWMs7/po2LbAK0+hsVX41sNQW32yqeO27KEo+v9XYzwcIRx+PHvtEiqwj2
         80/rHM2chcBGxYNd9KJvgO4up7lV4kTW9qujHKxsOgAlY6bn6g72GuXqYpQ1xSvCoFiC
         qYuYW11BhhhOj+kWHvq7EIzwAqbh6Yftv6o3tEP9Zl5djFQvY+bPm1Ml/hh1S0MnjLx2
         QHmURpc+65GhSIElCVeI8AltA0b2QdHbgewR8R+Qn+RyRExC6RWzYcmPvIm1Ql5Zu4fZ
         DEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787637841; x=1788242641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQdyTi/FS8Kj61goZufr0DmEJyM53G/+OIGRH28vBGc=;
        b=akiTUxbR8EYYt5QXx4qJ3cVoFvsENOdUJeiNP/1rMw2uWzjzLtbCCloRiN+rOd80SD
         F8ZprJv0lyjD7tBuWVjxE+/Y+UdYuq8VtE9li94ioM6Szk9O9Jd0D6F9ZlXgfby4fUmp
         4k2ocOUwQ60Ox/p+31YypKepQotMTl0B/p69uwnkFAuvTDNTO7weS7URHlqv7RqKbtTN
         H9GbjmwhZzPuOMS0ftxogsasdFQL5HtKGH0U0vAG3qfDvUFWEGdI7fHxp4/D87X3hxGm
         NgnLKjs73ZDZLR6dK9ToRWmM6/gMb+X0+g1SIrh+F0rwF4seOzs/IxJDKd+PyEoanRoZ
         bmPA==
X-Forwarded-Encrypted: i=1; AHgh+RrFA6rIlbeIYTGVpEhRma2CE95UG+NyQd3d5p/rFAa63VRJtvZbdLJRj2yWF+nsUqqednxn7ewMzSo=@vger.kernel.org
X-Gm-Message-State: AFuF++mX0OGeWD29U7QCbMMalFttAGK6Ylyv48DStF0s2PsqKvRPFMSX
	vmN2JMSMgn6JD4eRMZqZMbTWBefLRVKw7za2yIorB6bg8i4vc4mk/LTAsI1wKyE9EW4=
X-Gm-Gg: AR+sD13gXuuC0f87/aCQMfpnmeZyA8C0G9C4/xTPs3S+Tc3wkJ9WQv0k4h+cZxONnRA
	EwTat8vhygUXrbpXQm27pK3E+5u38jxN6nbzTUICqAYCcZDJEHZ8ObFWHgFldxSb4doG3lBQrXW
	6DK9cirfU6TTnRj9QFL+GJ1O5dZfhKVsRMWpMfq6u0eklnylhbq7ay+BvvpBNLqqRCYVzYQ16RD
	KcViH6/saWOj3YhxE+KG9r2MMRvW63gkRw3fDTmpvzZcvzt/9/cb4yJvGNAqW03nWpU7axwatiy
	b4fRpx5XKzqd4JwFSXZegS9OjWDhizF4jLGLt+WtHypcTegACluIrUg+el/8AXiaawlBGLrFwOD
	i7fg5+SjVL8g5zfP/EhnqZIeXbz7beqq/Gs1m+9OHj+mpk5F+ya3c7B9M5Ga3H9zMxz9LPBDaV8
	Tb5j3O/GxLIe2WW1REskR0DPDrU4x+PScbqEHYJ5CLsh7+dScjOpBpxTulQTwjfhracUJuWlEaA
	hEA1szB+k9EflksaNODjoDGPxaQAqJm31Cg14V099E8oAWJ/LRQ
X-Received: by 2002:a17:90b:1d50:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-395df29b3c5mr49167378a91.12.1787637840732;
        Mon, 24 Aug 2026 23:04:00 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b82847sm2536296a91.11.2026.08.24.23.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:04:00 -0700 (PDT)
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
	Zhijian Han <hanzhijian1991@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH v2] PCI: imx6: fix endpoint init error handling
Date: Tue, 25 Aug 2026 14:03:40 +0800
Message-ID: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
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
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
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
 
-- 
2.43.0

