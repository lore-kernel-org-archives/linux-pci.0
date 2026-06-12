Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 06101221721;
	Fri, 12 Jun 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253314; cv=none; b=KW3ExQxPDoKNcwUE6CnvVvq/t07NtRAry4O6rEh8bX24voKy/z1lmebf66z84cDuuYatRcvGiUtFOP48AWv4N9If0AMLAUxmF5JXi19xRz3+aYDY7HLL8qqyUQIxNH7yZb5FHuor7z3D+MI+9L8jqcoDwg/BHaa8VRX5LMc9rMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253314; c=relaxed/simple;
	bh=D/PrxaAcHHPQ2g76R55teDrajF1NSDmsEP9kRys+E7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zd/7s4xLBe+Z4apSCaPKIRrx6m7MYVC3Ra4XkqF/iZ/M3wNgIKUWhK/cv0Hbj3Y8mcvwqkIm3x8xcPoTot6VRwkAEjCayIS+fU/b8ObUsU6jBDTyhcm5pBRjRFHhy5fAM8jAehYWirxooBn4bM+cLrS/foY3Jj0tzuSbZLwMu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=TVpZuP8Y; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="TVpZuP8Y"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI/P2PDMA: Use RCU_INIT_POINTER() to clear pdev->p2pdma
Date: Fri, 12 Jun 2026 16:34:52 +0800
Message-ID: <20260612083452.1639-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781253301;
	bh=Jt1IL2VXR8/cyGdUlH8sHmasiufSjX351QzsBeAM8oc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=TVpZuP8YLrN/wPQFIJ0tNYnFM0Xxj5kwuIyBCaGCcCNnw4e3c72//+EQ2sFCafV+D
	 aNsn9AhZvTig4fcEzaSCvpKaIcNH4LUhnf0HqfbpaWVZplXU+hYjI4qRtuzK/qB4lE
	 XnMz61mdZok/JrKEQ8Kr7IuXyqfizyDrShdW/QbfcVT/IDh/mzsE4qgi8SYFjm2Jws
	 vE3tctY7pe6zfncweJlGh72ZJLCxksfBkqDTXf2RYBeRlIWUK13VqoPan+PlUhGDdR
	 CPHJnDLeoTkfT7O9YGdcTWBW/zMiklN6XcyIuW2Gg4+u6uEFHVa+jjF1PocUfz80l0
	 HKbXsu+gh9Qpg==

From: Li RongQing <lirongqing@baidu.com>

Since pdev->p2pdma is an RCU-protected pointer, directly assigning
NULL to it violates RCU semantics and triggers sparse static analysis
warnings.

Fix this by using RCU_INIT_POINTER() instead of a raw assignment,
ensuring proper RCU annotations and consistency with the subsequent
synchronize_rcu() call.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c89854..fd986242 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -236,7 +236,7 @@ static void pci_p2pdma_release(void *data)
 		return;
 
 	/* Flush and disable pci_alloc_p2p_mem() */
-	pdev->p2pdma = NULL;
+	RCU_INIT_POINTER(pdev->p2pdma, NULL);
 	if (p2pdma->pool)
 		synchronize_rcu();
 	xa_destroy(&p2pdma->map_types);
-- 
2.9.4

