Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B0258ED5;
	Sun, 15 Mar 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590494; cv=none; b=cEtCpZE+zdMNlXd1aCESx/oosjx1GXjGRjttWV/zUmFdSKDyeD3GUaYmD7R9+SuoP1XyNyDZaRnu2RO+TE+D73VlesChIK2g/4kA/ipv0ufC+nPQwziNQ+yletghg4NtbQJPA+RkKSDzchwHXhv691HfGEzfsBDfawmSJMaSjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590494; c=relaxed/simple;
	bh=7dnLw613Z8OOl0B+ryke/WcsqF/iFVxZRuQYjg8J1kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8qwTCWe25/vUIcFcPLiyxVcIHdXrvbIo3xgyLokRQXUgIQIJDoodVYc4MQjboKExrD7+bKySX9k3nMjCHY3PnMOH2dbbHoT38nlRLaJCpOMgUg/FdyqVuDLLsWqA9Hzi+s4XxKg6OgJAK0oiwW7EOVve5DzbHR/Swp3RYNZO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k6iHm+Xp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k6iHm+Xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jU
	IENowrVnfUnQUcYsUFD4O8FKV9wTW4/6d+sGfrfaM=; b=k6iHm+Xp/XyQ6FL2QH
	mdY6FKneWp4lOf3SfnYgQfRLfnxZ0lALnpXZtreWgMfrZ+0H2NVn3wi6D5xFoH6G
	1mt0sk5IDUW/G/O7f2s5mTfa/AcBtWYPjhdcQqUuUgNs/Fd1eL0s+nBJ4OHOX5Vb
	3JonLzJdx8weNbWM9z9KBEycw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHvwy817ZpjnSYBA--.30374S2;
	Mon, 16 Mar 2026 00:01:00 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v1 0/3] PCI: Encapsulate pcie_link_speed array access
Date: Mon, 16 Mar 2026 00:00:54 +0800
Message-Id: <20260315160057.127639-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHvwy817ZpjnSYBA--.30374S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryfuF1kurWkKF4xWry5twb_yoW8Xw4kpa
	43Wr4Yqr45J345A393ua1jv34Yq3Z8Ar42gryjgw48ZFnxGFy7Zayftr4ruFya9r4avr1a
	qFsrt345uFnrZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUe7KxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x4t0Gm2177fhgAA3n

Hi,

This series encapsulates the pcie_link_speed array by introducing a
public helper function to_pcie_link_speed() and converting all direct
array accesses to use this helper. This improves code maintainability,
reduces exposure of internal data structures, and makes future changes
to link speed mapping easier.

Patch 1 moves to_pcie_link_speed() from pci.c to probe.c and exports it.
Patch 2 converts the sysfs show function and an inline helper in pci.h
to use the new helper.
Patch 3 removes the now-unused extern declaration of the array from pci.h.


Based on this series of patch submissions: 
https://patchwork.kernel.org/project/linux-pci/cover/20260313165522.123518-1-18255117159@163.com/

Hans Zhang (3):
  PCI: Move to_pcie_link_speed() to probe.c and export it
  PCI: Use to_pcie_link_speed() for link speed conversion
  PCI: Remove extern declaration of pcie_link_speed array

 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.c       | 5 -----
 drivers/pci/pci.h       | 3 +--
 drivers/pci/probe.c     | 7 ++++++-
 include/linux/pci.h     | 1 +
 5 files changed, 9 insertions(+), 9 deletions(-)


base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
prerequisite-patch-id: 7b106b4bc491747237b75c9364a500eb8cfd31a0
prerequisite-patch-id: 0fabd60d739c45e76d4fb87cc008697f92e7164e
prerequisite-patch-id: 83fa7afd2c83f62058b212e93cfea72596389f76
prerequisite-patch-id: 145833e2f270b51817275764d5a578addf6f3709
prerequisite-patch-id: cda29dea578c6213dd799dfd7b5ae5e02c7f455d
-- 
2.34.1

