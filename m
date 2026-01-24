Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA429BD87;
	Sat, 24 Jan 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769240796; cv=none; b=JMbulhnyU4zNY93uyW3Ukr9EPU44/d73fv5HYBxmP1wvMFyVjN2WbbccKF2EWRpc+EGr7J6JLpJo0YSOoevsiteqcWCp2zclAKIpyxrN61hXJdIQrfnw8HzLeayFvTMXJIH+3oS4gf/DWCpdFRGwYD4QOJr2UvvBhTViCpeMiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769240796; c=relaxed/simple;
	bh=5B0X5YXmYQOWpEiKUDGpmIUjtJPZkg60k6NHDEwvSvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CUUueI2/U7ZR3SGclKcluMPzNHBGUDNscMCXXu+Rc6NUXO4lFTJTtHYzZKmtvhgRmqBM9G/PKhteG/b5wnWYrWNIqpRkbLuWrzVzCozLLM6t5HZkppUNowLkXjtPyjG2RfEe6MRIfmZblNPRkqzYlnfvjUL4epbOB93jODX8U7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PtWvAsfr; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PtWvAsfr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769240784; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sfwn3vAlAEvOJl0PVnmLd7EuSg5hGkhTYxpMGlXDYDw=;
	b=PtWvAsfroy15zujnhA+X1XZaq8KeHXQPHJqee31CPZCfzAs0O283nz04xend8InlUQ9CKCC8IIq+8gDvMpV/NaVXsQV5owM+tLRVNR6tknYswLmoMlQjuesgdjnbHeLxNA4b3DZZGCnCL71If4X/b0XW/Qn0OyoHM8O+uW2NXmM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WxiII9l_1769240782 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 Jan 2026 15:46:24 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v7 0/5] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Sat, 24 Jan 2026 15:45:52 +0800
Message-Id: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v6:
- add aer_report_frozen_error helper per Lukas
- add explicit log for reset case per Lukas
- add comments for pci_dev_put per Kuppuswamy and Lukas
- init info in call site per Kuppuswamy
- rename back to add_error_device per Kuppushwamy and Lukas
- highlight newly added log per Kuppuswamy 
- drop origin patch 4 due to useless aer_cap check per Lukas
- add fixes tag and cc stable for patch 4 per Kuppuswamy
- add new patch 5 to fix pcie_clear_device_status per Lukas

changes since v5:
- rebase to 6.18-rc1
- add separate patches to clear device fatal status per Kuppuswamy

changes since v4:
- rebase to 6.17-rc6
- pick up Reviewed-by tag for PATCH[2] from Sathyanarayanan
- minor typos in commit log per Manivannan

changes since v3:
- squash patch 1 and 2 into one patch per Sathyanarayanan
- add comments note for dpc_process_error per Sathyanarayanan
- pick up Reviewed-by tag for PATCH[1] from Sathyanarayanan

changes since v2:
- moving the "err_port" rename to a separate patch per Sathyanarayanan
- rewrite comments of dpc_process_error per Sathyanarayanan
- remove NULL initialization for err_dev per Sathyanarayanan

changes since v1:
- rewrite commit log per Bjorn
- refactor aer_get_device_error_info to reduce duplication per Keith
- fix to avoid reporting fatal errors twice for root and downstream ports per Keith

The AER driver has historically avoided reading the configuration space of an
endpoint or RCiEP that reported a fatal error, considering the link to that
device unreliable. Consequently, when a fatal error occurs, the AER and DPC
drivers do not report specific error types, resulting in logs like:

  pcieport 0015:00:00.0: EDR: EDR event received
  pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
  pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
  pcieport 0015:00:00.0: AER: broadcast error_detected message
  pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
  pcieport 0015:00:00.0: AER: broadcast resume message
  pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
  pcieport 0015:00:00.0: AER: device recovery successful
  pcieport 0015:00:00.0: EDR: DPC port successfully recovered
  pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

AER status registers are sticky and Write-1-to-clear. If the link recovered
after hot reset, we can still safely access AER status and TLP header of the
error device. In such case, report fatal errors which helps to figure out the
error root case.

After this patch, the logs like:

  pcieport 0015:00:00.0: EDR: EDR event received
  pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
  pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
  pcieport 0015:00:00.0: AER: broadcast error_detected message
+ vfio-pci 0015:01:00.0: AER: Errors reported prior to reset
+ vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
+ vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
+ vfio-pci 0015:01:00.0:    [12] TLP                    (First)
+ vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
  pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
  pcieport 0015:00:00.0: AER: broadcast resume message
  pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
  pcieport 0015:00:00.0: AER: device recovery successful
  pcieport 0015:00:00.0: EDR: DPC port successfully recovered
  pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80


Shuai Xue (5):
  PCI/DPC: Clarify naming for error port in DPC Handling
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
  PCI/AER: Clear both AER fatal and non-fatal status
  PCI/AER: Only clear error bits in pcie_clear_device_status()

 drivers/pci/pci.c             |  2 +-
 drivers/pci/pci.h             |  6 ++++--
 drivers/pci/pcie/aer.c        | 32 ++++++++++++++++++++++++++++----
 drivers/pci/pcie/dpc.c        | 31 ++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c        | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c        |  7 ++++++-
 include/uapi/linux/pci_regs.h |  1 +
 7 files changed, 82 insertions(+), 32 deletions(-)

-- 
2.39.3

