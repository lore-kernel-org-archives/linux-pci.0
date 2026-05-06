Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922E47CC80;
	Wed,  6 May 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081122; cv=none; b=EEFSq3OMG4YuZp9BV0mGescbMn6o3Bhr6UBbrr1qyLBESC+ixvjVNqeo0q4X7KtnQiDhaSN1mP8sXlXsKbF2C5pwkT/ZCqzxcyyl4CnsH1ypZZrzc0Y7dAGoY/AGItW/x0BAxwzIWHImZYFg4bubCOxwLDNX+7KkXpU/z+ZE+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081122; c=relaxed/simple;
	bh=hOvMa018kLpNbaWX7Zza3kl+vca409Z0VW8vMXcwSVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1ZV3NRqc52l6lYYCW4FFG3ch2XJtfr+G4RSP3pw7Nf6A2t3X4BSk1Y3Au+aKf/gIMp/SXUAFil5lhvHIZWFqxaAhYLTxn7BNNRoAiQpFIPN+MnSpNExhMJdgE2yRE2xm3ybymC0c60CPyUuhaEIFPIG0kT/G1SuLlIl5UVqToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mMb9kc89; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mMb9kc89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uE
	EJQ9fXszYfwRyDtR6o0/pUHqmq54B1aA4O008XVv8=; b=mMb9kc89cru2itfUkh
	Eh2md/CTuLPUpRJN1UCaVC+R7gJg/05zaFVf6MN375fUdxTcEbLRvm5HGyFiq31g
	C8tU96NjI4ZuPrcQSVMbckGSM6JiREeQqRoa5JbpvmbpVJG2G04HE0b46cM2H5az
	7D+Snzwl538eCInoaS0sk74dM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHAqsXXftpv5CgDg--.43926S6;
	Wed, 06 May 2026 23:24:13 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com,
	jingoohan1@gmail.com,
	thomas.petazzoni@bootlin.com,
	pali@kernel.org,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	claudiu.beznea.uj@bp.renesas.com,
	mpillai@cadence.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 4/8] PCI: j721e: Set max_link_speed to enable 100 ms delay after link up
Date: Wed,  6 May 2026 23:23:42 +0800
Message-Id: <20260506152346.166056-5-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506152346.166056-1-18255117159@163.com>
References: <20260506152346.166056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHAqsXXftpv5CgDg--.43926S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17Jr4UXrWkZF1xZFy5urg_yoW8Gr1xpa
	y7GFWxG3WIqFW5uanrZ3W5XFyaqFn8J3y7GrZag3WxZFnxCr93JFyIqFyfJ3yfKF4kAF17
	A3Zrt342qr43tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEt8ncUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB63W2n7XR45DgAA3Q

Set cdns_pcie.max_link_speed to the maximum supported link speed
(obtained from the device tree property "max-link-speed") in
j721e_pcie_set_link_speed(). This activates the post-link delay logic
added in cdns_pcie_host_start_link() when the controller supports
speeds greater than 5 GT/s.

As required by PCIe r6.0 sec 6.6.1, and following the same approach as
commit 80dc18a0cba8d ("PCI: dwc: Ensure that dw_pcie_wait_for_link()
waits 100 ms after link up"), this ensures a 100 ms delay after link
training completes before any Configuration Request is sent.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index bfdfe98d5aba..ee85b8e04f5b 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -206,6 +206,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 	    (pcie_get_link_speed(link_speed) == PCI_SPEED_UNKNOWN))
 		link_speed = 2;
 
+	pcie->cdns_pcie.max_link_speed = link_speed;
 	val = link_speed - 1;
 	ret = regmap_update_bits(syscon, offset, GENERATION_SEL_MASK, val);
 	if (ret)
-- 
2.34.1

