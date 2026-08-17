Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BC3BBA05;
	Mon, 17 Aug 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953554; cv=none; b=PJrUzN6GmXVYwY2R3dJ+QNvEz9ull3gJ4K5TGZIs8AC3+hvkwbOqN/VqdHmjm/znVTSeCMQn8R/Jboe6BlgWAm2+uXQMVoe4KtjAxjaI9k5/MpvVqpGI3kTWQ84ZWvD8HJVM/aPcReCqrh427K4bUasL2dZgYRok5OyEwx+pST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953554; c=relaxed/simple;
	bh=/jiHJvQNV58UYr/lcQfPX2Spvn78kO9MVNKZkRyocy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDJqugYlX2lHjgLJ3BhswSB2NmobyTcK0S+3U/VmvIKjFHrnqSORjrNW6pr0Zhqzm+VjeWDqJLqJa/bmbH0Zi45LJRZJGTR0UxStowAnuZx7uqz3d6RDSampbdjaP60MY+w0QC8Ff4CJee+8SnQeA5B5ZwHw3OJVky8x8qOXa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=fFbacJ38 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="fFbacJ38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=TtY9J2QK7D1O/4l9zOnU+V2eKgM70/78jl
	660bLlyTo=; b=fFbacJ38mSO9s85cCIjDxK6OnmyoVmNtI0kSbrL0gw9+CJQ5cY
	Vigtp0CklbbI7PyAebVzYX6wO/2C8Bih+YftGS3EgsVib/Rk2Jjx2bXmDzz3w6MZ
	eIrAwTYjeZLNgi33L1o8rB/WBy1HDf3H7RtHf9pB8+ldAabYISS0LJP5g=
Received: from localhost.localdomain (unknown [61.177.32.126])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCn+yBCv4JqQK+EAA--.36036S3;
	Mon, 17 Aug 2026 15:59:03 +0800 (CST)
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
Subject: [PATCH v2 1/2] PCI: Add MMIO Capabilities Register Block definitions
Date: Mon, 17 Aug 2026 15:58:53 +0800
Message-Id: <20260817075854.17207-2-engguopeng@buaa.edu.cn>
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
X-CM-TRANSID:Nyz+CgCn+yBCv4JqQK+EAA--.36036S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWrJF1DGr1fWFWxAry8AFb_yoW8tryrpr
	s8CasIgF4UtFW7Gwn7Ka4UGr17XFyrtrW3Z3yagrZ8JFnxK348Cw1kWF4YqF92vrs7AFy5
	Zw4q9348Wa9rZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
	67AK6r4xMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7VU10tC7UUUUU==
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

From: Penn <engguopeng@buaa.edu.cn>

PCIe r7.0 sec 6.35 defines the MMIO Capabilities Register Block
(MCAP). It consists of an array header followed by capability headers
that identify the version, location, size, and vendor of each MMIO
capability.

Define the MCAP array-header and capability-header registers and their
fields. These definitions allow subsystem drivers to use the Vendor ID
along with the Capability ID when capabilities from multiple vendors
share the same MCAP.

Signed-off-by: Penn <engguopeng@buaa.edu.cn>
---
Changes in v2:
- Update the MCAP specification citation to PCIe r7.0 sec 6.35.
- Document that capability header indices are one-based.

 include/uapi/linux/pci_regs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..4dd22cde9e71 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1338,6 +1338,28 @@
 #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
 #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
 
+/* PCIe r7.0, sec 6.35: MMIO Capabilities Register Block (MCAP) */
+#define PCI_MCAP_ARRAY_1		0x00
+#define  PCI_MCAP_ARRAY_ID		__GENMASK(15, 0)
+#define  PCI_MCAP_ARRAY_VERSION		__GENMASK(23, 16)
+#define  PCI_MCAP_ARRAY_TYPE		__GENMASK(27, 24)
+#define  PCI_MCAP_ARRAY_TYPE_CLASS_CODE	0x0
+#define PCI_MCAP_ARRAY_2		0x04
+#define  PCI_MCAP_ARRAY_COUNT		__GENMASK(15, 0)
+
+/* Capability header indices are one-based. */
+#define PCI_MCAP_HDR_SIZEOF		0x10
+#define PCI_MCAP_HDR_BASE(n)		((n) * PCI_MCAP_HDR_SIZEOF)
+#define PCI_MCAP_HDR_REG_1		0x00
+#define  PCI_MCAP_CAP_ID		__GENMASK(15, 0)
+#define  PCI_MCAP_CAP_VERSION		__GENMASK(23, 16)
+#define PCI_MCAP_HDR_REG_2		0x04
+#define  PCI_MCAP_HDR_OFFSET		__GENMASK(31, 0)
+#define PCI_MCAP_HDR_REG_3		0x08
+#define  PCI_MCAP_HDR_LENGTH		__GENMASK(31, 0)
+#define PCI_MCAP_HDR_REG_4		0x0c
+#define  PCI_MCAP_HDR_VENDOR_ID		__GENMASK(15, 0)
+
 /*
  * Compute Express Link (CXL r4.0, sec 8.1)
  *
-- 
2.43.0

