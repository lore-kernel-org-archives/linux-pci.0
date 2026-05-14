Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80303AF657;
	Thu, 14 May 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740276; cv=none; b=rpB9XCIHdHoFDYwiNc+/FvyzReYcnq3HWDPIiR0RCSLBBeQcLfw6HAW0r/WQy9McRrLuD8tV22ujVIn8z5t9QZqMfiqyToJ58OPFC8dILyr41AypceHAwrCGhhVrY8SfQEZzzFTh5nrtQCCLidfi64HJJEboKmDqi1P8QQhjprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740276; c=relaxed/simple;
	bh=dLuyUv0zg2WwqsxcV2pWR/nYNtG/xPQoCyIawxvHoKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uYjaOQeejEYpNsg+vboVx1gA8GU8g+1uHOXqRKvbF5G99lxrkcYejw3ZwxPLP8Rc9Nx3t4pUfhj4AMUYZuG2xx0U+6zIMF3keCCvXjG2NUe56w/WA5fPdaHRuR9+T89Kv9FcpJ652GPAdKkjw711qS/U44312bvmtw0VzgG+SVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PiO87B3H; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PiO87B3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1778740266;
	bh=dLuyUv0zg2WwqsxcV2pWR/nYNtG/xPQoCyIawxvHoKo=;
	h=From:Subject:Date:To:Cc:From;
	b=PiO87B3HV2gP7lX13ufpegAEffxAjcChqm4mUBwvjPAoizfUQZjThhZDQS7RxoH3/
	 UhJFEOTiPzUboKd5fkwJLAo+RV1mf8znrXs4sHpP/cYf+ra40e9/RwtL+vfqJqgHL9
	 KMzyFVis57jgJ/+VQtocaglY+rCARFpRv06yklWk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] PCI: Manage hotplug attributes through group and make
 slot attributes const
Date: Thu, 14 May 2026 08:30:59 +0200
Message-Id: <20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJKQXRqxAWUgcYY9qmUwiGc
 HcrLt/i/x2EIpPAvdgh0srC3mWUlwLs/HATIT+zQSvdqLqsUD4yClrvJGGwjLNP4b1MaNqh0cp
 cb60hyHWINPJ2nrv+b1mGF9n028FxfAGezbLjewAAAA==
X-Change-ID: 20260513-sysfs-const-pci-hotplug-48b62047984e
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778740266; l=605;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dLuyUv0zg2WwqsxcV2pWR/nYNtG/xPQoCyIawxvHoKo=;
 b=y5cOfiiysJsyXq/Z1Uq7eCo+Nqa+cIoIFG8zUsOz7IM1JbmU9LMrGulbrngtdYC/tvbhGGFKq
 BLvk4D1qHESDW+KS+MrWrrIWhYjKPJ2LC81YKNfQl+BEn1ujSBQoRjU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      PCI: hotplug: Manage hotplug slot attributes as group
      PCI: Constify slot attributes

 drivers/pci/hotplug/pci_hotplug_core.c | 125 +++++++++++++--------------------
 drivers/pci/pci.h                      |   2 +-
 drivers/pci/slot.c                     |  14 ++--
 3 files changed, 57 insertions(+), 84 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260513-sysfs-const-pci-hotplug-48b62047984e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

