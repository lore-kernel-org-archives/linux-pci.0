Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94601399D08;
	Thu, 24 Sep 2026 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228488; cv=none; b=fCcFZvlLJIbscvy5asnXn00FEQW6GJInCz3/blGk6l2Ihuc44qLAkc55CQKaaKEm7lpx5Whr4TcIvFQPAHiG0GgbLOBkl3mlu5hRhgpWZDT1QNcNONw7ceWEj4zKITxgjX1mBO397Dl0/xyJDNHG/npk7hbsTjLeFn77hRwmtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228488; c=relaxed/simple;
	bh=SyNq6q04nR2Yz70u0MUE6hcGQXSWNYBNNhni+6wrDSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSGincujRWRPNOqTPDSMyq6F2h0pNGdBYwCXAhpVHxc7gwYruOuyTvUhaD6b/J+yCMFPM98FGF5E2vi2Rl+0A0iXsPtFH8gj0G1HsEVFsSIz8YBEIhN8SkPOR6xCMJN40v807ZrY55TsYlulKsxQgXCzuI0wNTcFeGJP3sbEMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GwuNW8dL; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GwuNW8dL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790228480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P4v6cNM1orkRpHabK5BZVKKJkrk8WU5R3D6SCkcOASk=;
	b=GwuNW8dLjVHmawULZ3imZqHM+RVksVPLqyaO2EdOrYPrsYGTNLjqW0AagzYbbBHsrjrWGJ61rzjjJa4lC1tz2+v8mZ+tGKzSjoNXWAeSb2E6maoZxgSZdOQF0QO8s9OIQ5EV0+wrDufOV5IHEUR0ibSGT5cltq8ryzuo+PM3xWg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=jianjun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XBYmqZp_1790228478;
Received: from L-F9NL024XF6.hz.ali.com(mailfrom:jianjun.wang@linux.alibaba.com fp:SMTPD_---0XBYmqZp_1790228478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 13:41:19 +0800
From: Jianjun Wang <jianjun.wang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianjun Wang <jianjun.wang@linux.alibaba.com>,
	yanhui.wjj@alibaba-inc.com
Subject: [PATCH] PCI: Keep an already-configured bridge's bus number across a rescan
Date: Thu, 24 Sep 2026 13:41:15 +0800
Message-ID: <20260924054115.75574-1-jianjun.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pcibios_assign_all_busses() is set, pci_scan_bridge_extend() assigns
a bridge's secondary bus number with

	next_busnr = max + 1;

This works correctly during the initial enumeration: the bridges are
visited in order, none of them has a child bus yet, and assigning max + 1
as each one is scanned yields sensible, increasing numbers.

A rescan is different. Bridges that were already present still hold their
child bus (dev->subordinate), and for_each_pci_bridge() iterates
bus->devices, which is built with list_add_tail(). A bridge that was
removed and is later rediscovered during the rescan is therefore appended
to the tail of the list rather than kept in bus-number order.

This is where the positional "max + 1" breaks down. A bridge that still
owns its old child bus can be assigned a number that another bridge is
already using. pci_find_bus() then returns the sibling's bus, the
"if (!child)" allocation is skipped, and the bridge takes over the
sibling's child bus while the sibling is given a newly created one. The
two subtrees end up swapped, and the endpoint behind the reused number is
scanned a second time.

If a bridge already has a child bus, it is being rescanned rather than
enumerated for the first time, so there is no need to renumber it; keep
the number it already holds. Bridges without a subordinate still get
max + 1 as before, the initial scan is unaffected because no bridge has a
child bus yet, and platforms that do not reassign all buses take the
preserve path earlier and never reach this code.

Signed-off-by: Jianjun Wang <jianjun.wang@linux.alibaba.com>
---
Reproduced on a QEMU RISC-V "virt" guest whose host bridge uses
pci-host-generic, so pcibios_assign_all_busses() is effectively true.
The machine has three PCIe root ports, each with an endpoint behind it:

  -[0000:00]-+-00.0
             +-01.0-[01]----00.0   (network controller)
             +-02.0-[02]----00.0   (NVMe controller)
             \-03.0-[03]----00.0   (NVMe controller)

Remove the middle root port and rescan:

  # echo 1 > /sys/bus/pci/devices/0000:00:02.0/remove
  # echo 1 > /sys/bus/pci/rescan

Without this patch the two lower subtrees are swapped, 00:02.0 and
00:03.0 now point at each other's bus, and the endpoint that gets
enumerated a second time fails to probe:

  -[0000:00]-+-00.0
             +-01.0-[01]----00.0
             +-02.0-[03]--
             \-03.0-[02]--+-00.0
                          \-00.0

  nvme nvme0: Duplicate cntlid 0 with nvme1, subsys ..., rejecting
  nvme 0000:02:00.0: probe failed with error -22

With the patch the already-present bridges (01 and 03) keep their bus
numbers, only the re-added bridge gets a fresh one, the topology stays
sane and the endpoint probes normally:

  -[0000:00]-+-00.0
             +-01.0-[01]----00.0
             +-02.0-[04]----00.0
             \-03.0-[03]----00.0

Note the re-added bridge is numbered 04 rather than reusing the freed
02: renumbering only ever hands out max + 1, so once the preserved
bridges have advanced max there is no attempt to reclaim the hole. That
is cosmetic; the numbering is valid and no longer conflicts.

 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..6b418d20cde3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1513,6 +1513,18 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
 		if (fixed_buses)
 			next_busnr = fixed_sec;
+		else if (dev->subordinate)
+			/*
+			 * This bridge already has a child bus, so we are
+			 * rescanning an already-configured bridge (e.g. after a
+			 * sibling bridge was removed and the bus was rescanned).
+			 * Keep its existing bus number instead of renumbering
+			 * it: a re-added sibling is appended to the tail of the
+			 * device list, so handing out max + 1 here would let that
+			 * later sibling steal this bridge's number and swap the
+			 * two subtrees.
+			 */
+			next_busnr = dev->subordinate->busn_res.start;
 		else
 			next_busnr = max + 1;
 
-- 
2.25.1

