Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8540D56C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170393; cv=none; b=bE6oj/VdJqCZVg1811HMZv4MUp+mvV8ukpW017eTt9zr6lAzXn8KBg5anQPFfWgWXAPNegU6BJYxvjZZ0W5JH3oX6EBfTZhcEh66lMDBPG30PmsgYpGHHsotdSsGzDgp2raW8j4p5zOiIxNWEnW5SWjtTcQ4QWhIwruIu9n3KpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170393; c=relaxed/simple;
	bh=NkIDUMu3VMWbxRt7PpZiHwnSSRq07+kiLjqOn67zr5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSzMrmb2Cgyr2eWq1fyj6PpRsFaRVeouF6KpC8J/yF3b1DfF+xwXuJekijPJqqLpO3RYcUunTC76XcDn+i9vEQPdVV6xD3QkFeeU81HmbZnHR8iv1A2np/yyOPCz79BuJ+/tXLi1yQEfSqPQxF4qtBzdZWTjT4AY7ertyRWf0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRTC79uP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRTC79uP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7371F00893;
	Thu, 11 Jun 2026 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781170392;
	bh=MUpbJYpkybRn1Vrh5k0ox0UfDtFf4I9AfmzRGvnZEfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRTC79uP8gIv5001JD4dq93coyTtninv7h2QNg0Xeau5HZoqemTZOcTcg4SrwFsF3
	 1h6Nh48EZHhiImZC+bOsyKK/zDHaCE3qWvL/MiqBSp6eQAe79yYnMHk6QpCtOS06Jc
	 3hsjc6tbHGBfhQvSLbZpwEh812xAVLUQpcti3mmOuCgmkk5Xu7bTqKpqoMnWfIP79E
	 XBxGK1sQzOkVDb61vjA3KVDkOInKoJTkzwwwVgjuxuGxG5dBs5rQZTK8e79oubXRb9
	 RVu2aSO1B4/mwLjmFGi6aSNg+2n88LFLreWB+ziNpK+4QrRRhF6gbeUCMlDCur0en/
	 xB/YRPaTHVo3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pnv_php: Use common error handling code in
 pnv_php_alloc_slot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>
References: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 09:33:11 +0000
Message-Id: <20260611093312.0F7371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces spaghetti code by placing an error cleanup lab=
el inside the body of an intermediate 'if' block.

Pre-existing issues:
- [High] Calling SLOT_WARN() when alloc_workqueue() fails causes a NULL poi=
nter dereference because php_slot->bus is uninitialized.
--

commit fc5acb6d5ef23950f12a496bbb0ba6bddebe9f87
Author: Markus Elfring <elfring@users.sourceforge.net>

PCI: pnv_php: Use common error handling code in pnv_php_alloc_slot()

This commit introduces a new goto label to reuse error handling when alloca=
ting
a PCI hotplug slot in pnv_php.

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b81..e448f18020026 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
[ ... ]
> @@ -791,16 +791,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(stru=
ct device_node *dn)
[ ... ]
>  	/* Allocate workqueue for this slot's interrupt handling */
>  	php_slot->wq =3D alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->n=
ame);
>  	if (!php_slot->wq) {
>  		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");

[Severity: High]
This is a pre-existing issue, but can this call to SLOT_WARN() cause a NULL
pointer dereference?

Looking at pnv_php_alloc_slot(), php_slot->pdev and php_slot->bus are not
initialized until much later in the function. Since the structure is
kzalloc'd, SLOT_WARN() will evaluate with a NULL php_slot->pdev and fall ba=
ck
to dev_warn(&(sl)->bus->dev, ...).

Because php_slot->bus is also NULL here, this calculates an offset from a N=
ULL
pointer and passes it to dev_warn(), which will crash when it attempts to r=
ead
the device name.

>  		kfree(php_slot->name);
> +free_php_slot:

[Severity: Low]
Does placing a cleanup label inside an intermediate if block obscure the
control flow?=20

Standard kernel coding style typically places cleanup labels sequentially at
the end of the function rather than embedding them inside failure paths.

>  		kfree(php_slot);
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5cd04727-44c5-4ace-=
af86-d3c227234d4b@web.de?part=3D1
