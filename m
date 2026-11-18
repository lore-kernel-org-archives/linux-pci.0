Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012108;
	b=2azc09uxi6uQxUWUgIm0VoN2eTGcODXAK4L3hVNiSNGfAHpzOrPIvLowgyxS1WaRo3Jq
	 krLxVhecr2l4F0Bfq67wG0sH91MLTLcuRedWZMWvPIG/ot72wlnRmiqo0+PxZKLeOUdhj
	 CDsp70dPo1DQ1+Gm2WsM4N0wsP1uf0OBdhU1/RfjAY1sJrC8L+oAl+1CAnKcepPDigFvM
	 lb0ZYuwN0WC5AototFzk6XJY91ElujUnqJh5MWZbbIt7zLdfjd1x68+tt8ldI0izg4rBM
	 Axc9hO0I4ujQd746nK5ctC82LRwd63bvFDkBGcPzp/eBm2wtuHU5cPCSl7RsTHssRVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012108;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=fSgwhlmKyQGQwctHqc43zOlvjdBzMgAkGZ09qlZCKuI=;
	b=AXJWX1PbADHBAep2ST5DhFnyXyxwOJPrFgn13t6Wiz0aHpHDsX/T3rN0dO8HNQtNoRrn
	 8nT7AQ0r/luC3vsUXi4J8BFiqPaTD3azoLGIXsEys5YNj9bDa9xSu8PGEeflCULQqKJ4m
	 PSr4iEVFhd5qiU+6Hi1zDoK26DKOa3PUh31ylXhO+7zr5iEiherihk/eX3UFmTMEUFMUl
	 0X6zzQ/+WUlB+orMceDJ6rt8pE1HLniE7PIp+zF8sofWhEUoMfFGFp9TAVYerpwGxX7YJ
	 xM3RPe++uPWGcQi19KI7lYFK3jI1Jt7WA7y/NXBemdNuTEXETOcCyQQNxMS7uOHL3IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=J9u6jso8;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFF606A333;
	Wed, 18 Nov 2026 14:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DFF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=J9u6jso8
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7a04;
	Wed, 18 Nov 2026 22:28:22 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Yue Wang <yue.wang@Amlogic.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: meson: Fix potential use-after-free after PHY provider removal
Date: Wed, 18 Nov 2026 22:28:21 +0800
Message-ID: <20261118-324f82bd41-pci-meson-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1ef0f076c03a1kunmfe1958691a169f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUhLVhlCGElJQxodSU5KGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=J9u6jso8uxOqF1ixoniwY6KndX5ryqPnNLKDGPlR9JGvTenW6T/GKKNor60TS/vnGbYxX0j8BNgeGR0r0YsTF++W2HC7PNfYDWjjjYnI/B3koqT04ZOX/BoSjjUBFpp6ZiFVZ7KtiIwTKzejsAanv1MECs2sJcjTwO+b9mE5ugY=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=fSgwhlmKyQGQwctHqc43zOlvjdBzMgAkGZ09qlZCKuI=;
	h=date:mime-version:subject:message-id:from;

The PHY reference keeps the PHY device alive, but not the provider
driver resources used by its callbacks. Without a managed dependency,
unbinding the provider first can leave meson_pcie_power_off() accessing
freed provider data during PCIe removal.

Add a managed link to the PHY provider so the PCIe controller is unbound
before the provider releases its resources.

This issue was found by our static analysis tool under development.
Fixes: 4b0dc84b2939 ("PCI: meson: Add missing remove callback")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/pci/controller/dwc/pci-meson.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 8559d132dcde..251673bc5963 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -401,6 +401,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(mp->phy);
 	}
 
+	if (!device_link_add(dev, mp->phy->dev.parent,
+			     DL_FLAG_AUTOREMOVE_CONSUMER))
+		return dev_err_probe(dev, -EINVAL, "failed to link PHY provider\n");
+
 	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(mp->reset_gpio)) {
 		dev_err(dev, "get reset gpio failed\n");

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

