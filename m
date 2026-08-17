Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC753B893C;
	Mon, 17 Aug 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953555; cv=none; b=X1qoOtDwx21Usyc8I9MUlGneoestN0Kfiut3apAc9aqBzbfpPDYOALdhqwziD1g2yBCHKnP/PKiPm2shulnWrM6GQl5XVvAcfwK6S148CfuAwivczvFmJ5b1pbc29GiQNa5TmOzven946Ugylu8xJ1xi6bLywFd3ZdFw48rzKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953555; c=relaxed/simple;
	bh=RucAdu/L/lKt5DB9LfrJVlFxjNoiBx4Z0ABwjk9rTzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBLBvoHzv51vxMYKZkwe6+Gcb8LTfh1hHvg9z8+GWbOrGplLC0owbj2A1u24iH7Vln7dTAN/aWs0d7UbpgmBKh94mP+D2QraInimK4IQGlAbj6Vhs0Z1LclLKJ5hcgKA+wJ42KfUYsSj6fNAyWnrB5ixTMlo9Uvszw3SyeapNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=RKopZbs/ reason="key not found in DNS"; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="RKopZbs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=El6V5A/3KG
	8e+CPQWGJn02nuxkSqI95scSt0bo3Gj1U=; b=RKopZbs/0T8Zw/xpan9rqJ2O6d
	5Tz45nIxnsbrQvOhWjVKgl6FxeV9Cc4KJCvcJ0aWdyGIOEf+8+XJj78qreQft8Iw
	DMZ+f7gmoYkxzBNCS4VCotL0Jwy/QSCEkGRh3e7QNfZVqctxfXQQWnSd+nSvCLLM
	ogm3U7ee7NQ2QmYgs=
Received: from localhost.localdomain (unknown [61.177.32.126])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCn+yBCv4JqQK+EAA--.36036S2;
	Mon, 17 Aug 2026 15:58:59 +0800 (CST)
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
Subject: [PATCH v2 0/2] PCI/CXL: Distinguish CXL capabilities in MCAP 
Date: Mon, 17 Aug 2026 15:58:52 +0800
Message-Id: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgCn+yBCv4JqQK+EAA--.36036S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15tFy7JFyfuw4rtw4kCrg_yoW8Wr1xpF
	n5Gr4Sqa4rJF43CrZayF48tF1fZFZ5ArW7JFy7G3s5tF4j93WUGrWjyFyrtFyjkr97WF15
	XFWjqry8W3Z8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When MMPT is enabled, a device may expose PCI-SIG-defined MMPT
capabilities alongside CXL-defined capabilities in the same MMIO
Capabilities Register Block (MCAP).

MCAP capability IDs are scoped by Vendor ID, but the CXL capability
parser currently matches entries using only their capability IDs. This
can cause MMPT entries to be interpreted as CXL register blocks.

Add the generic PCI MCAP register definitions, then update the CXL
parser to reject capabilities carrying a non-zero Vendor ID other than
PCI_VENDOR_ID_CXL, while preserving compatibility with legacy CXL
capability headers.

Patch 1 adds the PCI MCAP array and capability header definitions.
Patch 2 filters non-CXL capabilities before interpreting their IDs
while continuing to accept legacy capability headers whose Vendor ID
field reads as zero.

The fix has been tested on CXL 1.1 and CXL 3.0 devices. On the
MMPT-enabled device, it prevents both Mailbox and Status capabilities
from being misidentified.

Changes in v2:
- Update the MCAP specification citation to PCIe r7.0 sec 6.35.
- Accept a zero Vendor ID for compatibility with legacy CXL devices.
- Move the u16 declaration above the u32 declaration.
- Document testing on CXL 1.1 and CXL 3.0 devices.

Penn (2):
  PCI: Add MMIO Capabilities Register Block definitions
  cxl/core: Skip non-CXL capabilities in MCAP

 drivers/cxl/core/regs.c       | 12 +++++++++++-
 include/uapi/linux/pci_regs.h | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.43.0

