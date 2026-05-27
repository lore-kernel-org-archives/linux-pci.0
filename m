Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09629305672
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912050; cv=none; b=t1LMJJchOnKLELUHE7BE7kCmQwgsFl1OxKph85DobG9OIqYRWjEbQRTDDG9qFIpcNhEA7fAnNzaMq42gD/k1fESiQx0KM0bNavw2fikZPYLT0A7x9ykR7tzqsUvUr0sH1X3CEwRarPZxmaDNrpk9YyaeB4qfb3xZRv26su4h8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912050; c=relaxed/simple;
	bh=sx0PNqGInbgDaneNRZW0kzufSFsF6zLIwIuh6zmkqnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFOITBx4CWKjtHtpzV6cJwJ7pq7oRrBXaPN4mIjoF+2qdQWlhlHTiGChNTxiJDRw15vJT+9xXawIkxgVutyVrWGrIHOIsxbn2jeLvqNExuHVWcpv8LTHCiFWtp8MpMs2alnR6pZUBc6UV/XtEXT+HmvGkT1xWgKoWNsdzgWPs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzWxqDL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzWxqDL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755981F000E9;
	Wed, 27 May 2026 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779912048;
	bh=8cy0nJo2zeQTyIn7+ODn4Kisc46C7quk+xh+IC+z5ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fzWxqDL/t1Bo1KN3DQ0gcO0sL2pMEwLlJnzjXbOVdRdVrrbvtSfi6hACR9igy+ppF
	 Un4d+KQZpR0H3Tcnc2bsYpp+VRNwv7CldtxoVcj7YaCR+0CUBYzpNWNamRRtiApoN1
	 uICAwzZPQyoVSOfOqfzSJrCKQ7BPtMBlRkRPLlNA2nS37Z8JOtaNo8XDuCiT8oaHnw
	 S+R1UV87/aD8tu+0kV35EM5a4NLSVYx/cepKgoG+TDxRFBbyyxLmWA5XYhaC1s7bz3
	 OvWKDPw7SaoortLuGEbucNIqca1oz8u3lEKtwELhQJ1o2yQRCJWPsmt8WEG9j1j2v8
	 mfS0/AFWRSZwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] ppc/pnv: Refactor PNV PCI hotplug driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Gupta" <adityag@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260527180816.2749186-3-adityag@linux.ibm.com>
References: <20260527180816.2749186-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 20:00:48 +0000
Message-Id: <20260527200048.755981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected state modifications and TOCTOU race in slot enable/dis=
able paths.
- [High] Lockless access to pci_bus->devices list from hardirq context.
--

commit cf3f614d9d225b084eb92a8c44dcbe6b7a0d3932
Author: Aditya Gupta <adityag@linux.ibm.com>

ppc/pnv: Refactor PNV PCI hotplug driver

This patch refactors the PNV PCI hotplug driver to separate PCIe and OpenCA=
PI
slot operations into backend_ops. It isolates PCIe-specific code so future
updates can edit specific ops instead of common code.

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index d0f5e8ad1f716..997412eea4863 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c

[ ... ]

> @@ -972,7 +1026,7 @@ static void pnv_php_event_handler(struct work_struct=
 *work)
>  		pnv_php_enable_slot(&php_slot->slot);
>  	} else {
>  		pnv_php_disable_slot(&php_slot->slot);
> -		pnv_php_detect_clear_suprise_removal_freeze(php_slot);
> +		pnv_php_detect_clear_surprise_removal_freeze(php_slot);
>  	}
> =20
>  	kfree(event);

[Severity: High]
This isn't a bug introduced by this patch, but can this sequence lead to a
race condition?

Looking at pnv_php_disable_slot(), it checks php_slot->state without holding
any synchronization locks. If a sysfs write and a surprise hotplug event (v=
ia
this event handler workqueue) trigger concurrently, can both threads pass t=
he
state check and proceed to tear down the slot?

It seems this could lead to double-unregistering and calling pnv_php_releas=
e()
twice, which would result in a double list_del() on php_slot->link and a
kernel panic.

[ ... ]

> @@ -1055,7 +1109,7 @@ static irqreturn_t pnv_php_interrupt(int irq, void =
*data)
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This is a pre-existing issue, but does the interrupt handler have a lockless
access issue here?

In pnv_php_interrupt(), the handler accesses php_slot->bus->devices via
list_first_entry_or_null() without holding pci_bus_sem or taking a reference
on the returned device.

Concurrently, pnv_php_disable_slot() calls pci_hp_remove_devices() which
unbinds and frees the child devices. Since the root slot IRQ is intentional=
ly
left active during this removal, if the interrupt fires and resolves the ch=
ild
device just before the hotplug core frees it, could this cause a use-after-=
free
in hardirq context when passing the pointer to pci_dev_to_eeh_dev()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527180816.2749=
186-1-adityag@linux.ibm.com?part=3D2
