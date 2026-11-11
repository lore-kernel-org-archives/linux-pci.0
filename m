Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414890;
	b=nwESy7GDRlx2DTOYsfsYACD3TBc1oFQa7cd4HNCvQmRLBFS8eE5dXvgPQKgokTIvF+39
	 GYGXXaW3vJkC8K99FtJ/PSm/OvpQjbo0BbY247LKUj/wqObhzO4yJm+yCucSNp34lj7uB
	 jpSBde/QIOqfnaQLhq5L3mpnWuXKEndq3wuTlsNGZ+1r7E/6IeKrJJjLVxTiOX8Bn0Nv5
	 eCF7vUfH1yVFvod+4bhSMU28GmFU5mxuTPD7wLBCMf9AjxbwAGJOoksDsmXMPMnwUw5WS
	 r+UMhIp03AU94dvT3WOaqHKLK8eiNJ/6y4OnvHLBo7DrzHODuoFMYW5hpuIbWlRjGWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414890;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=p7rJwov/3j8Ypjm8ghRAS0uIYAtINjdKXgXc9xzdwyE=;
	b=kRiLlhVni4ip7xA9iOzofBmMKhT6VogaoG6JDT11wqfQjFQbH5gueaOWxK/GLvY0JeCI
	 iLL65UJrEKnaFOu32VSdPbEshXuJ3fOKwf6yMzsVtKU74Ui+akvkbX6P6qJF77TRAIutF
	 DzMxHk8sx79W5iTfJCZKvxRwjsC4op5PQhxAx/gRYfQ6cxzXkUNAmyzDIIZIwgisIBQXM
	 tbMGZGYXMNIS/RfZkHulqW8BO+Zv5V9DHX0tjjPSUGsMKQJ4MdWtHW9ZMGi6rqBtxX/Mn
	 3ko/5PvGfbssGdIGIggykWpR3ghn2hu2YJ/xVJ6LKBgHbd3Xa4IdNGhW9If4mlrKplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=d0c0FhnU;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAA606A324;
	Wed, 11 Nov 2026 16:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FAA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=d0c0FhnU
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2900C4C442F7CC;
	Wed, 11 Nov 2026 17:34:01 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-pci@vger.kernel.org
Subject: [PATCH RFC] PCI: Start the reset of WD PC SN730 NVMe controllers early
Date: Wed, 11 Nov 2026 17:31:43 +0100
Message-ID: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794414841; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=p7rJwov/3j8Ypjm8ghRAS0uIYAtINjdKXgXc9xzdwyE=; 
	b=d0c0FhnUNtG2eyBG6EmrEbAbSiDZFbKETWdxmZumAxx11pbvhVVYHVTxjZQ7mYUBWvjReR0aqVjB
	K6lV3pms+Agdf/2W9eBV1EBGjH/Oegn0Acfu3hz4HJvKSBfLUsuAH+EGAbV2mwvQOa/WBGGCj5YyQG
	rMwqLVvU5vimqbBu02YIccXU8x3I2hiqTSMQ1B8T87Xp1lnZeTDzp8X0BdRDvpelrewt3WBT8sTNo+
	KsEPI9PU1lAwaDMOUVMiMDpx3fGCwC4si77NgEGcYrcYpZip7MRMNhexvG2Cm7jTGaAbRBw8GDszrg
	07tY2iIXRBqEKDGXq9k7WCzQWMRc0Z1A==

[Please consider this a bug report.]

On a Dell XPS 13 9310 (BIOS 3.17.0) with a WD PC SN730 1 TB (15b7:5006,
firmware 11170012, the newest available for this OEM drive), about one
boot in ten mounts the root file system 100 to 700 ms late. With the
nvme module probing at 0.29 s from a small initrd, the time from probe
to Identify grows from 9 ms to 74 to 229 ms, and the partition table
read and the mount get slower too:

    nvme nvme0: pci function 0000:01:00.0                 [0.293894]
    nvme nvme0: passthrough uses implicit buffer lengths   [0.522525]  (+228.6 ms, usually +9 ms)
     nvme0n1: p1 p2 p3 p4                                   +27.3 ms  (usually 3 ms)
    EXT4-fs (nvme0n1p3): mounted filesystem                 +82.2 ms  (usually 8 ms)

Tracing nvme_disable_ctrl() and nvme_enable_ctrl() with function_graph
over 120 boots shows the time is spent waiting for the controller reset
nvme_pci_configure_admin_queue() does first, as the firmware hands the
controller over enabled:

    boot  disable (CSTS.RDY 1->0)  enable (0->1)  4 KiB reads after
    fast          2 ms                  2 ms           ~0.1 ms
    slow     81 to 584 ms          16 to 60 ms        5 to 7 ms

The controller state at hand-off, read from the initrd before nvme
binds, is the same in fast and slow boots, CC=0x00460001 CSTS=0x00000001,
so there is no shutdown in progress. The slow resets also happen without
GRUB’s grubenv write before the hand-off (2 of 31 boots) and with the
probe delayed to 0.76 s (1 of 30 boots), so it is no busy period after
the firmware phase that a later probe would avoid.

Clearing CC.EN before the driver binds, emulated from the initrd with
devmem, works: the driver finds CSTS.RDY clear and continues, the reset
completed within the first poll in 29 of 30 boots (35 polls once), and
none of the 30 boots showed a slow reset, enable or read, against 8 of
90 without it. The difference is not yet significant (p = 0.1).

So start the reset in a final fixup during enumeration, at 0.19 s on
this machine, about 100 ms before nvme probes, which overlaps a slow
reset with the remaining kernel initialization and the module loading,
and costs nothing for fast ones.

With this change, 1 of 59 untraced boots stalls, against 7 of 41
untraced boots without it. In the other 58 boots Identify comes 7 ms
after probe and the root file system is mounted at 0.31 s. The stalled
boot:

    pci 0000:01:00.0: NVMe controller reset started early  [0.192544]
    nvme nvme0: pci function 0000:01:00.0                 [0.292395]
    nvme nvme0: passthrough uses implicit buffer lengths   [0.441335]  (+148.9 ms)
     nvme0n1: p1 p2 p3 p4                                   +67.0 ms
    EXT4-fs (nvme0n1p3): mounted filesystem                +104.7 ms

That boot was not traced, so whether the reset outlasted the 100 ms head
start or the enable was slow is unknown.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Note, assisted by claude-opus-5-5 (found, traced and drafted)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee41..e6535bcb0553e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4187,6 +4187,44 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 	return 0;
 }
 
+/*
+ * The firmware leaves the NVMe controller enabled, so nvme-pci starts by
+ * resetting it (CC.EN 1 -> 0) to set up its own admin queue.  The WD PC
+ * SN730 (firmware 11170012) usually completes that within 2 ms, but in
+ * about one boot in ten it takes 80 to 600 ms, and the enable and the
+ * first reads after it are slow as well, delaying the root file system.
+ * Start the reset during enumeration, so it runs in parallel with the
+ * rest of the boot, and nvme_disable_ctrl() finds the controller disabled.
+ * Like nvme_disable_ctrl(), skip the shutdown notification, as it could
+ * complete commands into memory the firmware owned.
+ */
+static void quirk_nvme_disable_early(struct pci_dev *dev)
+{
+	void __iomem *bar;
+	u16 cmd;
+	u32 cc;
+
+	if (dev->class != PCI_CLASS_STORAGE_EXPRESS || !pci_resource_start(dev, 0))
+		return;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (!(cmd & PCI_COMMAND_MEMORY))
+		return;
+
+	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(u32));
+	if (!bar)
+		return;
+
+	cc = readl(bar + NVME_REG_CC);
+	if (cc != ~0U && (cc & NVME_CC_ENABLE)) {
+		writel(cc & ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE), bar + NVME_REG_CC);
+		pci_info(dev, "NVMe controller reset started early\n");
+	}
+
+	pci_iounmap(dev, bar);
+}
+DECLARE_PCI_FIXUP_FINAL(0x15b7, 0x5006, quirk_nvme_disable_early);
+
 /*
  * Some NVMe controllers such as Intel DC P3700 and Solidigm P44 Pro will
  * timeout waiting for ready status to change after NVMe enable if the driver
-- 
2.54.0

