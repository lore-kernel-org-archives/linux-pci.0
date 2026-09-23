Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156385678C3;
	Wed, 23 Sep 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190986; cv=none; b=a34ZVO9S20hZgD43tpiso8fyTn6+/puhxNg+15exbc+7SEcZAEyk+FyKvNij1lswovMMtQ9ZYBGSm7rrdEAzy2eQi1XU7E+7VD9/Ajnz9bRQllPSVlawuti837Q9wactbjwg8uh9L0Zwaw7bkVTOlklvURZzMhmi9YYgCOkSCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190986; c=relaxed/simple;
	bh=Sw+rbK1UFUCG1jMvfD0VACNAjclFZkAOLK1XJ0AlcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWRyQgsGZaqdC+3J8Yo5MhH7/Qxte+NqBO2gULwRqSyI5HDOVZP04sskscPPwfA19FEgyDpR+MQ5Mg76eqRAdpb40Ers68Z9uw0CQyvj7zgj5C+kRMBEz4WsQD3alavqSSJIAg24HTJKIR7tkt35pjNQFuIbS9toKDIINMg34n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bojanowski.me; spf=pass smtp.mailfrom=bojanowski.me; dkim=pass (2048-bit key) header.d=bojanowski.me header.i=@bojanowski.me header.b=Ea6rxEgr; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bojanowski.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bojanowski.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bojanowski.me header.i=@bojanowski.me header.b="Ea6rxEgr"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hqmsV3lX7z8txW;
	Wed, 23 Sep 2026 21:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bojanowski.me;
	s=MBO0001; t=1790190974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Crud4DNRpjpxVffh6nLUuiKzQRz0+n2hlYOzob10iuU=;
	b=Ea6rxEgrPs7yFEyz3tTzd9FST5wtyBKnaVE2+WILtNCHqkUcMR5lXj73/Kl0JyBlVSL9Wc
	+aDuSaANtAx6Zde+Z6huyI66FDAb7ShknxT7yqb3zLVj3wgRWSfT5dXsXbH/kg63QjDPUo
	8Z0/NVDvrl+dxLHP/DJy8K4ntodO9YtuRpuCFzLD+CBa5JmcV/n8YmQdR6Lvhzci3oXQU7
	z7uJ78PCr6NhBLsx89zaJiw8xpLlQPQs8c+a6HOgu9QcX06wvCXqWLV6+K+pMxyfphBA8N
	YQNx+x7ghPA4s1l0J9qIJG6rPzRmvRhsZXsQQJFXgWSdY+m+pg1a8SquYNE0FA==
From: Tomasz Bojanowski <tomasz@bojanowski.me>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Wild <andiwild@gmail.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: PCI: failed link retraining quirk costs 1 s per empty AMD Promontory 21 port
Date: Wed, 23 Sep 2026 21:13:57 +0200
Message-ID: <20260923191357.7410-1-tomasz@bojanowski.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On an AMD AM5 desktop the pcie_failed_link_retrain() quirk fires on
two empty downstream ports of the chipset switch and adds 2 s to every
boot.  This seems to be a different case from the one addressed by
"PCI: Skip Target Speed quirk on clamped ports with no link" [1]: here
the Target Link Speed is not clamped, so that patch does not return
early and the LBMS branch is taken instead.

Hardware: MSI MAG B850M MORTAR WIFI (MS-7E61), BIOS 1.A68 09/07/2026,
AMD Promontory 21 switch, downstream ports [1022:43f5].  Nothing is
connected behind 06:00.0 or 06:08.0.

Seen on Fedora kernels 7.2.5, 7.2.6 and 7.2.7 (33 boots, every time).
The same two messages were already present on openSUSE 7.1.x kernels
on this machine in July, so this is not new in 7.2.

  [    0.248171] pci 0000:06:00.0: broken device, retraining non-functional downstream link at 2.5GT/s
  [    1.248035] pci 0000:06:00.0: retraining failed
  [    1.248972] pci 0000:06:08.0: broken device, retraining non-functional downstream link at 2.5GT/s
  [    2.248036] pci 0000:06:08.0: retraining failed

Port state after boot (06:08.0 is the same except Width x2 in LnkCap):

  LnkCap:  Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <32us
  LnkSta:  Speed 2.5GT/s, Width x1
           TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
  SltCap:  AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
  LnkCtl2: Target Link Speed: 16GT/s

Since the message is printed, DLLLA was clear and pcie_lbms_seen() was
true when the quirk ran from pci_device_add(), before bwctrl is bound,
so the LBMS bit itself must have been set on a port with nothing behind
it.  The kerneldoc above the quirk expects both bits to be clear on an
unconnected port, which this chipset does not seem to honour.
BWMgmt- after boot is expected, as bwctrl clears LBMS when it binds.

Each port then waits PCIE_LINK_RETRAIN_TIMEOUT_MS before the error path
restores the original 16GT/s target.  With this chipset used on many
AM5 boards, other systems may well lose 1 s per empty chipset port too.

Let me know if any other information would be useful.

[1] https://lore.kernel.org/all/20260801201244.4421-1-andiwild@gmail.com/

Thanks,
Tomasz Bojanowski
