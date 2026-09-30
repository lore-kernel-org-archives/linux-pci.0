Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1736195B
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764243; cv=none; b=WWsbqNjMSNPsws1q6+Qmt3V8YHG+AC3wFe2K7KrihKVBLdRVFAwtbpQsANpZSoDQQk6zv5bWFqCpVsXHWlwpNyNyupeRDbw1txB+2ceKZ0ZZCyqgZCihCdiHVlIpN39hde9MmyfeirSSBWYTDJKJmrC/Z/tkHSy0l8Yht9ZQaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764243; c=relaxed/simple;
	bh=LvyR5aGpyQZdCZNpTx7fGAilDs3BJHm6Q/QEFgtp4uc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qIujBTaXGJ5rHCo7vlrEKAwFa7tdeR1hZtSCzXUYoOY5ij9lNQw5R40Pw612K1oVILRAq0LfxW6UTPfvrUX9rqr3fSOGVpRmpC20ue5OaUQwgdN6zCytnXgtdjSHS+bpcTNiisknk333qS1/fOdQM6J163ophhOrvLNka3unBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTbEdnKZ; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTbEdnKZ"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e735659b7so38668975e9.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790764240; x=1791369040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1+PuJJ3wOS6tvZ0KUVb7bT/lnQfHxZnC8edrNXWJcYA=;
        b=eTbEdnKZjpZN3yKYkTA9kM0B+OmM4Uq2YO/ETfFg+FOW1xDCpdkeD2Tytw15oSBfm0
         burlbD0At5eIOey/Jb0AHx8XooGRK//7a7bfQAdWpCNwM67683F6x4o1af5ceUaKxq5E
         odILRVm0toT/7MMIkxS7Q+5ccRkTL9pErVGSPkIjWuZnJ1qHVDk0nEpnK2F7vEWKyIAE
         3I/LplNo7n6/Iqnp0XkCFmIhBG7AnvTwoIJrs0lHknTPxDPM9HyajIEgg8H1s9p+5VKK
         Hq2dN9BAKM7ciXPTYl0+q3j+XFGwimyYHZGW7fufQ74MyF4TTzisEEz1hp+GHwErx+4f
         dvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764240; x=1791369040;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+PuJJ3wOS6tvZ0KUVb7bT/lnQfHxZnC8edrNXWJcYA=;
        b=GqbMTnEf6PqGBg8BHKAvABQRCei/3xWFB1ej7O94uJti/fBN90x05As1P9pYcl4WMO
         8Z0eVnIVLZSXaJ1P1boO4lMsdnvZxC4gExTzj5fmArkaIy+uRwLfi8xGuyTFZGCTayYa
         s3RBub8xdpf+0NQ1EvAzCrEQaaiiiBxeppi4XrZ4nWe5PyK76z6JVQM+JogMzWek3MF4
         xqYeUbxaZK7mQ4SsHz28/F1IYLWysx54drtbLuxthIOMDLwQKbcXZgEfkomiG8Jj5pa6
         P/ASP37jqYkC+1solwmRqNUKjSdbyyOSYkPE8QVhO/KKxyH+kP3+8MjejevjAl0tvKkj
         YILA==
X-Gm-Message-State: AFuF++le3L3Ma0aY3ejcac/tIpXn2aE0NF1RceBwQKFmcimJtlLop0e5
	9K9vui2dozDco3/WjbdR0fUGijwp0ByZUP2e6YdPPsuifBhx3xtmnx6VqNzf6FiIfyd/Ztfj8i2
	bieTaRql+XzLpDJVFdMOYv+jfNPVbwDzcvFPh3rgglPUOoch/mg7UgvsQP8cKed8VZJvs7GgXps
	B+KNDQlu+OVr0BoxuItHbktgMcSxuPkg==
X-Received: from wmpo20.prod.google.com ([2002:a05:600c:3394:b0:49f:fc29:a959])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c162:b0:49e:7a00:b9a5
 with SMTP id 5b1f17b1804b1-4a01ad907efmr16095195e9.4.1790764240209; Wed, 30
 Sep 2026 03:30:40 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930103036.248989-4-ardb+git@google.com>
Subject: [PATCH v3 0/2] PCI: Allow non-prefetchable BARs in prefetchable windows
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

(v2 never made it to linux-pci@ - please disregard it if you did get it)

The non-prefetchable window of a PCI-to-PCI bridge can only decode
32-bit addresses, and so even 64-bit non-prefetchable BARs of devices
below a bridge compete for the scarce MMIO space below 4 GB.

The PCIe spec notes that marking such a BAR prefetchable still permits
correct operation as long as the entire path from the host to the device
is PCIe (PCIe r7.0, sec 7.5.1.2.1). The same applies when the OS places
a non-prefetchable BAR in a prefetchable bridge window, and so this
series permits that unless there is a bridge on the path to the root bus
that is not a PCIe Root Port or Switch Port, allowing 64-bit
non-prefetchable BARs to be placed above 4 GB.

So add a new bus flag PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS, and wire it
up so that it is only set on buses where this relaxed placement is not
permitted. Then, use the flag to to decide whether to treat 64-bit NP
BARs as prefetchable only for the purpose of resource allocation (but
not for mapping the MMIO region or other reporting its properties)

Patch #1 is a preparatory refactor of pci_bus_alloc_resource() with no
functional change, and patch #2 implements the relaxation.

(based on v7.3-rc4)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Link: https://lore.kernel.org/linux-pci/20260910143440.3865663-2-ardb+git@g=
oogle.com/

Ard Biesheuvel (2):
  PCI: Add __pci_bus_alloc_resource() to allocate with explicit flags
  PCI: Allow 64-bit non-prefetchable BARs in prefetchable windows

 drivers/pci/bus.c       | 70 ++++++++++++++------
 drivers/pci/pci.c       | 43 +++++++++++-
 drivers/pci/pci.h       |  7 ++
 drivers/pci/probe.c     | 35 ++++++++++
 drivers/pci/setup-bus.c | 23 +++++--
 drivers/pci/setup-res.c | 30 ++++++---
 include/linux/pci.h     |  1 +
 7 files changed, 169 insertions(+), 40 deletions(-)

--=20
2.56.0.rc1.315.gc6ed9934b7-goog

