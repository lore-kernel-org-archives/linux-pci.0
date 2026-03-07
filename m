Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13633506C
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905404; cv=none; b=sZrs5a2/8fzGam1tqzUUPU+8fFJJ+aP6gAQZcspMJ8u3JMbGFP5ePX6DLzlBAijrr5vUgX3cViaGDWQCvLQgRlrW0YUcUq++TtGnH6/ze0aRJ8JB4R6RdLZ/xfr+DUhuu8r+A5LPd3d3ql5ZX9uVkchld55Sk1HRzAtcTba2zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905404; c=relaxed/simple;
	bh=X+OY1h5M3OkLi9tKtG+M6ONCrJaX6V+mYY31mXHsUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDeT3R9aQuI4lZ1i9UckCco7vKrUCY3vCp4Fvg4ldNULvoBQGpLnQS9GlY/ovMynFEc1xEJnMlu41CuA5//D/Bz2spAY+9wTc7b6Rb5RPF0L+YxT3p24Q6HZ7S3J7SZkZ9KhjjaLNj3czVRBEHdq+/EKSYYASdBHHyecJ914dWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id B7AB03F1E0;
	Sat,  7 Mar 2026 18:35:53 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 0/5] Bridges without VGA support
Date: Sun,  8 Mar 2026 02:35:33 +0900
Message-ID: <20260307173538.763188-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

reformatted the descriptions to follow the style guide, removed unlikely()
from return code checks.

Companion patch for i915/xe is v3 of

  https://patchwork.freedesktop.org/series/161721/

which can be applied independently and should probably go in before the
__must_check patches at least.

Not sure if these should have a Cc stable. If yes, there is a backport of
the i915/xe patch as well (what patchwork calls "v4").

Simon Richter (5):
  vgaarb: pass vga_get_uninterruptible() errors to userspace
  vgaarb: pass errors from pci_set_vga_state() up
  vgaarb: mark vga_get() and wrappers as __must_check
  pci: check if VGA decoding was really activated
  pci: mark pci_set_vga_state() as __must_check

 drivers/pci/pci.c      |  6 ++++++
 drivers/pci/vgaarb.c   | 20 +++++++++++++++++---
 include/linux/pci.h    |  4 ++--
 include/linux/vgaarb.h | 15 ++++++++-------
 4 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.47.3

