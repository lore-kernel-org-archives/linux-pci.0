Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740472E736A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918179; cv=none; b=sosAfAgDNYKsrb/xMg9Lbn2sfPLXK8M6KLrNI/xYk9jxcD5fV4INaxL9pvMk/3rQK3eLLuZLanjXvakkQ88Y1NlyUAS7ah2Ud8nOio8iXUQOUrYLXKdE4cjyBLF0cyKgSZR6X2RtV5ZulAa/JIRyl2g9oP1YynU1+P3tZjww9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918179; c=relaxed/simple;
	bh=Z6UUVzEIZpHgNMCVPrT4U97Q4/vSund9PDoOz82kvCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NhYw99Sy4IN1Px6ZPTEL/0zoYDkN3Qgg/2oLG7MhCaZ5nxUzlrAbmmnaw0QAbYrpRPpcHqFRXB8TeaiGXYyo6Yuh4HpC0mVW1+RP7ls1oPPd9MlVY7TDIWMQbMXR1UzVU6J7QAOi1eQXup7cqYFSabfuEICi2g/Ug3BYLpWvoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2aoC1BH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2aoC1BH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6E71F00A3A;
	Wed,  9 Sep 2026 01:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918177;
	bh=lOfNngDOESLkukZyLkhKFWv7ZQ0LpOL6nZD4rlG4zF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2aoC1BH7NYHPTpAQdSqAca+SEnzaDiePVMv+gQxlPEl8oRzsa+EwSge7sgoCnKJ4
	 Pdlw5myZinQtyckQqO/pdcmnkQ0WtV5f4rRUg4wjic/8vg1UonYy43WJMiJfWFUJFb
	 3Qxxvbbl6lx9s04zysqi2YiTyacfXA+yJBezWRKUFqIRFNQa5EvWvUjPFyVPEwskFh
	 nDmouXhgYn1lUul7dSc31rZ1fys8xeXwcbhXsPNzdrjxm7ZlwhT7hyHkatmA0cXx+f
	 6FljlWB/HGPyL2hzuipPvcMT1zFYVx41sJ1HkZtKHWrigT74OWnyhrtGKKMJq5vkAv
	 1/dhG8gNpb0mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: cpqphp: Check pci_hp_add_bridge() return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fahmy Hassan" <fahmymohammed@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909013028.508870-1-fahmymohammed@gmail.com>
References: <20260909013028.508870-1-fahmymohammed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:42:57 +0000
Message-Id: <20260909014257.AD6E71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately claims to remove a 'now-resolved=
 TODO entry' and states that the failure goes 'completely unreported', resu=
lting in duplicate logs and missing changes.
--

commit b0a51b9f884f314ded07cba26637065948174b4b
Author: Fahmy Hassan <fahmymohammed@gmail.com>

PCI: cpqphp: Check pci_hp_add_bridge() return value

This commit adds an error check and log for pci_hp_add_bridge() in
cpqhp_configure_device(). The commit message notes this fixes a completely
unreported failure and removes a resolved TODO entry.

>     cpqhp_configure_device() calls pci_hp_add_bridge() without checking
>     its return value. If pci_hp_add_bridge() fails (e.g. no bus number
>     is available for the hot-added bridge), dev->subordinate is left
>     unset, so the subsequent pci_bus_add_devices(child) call is
>     correctly skipped -- but the failure itself goes completely
>     unreported, making such problems very hard to diagnose in the field.
>    =20
>     Log an error via the driver's existing err() macro when
>     pci_hp_add_bridge() fails, and remove the now-resolved TODO entry.

[Severity: Medium]
Is the statement that the failure goes "completely unreported" accurate?

Looking at pci_hp_add_bridge() in drivers/pci/probe.c, it already explicitly
logs an error when no bus number is available:

	if (busnr-- > end) {
		pci_err(dev, "No bus number available for hot-added bridge\n");
		return -1;
	}

Additionally, the commit message mentions removing a "now-resolved TODO
entry," but the patch does not appear to remove any such entry from
cpqhp_configure_device() or the rest of the file. Could the commit message
be updated, or was a chunk of the patch accidentally dropped?

> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqph=
p_pci.c
> index 81c58b1ec200f..34803f36ba65c 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -100,7 +100,9 @@ int cpqhp_configure_device(struct controller *ctrl, s=
truct pci_func *func)
>  	}
> =20
>  	if (func->pci_dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> -		pci_hp_add_bridge(func->pci_dev);
> +		if (pci_hp_add_bridge(func->pci_dev))
> +			err("bus/device/function %x/%x/%x: pci_hp_add_bridge() failed\n",
> +			    func->bus, func->device, func->function);

[Severity: Medium]
Does adding this err() call result in duplicate logs when
pci_hp_add_bridge() fails?

Since pci_hp_add_bridge() already logs its own error for the missing bus
number case, this new message will be printed immediately after the core PCI
error log, potentially duplicating the error reporting.

>  		child =3D func->pci_dev->subordinate;
>  		if (child)
>  			pci_bus_add_devices(child);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909013028.5088=
70-1-fahmymohammed@gmail.com?part=3D1
