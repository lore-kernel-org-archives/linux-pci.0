Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EB4AA1CE;
	Mon, 21 Sep 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999745; cv=none; b=P2sqnXaUY7+p04Uu76rXX2tzsJ19SRQYOtSEH63zPvHpG4jBi0/0OjNZ+hztZ9ee1PzmFvl1ifWXw8v/2bQC0lmS66wo14izZ52DcY4Rbzw8joCCsw2jWo4Ls6Hzg25+HDYVM/V9jFFqbYrrvjMhMEL8p7sls6s2K1QLhqb2tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999745; c=relaxed/simple;
	bh=iE0JdRz+khmRrDu+MAjHjDgVdC3s95waKyBaGG7cowg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLMZ7RiV8fek7OO/zGOHsCbpdNqoFqPMrkyBqtuHORO1lwiaZZmIEgHTimTR6eeujCdEaHtTx+o1vmuYRmMj0zlkRAGQlkYJ9KQzpqdpbQOLQiN3ITA3tvha9gHRT3p03+GG5vtMrOc62hbdUlbaBfwPNEwcvTFcSc3vTHqKFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=qu8TNTjx; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="qu8TNTjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1789999661;
	bh=rIYPt0Wxy+Ut4d15aTOdy6Ut8SxJD8FCqFcfoNnClH0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qu8TNTjxv/WChdT4K7FYiUArphssfVjoc4v4Dupfn2j8LAzZLPQI+z8Ay1Qg9xQJ/
	 wzFjaAeI7CArLt1ZEgU6ii2wGQpYly5gdzeeOcjdj6MwgyKej1SUaAXWsIbRckrl56
	 c6UT5PZJF/s3SRD6P+5ktwubQ5Hpe/SJcyJ9DS9A=
X-QQ-mid: esmtpsz20t1789999659t7aa19f31
X-QQ-Originating-IP: oMADQNDOvXIubsZPOcl6bvpJzk6GNhxqXC0B/OXPS7k=
Received: from localhost.localdomain ( [14.153.244.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 22:07:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4368887231060732096
EX-QQ-RecipientCnt: 8
From: Haowen Bai <calvin.bai@ugreen.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Bai <calvin.bai@ugreen.com>
Subject: [PATCH] nvme-pci: skip FLR after a failed controller reset
Date: Mon, 21 Sep 2026 22:07:32 +0800
Message-Id: <20260921140732.2942207-1-calvin.bai@ugreen.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NG7xP+P+sy64Ak+TVM5j/Wlw268PzRwJFksZPFBCNLzMTfW+GTDVniRk
	Qx7yU67pX/fxu/P4qqz/LEpQJ1iCjnRjkLwFCW7gnBBQwsNZ23azc24NgEUI0nj4qTVewaL
	nnAudlq5MPGR/+bUiPDoS/EwctSPs01VDJoKrF7EL1WlznMj5waU/afCF9DSLF6J8mKY/oK
	tdinCVH7ekODXRH3euq78WcmBr6YKb9dpP+N1WKBB3RnfYc04tmpbBdYhwnlnAKDUEnFLiG
	lPN5hjPxBE6Pj8ug40UXljUXQuWgHOjendJ+3/IudRPVGHwDqTEZrMHCzQcYnsowyWmdYbW
	cm8RIhkYj0GUSImWy1yUyuRsIuj1aMbZfz1sVS4H/Ra/a6os5k9xT0K+6nrfMvbnMubnUiV
	il+ikF6CRgxrpUtID9gTf6ByIY+joArraAIQbVR64QdTHKx/U+jnxvLP0MogzDqHH5kGtME
	YJWTKjzIK8NTPXJEVWfZx9Q+Sp81xtDyBuqwa9qR0t0IxCdfCAD7MkaQnJDp/TVWyLlrxKL
	m67EKErx3/0Si70Vu4o9UW6eguIbAt29o3rQtU7Kk+Hn+u0glaRvcucfS5PO+xVPzYZiEPs
	qShudSHGsK6JzdHTGqoZSYVWGZwMwRARKHwJyvZFoQ2Pqy0P9gdSJHnyrWf7COZm2aatVIK
	3ZLXihjB3ZnKcCq4JoOf9u+thU9tORElq0vaFALbBtDAovs/icj7p8EmJ+mKpXYtpRRHna3
	POfuOem7MmU7e9f5y+bcsbqGquiOyxGUSUO11CV3jPVhHOiSxLY6pzyqYw/WS+n2zBCORqj
	GBtcjMD50Ejnd/mYowEJmhwo/thqD6hjaN7Wf0KViGDsMlVKAJKqwSOVIl6Cu+RG2s+MKKp
	Zh9QZNksbd9R9A1VH+LLg1/oZTbJEuUZAGv4A2m7GcPyei3PKqXmC2Jjn8hp2Pp2zxIoyUu
	5er8C+MzjxvoRzn8Va+cgB9QHWTuEjJD0yLUod3OozA5TfT0gyfDqm313JvJF49mVvK0di4
	GbaXPXk+/LHgKKQB7sSRXhOb4lLFI+nA+UwaACBgfg1uBUPB2+Z6z655MItXU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

nvme_disable_ctrl() already waits up to CAP.TO for CSTS.RDY to clear.
If that times out, nvme_pci_configure_admin_queue() currently issues a
PCIe Function Level Reset and retries.

FLR is performed with PCI config cycles. Those cycles take
pci_config_lock, a raw spinlock, and wait for the endpoint to complete
the transaction. A wedged NVMe function can stall that completion.
Other CPUs then spin in pci_conf1_read() -- including ACPI PCI config
from an unrelated device -- and the NMI watchdog reports a hard lockup.

This was observed on an x86_64 UGREEN DXP4800 (kernel 6.18.15) with two
ZHITAI Ti600 NVMe devices used as bcache. Each disk independently:

  nvme: I/O timeout, reset controller
  nvme: Device not ready; aborting reset, CSTS=0x1
  nvme: Device not ready; aborting reset, CSTS=0x1
  watchdog: Watchdog detected hard LOCKUP
  RIP: native_queued_spin_lock_slowpath
  pci_conf1_read -> acpi_pci_set_power_state -> mmc runtime resume

The two "aborting reset" messages are nvme_wait_ready() timeouts, 128s
apart, matching (CAP.TO+1)/2. The lockup is ~11s after the second
timeout, i.e. on the post-FLR cleanup path, not in the wait loop.
Linux 6.12 has no FLR fallback here; 6.18 and 7.3 still do.

Skip FLR when the controller is already in NVME_CTRL_RESETTING (I/O
timeout recovery). Keep the FLR hammer for initial probe, where the
device may simply have been left enabled by firmware. Reset work then
marks namespaces dead instead of hard-locking the host.

Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Haowen Bai <calvin.bai@ugreen.com>
---
 drivers/nvme/host/pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5440cf18b55b..1df475fab950 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2373,12 +2373,18 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 		/*
-		 * The NVMe Controller Reset method did not get an expected
-		 * CSTS.RDY transition, so something with the device appears to
-		 * be stuck. Use the lower level and bigger hammer PCIe
-		 * Function Level Reset to attempt restoring the device to its
-		 * initial state, and try again.
+		 * Controller Reset did not clear CSTS.RDY. FLR can recover
+		 * some devices, but it issues PCI config cycles with
+		 * pci_config_lock held. A wedged function can stall those
+		 * cycles and hard-lock unrelated PCI users.
+		 *
+		 * Only try FLR during initial probe. On I/O-timeout reset
+		 * the controller is already known stuck; fail the reset
+		 * instead of risking a host lockup.
 		 */
+		if (nvme_ctrl_state(&dev->ctrl) == NVME_CTRL_RESETTING)
+			return result;
+
 		result = pcie_reset_flr(pdev, false);
 		if (result < 0)
 			return result;
-- 
2.47.3

