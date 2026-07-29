Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD930C37A
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296718; cv=none; b=f7tJArqgnhfSu/RDzubNQB06z0N5WaNW3tCTA13gPQoxq85rKL50GaHk3Drv65edpnQv9rGOaN3LTAT/L+27n/Qp5UBXK2H9MSvOk6gQONivrKGNx6Bt9SUsOl2NN6T+002mQFj28EWFDNNGU5cbHPo0+vUXDf2WGrX1QGOYbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296718; c=relaxed/simple;
	bh=40c6RPJACtRmer9VHC70ps1Z5Cy8vlMiWtKCQGVTEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=me5UxBVHPcpjiI5oPcGqemeOvfZadzTGDMq4HuwER2wyKYzU4x2KKNYpmu+gJ3GF/EZjiq7rLzXqqObEjQjANTLtz6Izoxv77h9a5SZ5pDUaJflwAd2EWHtIJNJAVbSybI3M9afI/fAoe/54tmww25Gwj2/Jc+3iAzd2bKlsfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EpS+s9tg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EpS+s9tg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785296713; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RADnKH0wVYkeD+Mrk3T5X/CMlonNvhoQCIpteRc2tYk=;
	b=EpS+s9tgAMBJfsdXKjEU6Zuqw2GxF020jsvUozYvZi4e7+xxyi7QyViOUQN8nuqre9evmEQccgxYlKYDGAGftP1UUuzXrhmuU/L/4bb3sKkQJES+6e2tSzZ04GgsRbtwPbb7beLlSRULTz4oI4moUuszEbNANdEkWpbfGN3G3GA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X80t0si_1785296712;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X80t0si_1785296712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 11:45:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Kees Cook <kees@kernel.org>
Cc: linux-pci@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v1 0/2] PCI: Add pci=nobwctrl to disable the PCIe bandwidth controller
Date: Wed, 29 Jul 2026 11:45:03 +0800
Message-ID: <20260729034505.469107-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
(LABIE) bits.  On some (typically old) platforms this has been observed to
cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
on Intel P45 using a quirk") works around one such platform with a
per-device quirk.

A per-device quirk only helps once the offending device is identified and
a quirk has shipped, which is awkward for a boot hang since the machine
cannot be booted to report the culprit.  The only existing escape hatch,
pcie_ports=compat, is a blunt instrument that also disables AER, PME,
hotplug and DPC.

This series adds a pci=nobwctrl boot option to disable just the bandwidth
controller system-wide, giving users an immediate, rebuild-free workaround
while a targeted quirk is worked out.

Patch 1 adds the pci_bwctrl_available()/pci_no_bwctrl() infrastructure
(mirroring pci_aer_available()/pci_no_aer()) with no functional change.
Patch 2 wires up the pci=nobwctrl parameter and documents it.

Tested on a QEMU q35 topology with PCIe ports and switches: without the
parameter the bwctrl service devices are present as before; with
pci=nobwctrl they all disappear while PME/AER/hotplug services stay intact
and boot is clean.

Guixin Liu (2):
  PCI/bwctrl: Add pci_bwctrl_available()
  PCI: Add pci=nobwctrl parameter to disable the PCIe bandwidth
    controller

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  4 ++++
 drivers/pci/pcie/bwctrl.c                       | 12 ++++++++++++
 drivers/pci/pcie/portdrv.c                      |  3 ++-
 5 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.43.7

