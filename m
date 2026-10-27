Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104157;
	b=mHJ48i/29YksELNOzw5wkYItJ67WjsLCfeRqQXFhOEpTlv7HU2ZmhX0WAW8swtIls/20
	 YY3sbSFdhR+zxDeYBG4yQt8nyvxIax/aptDFCdxC3iJ38hK5BLlvLyQxxceZf2nXTR4B5
	 L8H/QBnR7OqR5NN4nRzQxo+i2Uqxm//cVOR/+1+Yauxhii/rqyf+3mnQJSiPCPguDgVeW
	 9SWGMbacU0EIdli+AuyUFMYl8oF11mifPNT41Q7d0UJQk2brfMRPOvLk1DvVmd59iXtcB
	 mnb0CfgIa7ZYijsOujandcOCOayfXgkf+be/ipSakk+9jr2ZqZlvIlMSmsCWwFIF19A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104157;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TdYceE7RRPUM62LOVxn/fHgK36xYRy4qKZfZkYwC3NA=;
	b=QPci7vFYFn1HxUEVWiqgnU2tVirljUHF9SOD2P+tCqEGwyWUkXkPC1SAWpAKT1Xf6Mo1
	 84G4ecEUIWcS2R/upTzSpH9hppzLHtI3LFzBkAWB9NhtE5JEheKOW2fzAqy/YfhCUDDym
	 utajPQa3Ih7rP6UBu0DXBxLlVZLi+zaw++aBeVzzurOPBiXuuJqlxRg7dZgkeCVM3tg94
	 dzR8Yn+drfu1CqPZP0xOpZV25fgUvBCtWtOOu8mlhFz8g1XHyP6OT7QBXZvS10dpQnimW
	 2oGg4LcsSZHGbHn1ucaFn7iQLn699kcWo7neuYl0P+QlCiPZ54FYHJc+xNbI5zPiN8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ql3fsKVv;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B371606A335;
	Tue, 27 Oct 2026 12:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B371606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ql3fsKVv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Td
	YceE7RRPUM62LOVxn/fHgK36xYRy4qKZfZkYwC3NA=; b=Ql3fsKVvhSIX7zUl8a
	qzihG3hTfydNTdF9wLL01uUMT1FV8wHgK2mWad0l/ETDV9U0UQx/eW5/86NZHCQQ
	1Eg3YQFEO91ulexQRqIUvmkBdlDFdJfrg7lFGqmkDXidKtizIFsgQ7mtGUSYxIQ8
	nwvaR5/DeNw/y5Elc1plFAl7A=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S6;
	Tue, 27 Oct 2026 20:28:46 +0800 (CST)
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
Subject: [PATCH v4 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:23 +0800
Message-ID: <20261027122827.2725643-13-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW8tFy8Cry5CF1DZr4DXFb_yoWDWFgE9r
	9rCFZ7ArWUury5G3ZFyw4fXryqva47ZF1j9ay8tF90vFn7Zw18tr9rZrZ8A3W8Gr1DJF97
	Jr1qyF1rAry7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B8422rgmP8aZQAA3C

sophgo_pcie_disable_l0s_l1() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap() and store the offset in a u8.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..39703d2b7b5f 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 offset, val;
+	u8 offset;
+	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-- 
2.43.0

