Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5130C606;
	Thu, 24 Sep 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230536; cv=none; b=B2+ucnuq9YgOghVz65XdGOn+c2a73juwbe75kuQXPEk6FGr6V+3qMNxfDdZ+l9dutzzGs72R8bbOsrW1vwvRRDZ35hfbKbHat5ClcZ98RYoFfLpEYSojFQ32kvOpSi/ZlDzKwiXzcEWcKOf+mhlzSJdPu+WQ+9yO5+GZA9u6jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230536; c=relaxed/simple;
	bh=gbdpYTv/49lhuL3afmiaD5azjFXdSSArK7o/hxTxUPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+yWLBv1EFFT/lSTgsbzF2li881XI61BePLtEPpm6AP4bFJHh0+bXhqV+qUoA7lHQzE4DRfIEqAx2QdTUhzerbFq8VkJ8boyZBVjdgfA8iyg7jV5Wwil3sC6G468jagHij+RZNOSp7chje1L9axgreThjYjNROMfQh7lnpCtW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9211186|0.1179926;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.148357-0.00344818-0.848195;FP=7738451504425728954|3|1|2|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jLtpbfj_1790230515;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpbfj_1790230515 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:22 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Liao Xuan <liaoxuan@hygon.cn>
Subject: [PATCH 0/3] Add adaptive NVMe link rate switching function
Date: Thu, 24 Sep 2026 14:15:10 +0800
Message-ID: <cover.1790222172.git.liaoxuan@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liao Xuan <liaoxuan@hygon.cn>

NVMe devices are commonly left trained at the maximum PCIe link rate
even when there is little or no I/O activity, which wastes power in
both the device and the surrounding platform.

This series adds adaptive PCIe link rate switching to the NVMe host
driver. The link is downgraded to a configurable minimum rate when
I/O activity is low to save power, and upgraded back to the maximum
supported rate as soon as the workload requires it, so that peak
performance is maintained under load.

The amount of transferred data is accumulated on the submission path
with per-CPU counters and evaluated by a per-controller timer. The
switch threshold is derived from the bandwidth of the minimum and
maximum link rates such that the extra time required to transfer the
data at the minimum rate does not exceed the estimated link retraining
time. The controller queues are frozen while the link is retrained
and resumed afterwards, so no I/O is lost or times out during the
switch.

The main functions of each patch are as follows:
1. Patch 1 adds the core switching functionality. It uses the target
link speed interface of the PCIe bandwidth controller, which is
exported for this purpose.

2. Patch 2 adds hysteresis and idle detection to the switching policy.
The link is upgraded immediately once the threshold is exceeded, but
only downgraded after a number of consecutive below-threshold windows,
which prevents excessive rate toggling under fluctuating workloads.
Monitoring is stopped after a period of inactivity and re-armed by the
next I/O.

3. Patch 3 exposes the switching parameters (enable, monitor_interval,
min_speed, up_threshold, down_threshold) via sysfs so that the
power/performance trade-off can be tuned at runtime without a reboot.

The feature is currently enabled on Hygon platforms.

Liao Xuan (3):
  nvme: Add adaptive PCIe link rate switching function
  nvme: Add hysteresis and idle detection to link rate switching
  nvme: Expose link rate switching tunables via sysfs

 drivers/nvme/host/Kconfig        |  10 +
 drivers/nvme/host/Makefile       |   1 +
 drivers/nvme/host/core.c         |   4 +
 drivers/nvme/host/nvme.h         |  50 ++++
 drivers/nvme/host/pci.c          |   4 +
 drivers/nvme/host/speed_switch.c | 424 +++++++++++++++++++++++++++++++
 drivers/nvme/host/sysfs.c        | 143 +++++++++++
 drivers/pci/pcie/bwctrl.c        |   1 +
 8 files changed, 637 insertions(+)
 create mode 100644 drivers/nvme/host/speed_switch.c

-- 
2.43.0

