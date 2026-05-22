Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311A3812C4
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482641; cv=none; b=QMMTZiR4NEnFL2SKoRPVVaW/WMqQQo8rNHS2vMjfcMCccBt930yzJ98qvc+I4o1c/8dUVvEmgZ59JQ/d0NCCGeKhLcVCvpk+Voy2AuxyGoOxCI3X81kK9LFCMYctA2G3uMGuOKYu88Olej4XKk3Ltlw2QOdJEhDQYNWp8YoFJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482641; c=relaxed/simple;
	bh=YVnJfFQyonI9x2WdV0gaGXDNrK58MrdGXVkI1up2vEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WYCQxsJy+QMf+xMx53fUP/IYyhOx23PBHrEZx3JRr6seKpqC/dajqIxcI+lNTLyozYYHUg0Pu93O1QmSM44PNvesQS9W/7R+b8p4+RW312gzO92t4ZE2tSfLNY7Z8hB/c8sJew4B62khuCPsOtKxYI0HMzaxpvngQJ0kaRp3aRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApDrQHKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApDrQHKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E51F000E9;
	Fri, 22 May 2026 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779482640;
	bh=FW9d7BvXHLFUo4RKdGUAW0SkJqBdGUkQ3rovZu9ElGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApDrQHKmdnHi5GWZqR+ddfafX32Uvhw1YyGR6L7k4n8iVc5oioN4ofZVaTYfxV8pB
	 MfvXOxeqsaj3ca7ovngl9R2LAnEeA1M/GMBYTVW1K0I0UtDcg9hhxVnURt7jZ3Tz0v
	 fSdbKg6PQaOtWNHrycBW9gEQH6FZdCSz0pG2BELljCcyYzgIv3jW1Hr23TgnrDAmZB
	 BMNQAxH27kWn8NdPAMhCLVgyy4hjplRYk2gCZAwVulp5pESG0GyXz6Orkc8M8rnJxX
	 1McqS4ghGQCNK+1d97T/s4AO7i97DlvHRQb6bI5Wbmi68l9fhJ7zzacjdpW/G3lnSz
	 gAciMAP26/g6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522202410.3104264-2-dmatlack@google.com>
References: <20260522202410.3104264-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 20:43:59 +0000
Message-Id: <20260522204400.4C7E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `kho_is_enabled()` check before calling KHO preservation=
 APIs in PCI Live Update FLB operations.
--

commit b0cb2fb154fba1aa85d63570fe0186e243353fb7
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Set up FLB handler for the PCI core

This commit sets up a File-Lifecycle-Bound (FLB) handler for the PCI core
to participate in the preservation of PCI devices across Live Update. It
allocates and preserves a pci_ser structure using KHO when the first PCI
device file is preserved.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_dev *dev =3D NULL;
> +	u32 max_nr_devices =3D 0;
> +	struct pci_ser *ser;
> +	unsigned long size;
> +
> +	/*
> +	 * Allocate enough space to preserve all devices that are currently
> +	 * present on the system. Extra padding can be added to this in the
> +	 * future to increase the chances that there is enough room to preserve
> +	 * devices that are not yet present on the system (e.g. VFs, hot-plugged
> +	 * devices).
> +	 */
> +	for_each_pci_dev(dev)
> +		max_nr_devices++;
> +
> +	size =3D struct_size_t(struct pci_ser, devices, max_nr_devices);
> +
> +	ser =3D kho_alloc_preserve(size);

[Severity: Medium]
Should this code verify kho_is_enabled() before calling kho_alloc_preserve(=
)?

The commit message states:
"Note: There is no reason to check for kho_is_enabled() since it can be
assumed to return true. If KHO was not enabled then Live Update would
not be enabled and these routines would never run."

Does this assumption conflict with the Kexec Handover subsystem guidelines?

The guidelines mandate that all callers of serialization APIs must explicit=
ly
gate their usage with kho_is_enabled().=20

Calling preservation APIs like kho_alloc_preserve() without the check can
silently add tracking state that will never be used if the subsystem is
unexpectedly inactive.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522202410.3104=
264-1-dmatlack@google.com?part=3D1
