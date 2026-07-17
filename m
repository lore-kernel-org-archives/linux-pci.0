Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0A3C8716;
	Fri, 17 Jul 2026 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281901; cv=none; b=qT0bn/MsMYfaEsO4nOfeVMAjxMxha2E0P8a/3h88KEOnXWOAtIbazInqtk3OoNQi/MheowdIVDyUDow5LDIohbQ6keijafsTkLkOsjKU25xWwL4/KXRgbllGxuvU92YGoC/a8qbDQjJLnGmK5tTgyiyVd2ZLeUUmuWkiuNBwcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281901; c=relaxed/simple;
	bh=FRKOW5qlUmIS/8mUlgbPDLIACCHewyeZoycB3AfFFR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cx3Xt6CW23BIaVBALr8aRb8WyP7msd+Dif5AJ/OzqzB51SG6FxtURTb+lq3YVBdErWtd4qNXhbjZYW4Ma9mevr1BVKpxtdy13qltKl9H6oKVf7IyrJgvMukUBypZ1yz1mw0piVXQH4hgkegmEF//wfrDqnBk+6cXLYxhAmCd9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1645996281c511f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f02f1134-a8e6-48ca-bb68-a070a8cd5ccd,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:cb1c03edffc0eab13c4d4818ad587cf9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1645996281c511f1aa26b74ffac11d73-20260717
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 929762574; Fri, 17 Jul 2026 17:51:30 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: leixiang <leixiang@kylinos.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Fix use-after-free in pci_p2pdma_add_resource() error path
Date: Fri, 17 Jul 2026 17:51:17 +0800
Message-ID: <20260717095120.51111-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pci_p2pdma_add_resource(), a devm action is registered to call
pci_p2pdma_unmap_mappings() with the 'p2p_pgmap' context. If the subsequent
call to gen_pool_add_owner() fails, the code jumps to the 'pages_free'
error path.

In this error path, 'p2p_pgmap' is explicitly freed via devm_kfree().
However, the previously registered devm action is never removed. This
leaves a dangling pointer in the device's devres list. When the device
is unbound and devres is cleaning up resources, the unmap action will be
called with the already-freed 'p2p_pgmap', resulting in a use-after-free
bug.

Fix this by properly calling devm_remove_action() in the error path before
freeing 'p2p_pgmap'.

Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
Assisted-by: Antigravity:Gemini [tools]
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 drivers/pci/p2pdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..7f54532932ab 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -451,13 +451,15 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			range_len(&pgmap->range), dev_to_node(&pdev->dev),
 			&pgmap->ref);
 	if (error)
-		goto pages_free;
+		goto unmap_mappings;
 
 	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
 		 pgmap->range.start, pgmap->range.end);
 
 	return 0;
 
+unmap_mappings:
+	devm_remove_action(&pdev->dev, pci_p2pdma_unmap_mappings, p2p_pgmap);
 pages_free:
 	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:
-- 
2.43.0
