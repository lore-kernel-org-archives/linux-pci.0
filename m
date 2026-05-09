Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4D33A9DA;
	Sat,  9 May 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332076; cv=none; b=BVIhjyIQKd2HrOnYGMAkAGUXdYMccn9v07b34UZcMeD0HWkA78wqERoFzZtNY9VWJtaiXEpPN4cLf3jYCBAfiOaNgKmjKvNw/9WanLOsF8WQyCe7O9b5DP7JdYtkR1+v6RhQb+IF+/FWtIdGoWXzf99ryyWVrKcGZJJRGuqZUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332076; c=relaxed/simple;
	bh=Bx5RTG16alEN33aSfTu6bO/Q+OFo/APLLyZtp2E2Xfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4npCorcrV50rgD6iK46Knklvq5HcjphgHlaQmigaRmqzP41nBSqoNCQ4E8fn9gaoi2khEY7QedMiBMtN1i3L6rMiDdrdUZFi+MeeuewkrtA61sPyonCM2mYzCGoYQYKZ6pf8eXO+ggGElH3v8Xcpgy2+utUU+0mDzqOGEfwoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XlQv04Zd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XlQv04Zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lL
	jAusElsxPsZJOzV0FysF8OcaXhcq79UBPL0AsoViM=; b=XlQv04ZdsuhQbHRSA9
	gXLltCmKQYrTVl0nwk6bd6AlAICU5rKhv9cBW9cIi6yFmY7qEwz8LabYgnNnqzxv
	52OYjX2i7LiARoCWopCvcp95QNlPjDuKNq2CC8whoorsgslJF5eXwAxj9CbSgz+w
	hg5t56mpRwFYjqwtGJ/ATklbo=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHYi+GMf9pRitfDA--.13014S3;
	Sat, 09 May 2026 21:07:22 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/3] PCI: cadence: Fix Root Port configuration space access for LGA IP
Date: Sat,  9 May 2026 21:07:14 +0800
Message-Id: <20260509130716.2104103-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509130716.2104103-1-18255117159@163.com>
References: <20260509130716.2104103-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHYi+GMf9pRitfDA--.13014S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1UGF48Cr4fKw4rZryxZrb_yoW8KF13pF
	4DGFWfK3WfJFWa9Fnaya98W3WYyF9ava4DJana9w17ZF1a9rWUJFyY9Fy5KF13KrW0v34x
	ZrWDtr9rGFn0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pN0PffUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxArIbGn-MYqeAQAA3Y

On LGA (Legacy) Cadence IP, the Root Port configuration space is
located at offset CDNS_PCIE_RP_BASE (0x00200000) from the controller's
base address. However, the standard accessors cdns_pcie_read_cfg_*()
did not include this offset when operating in RC mode, causing any
configuration read (including capability list walking) to access the
wrong register region (Local Management space).

Additionally, cdns_pcie_read_cfg_dword() used a direct readl()
instead of the more general cdns_pcie_read_sz(), breaking symmetry
with byte/word accesses.

Fix this by:

Adding CDNS_PCIE_RP_BASE to the address for RC mode on non-HPA
(i.e. LGA) IP.

Replacing cdns_pcie_readl() with cdns_pcie_read_sz() in the dword
accessor for consistency.

This change enables correct capability discovery for Root Ports on LGA
platforms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index a1c531fd2061..c057f4b393e6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -433,6 +433,9 @@ static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
 {
 	void __iomem *addr = pcie->reg_base + where;
 
+	if ((pcie->is_rc) && (!pcie->is_hpa))
+		addr += CDNS_PCIE_RP_BASE;
+
 	*val = cdns_pcie_read_sz(addr, 0x1);
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -442,6 +445,9 @@ static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
 {
 	void __iomem *addr = pcie->reg_base + where;
 
+	if ((pcie->is_rc) && (!pcie->is_hpa))
+		addr += CDNS_PCIE_RP_BASE;
+
 	*val = cdns_pcie_read_sz(addr, 0x2);
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -449,7 +455,12 @@ static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
 static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
 					   u32 *val)
 {
-	*val = cdns_pcie_readl(pcie, where);
+	void __iomem *addr = pcie->reg_base + where;
+
+	if ((pcie->is_rc) && (!pcie->is_hpa))
+		addr += CDNS_PCIE_RP_BASE;
+
+	*val = cdns_pcie_read_sz(addr, 0x4);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-- 
2.34.1

