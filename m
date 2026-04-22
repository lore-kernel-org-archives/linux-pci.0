Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE81A5B90
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823298; cv=none; b=eakvqErxEg/lwLzI3uiNKcQAa5cxY/m6MFC6CNlczYIJfxNGAeioATKR4IWea6Y8UNDNBcPZR6iwaz0I1PDrSIP+Afyx2De8CtqQG61W1LnLQ/24TyFaLh0ti/FaK3K1FfRyuPFx4nPyhFJnKK4YkH4COebwXHC1ckYnkVPiVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823298; c=relaxed/simple;
	bh=OK3YYnLcx2i4ehxjcAAsRgSdgy4kpF9rBu4QmTsDpYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XEs+bVVgLWyX6IxLNZRs2cQCqAe5vqn2xrfcm2EwOdanxKyJ39qeNUn11u8b6JQSAchsM2+yeShgOqaCZBvUyfTqXfSMdJ3Cwjrp8fCBTRlVbyvT0+KVjD6hZCxniEITvlGf7WpCcmMcCWfocNXFc5NdwU9UTGp2azu2RPHtWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U1MD95gE; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U1MD95gE"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba07bb51;
	Wed, 22 Apr 2026 09:25:54 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 3/3] PCI: vmd: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Wed, 22 Apr 2026 09:25:27 +0800
Message-Id: <1776821127-234830-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9db2cb327209cckunm4d4f8bca15df3d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5OVkhKSh1IS0gfTU5IGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=U1MD95gEQXC1grldOftazemM99uBMjRkdMUKyW0819FCa1Dglmaiq3bMXdkd076iv6OCXYgKQmzGd5q6ERvaZV6g8vw94tCca2R6ZbhIYFJM7godwBwE7I0ZLtxCA2Rup/gmy4+s0mp9mu6OLTvHJnAtSVojJtHXnU8B8kTED6o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tEXBenlFprHa6FEEe0Ln4EQ4v0tcPoFiis15E3/s5B0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors() to
explicitly request devres-managed interrupt vectors. This makes the
driver's intention clear and avoids the ambiguous implicit management
previously provided by pcim_enable_device().

The change prepares the driver for the eventual removal of the hybrid
IRQ management pattern from pcim_enable_device(), ensuring consistent
resource management through devres.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/vmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250..d8de63a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -684,8 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
-						vmd->msix_count, PCI_IRQ_MSIX);
+	vmd->msix_count = pcim_alloc_irq_vectors(dev, vmd->first_vec + 1,
+						 vmd->msix_count, PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
2.7.4

