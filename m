Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BD36E471
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348436; cv=none; b=B4j3fL2kNAWeMaMn8MmHi5P8HpcXz3XMstrptOQ94w2iXqqGOiI3+4roas/cVh/p47odtc7i7WqTw5mvovCgvhmi4narXfYJzqdIRVfPMyRY1R9/9Y7bDzSE/9WXtO73GMYTJ72Y552tPCfYShaPdibsGjeQlggpJ+bxSgCzRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348436; c=relaxed/simple;
	bh=kqJxFbFhcYEXnHt07y1DaF7FxKKIE1KP0g1VEIxUaZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt16NXYLtFV8jM+TpSfrWywYKWv0yGcHCk5dcMhokoUv/kJyifRCogeOLKmfaJ/x+ciBZJTVmKC07D1/HoGaBZSIRhGeSWMQnSC7K/PKk/ZPQNji0zQqKYlplqa44Ia3fIbfkh/vBIoHxBVI/MF5sizAwhQBZ9lI3wBm55y70i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 5129A3F1BA;
	Tue, 17 Feb 2026 18:04:40 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 0/5] bridges without VGA support
Date: Wed, 18 Feb 2026 02:04:14 +0900
Message-ID: <20260217170419.236739-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this allows bridges to refuse forwarding VGA, and reports this upwards as an
error, because we cannot set up valid decoding for the requested device in this
case.

I think it should be fine to leave VGA forwarding enabled on lower bridges if a
bridge closer to the root refused to enable forwarding, because no accesses can
reach there anyway.

   Simon

Simon Richter (5):
  vgaarb: pass vga_get errors to userspace
  vgaarb: pass errors from pci_set_vga_state up
  vgaarb: mark vga_get family as __must_check
  pci: check if VGA decoding was really activated
  pci: mark return value of pci_set_vga_state as __must_check

 drivers/pci/pci.c      |  6 ++++++
 drivers/pci/vgaarb.c   | 22 +++++++++++++++++++---
 include/linux/pci.h    |  2 +-
 include/linux/vgaarb.h |  9 +++++----
 4 files changed, 31 insertions(+), 8 deletions(-)


base-commit: 9702969978695d9a699a1f34771580cdbb153b33
-- 
2.47.3

