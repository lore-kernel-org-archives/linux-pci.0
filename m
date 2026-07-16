Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5A3502A9;
	Thu, 16 Jul 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201515; cv=none; b=DsPd5AQq932x4DOPVHNr5kaQlymnZbTRYN61Nm3yUPznWRJsEGD7dkCTXWGIMu6cC/D6aiBzbPGQzzafMjPRoGwdmM0j6mZxjKeLNZE45MOo0Q+AEErAyk+ijyFZSvcYFlI38nUMMJNa/XY1bY0Wkr4oyUss1xJ64DIaLp48JYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201515; c=relaxed/simple;
	bh=WM02DUzdy4HabgJXR75yvultM4DgXC9/b7Dv8gui5Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+/Fa72ohCpn2u05SXfMDFh5b7QeqNBbOQ/jKVtbpPOnDI+ortIdjhWsVP5DnMcViuPI1MU6uDqtV5OL4aGeXZ3CbdfLm4GFa6mkXZ2f/dc+7z5VQklp9Y0q0/MekMODWTMhXT4pnLbNWFgebxHlfIqZueG+v8dsd2fh04KNeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KJiRJ4Jn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KJiRJ4Jn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784201506;
	bh=WM02DUzdy4HabgJXR75yvultM4DgXC9/b7Dv8gui5Ks=;
	h=From:To:Cc:Subject:Date:From;
	b=KJiRJ4JnoUuVCKAe8iph6AMfb4k42Y2/Tr17o3sLhSsjqvpZ3hVJG7p0m0kRmPccO
	 1yJbo8RVSnIuw6RX5WAwuXt5NUo7DENh/HWbOnRTkrmeit5ekPofCNMwatnkLCa5L9
	 QfMdfhFB+b7Eelg4vq2lWbssMKRupp2RDz4ZKs/jYT1ryagqKAPMZAZg+CR03fOTCQ
	 hikKUkeIx6VbNX/2ZWJqdsLnNxKSTuEitcZJFgigQHSEWrtZkUyS5sSdkoriUAiGu9
	 5PjuZKE5CeOytemEQQBjV+KI3MJsQhfvtlHKzg7ply88D7opevfawK5YZATPNDVJ+3
	 eSK2CziPIye/A==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FC8E17E0177;
	Thu, 16 Jul 2026 13:31:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bartosz.golaszewski@oss.qualcomm.com,
	wenst@chromium.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] PCI: mediatek-gen3: Initialize all resources before installing ISR
Date: Thu, 16 Jul 2026 13:31:42 +0200
Message-ID: <20260716113142.46742-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the bootloader leaves the PCI-Express MAC+PHY enabled before
booting the kernel, an interrupt may be pending while probing
this driver, which means that the chained interrupt handler is
called as soon as the irq is enabled and handler is installed.

Since the mtk_gen3_pcie structure gets fully initialized only
after installing the handler, that condition results in a NULL
pointer kernel panic (mostly due to pcie->base being NULL, but
other members will be uninitialized as well).

In order to resolve this, disgregate the mtk_pcie_setup_irq()
function and partially do the same to mtk_pcie_setup(), so that
all of the required resources are initialized before installing
and enabling the interrupt handler.

Also, install the ISR after deasserting resets and powering up
the PCI-Express MAC and PHY, by moving the call to the function
irq_set_chained_handler_and_data() to the appropriate place in
mtk_pcie_setup(), as hardware registers cannot be modified if
the hardware is powered down and could result in a SError.

This makes sure that all resources are actually available and
hardware is powered on before any registers operation is done.

Fixes: eddbac092e5f ("PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

The real issue starts with commit eddbac092e5f but this still goes
a bit further by reordering things a bit, enabling the interrupt
after powerup and but before port startup, along with getting the
irq in mtk_pcie_parse_port(), where a bunch of other devicetree
resources retrieval is done, grouping them in one place.

This actually resolves the following issue:

<6>[    6.877824] mtk-pcie-gen3 16910000.pcie: host bridge /soc/pcie@16910000 ranges:
<6>[    6.877854] mtk-pcie-gen3 16910000.pcie:      MEM 0x0050000000..0x0057ffffff -> 0x0050000000
<1>[    6.877972] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000184
<1>[    6.877978] Mem abort info:
<1>[    6.877980]   ESR = 0x0000000096000004
<1>[    6.877983]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[    6.877988]   SET = 0, FnV = 0
<1>[    6.877991]   EA = 0, S1PTW = 0
<1>[    6.877993]   FSC = 0x04: level 0 translation fault
<1>[    6.877996] Data abort info:
<1>[    6.877998]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[    6.878001]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[    6.878005]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[    6.878008] [0000000000000184] user address but active_mm is swapper
<0>[    6.878012] Internal error: Oops: 0000000096000004 [#1]  SMP
<4>[    6.878018] Modules linked in:
<4>[    6.878027] CPU: 0 UID: 0 PID: 82 Comm: kworker/u32:3 Tainted: G        W           7.1.0-rc5-next-20260525+ #1700 PREEMPT(full) 
<4>[    6.878037] Tainted: [W]=WARN
<4>[    6.878040] Hardware name: Google Hylia SKU1/2/4/5 board (DT)
<4>[    6.878044] Workqueue: async async_run_entry_fn
<4>[    6.878060] pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
<4>[    6.878068] pc : mtk_pcie_irq_handler+0x40/0x1f0
<4>[    6.878082] lr : handle_irq_desc+0x3c/0x68
<4>[    6.878095] sp : ffff800080003f50
<4>[    6.878098] x29: ffff800080003f50 x28: ffff000080b7d3c0 x27: 0000000000000000
<4>[    6.878109] x26: ffffcc9bfd8ca990 x25: 0000000000000000 x24: ffff000080204a05
<4>[    6.878117] x23: 0000000043400009 x22: ffffcc9bfb60793c x21: 0000000000000000
<4>[    6.878125] x20: 0000000000000000 x19: 0000000000000184 x18: 00000000ffffffff
<4>[    6.878133] x17: ffff3367f0734000 x16: ffff800080000000 x15: 00000000ffffffff
<4>[    6.878140] x14: ffff000081866bd3 x13: ffff000081866bd5 x12: 0000000000000020
<4>[    6.878147] x11: 0000000000000040 x10: ffff0000802136a8 x9 : ffffcc9bf9da34c4
<4>[    6.878155] x8 : ffff000083149020 x7 : 0000000000000000 x6 : 0000000000000000
<4>[    6.878162] x5 : ffff000083148ff8 x4 : ffff0000831491a8 x3 : 0000000000000000
<4>[    6.878169] x2 : 0000000000000000 x1 : ffffcc9bfa594188 x0 : ffff000080b4c830
<4>[    6.878177] Call trace:
<4>[    6.878180]  mtk_pcie_irq_handler+0x40/0x1f0 (P)
<4>[    6.878192]  handle_irq_desc+0x3c/0x68
<4>[    6.878204]  generic_handle_domain_irq+0x20/0x40
<4>[    6.878217]  gic_handle_irq+0x144/0x2c0
<4>[    6.878224]  call_on_irq_stack+0x30/0x48
<4>[    6.878231]  do_interrupt_handler+0x88/0x98
<4>[    6.878239]  el1_interrupt+0x48/0xb0
<4>[    6.878252]  el1h_64_irq_handler+0x18/0x28
<4>[    6.878264]  el1h_64_irq+0x84/0x88
<4>[    6.878271]  _raw_spin_unlock_irqrestore+0x14/0x68 (P)
<4>[    6.878283]  irq_set_chained_handler_and_data+0xc8/0xe0
<4>[    6.878294]  mtk_pcie_probe+0x98/0x4b0
<4>[    6.878304]  platform_probe+0x64/0xc0
<4>[    6.878317]  really_probe+0xc8/0x3f0
<4>[    6.878327]  __driver_probe_device+0x168/0x1d8
<4>[    6.878337]  driver_probe_device+0x44/0x128
<4>[    6.878347]  __device_attach_driver+0xc4/0x198
<4>[    6.878357]  bus_for_each_drv+0x8c/0xf8
<4>[    6.878365]  __device_attach_async_helper+0xbc/0x148
<4>[    6.878375]  async_run_entry_fn+0x3c/0x188
<4>[    6.878385]  process_one_work+0x164/0x4f0
<4>[    6.878391]  worker_thread+0x19c/0x320
<4>[    6.878396]  kthread+0x138/0x150
<4>[    6.878407]  ret_from_fork+0x10/0x20
<0>[    6.878416] Code: 9100c000 f90037e0 f9400793 91061273 (b9400273) 
<4>[    6.878421] ---[ end trace 0000000000000000 ]---
<0>[    6.891047] Kernel panic - not syncing: Oops: Fatal exception in interrupt
<2>[    6.891051] SMP: stopping secondary CPUs
<0>[    6.893869] Kernel Offset: 0x4c9b79c00000 from 0xffff800080000000
<0>[    6.893873] PHYS_OFFSET: 0x80000000
<0>[    6.893874] CPU features: 0x08000000,003c018b,a6c605a1,357e7663
<0>[    6.893879] Memory Limit: none
<0>[    7.258223] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---


 drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++-------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 66c33a09dd95..2c28b8e983c3 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -903,25 +903,6 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
-static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
-{
-	struct device *dev = pcie->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	int err;
-
-	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq < 0)
-		return pcie->irq;
-
-	err = mtk_pcie_init_irq_domains(pcie);
-	if (err)
-		return err;
-
-	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
-
-	return 0;
-}
-
 static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
 	int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
@@ -939,6 +920,10 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 	pcie->reg_base = regs->start;
 
+	pcie->irq = platform_get_irq(pdev, 0);
+	if (pcie->irq < 0)
+		return pcie->irq;
+
 	for (i = 0; i < num_resets; i++)
 		pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
 
@@ -1175,10 +1160,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 {
 	int err, max_speed;
 
-	err = mtk_pcie_parse_port(pcie);
-	if (err)
-		return err;
-
 	/*
 	 * Deassert the line in order to avoid unbalance in deassert_count
 	 * counter since the bulk is shared.
@@ -1205,6 +1186,9 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 		}
 	}
 
+	/* All resources are now available: install the chained handler */
+	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
+
 	/* Try link up */
 	err = mtk_pcie_startup_port(pcie);
 	if (err)
@@ -1233,9 +1217,12 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 	pcie->soc = device_get_match_data(dev);
-	platform_set_drvdata(pdev, pcie);
 
-	err = mtk_pcie_setup_irq(pcie);
+	err = mtk_pcie_parse_port(pcie);
+	if (err)
+		return err;
+
+	err = mtk_pcie_init_irq_domains(pcie);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
 
@@ -1245,13 +1232,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 		goto err_tear_down_irq;
 	}
 
+	host->ops = &mtk_pcie_ops;
+	host->sysdata = pcie;
+	platform_set_drvdata(pdev, pcie);
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
 		goto err_destroy_pwrctrl;
 
-	host->ops = &mtk_pcie_ops;
-	host->sysdata = pcie;
-
 	err = pci_host_probe(host);
 	if (err)
 		goto err_power_down_pcie;
-- 
2.54.0

