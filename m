Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6233CD8C2;
	Fri,  1 May 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649814; cv=none; b=emkCZkAzxpn9N0wwAvQw0UOBemJv0ws5KBBBaDB8g+NenvWH4YIlWCrcM5XIecrnMh5mINE1Jz8RtVw7YPOysNElDit0nDhDuOrFIjy6wTUqOwn05S1sYE7Oll13dlGTpOpEF8TrVWHHYy9e0G6h25YU37w0G7PjmUD3Oalm0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649814; c=relaxed/simple;
	bh=MKXEPVMRBKqTiNJKUbrmcfWXc+7QN5Gm1j7PsYVgCrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=un36G8DDYmGshFvb1LVtpH6gtdzoPT/F9t/JdyY1vpMVMDU75q7YvkS0qUmdYVwF/nq+3s3iq2igpAKnIv0AJHAnKLpRaVHH//dBimqWKGqinK7X0PwZCaok0y81FuWELYSWfNELmC2nx2uNnbrMQm/4hANI2GvGKNNGIzOrNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jhTaH9fJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jhTaH9fJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rN
	qbrJ0nYBLUq7KvlneyDzlxeJd5FU1yTTH99vsr+/Q=; b=jhTaH9fJuQMA7ClBan
	6isFXXHBF+KQZ3ULwH/LZTlMhxuWnY7b69VbtYXw1ms6DwCLoOXM16vjgN83RsO6
	dfEqkMGjG/a8WtVugORKCiqmWRlAo60YBNu7mEqBlJ14RzamERpp5YeywwR7g2uv
	sKpPj6f3psu/bmGLG7w8t0SIc=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCH4HBbyPRpuOd_Cw--.58479S4;
	Fri, 01 May 2026 23:35:57 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/2] PCI: j721e: Set max_link_speed to enable 100 ms delay after link up
Date: Fri,  1 May 2026 23:35:53 +0800
Message-Id: <20260501153553.66382-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501153553.66382-1-18255117159@163.com>
References: <20260501153553.66382-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4HBbyPRpuOd_Cw--.58479S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1xXry8try3ZF17tFy8AFb_yoW8Gr1Dpa
	y7GFWxG3WIqrW5uanrZ3W5XFyaqFn8J3y7GrZag3WxZFnxCr93JFyIqFyfJ3ySkF4kAF13
	A3Zrt342qr43tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zZg4U5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x3ghGn0yF2uugAA3O

Set cdns_pcie.max_link_speed to the maximum supported link speed
(obtained from the device tree property "max-link-speed") in
j721e_pcie_set_link_speed(). This activates the post-link delay logic
added in cdns_pcie_host_wait_for_link() when the controller supports
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

