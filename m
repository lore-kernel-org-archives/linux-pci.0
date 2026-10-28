Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156863;
	b=WbDSxOnt6S4QvhbWjW6fvDR4u1Ihl6fky69SWcs7GHJZH5781c17JHBlBL7IUo8VgqdQ
	 xYuEpMTUfZ+/V66vT913CD4sGFcW+a9e+zDekST7KA5nzhPk704r8u/qVy6WhDpG1AKAt
	 g09TcXrTUEcKWPnTxsOzSQzzp7hoorMntN/b1b/dLfQ8GeVLXqIvUkLas7DNzmyYhDtSx
	 iKOcjW7ni8mmYcC9rkc+R+6Sbys6s3Guf9+xhP4MhBkFRLTW+w7NIHSZHV4yH/wFYnAYN
	 GawT+FoijZvpyQo4tr9/VhYKxz0YWJO+jxlwnbbdLlRblPDN0DZjFnTCCYR1t7X6G/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156863;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nw4a8GdF8Rm29zjnqIJ6ENwjtf0jPmRW0n0sSDEi4cM=;
	b=EMH9/3gCKSHa1n5pIW2HBZkzfnk+r/kwr0IVlr2NHmDSYfVG1ycDJ8oHRLVgYn7GIBsl
	 yP7BeZfz+i/ARccYPM7YlJwmz17Os07wSt0vei+ZzAz/4aIvX1fFBZXlE9hqZc0Yq1d4K
	 /rwwI03sbDaTp5kYW4/Cx30ACdyk3Tx31XMnOw3tY03KZcR+9uGacvLUzX12ibmdoelm6
	 p0wdSBnMvGE6ZngdmrZZro6wYRvir43jUX8rq9zI0ARIQHrlwXdN4hqrf6/ny0P5k1Eb5
	 4XYFrDTp5HbRRQhsArv5HPtY0jfytnXaGekxHFjIFzlXY1sxS0CNNUamOdaWYE+wmxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mfHPLhUE;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FB60A260B;
	Wed, 28 Oct 2026 03:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586FB60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mfHPLhUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nw
	4a8GdF8Rm29zjnqIJ6ENwjtf0jPmRW0n0sSDEi4cM=; b=mfHPLhUEBNSyABWGzy
	f3gCIUpgfmhhwV89Nf+l+zP5PJdFVM30klupuAmjToA4LdU+y+paXyoXz7EwhF01
	l08XZyiSLPaSvAOtRaReUJfutCxQ1qwwDBRGp2orAr+N1vlLpashVmPD72Oc54Nq
	UbBpmG7egMdLUrQjb2Q2FLJx4=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S9;
	Wed, 28 Oct 2026 11:07:04 +0800 (CST)
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
Subject: [PATCH v5 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:43 +0800
Message-ID: <20261028030652.2917756-8-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45Aw18JF1fAr1xWw1rZwb_yoWDCwcE9a
	4qkrZrAr4UGF9Ik3WSvw4fZF9Fya4xZw1j9a4rJF9xZFn2gr1jvFnFqFWDAFnru3WkJr93
	Jr1qvFyIkFWUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNE_MPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xnihmrhZtnE5QAA3D

eswin_pcie_link_up() is the .link_up callback, so it is called on every
link state poll. Replace the dw_pcie_find_capability() call with
dw_pcie_get_pcie_cap() so that the capability list is walked only once,
and store the offset in a u8 as everywhere else.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-eswin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 1bb44696057e4..d08277e8cc690 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -84,7 +84,7 @@ static int eswin_pcie_start_link(struct dw_pcie *pci)
 
 static bool eswin_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
-- 
2.43.0

