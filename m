Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.26.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776545;
	b=v7O48oMMPW5P33nPVKOitMp0ElantUe0vA7QZoLzwUyRaWxgTeB91BZyR6pDpqMN4C5I
	 4Fm/LXMkn8H9BR5TbUyJFjrI2lTm2iGhp75Hc7nqgO4Y8gHVnr4GffdqS4X5mc0mI9eyf
	 o0WYDqeAcQjg7JqkL/N/xYKotozHXez7tsfnIdp2U1jXQeJqYb/nSF1BT3q5XrOUavk8E
	 Rbl1EvCfUCNDBDte8bSryvtnmC126+4vtlRLG1Jzr+mYUrqvM1RjwbmhN99kghhviFK4I
	 2U9XDDgp8O/udn0BTcpRy/MHxnSCeYJFOgLU0TVWybtNFJfooNZ/1iitADCoOr7sDEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776545;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Mz0uhk3OFWJ0FNh9q5bukOUzm++jVY5/KHluP5c0a2Q=;
	b=aw5Wq7aLLNXxl7AzVXzxiAr2VXpP2VLzNfoB9utPILF/heZGTTLFHNdr+3OQZcyi7w3O
	 m37HZ7+5DnKnzsnHSfpeMvsSFKtpT8jvsvU81KuZSICnhY/E72rD6t39a+v3RedhuEqFj
	 K6DH7/bPOW6dZx7vBl8iKqaKQGEijkI3HMFEXEtZpcQsbF7WSiZFNp24fGOx+9b7HJxbM
	 bArsML2R2r6KkZT5EHLtAGXXJ+Oaj12wbzDImYUUg/fxCEun4kYkoFQedhqETRqAQFsO0
	 QDz9mItbvUJ2/48SE0F0Ku5s4CgOOEvyr986eLR2Mg7T6Pj9+QHE9TG2byM5u+2Cupg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pc-heini.de;
	spf=pass smtp.mailfrom=pc-heini.de;
	dkim=pass header.d=pc-heini.de header.i=@pc-heini.de header.a=rsa-sha256 header.s=default2410 header.b=dFvqVOY1;
	arc=none smtp.remote-ip=168.119.26.116
Received: from www636.your-server.de (www636.your-server.de [168.119.26.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B94606A31C;
	Fri, 27 Nov 2026 10:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pc-heini.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pc-heini.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pc-heini.de header.i=@pc-heini.de header.a=rsa-sha256 header.s=default2410 header.b=dFvqVOY1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pc-heini.de
	; s=default2410; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mz0uhk3OFWJ0FNh9q5bukOUzm++jVY5/KHluP5c0a2Q=; b=dFvqVOY1av0BLvIqCNUD8yPs/l
	sJhmj9kgosEvNGJfRUua7o+XkJ6I2hPhWQCNM4TQZeWiQ8EshgaQzvSA61bwUXSqWogAeymhuvjoX
	6EDR2P9VVInQmCZmMIGhSI9vYw7udHHFXUwKVcGv2OutwrnHwvcT1n/5mCtscV6UCOwR1Fejimc+t
	LTW3R0mVPLerL2298OcFF+N06eXGzVWwUgYBVTnD0I6ESR8ul9Eu9uccV9r/zrGCHhpkZR2XJ2jzk
	gr4CsLLjyH/5fdsf4KCZHleStmqqFzNQqbpvNS/FiFOkeh52D6E0mB6/gHoZ4Xpwzu8U6j0diiKoM
	0p+kDg4g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www636.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xWtVg-0004Xw-1P;
	Fri, 27 Nov 2026 11:48:56 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xWtVg-0008AK-0A;
	Fri, 27 Nov 2026 11:48:56 +0100
From: Moritz Hiller <m.hiller@pc-heini.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Moritz Hiller <m.hiller@pc-heini.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: wait for MMIO to come back after resume from suspend
Date: Fri, 27 Nov 2026 11:46:21 +0100
Message-ID: <20261127104637.219891-1-m.hiller@pc-heini.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120180814.GB1810@lst.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de> <20261120180814.GB1810@lst.de>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)

On an ASUS ROG STRIX X570-F GAMING (BIOS 5044) with a Samsung 9100 PRO
attached directly to a CPU root port, the root NVMe drive sporadically
does not come back after resume from S3 (roughly 5-10% of resumes):

  nvme nvme0: Disabling device after reset failure: -19

The single readl() of CSTS in nvme_pci_enable() returns all-ones about
200 ms after resume. At that point config space answers, the link is
up, the device is in D0 and there are no AER errors. The controller is
not dead, it just needs a few hundred milliseconds longer before its
MMIO space responds.

The platform apparently removes power from the device during S3 while
the PCI core still treats it as D3hot. pci_power_up() finds PMCSR
already in D0 and does not wait, and pci_bridge_wait_for_secondary_bus()
only runs after D3cold and only checks config space, so nothing waits
for MMIO to come back.

Move the CSTS check into a helper. If CSTS reads all-ones and the
controller was shut down for suspend (NVME_CC_SHN_NORMAL still set in
ctrl_config, the same test nvme_reset_work() uses), poll CSTS every
100 ms for up to 10 s while the device is still present. Controllers
that answer on the first read, probe and other resets are not affected.

Without the patch, 4 of 39 automated S3 cycles on the machine above
failed. With it, none of 45 failed (30 on a v7.3.4 based kernel, 15 on
v7.4-rc2), and whenever the wait triggered the controller answered
after 200-400 ms. This version has been running on the same machine
for several days of normal use: 9 resumes from S3, none failed, and
the wait triggered 4 times (200-400 ms).

The failure analysis, the code reading and this patch were done with
the help of an LLM assistant (Claude). I reviewed the change and ran
all tests on my hardware.

Link: https://lore.kernel.org/r/598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de
Signed-off-by: Moritz Hiller <m.hiller@pc-heini.de>
---

Notes:
    Changes since the proof of concept in the bug report:
    - Renamed the helper to nvme_pci_csts_readable() and moved the initial
      CSTS read into it, so the whole check is in one place (Christoph)
    - Rebased onto nvme-7.5, sorted the linux/delay.h include
    
    Open points from the report that I left as they were:
    - The 10 s upper bound is arbitrary.
    - The wait also triggers on thaw/restore after hibernation, because the
      same bit is set there.
    - The wait sleeps with shutdown_lock held, as nvme_wait_ready() already
      does in the same call chain.
    
    Build-tested with W=1 on nvme-7.5, checkpatch --strict is clean.

 drivers/nvme/host/pci.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8088d5aa..342cd0609 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -3427,6 +3428,41 @@ static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
 	return true;
 }
 
+/*
+ * A controller that was shut down for suspend may have lost power while the
+ * PCI core still treats it as D3hot, so nothing waited for it to come back.
+ * Config space can already answer while MMIO still reads all-ones. Give such
+ * a controller some time instead of declaring it dead on the first read.
+ */
+#define NVME_RESUME_MMIO_TIMEOUT_MS	10000
+#define NVME_RESUME_MMIO_POLL_MS	100
+
+static bool nvme_pci_csts_readable(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int waited = 0;
+
+	if (readl(dev->bar + NVME_REG_CSTS) != -1)
+		return true;
+
+	/* Same test nvme_reset_work() uses to detect a resume. */
+	if (!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL))
+		return false;
+
+	while (waited < NVME_RESUME_MMIO_TIMEOUT_MS &&
+	       pci_device_is_present(pdev)) {
+		msleep(NVME_RESUME_MMIO_POLL_MS);
+		waited += NVME_RESUME_MMIO_POLL_MS;
+		if (readl(dev->bar + NVME_REG_CSTS) != -1) {
+			dev_warn(dev->ctrl.device,
+				 "CSTS read all-ones after resume, controller ready after %u ms\n",
+				 waited);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
@@ -3438,7 +3474,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+	if (!nvme_pci_csts_readable(dev)) {
 		dev_dbg(dev->ctrl.device, "reading CSTS register failed\n");
 		result = -ENODEV;
 		goto disable;

base-commit: 524994430562e49610802a2c0c0859ce316a72f0
-- 
2.47.3

