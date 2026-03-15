Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260263B2A0;
	Sun, 15 Mar 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590147; cv=none; b=HLqhqb/OVZLJyjeaW6oRdeFWSRNtyVW3Jv3g77Etp7QPquQpX/cAsZftaZznUB8ygXfqrl11pdedovv1P/WjuxWlO6FFKVJzlte+jw9uoHTCqNR2vD/5U7fwkWC6pu/q/Wh4s0C5b4BRSzeh/UMu8L1Zln1MOxwIieZooEibKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590147; c=relaxed/simple;
	bh=d2yP1OCMs17qGWeXbqJrxFk7tNpZZN7u2MOqR9iYWcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRHLpY03jVi2jdeIkU7Y5Z36RL9Vx3MfLbFpHOjYdzxVj1WJ6BDeBm0sLIq7px3v8nFCYjeXKpmPklQOAEodOJu/Kp5tdSZHEs/Z0iVUnHBi7MdoTLhob5QXeqn3HjIz+KMtKNcQH4u9bf14cDWYZkblC9TDlIqIb71VbbGZ738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M9rd7Cds; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M9rd7Cds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GF
	VfRKL99lRaMhHxBDcVJGh2yyfKwEbD/Z7NGe5mqUU=; b=M9rd7Cdsyb0CKDGd3r
	Erx9LtRK7kcgF0jPWhFc9/74ib7eqISPBIUj9M486aYPOOfPoVpBLE1MiX7WmkQO
	cJLH0t3qLhjec5BM1qV5kRMlmPm3TCV+AsgIofDWShsTZyEhD2sx5U0lY7l0srav
	G8LI3TLv410bn9IEQcXqtt5zw=
Received: from zhb.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+tll1rZp4xVFVw--.62205S2;
	Sun, 15 Mar 2026 23:55:18 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] Subject: [PATCH 0/2] PCI: cadence: Add LTSSM debugfs
Date: Sun, 15 Mar 2026 23:55:12 +0800
Message-Id: <20260315155514.127255-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+tll1rZp4xVFVw--.62205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4Uur4xJw43Zr17ZryUtrb_yoW8XFy5pa
	95G3yfA3WxZrWav3Zav3WUXFyfKF97Ja97AwsF934xAFy3Cr98JryftFWrXFW7GrsrXr17
	Zr15t3ZrKFsayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUku7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwbWemm21mY+WAAA3g

Hi,

This series adds debugfs support to the Cadence PCIe controller driver,
allowing users to read the current LTSSM state of the link for debugging
purposes.

Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
distinguish HPA (High Performance Architecture IP) platforms, which
have a different register layout for LTSSM status.

Patch 2 implements the debugfs file "ltssm_status" under a per-device
directory. It reads the LTSSM state from the appropriate hardware register
based on the 'is_hpa' flag and displays both a descriptive string and the
raw value.

Hans Zhang (2):
  PCI: cadence: Add HPA architecture flag
  PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe
    link

 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   1 +
 .../controller/cadence/pcie-cadence-debugfs.c | 211 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
 .../cadence/pcie-cadence-host-hpa.c           |   8 +-
 .../controller/cadence/pcie-cadence-host.c    |   8 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 147 ++++++++++++
 9 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.34.1

