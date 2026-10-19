Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47B30E83A
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392792; cv=none; b=FBRa/2QxTDobjIhffv1ReBJWBTyxpj2/e3MF7kVxaK3qOmlk3x7A0gN+VTFYLP1avej7tn8+er+tB1DCLDLZv0Rt2efrTwY4KaHww0JoaqVzH7ZhTGG4DIZLWb6NHcv8jhXBlBMwXaJUI9PgcLFM81Mp16m6YZHSnAmLbH6b5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392792; c=relaxed/simple;
	bh=ICWosO4Iw+3uASSl4S01prJwFvtuCvRIE1kqXegzmpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chf3UHBQHnk9IzIV4O3zbDkGVjw9yBSplBEvq291CduME9sxWQ9SXoGcAm/B2cRXBE1K4DyOID7Gbw9UlLfR5m5vYHh3a9lxA3z1/Zj3meuFU64GEds5t100YWuuEeKj82ypQsKt2E2Y6UMQFamkLFCb97DjrlXq78GHLJAvKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQpQBQ8p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQpQBQ8p"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e011d370dso1427801f8f.0
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392788; x=1792997588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9XPtOkvY2xGoEM32FGfKxcwuTkJk/35iPrfDKXNDEk=;
        b=aQpQBQ8p7Z9pnVRyZ5jNKZ2tHJjV5Z1e8yxK2xV8D1F9kmyxNphJQTvusON6js5Gtn
         IOPJeLvGWko+livZkIfgZckERraUMQxDVGWv4/2pwgV5YmOB6n8Cy/NdOFF872DkYL/U
         uEn17ngFjAPTw17Q1hqdGIzB80ccAOopCnQLQ2sLmDm82GLWiTG0E45UmoVM8BuhHbtq
         kopCGg0JEhRWvuGMabGv0aJ80d5fXy6xPplBTImaxRKKoV6XrZOiasslKf0qnbMPisSO
         QgFYn+P7GIkE7m2ORkKPpEksDQcEQ9yjZdVzeFOPbXHKiAvX0vxgDHSmMsOwcHXKbhpO
         MC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392788; x=1792997588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9XPtOkvY2xGoEM32FGfKxcwuTkJk/35iPrfDKXNDEk=;
        b=V2dKeqZZOR9Zb8Z/OYGN4d0RylcKLxJ5V2MlpgEqg7GLkXbpC2f1piSszUd1SJ3jZ6
         M5rRWby9bGoM0T3XGo5dDNPsmgwVLmmFjfrJfMosEd0tztLHuQlh53pUEQXTZrbdW6Ss
         o/y3fZNQcMVQF/T/FU1YwdGxChVGYDUQN5r2hid+Rj/nvu2cQUUZYy1S1nyseIR163EY
         rRlj81K9rAFXlwwBhLrf8FzYP/CKMr5cz2vgz8PSmOvOx34QY9X0J12orJm5ilhDtJ6+
         dcbZEJSCUzFXyKGaVze/8x8oRO5tHC/GUlaj6eMun5cjWKhyPnsYukq7vOOAJH8XBspu
         SK2g==
X-Forwarded-Encrypted: i=1; AKwUvBx2oHm0UEuX5O1Gda+xzjF4yt9Qq163qgUoK6B20WBq80Oph5dQyUmu96yNopX0jB6QipiY6wt6swI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ6ICPfB4IFuNhGz5O7DdbWLqpk39Ml2OD/L+PLI51JRiFanwp
	/r5TaWsESTCVGo7VYp+Md/ny46pkGoFOBT2sOvbDlu3/16qYJ/B4ehgNcS5mHA==
X-Gm-Gg: AYBFou2IpNzeuc+V+oarzHfweQipY/SxY9DL6N/vV/4fdYATxlax9ZxONjOsS68C9ZB
	+2rdwJP5olaqvIiGu3T46YKF7d/6VZzrbe2s9KZN4yxTGWY74jMDtFg/eoiTYQi0wzLxKN8WaQa
	BH+T2F1UaX+4URw+OsmXuxvT0l1D3TtQOQzG7E240QoSdOIlLcZlG3AXRfcKiE2Mn8A70GjHSrd
	T/V5YBNUtQjMkx1BZrNzNIvPt7/kQUUpLr/uvNUiZsi5zxsJnOX9/aIuSSxuoeACBmg8QuYY4au
	WK0s7f3gm3YLSAvd6Yxf9kihJbLxNDZL4SftFTHDdo5Yr8dpYA0sfzktslY+IqyUh0nh0nWJIun
	mQK80qWdDzXQSw198TokG9PmpSY1163+vEIlleJo2YiufPCEUPzBuo04bRTqDRsMkOka0soe8r6
	xmU9PCos5urghGpEIfb9YXP1yZOgwG6MZQ2x9jntotleSA+083Wq1MHktl5/f00z9Utk6ItaPZr
	5QgGsuWFSx83sm4ox6jJWDeC36nb88/gwbxd+nLukabn6+wafHGC2JmDw+W
X-Received: by 2002:a05:6000:29d2:b0:48d:ff71:dd97 with SMTP id ffacd0b85a97d-48e07975c0emr7979526f8f.7.1792392788079;
        Sun, 18 Oct 2026 23:53:08 -0700 (PDT)
Received: from SVR.localdomain ([158.173.154.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8cfesm18545783f8f.37.2026.10.18.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:53:07 -0700 (PDT)
Sender: Semih Baskan <strstgs@gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Semih Baskan <strst.gs@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] PCI: iproc: Skip BCMA-attached controllers in the platform bus driver
Date: Mon, 19 Oct 2026 06:52:49 +0000
Message-ID: <20261019065249.552-1-strst.gs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 767012397976 ("ARM: dts: BCM5301X: Describe PCIe
controllers fully"), the Northstar PCIe nodes under the "brcm,bus-axi"
node have compatible = "brcm,iproc-pcie". bcma_bus_register() creates
platform devices for the children of that node before it registers its
own cores, so pcie-iproc-platform probes these controllers before
pcie-iproc-bcma does, as IPROC_PCIE_PAXB.

IPROC_PCIE_PAXB sets has_apb_err_disable, so the first config read on
bus 1 reads APB_ERR_EN at offset 0xf40. The report in the Closes: link
shows that read taking an external abort. On a BCM47081 (PCIe core
revision 0x01) with a device behind the root port, the board does not
boot, and it boots when has_apb_err_disable is cleared.

Return -ENODEV for a controller whose parent is "brcm,bus-axi", before
the driver allocates or maps anything, so that the controller is left
to pcie-iproc-bcma. The devicetree stays as it is. The check does not
depend on CONFIG_PCIE_IPROC_BCMA, because a kernel with only
pcie-iproc-platform does not boot on the BCM47081 either. On a BCM47094
(core revision 0x07) pcie-iproc-platform enumerates the devices on its
own, so there a kernel without CONFIG_PCIE_IPROC_BCMA loses PCIe, as
before v7.1. CONFIG_PCIE_IPROC_BCMA defaults to y on ARCH_BCM_5301X.

Tested on an ASUS RT-N18U (BCM47081) on a 6.18 kernel with the
controller/iproc-bcma changes backported. With both drivers enabled,
pcie-iproc-bcma binds controller 0, the BCM4360 behind it enumerates
and the platform driver logs nothing. With only pcie-iproc-platform
enabled, the board boots without PCIe. Without this change, neither
configuration boots on this board.

Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Closes: https://lore.kernel.org/r/0dcfb2db-5536-465a-bee1-afe160535748@broadcom.com
Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Semih Baskan <strst.gs@gmail.com>
---
This is on controller/iproc-bcma in pci.git and needs 9850907ee1dd
("PCI: iproc: Use the EROM outbound window on BCMA"). Without that
commit, pcie-iproc-bcma fails with -EBUSY on v7.1 and later, so this
change alone would leave Northstar without PCIe. If this goes to
stable, 39d1c645bb99 and 9850907ee1dd have to go with it.

Mani's sketch [1] returned -EINVAL; this returns -ENODEV, which the
driver core does not log as a probe failure.

[1] https://lore.kernel.org/r/179197555828.38040.6359970121400952902.b4-reply@b4

 drivers/pci/controller/pcie-iproc-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 4c9a0c4bb923..63560c733a8f 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -45,6 +45,9 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	int ret;
 
+	if (of_device_is_compatible(np->parent, "brcm,bus-axi"))
+		return -ENODEV;
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;

base-commit: 9850907ee1dd4376c09c4129e0adbe3b39d191b7
-- 
2.43.0

