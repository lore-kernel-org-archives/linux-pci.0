Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194071;
	b=V4+sitfWnWWX09fHJpO19HRdhkxXtgeeXt4TR4bLMgLU8xCs1a4jzMnP6l6H4hRHRgrY
	 yy9aEIMOGHovGWixPQgJRiBFzQCh+UBxsV/TwuNgb5YGno97cLZLgBfEIdes0+a73rO1t
	 MFsEtJ8Xs+f8uayVqBpR+OycjB/DQNJ6Ulj8Ie1Xxo0A4yncZwtdzCup5rv79U2c7gyOx
	 LppHCTxs9273o8Z/CdGMV8mZAZO2HJrVoxQe97T/oe900SqQzTLPlEm+gDWgoByb4djYd
	 kihGKfHS/k3wo3JXlf+TZYklEErEzKsS4gaGeGglXJCGme4fm6V+FlKa41PhKTPFt9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194071;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=ajFsvHsw9ZV5CYCE+L14wp5QKFYCfNkD8yU/JAp01+0=;
	b=qVKZTlF206dOdbkH/a3PxYIMY578aaXmDcN/rBWjPnI5hn389/V2HmASQa7L4u2u+CN3
	 2ZS3WZsJEEvXQa+3iT8Pl4Cmw3jqeErjrwlLsYgbNABlbsGhSPZQin5y7kPFn3DYNVmIK
	 2d1sDo6HGBM4J3uiTB1OQDGPce0/FoNJAdvgFMo02xjUmmqV/V5buLNKpxKow2wB/bFhS
	 4eMYKoO+40EzVFetBb6NFoLNKOTLZZJM2aS8s3+NloNgfJlMLtV11LbZL3BBph0eqy3pQ
	 navrupia/MoggItVdeX1HnVvDBYHimAzxDlIIZny4RRzPEEPEi8s8MKbZ/zFQXmH3sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=OzzmcBb8;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 77B1E606A320;
	Mon,  9 Nov 2026 03:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B1E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=OzzmcBb8
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Li RongQing <lirongqing@baidu.com>,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, Yuanhe Shu
	<xiangzao@linux.alibaba.com>, Hans Zhang <18255117159@163.com>, Vidya Sagar
	<vidyas@nvidia.com>, Farhan Ali <alifm@linux.ibm.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Juergen Gross <jgross@suse.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/MSI: Initialize MSI-X descriptors in the setup loop
Date: Mon, 9 Nov 2026 11:14:11 +0800
Message-ID: <20261109031411.2205-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794194061;
	bh=ajFsvHsw9ZV5CYCE+L14wp5QKFYCfNkD8yU/JAp01+0=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=OzzmcBb8UKyypdfR5JRuswJ+7iDQ249ICfUMqL4NccpN7qdR3Do++/PbQL/fCA15T
	 n9t9/a6mOKTYCHWyRs7rT8BR8vK30gh+FahnAr0giQUp5mClAMLIAHb8lMwigRuhN8
	 iTwugNhXFf5Eq5JBWwkiBqNPIN/ufY6yPujzDFrJcq9GtWSTkPgtyu+jk1lTqWGMk+
	 L3/mpmT/k7Tx2zh47EPICMWpL0W89g9KjnVh2EV4ig/svDYOvoBpuSr4VNzkjS1jWh
	 4I9UXBtofju4UDX/FPpUuvCzTsvst6Kipw5/NzZ97VXF9cbf+A07CAoMJ3Vu0BvX0Q
	 ha06kP6EufKpA==

From: Li RongQing <lirongqing@baidu.com>

msix_setup_msi_descs() reuses a single stack descriptor for all
MSI-X entries.

Since msix_prepare_msi_desc() only sets can_mask for non-virtual
descriptors, a virtual descriptor can inherit can_mask == 1 from
the preceding real descriptor.

As msi_domain_insert_msi_desc() copies the descriptor, this stale
value can cause pci_msix_write_vector_ctrl() to access beyond the
mapped MSI-X table.

Clear the descriptor inside the loop to ensure each MSI-X entry
starts with can_mask == 0.

Fixes: 3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/msi/msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index a346284..681dd2f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -638,9 +638,8 @@ static int msix_setup_msi_descs(struct pci_dev *dev, struct msix_entry *entries,
 	struct irq_affinity_desc *curmsk;
 	struct msi_desc desc;
 
-	memset(&desc, 0, sizeof(desc));
-
 	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
+		memset(&desc, 0, sizeof(desc));
 		desc.msi_index = entries ? entries[i].entry : i;
 		desc.affinity = masks ? curmsk : NULL;
 		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
-- 
2.9.4

