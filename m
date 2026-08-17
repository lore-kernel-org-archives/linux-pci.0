Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF73BBA09;
	Mon, 17 Aug 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953557; cv=none; b=beGpVs0X78v9xlPEadE7Hsk7NHCJDmsvpDE3eKUP0VEKavqlOSayfe4hl0+e1imJ5luZh5CKgd+AHPXKyF/MvwVrjh0UN8XFZYHwD3y6g8QKoiECxQdVX+1oHcmV6Xh03N2XdiWxoZpCMMfPo2I3ZkKPJFQmvMgzTSD8PJ7YLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953557; c=relaxed/simple;
	bh=RzMB2IiZ7mKATTST2XcqxoYyQcTCbQ70HP+6xtdWH/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/xOMiNGf74zUxkPAsq4JTQNcNGa3Xl0Ej2C8B1GXw4w09nC1jLsgyEI7J9utJyCqQYTc2J3gby5V+l4ywcfDxILhdeXNuZqaOBc7UJkUDjbHu3Xe8i0ia6z2FhAS2i1RLA7Vp2GDXLhQ89g37mNWvd79fPrHmAGwhOfMkhphI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=CN0TXnUs reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="CN0TXnUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=K369yF51RzG3o8pZ1IjmcRCCSz9AnjQOzT
	n2Rq2G0Bo=; b=CN0TXnUsUUVf87VsBQqri5+qgCgD2gzgOjINr2URX3XUHloLXe
	JosjnMF5BOlbc0rZc+fF/UxK+07LHYmHfh2qAC9/IR6jDYXIqwMKJGA2QXJVmFju
	sTpr0mVxKuENu+DJrpIzA2D9RvtK4BqwfU4pAoddLpt4SiPaEUU9odS1E=
Received: from localhost.localdomain (unknown [61.177.32.126])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCn+yBCv4JqQK+EAA--.36036S4;
	Mon, 17 Aug 2026 15:59:06 +0800 (CST)
From: penn <engguopeng@buaa.edu.cn>
To: linux-cxl@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	johnny.li@montage-tech.com,
	peng.guo@montage-tech.com,
	jingzhong.yang@montage-tech.com,
	Penn <engguopeng@buaa.edu.cn>
Subject: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Date: Mon, 17 Aug 2026 15:58:54 +0800
Message-Id: <20260817075854.17207-3-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgCn+yBCv4JqQK+EAA--.36036S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DurW5AF13Xw1fXr18Xwb_yoW5Jw4DpF
	4kG3yYgay8tr4xArZ7Aa1UXFyrZF9Yya47AF98K3sY9FsrC3W5urWIyayFqFyak3s7JF13
	XFZFq3yFkwn8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
	wVAFwVW8CwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUGhFxUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

From: Penn <engguopeng@buaa.edu.cn>

When MMPT is enabled, a CXL device may expose CXL-defined capabilities
and PCIe Management Message Passthrough (MMPT) capabilities in the same
MMIO Capabilities Register Block (MCAP).

The CXL capability parser currently identifies entries using only the
capability ID. Since capability IDs are scoped by Vendor ID, a
PCI-SIG-defined capability may have the same ID as a CXL-defined
capability. This causes non-CXL entries, including MMPT and MMIO Mailbox,
to be interpreted as CXL register blocks.

The MMPT register block may be interpreted as a CXL mailbox. This
causes mailbox initialization to fail with:

    cxl_pci 0000:3b:00.0: Mailbox is too small (64b)

Check the MCAP Vendor ID before interpreting an entry as a CXL-defined
capability. Skip capabilities with a non-zero Vendor ID other than
PCI_VENDOR_ID_CXL.

In legacy CXL capability headers, the field now used for the MCAP
Vendor ID was reserved and reads as zero. Continue to accept zero to
preserve compatibility with those devices.

The fix has been tested on CXL 1.1 and CXL 3.0 devices. On the
MMPT-enabled device, it prevents both Mailbox and Status capabilities
from being misidentified.

Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
Suggested-by: Johnny <johnny.li@montage-tech.com>
Signed-off-by: Penn <engguopeng@buaa.edu.cn>
---
Changes in v2:
- Accept a zero Vendor ID for compatibility with legacy CXL capability
  headers.
- Move the u16 declaration above the u32 declaration to follow the
  reverse Christmas tree convention.
- Document testing on CXL 1.1 and CXL 3.0 devices.

 drivers/cxl/core/regs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..c7c14089f2c6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -133,8 +133,18 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 
 	for (cap = 1; cap <= cap_count; cap++) {
 		struct cxl_reg_map *rmap;
+		u16 cap_id, vendor_id;
 		u32 offset, length;
-		u16 cap_id;
+
+		vendor_id = FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
+				      readl(base + PCI_MCAP_HDR_BASE(cap) +
+					    PCI_MCAP_HDR_REG_4));
+		/*
+		 * The Vendor ID field is reserved and reads as zero in legacy
+		 * CXL capability headers. See CXL r3.2, Table 8-44.
+		 */
+		if (vendor_id && vendor_id != PCI_VENDOR_ID_CXL)
+			continue;
 
 		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
 				   readl(base + cap * 0x10));
-- 
2.43.0

