Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2C28B4FA
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422421; cv=none; b=bMdqcLcdJWVAnFiHSxixAauEK+oW29kE3WabDZeNq+7vmrnVp4iLrkLqqB0mQV4K+ql9xlXdkWT6DISCIBbRtY4wKBBhE4fmq87vZLTJnDtgSXh/5XrOhX9/zrwNnnX6F5+/com8TU4rjs0EOF0KuQqmriUTgWYiVcvCHSP2z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422421; c=relaxed/simple;
	bh=iMDxVFvxj54lV+nlp+RC7JNKZwidTWMygtDnkKSoYvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAVk7OhSs/wJaUBMBANuhS7mZ3gQXATaFSqGvmeKqpWeUlYBsoV3/39BF66K9tAb8D6Pd9VQRuxA6K/syYoyrPqxxMwyCDmiW089eezG1UKj1/xC2J9ALzd1+n8u6IqoILP44jpHphBpVuGAGgGfk6sZv4gPIKrTqu2+DYsaU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 15B983F1F5;
	Wed, 18 Feb 2026 14:46:54 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v2 0/5] Bridges without VGA support
Date: Wed, 18 Feb 2026 22:46:28 +0900
Message-ID: <20260218134633.461181-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217170419.236739-1-Simon.Richter@hogyros.de>
References: <20260217170419.236739-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2 fixes the formatting errors.

This allows bridges to refuse forwarding VGA, and reports this upwards as an
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
 drivers/pci/vgaarb.c   | 20 +++++++++++++++++---
 include/linux/pci.h    |  4 ++--
 include/linux/vgaarb.h | 15 ++++++++-------
 4 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.47.3

