Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156863;
	b=h1bknsrho1PV75wZAI6O3ZpN8x+Rejp9591EMbewlEoLRzI4wsKJsUpkA/hmvpUZ/SEn
	 sy/21XBeQcASZyrKzjnUVhvQKa3Eb+Q9nB0DGMvlYPMhWIdDTVvROEdRkqrKf8tEjyuoo
	 JJ4h6+oBvVcQ2rzRS+AQYYWUwk17annikKZEwBpTTikVHwKj5mWdAFPFiNF27AmjmlCNT
	 JrXJFWsPj7KxoYEATYanBUrPQNEknrpai9fc37RFD0nGv0ZqW+sirrtQFoZD/tsw11mR5
	 HFAgtuS5jXqVDg//k0r5fakuYRURRrx4MCoF/XB5mGzJ8rN1P7+RGt21ZVKQnhoKHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156863;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=gvYgj8/VtDiXCuQH4R2FXsxKr1lVxn6Z5zkOXet1cl0=;
	b=ALX1s4kXrHbHmQkrD0POdhRVkylhYQDQnfiW5/znjQWeJRJ0bJ3J3ap31ZztYV0CGb2e
	 vWx19yfH21Hc3k6Do3AycDBYE0YcT0/FO2IM9JHVLUhuYsxM21aw/NeXKLhHqpxLpfOSZ
	 tAVrHHF5cIZPcMTnw61Nta7AzxNNKeYqaHPPdlNPeX/RP7kUAs7k5S9uYEHlpr6fcenpC
	 1vgqgdvc20W0AIQIx2MvJkXSQUm0XghKwYAvNgzH9xwWrK5lNGu71AwVhAuTsfBDWJcBw
	 WwLiL0sZb2PMfvJ0B6Ngr09d6DVuhfDGEcqB0WkxX5b6OvOeMb4ElaJw0LSX6C51l8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c+gpwuqz;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14971606A320;
	Wed, 28 Oct 2026 03:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14971606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=c+gpwuqz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gv
	Ygj8/VtDiXCuQH4R2FXsxKr1lVxn6Z5zkOXet1cl0=; b=c+gpwuqzqtT532VjV9
	nrjYgYtKt+9aGWJ1k+EHtUXPiGCZ7WmfxNid/58TcqDyFhiNTjHn2hY7oEeO51rt
	D1XC4G/eKZLUOKBjAkgQstQDrFInvB0eO9yAcFOVgqxvdENWegJoEAq4rvdGNADf
	XPXpXW/64fglaQv6JxiHFdbT0=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S3;
	Wed, 28 Oct 2026 11:07:10 +0800 (CST)
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
Subject: [PATCH v5 09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:45 +0800
Message-ID: <20261028030652.2917756-10-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Zw4xKw15uw48KryrXrb_yoWDArbE9r
	y5CrnrA3y5CFZ3CF12yw13AFy2ya42q3W09ayrtFZxZ3WxXw1vgws7ZFWDZ3W8Grs8Jr97
	tr1DAF18J347JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJPEtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x7jh2rhZt7GZQAA3B

intel_pcie_link_setup() is called from intel_pcie_host_setup(), which
runs from the .init callback after the controller resources have been
enabled. Replace the capability search with dw_pcie_get_pcie_cap().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 348e579e683fa..a891c3f8eb012 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -119,7 +119,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(&pcie->pci);
 
 	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
-- 
2.43.0

