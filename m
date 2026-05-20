Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0573CCFB0
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301263; cv=none; b=HIGwdHBgJxfKbvofSoqEInNfwfY4dsGdI9zenB/PcNlpkz1qQo1P/LaCOD/SgjLbNaT/rJXpLwmeJNWLhuNGBVjpPC9ob5rmj3uQTeYdyhDm8M4JfCd1/Ky/TJPAmQegVCcRF//ClTAD14CBG+wPoXCClBbN+LiB0SnR2ryw/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301263; c=relaxed/simple;
	bh=1YM9Ab1BArLCIZ4bKc/gdmhH/qAxiuzUgfpjQ31oATQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYWw2RHLCclHBipgGiuy32tNzHe1uZzsJecK2t051UwRC66pjqxlxQatDYjfFvUR/rr8uzl5UpN/qF+Hrm468zL1HNDlaY+Xjsk9jOXgUbEYc80188KMxizol9kUNagSt5BcOpJEdJlgCpehaOd6X95tDxTsl84FeP7jwdRjaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWdT99Qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWdT99Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A7E1F000E9;
	Wed, 20 May 2026 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301262;
	bh=d3YdDHYo3R+w1kesXtGBqbRTFSKRS0N8NTb2nPiQL2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWdT99QoVcl9IiMb4fQBkY4dpVNyRr2q8ECkltW97UXIo+Lt8gav+RoQMKTMT7J0l
	 EKurkBOrMyz6UxHmX4h1ypmUOlo7AH7sfuLvEVO73hsNHtc7AGixVskyZ8f3E4C9tq
	 Ev9Lqh5l9sCzPrKQAQPv9BgRVuKkMmx+IhlAbcnIXneOY+e1SqNHEfxTwhVI8ZuSly
	 G6cB3J2IabUlavr/VUdiZGbLTwwiRaaQL4JQUdsga6pbiOMRNnhDXfjGGXzkn4fuCl
	 00qWIdxbPHFzv9lSEit4B6wUrzJDWkzzetfHRg9/6alGqGidm11F7m490d/faoxSlK
	 Aj08zIvpiK08g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 2/7] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260520171113.1111-3-alifm@linux.ibm.com>
References: <20260520171113.1111-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 18:21:00 +0000
Message-Id: <20260520182101.68A7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete Device Disable / Race Condition
- [Low] Const Correctness violation in helper function signature
--

commit 914208ab22fdc2baa5a5a849742b75582c456d5e
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit avoids saving the device's config space state before reset if t=
he
device is inaccessible. This prevents saving invalid values that could get
written back to the device during state restoration.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0c9f0166af5c..e71b814153921 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but should this parameter be declared as const char *msg?

The function is passed a string literal "save state" by its caller, which
can lead to compiler warnings about discarding the const qualifier.

> +{
> +	u32 val;
[ ... ]
> @@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +

[Severity: High]
Does returning early here skip disabling the device in the lines that follo=
w?

Because hardware state changes asynchronously, a device might be transiently
inaccessible during this check but recover immediately after.

If the function returns early here, it skips the subsequent
pci_write_config_word() call that disables Bus Master and legacy INTx:

	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);

Could this leave a recovered device with Bus Master enabled during the reset
procedure and risk unintended DMA?

Should the pci_dev_config_accessible() check only guard pci_save_state(),
so the kernel always attempts the disable operation?

>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520171113.1111=
-1-alifm@linux.ibm.com?part=3D2
