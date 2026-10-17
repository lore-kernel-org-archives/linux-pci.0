Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9A2EA15C;
	Sat, 17 Oct 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257691; cv=none; b=jx7KRMykOn4M7ZYcOEkw166u44nTaqtYFzEKXc2vVYYAap4asYNYw/M3jvWI63bhhqxYUFsrdLZt7fS/SNsrCZINdf8VeCpZlwCAmTwPl1YJ0GkU2ftpMmb+q+OFSy8z0p4wlgb3JhZNzX/OycPGqMtkEnTznoD2ZXNdqMJ8sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257691; c=relaxed/simple;
	bh=zxX3E83OqIIUS7m4i7EBtiQvC3cvBH+WbrlMsDxkj2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjjqWAqF5W//HiDudyUDS7L/61bRBYOs/yAg4fx6vFnfpP6IWNxjm01vlUWnmF9VlAdKg3xaDhigIUbHmvVXqco2DQp6tc5u1Si96kBAqt7V5hH+CbvIrXIFdJk5sVgGYD+AjVeRQMSLDmG9x+z7xDNghBii6W4FoDV9p/SASaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nKjGRPNd; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nKjGRPNd"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6T9x4JRyzMldw;
	Sat, 17 Oct 2026 19:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792257685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2XRTHANTl2Pu+iHWqQX9TXGargdFMBQEeSuu9dQWAqU=;
	b=nKjGRPNdT2ecST9FgP0q03CUo+N7F6e7z6hXFoDkEOwr68tJwag041sRz8f/WdPPsvES+4
	/YVi2xbPSgw1tnAqYc8WCYuQUsas/A9GlbjFev78meNtxJuOVCplN402oftJ1nGYdPrO3c
	dJM3l3bgzOK983lMuVE00lgyOMIItSoEpim2wmKW3pmrndONku3WImHUiaaS0GQcnXaI9i
	3B1mGamQD4tr+XRwgfNMrlZCvWjEJ4mSYfqiRYez0C4ktX8w5xfByv+cqmcDTrHY6f9VNI
	MLThCqs1ok5MuDykCB3TKbnHyMkUoU5YiXT3sy43RikzPkbcKm5UdBF5ps+Jew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-host: Free MSI IRQs on error
Date: Sat, 17 Oct 2026 19:20:21 +0200
Message-ID: <20261017172122.225861-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 14c1b8ccd5b199db274
X-MBO-RS-META: dwkqwgazuunnwt96x5miy83t9cnm9q8q

The rcar_pcie_get_resources() calls irq_of_parse_and_map() on both IRQs.
The rcar_pcie_enable_msi() called afterward calls devm_request_irq() on
both IRQs. In case a failure occurs after rcar_pcie_enable_msi() was
already called, the invocation of irq_dispose_mapping() on those two
IRQs triggers a WARNING:

remove_proc_entry: removing non-empty directory 'irq/96', leaking at least 'R-Car MSI'

Fix this by calling devm_free_irq() on those two IRQs before invocation
of irq_dispose_mapping(), this way the IRQ is free'd before it is
unmapped. Fix matching issue in rcar_pcie_enable_msi() fail path too.

Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 remove_proc_entry: removing non-empty directory 'irq/96', leaking at least 'R-Car MSI'
 WARNING: fs/proc/generic.c:747 at remove_proc_entry+0x120/0x144, CPU#3: kworker/u33:6/81
 CPU: 3 UID: 0 PID: 81 Comm: kworker/u33:6 Not tainted 7.3.0-rc7-next-20261016-00042-g33a3dc2a3ff4-dirty #2134 PREEMPT
 Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : remove_proc_entry+0x120/0x144
 lr : remove_proc_entry+0x120/0x144
 sp : ffffffc0804238a0
 x29: ffffffc0804238c0 x28: 0000000000000000 x27: 0000000000000000
 x26: ffffff84c01db20d x25: ffffffe1678941eb x24: 0000000000000061
 x23: 0000000000000001 x22: ffffff84c016e000 x21: ffffffe167f639b0
 x20: ffffffc08042390d x19: ffffff84c0de1d00 x18: 00000000ffffffff
 x17: 6e696b61656c202c x16: 2736392f71726927 x15: 0720072007200720
 x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
 x11: 000000000000018a x10: ffffffe167ea7878 x9 : ffffffe167eff930
 x8 : 3fffffffffffefff x7 : ffffffc0804235c0 x6 : 0000000000000000
 x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff84c110e300
 Call trace:
  remove_proc_entry+0x120/0x144 (P)
  unregister_irq_proc+0xd4/0x100
  free_desc+0x3c/0x18c
  irq_free_descs+0x70/0x74
  irq_domain_free_irqs+0xb0/0x11c
  irq_dispose_mapping+0x64/0x138
  rcar_pcie_probe+0x254/0x5ac
  platform_probe+0x68/0x8c
  really_probe+0x1ac/0x388
  __driver_probe_device+0x160/0x170
  driver_probe_device+0x44/0xec
  __device_attach_driver+0x10c/0x124
  bus_for_each_drv+0xa8/0xd0
  __device_attach+0x98/0x174
  device_initial_probe+0x34/0x48
  bus_probe_device+0x30/0x90
  deferred_probe_work_func+0xd8/0xf0
  process_scheduled_works+0x300/0x4ac
  worker_thread+0x13c/0x1cc
  kthread+0x108/0x118
  ret_from_fork+0x10/0x20
 irq event stamp: 8926
 hardirqs last  enabled at (8925): [<ffffffe1666b840c>] __up_console_sem+0x50/0x64
 hardirqs last disabled at (8926): [<ffffffe1672c5908>] el1_brk64+0x1c/0x4c
 softirqs last  enabled at (8920): [<ffffffe166610214>] __do_softirq+0x10/0x18
 softirqs last disabled at (8899): [<ffffffe166610214>] __do_softirq+0x10/0x18
---
 drivers/pci/controller/pcie-rcar-host.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 5856861922599..aedfb283826b5 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -768,7 +768,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
+		goto err_irq2;
 	}
 
 	/* Disable all MSIs */
@@ -783,6 +783,9 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 
 	return 0;
 
+err_irq2:
+	devm_free_irq(dev, host->msi.irq1, host);
+
 err:
 	rcar_free_domains(msi);
 	return err;
@@ -791,6 +794,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
+	struct device *dev = pcie->dev;
 
 	/* Disable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
@@ -798,6 +802,8 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 	/* Disable address decoding of the MSI interrupt, MSIFE */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
 
+	devm_free_irq(dev, host->msi.irq2, host);
+	devm_free_irq(dev, host->msi.irq1, host);
 	rcar_free_domains(&host->msi);
 }
 
-- 
2.53.0

