Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EE379C3C;
	Thu, 21 May 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380338; cv=none; b=HHCTqf0twIORR3jIx06XBoFAFZqPaL/hxQCkiYeRU7xgxqbWDi5jm0EGC7Fe7Xq0ebZ0KXq0SKaXIGBCnMhkHUo77AK/09VzNWmpFG3Y4SIQ/irSHsS7+/CqMnwJeTT5Cuqupf4xynK2VA1LWPsgmN1Vfg8Owc3xL+arcqqto9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380338; c=relaxed/simple;
	bh=fT8dxjXxCg/bew1IJPmRTvutus6CZPrZmciNj+qVaUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE3S7UkAUzEv0v7GLkXKfgbH0FEmkzI55Lk0+eJ2YjWYbHHckBv4IiuJlc+9rrV6EAOjyXTsVNRqatzFNcN7GH4jkbemSeo0382YgVpjkUHVSr5HHr5Q6W/PM+vmiaM/u7lDnfRykSRwWrmycacbzWcasa9ZbeTG/76s7shzceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DIszjuHi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DIszjuHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kq
	1Ji5oNISkWEUwAdsNxvMAszfkSLbc8uwVhYf0WtWM=; b=DIszjuHi4pV0be+H9f
	rkc9ouhQT6ROb9pC3jrNyxJ5wGV3z2aLHY6ivNACPtkaNPhiIX8QsNT2jMn8++cs
	sdL8YGpOoZNChJ85OaUsDAfUpy0dcp/sD3EGlYPhjtz0TOVQZlf946+LJR1A9CMC
	u/AxVCVq4WoKlUjnOJLZwLfx0=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S2;
	Fri, 22 May 2026 00:18:28 +0800 (CST)
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
Subject: [PATCH 0/9] PCI: controller: Add missing rescan lock around root bus removal
Date: Fri, 22 May 2026 00:18:13 +0800
Message-Id: <20260521161822.132996-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr18tF4DtryrGF1UAF17GFg_yoW5AF17pF
	ZxK34Iyrn5Jr45ur4kta18JryagasrJ3y5t3s7Ww43uF17Za4UXryayayFqa90kFW7KF1j
	vFnrt3W5Kwn8AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVyx_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBR-I2oPMFT4GAAA3t

Several PCIe host controller drivers call pci_stop_root_bus() and
pci_remove_root_bus() without holding the global PCI rescan lock
(pci_rescan_remove_global_lock). This can cause race conditions with
concurrent PCI rescan or hotplug operations triggered via sysfs,
potentially leading to use-after-free or system crashes.

This series adds the missing lock pairs to all drivers currently
exhibiting this pattern. No functional change other than proper
synchronization.

Each patch is independent and targets a specific controller driver.
Please review and apply.

---
The following are the comments from the sashiko-bot@kernel.org review.

https://lore.kernel.org/linux-pci/20260519132017.63E1BC2BCB3@smtp.kernel.org/
"""
> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	cdns_pcie_debugfs_deinit(&rc->pcie);
> +	bridge = pci_host_bridge_from_priv(rc);
> +	pci_stop_root_bus(bridge->bus);
> +	pci_remove_root_bus(bridge->bus);
> +}

Could this lead to a race condition during root bus teardown?

Calling pci_stop_root_bus() and pci_remove_root_bus() without holding the
PCI rescan lock allows race conditions with concurrent PCI rescan or hotplug
operations triggered via sysfs.

While this pattern might have been copied from a pre-existing function like
cdns_pcie_host_disable(), does it need to be fixed here to prevent
use-after-free or system crashes?

Should these operations be protected by acquiring the lock using
pci_lock_rescan_remove() and pci_unlock_rescan_remove()?
"""


The function cdns_pcie_hpa_host_disable() mentioned in the bot's comment is from
a separate patch series and will be fixed independently. This series focuses only
on existing controller drivers in the mainline kernel.
---

Hans Zhang (9):
  PCI: cadence: Protect root bus removal with rescan lock
  PCI: dwc: Protect root bus removal with rescan lock
  PCI: altera: Protect root bus removal with rescan lock
  PCI: brcmstb: Protect root bus removal with rescan lock
  PCI: iproc: Protect root bus removal with rescan lock
  PCI: mediatek: Protect root bus removal with rescan lock
  PCI: rockchip: Protect root bus removal with rescan lock
  PCI: vmd: Protect root bus removal with rescan lock
  PCI: plda: Protect root bus removal with rescan lock

 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware-host.c  | 2 ++
 drivers/pci/controller/pcie-altera.c               | 2 ++
 drivers/pci/controller/pcie-brcmstb.c              | 2 ++
 drivers/pci/controller/pcie-iproc.c                | 2 ++
 drivers/pci/controller/pcie-mediatek.c             | 2 ++
 drivers/pci/controller/pcie-rockchip-host.c        | 2 ++
 drivers/pci/controller/plda/pcie-plda-host.c       | 2 ++
 drivers/pci/controller/vmd.c                       | 2 ++
 9 files changed, 18 insertions(+)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.34.1

