Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8931F99E
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510686; cv=none; b=d4aL4pSexGhNyvNL+dLQrOx+op5QM/UPxqPm28kvM809xBPnz42TuNswxsiI7izN4sT+gFtY3Q+9fjL21K3HxGKN96b5lEKuRVf+teP5g14+naJIb1q6hbW/kxSzHSXODjNusWcNjSGEzOLSyXCJKNftr2B4z4i9BNx488VVGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510686; c=relaxed/simple;
	bh=uoSpBInz96NOD1ZGUj+XqyHV7iHFSTaAsszzgYt6ZGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fv6gGPJst6qawpjNhwyK5KStHe/3AseYbccwn8YdKvdLCCEXBdPKkgY+VdXEjR+cea6c9aUixxgdUbRKv0GytcEvY32sFk3oqUSijGhDx8g5R+CE3dmV9eKCXbrQUMrHqfcImbP1OD5FG8yRidY2cEudHhEgb9b1aGdLZbj5vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUCdKT8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUCdKT8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E881F000E9;
	Sun, 23 Aug 2026 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510684;
	bh=uoSpBInz96NOD1ZGUj+XqyHV7iHFSTaAsszzgYt6ZGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUCdKT8cMKbOJY8Twr9gUpG+Ne43Oe8ktQFh90bIVp2jN5qyRbUXAvPM3nwpm1pB6
	 o/zcOLczX3lLWv4mhjA0o4UOLr1JRKug4+yDJPfQryIsCO0i3neOdLD+ewuHZkkNTL
	 6xsaMv3xr0ymwBDyXXEM7uwi3C69HcWI9GhmiJlbu+FZtJMGXownOkSWKZDaxa4wLb
	 FccgWEF8bJqge+XSQelsMB4M3CPY2W0EhdIh4+/KYbA+ni0Gung6u2SLut+weGq6Lu
	 tgMaAIvqzqh6XQdJ2aOjWPd23hJpiGpld3uMY4PNW7ZDB+ZrPePvPCQDNbZ3/pi0QM
	 nL1jHw2KWLFkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] pciehp_hpc: workaround to not wait in
 pciehp_isr on surprise removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260823183458.982699-4-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
 <20260823183458.982699-4-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 18:44:44 +0000
Message-Id: <20260823184444.74E881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Concurrent calls to `pci_hp_spurious_link_change()` corrupt state =
flags, breaking hot-plug recovery logic.
- [High] Lockless read of `pending_events` races with `atomic_xchg`, bypass=
ing spurious link checks and causing premature disconnections.
- [Medium] Incorrect truthiness evaluation of `pciehp_card_present()` break=
s the disconnect workaround during severe surprise removals.
--

--- Patch [3]: [PATCH RFC 3/3] pciehp_hpc: workaround to not wait in pciehp=
_isr on surprise removal ---
Note: The format of this review has been altered to provide a free-form
summary of the findings due to automated recitation restrictions. The origi=
nal
patch diff is not quoted inline.

commit df7f3f7b5143de6a32373ccd864f5ca514636a79
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>
pciehp_hpc: workaround to not wait in pciehp_isr on surprise removal

This patch adds a workqueue to handle PCIe hotplug device disconnects witho=
ut
waiting in the interrupt service routine. It checks the presence detect sta=
te
bit to differentiate between safe and surprise removals, scheduling the
disconnect work if the card is no longer present.

[Severity: High]
Could the concurrent evaluation of pci_hp_spurious_link_change() in the new
disconnect workqueue corrupt state flags? The function
pci_hp_spurious_link_change() is stateful and clears the PCI_LINK_CHANGED b=
it
using test_and_clear_bit(). If the asynchronous workqueue destructively
consumes this flag before the primary hot-plug IRQ thread evaluates it, won=
't
the core handler erroneously tear down the device tree instead of safely
ignoring a transient link flap?

[Severity: High]
Does the lockless read of pending_events in pciehp_disconnect_work() race
with the IRQ thread? The workqueue reads ctrl->pending_events locklessly.
However, the threaded IRQ handler pciehp_ist() unconditionally clears these
events using atomic_xchg(&ctrl->pending_events, 0). If the workqueue execut=
es
just after pciehp_ist() clears the events, it will observe a value of 0.
Wouldn't this cause the workqueue to completely bypass the spurious link do=
wn
safety checks and prematurely disconnect all devices on the bus?

[Severity: Medium]
Will the truthiness checks for pciehp_card_present() fail during an actual
hardware surprise removal? When a device is abruptly removed, configuration
space reads typically return 0xffff, causing pciehp_card_present() to return
-ENODEV. Because -ENODEV is a truthy value in C, the condition (!present) in
the interrupt handler will evaluate to false, meaning the disconnect work is
never scheduled. Furthermore, the check inside the workqueue evaluates
pciehp_card_present(ctrl) !=3D 0, which is true for -ENODEV, causing an ear=
ly
return. Does this logic inadvertently disable the workaround precisely when=
 a
surprise removal happens?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823183458.9826=
99-1-abhinjoses@gmail.com?part=3D3
