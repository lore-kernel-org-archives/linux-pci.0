Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104161;
	b=UTpF9yDDOHWSjlcaH2uWKouxHME7FfSYPlrGe1hd6oybbwHweHxxXbi2T3KCaypw8WQl
	 gvnFk5QodzFT/Y48Gt4CbjJYHcCnEMvsKr9e9SM2uaDK6CwryWn1Ny78mcjW9V/ccCbet
	 w7RmneEM2fUa+qrKMA3y9njcA+Y9aD/go3gv8H4syzPNwhlr3/9ks+QOS5FMYnDHIHCBz
	 my+OCHBmaBD3VjHNz2ShyJm6QPISQVv/rnFWtI+lElEAp2C5r6fni/8KwFmv5YAM01GB6
	 splUv16tCEhRrqkhbIcLd6Xi93K5lKRuDsriychAVXIoVPMSjC7FjAiqJcypqC4jOUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104161;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+WNu1ci5a6DlT+vajHNP6rNH5UkEzR2bIj3SQj7gr3o=;
	b=JscrOUdkYWsIjlGNJPRiLO6hFYRxIrI2GTY7AC4qUMlkAcE5Tl9rgNasvVs7L7popkSd
	 d0inWqy4V6bcmFGgAooD8J+i8us/dobOK5EmP0288pXml1zlS2Qc/LYZBcmoVlEfhvlZu
	 /xjTMeF4iVkxxAWscG7TpURl+exd0+W+g2IHP0wBKAZi0JNy4KcU5FydoFb1BJWLrZNeI
	 MvHpnATUC/OE1b0ioKyo2/fVfUfKo2ARvFuRornqEs6gsP5zykfGYrWv2sVhH536iD/uw
	 eSHjkF6O5nynNXm87qFpjgtRSCEFuGjz4Y0+BXsheA5jdKIcO2eKHOvc/p8raRoDxEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="SZy/ihn8";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBF60A5BCF;
	Tue, 27 Oct 2026 12:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EBF60A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZy/ihn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+W
	Nu1ci5a6DlT+vajHNP6rNH5UkEzR2bIj3SQj7gr3o=; b=SZy/ihn8oSlZdUR2Zf
	/gq5NcKWpi0rocdWQASPZIRRBW8NjbvHBohneopn5Af51NJBFtjs9RW+dJc3LrPs
	cYxs3K3Sqy9GM+IpGV10kQ5BvtSGLA8qjCkGp8qCzomRO6eCgg5TswgA48/K/MY5
	4PsEg9RcVSv471TZPP4WguQnk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S7;
	Tue, 27 Oct 2026 20:28:47 +0800 (CST)
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
Subject: [PATCH v4 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:24 +0800
Message-ID: <20261027122827.2725643-14-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fWryrZrW5XrWkXry8uFg_yoWfWFcE9r
	9xJan7ArW5Gr90kan2y3WfXF90yay7Z3Wj9a1ftF9xZ3Z2vw1FqryDZFWvyF4UGrWDJr97
	Kw1qvF1rAayUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x8422rgmP8aCgAA3q

k1_pcie_disable_aspm_l1() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 0564c46e2f48..a22a6d4dd2e5 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -113,7 +113,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.43.0

