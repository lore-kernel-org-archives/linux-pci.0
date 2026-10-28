Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156862;
	b=Mj2H9dQqF75PnivrZwhhUNik2uyTytkUmoo5JVJu89OXRcaGFDvYtUt4KrGCYRJBXcyH
	 jN5i6j25YTuc/uQeFr26qyGHj37KtTbXXJV2XIGX7hEDAfALfDLrNvndaPveuoecIm0zD
	 aRY2v7Vxa9NIqJG+C5Xb14twY8zHB9RPJy7B167K7pFTgQJ7W7CccKDaDUHUk7vbCNGXz
	 cvF2w0bkIB53N5hjRGPH0ecvrsgG30bWAqUq5ZkEBcB1vRlOdWi6iCqVg67cS6EszW/Tz
	 QsOH0glyucEBeq/TB4vZykiry9ZGqtQvr+7XufEL0ZUGfIM1PvW4nLiIR4VLciyXlIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156862;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OY/nKIFipbhUneBZ6EWbb2qdOnB0mX9Xjv8WIqIqTe0=;
	b=x53nbt4E1+ybBVW/xqF01V0/yeT0p5xJ5c945+HDselemsP2BRrQ23/N+SE1P5op7GGv
	 05yy6WEYP152KYVzi8EKlRDzDar01UZ/ux5wpDxEd4Kj2AmGtGbtQSjtZUrskK6LcjqCp
	 524V3GwNQ1JU+uq1qPU0td0cDRfIJ+Mb2Sr5oONg8eabO3EhIn+VQ4MDimpc9ZLE3fs2X
	 9M+9TrKkfC+poLL3taXInzzZig0U4zNUGrLkez/c+VNJm5SIsjpAQpDB3K7Fy7b2mqhGB
	 YineWCyrGvKyzKtzhDWXIMYtuCgBV1Xz1gixtAxQcYdBEbgC3VzMQRKEGgV3cLKjRNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="JHVEs9/F";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D260A2630;
	Wed, 28 Oct 2026 03:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C1D260A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JHVEs9/F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OY
	/nKIFipbhUneBZ6EWbb2qdOnB0mX9Xjv8WIqIqTe0=; b=JHVEs9/FcCLjbRxwb6
	ZtPbxyG9rUTPsqqbK3MYQOLZzliU00LrGUeqZDcuTkE2rK74s0NJ2I1WGzX+hOPH
	wvx5yHDAb1Pg+ZCdSDljZ+kMspehvDecSf+YOJ9/uOWY/3H335c+u+nheJ5iAXCQ
	QAZSAAaK/772fZWEtudMEywHI=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S2;
	Wed, 28 Oct 2026 11:07:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 08/16] PCI: dwc: fu740: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:44 +0800
Message-ID: <20261028030652.2917756-9-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDXrWkJw4Dtr4rZFWUArb_yoWfZrbE9F
	yDGr97ArWDKr9Yy3W2kwn3JFykZa47WF1jgayftFZxZFn7Ww10qrykXFZ8AF4kWFZxXF97
	Jr1qyF48Jay7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtZXo5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x3jh2rhZt3GFwAA3z

fu740_pcie_start_link() is the .start_link callback. It runs after the
controller has been powered up, so replace the capability search with
dw_pcie_get_pcie_cap() to cache the offset.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 6c7ce16031704..00ec69a091647 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -178,7 +178,7 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
-	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap_exp = dw_pcie_get_pcie_cap(pci);
 	int ret;
 	u32 orig, tmp;
 
-- 
2.43.0

