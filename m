Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E137FF71;
	Thu, 21 May 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380347; cv=none; b=tdaTME/QZaS+KaeyrSMwE8PZApEwq4eG4iiy3XC9hs8276LXcO3/Flals5PjLz8s3c2ixR47AzM3yVIl82Ns1IZkfXttLqKPgcKK645LulHdekZ8fnvKkp2q+oYQ/b7gnwbEdOWTcM06gqk4zCve5i+IHqqxpahR2bIjwO7Sv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380347; c=relaxed/simple;
	bh=KDjJFSLbbZKCwMhib20ZGsNoqYfeMvyNAEe5z3yp6Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGYJ1vWWimX2S6/lG9EHRa4XzdR0C5baGal49WZb/JqbUd4w78202uK2o2EkQsLOJjY7oCIvrzZvoCRZ1gGrn3VTK9k4T1/pvwaC/ixI4UiuV4Tk+/RhYGnyJR6XDNbuVGcY6Ahqsl/RPXMNnGwwTwdQ5H63zCeujDuv3/2WaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDoZG7qf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDoZG7qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+W
	iqr6FurRw/iH8DdGRUunZlQmTskphzyGnGRFzKr/c=; b=jDoZG7qf+luDrcIynW
	hox1L5JnWzTadpQK6NmWRxeGolmhRHfQ5Teb4cmTrElkvXEeTt8byFNaR7Al8bIg
	qlnnrlTS3uu8UtVA6MrOliCqMY0o0d5cmGVKXbPnLknkXmV+bzZfebT+je8R1l5D
	5bnRgxsJgAbqEyli1iEL7CZ5A=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S3;
	Fri, 22 May 2026 00:18:29 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	a-garg7@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/9] PCI: cadence: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:14 +0800
Message-Id: <20260521161822.132996-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521161822.132996-1-18255117159@163.com>
References: <20260521161822.132996-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKryDGr15uF45Zr18JF4ktFb_yoW8Jr1DpF
	y2qryfKF1rXrWY9an2y3W8Xr13J3Z8A3y7Jws29w1xuF17AF1qqF9IkF1jqry3KFZrtw13
	X3WDt3ZrKr15A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_KZXUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xV-I2oPMFWHUgAA33

Calling pci_stop_root_bus() and pci_remove_root_bus() without holding
the PCI rescan lock may race with concurrent rescan or hotplug
operations triggered via sysfs, leading to use-after-free or system
crashes.

Add pci_lock_rescan_remove() before stopping/removing the root bus and
pci_unlock_rescan_remove() after in cdns_pcie_host_disable().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0bc9e6e90e0e..87fd8afa301b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -365,8 +365,10 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 	struct pci_host_bridge *bridge;
 
 	bridge = pci_host_bridge_from_priv(rc);
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 
 	cdns_pcie_host_deinit(rc);
 	cdns_pcie_host_link_disable(rc);
-- 
2.34.1

