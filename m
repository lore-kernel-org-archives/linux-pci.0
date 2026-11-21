Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266417;
	b=vc8XY5hV2lQ1kvYQEq8wROG+WW1n4WXEHX7zCWCRiEA0Q+NCnV7szhDa78BTQGJwI2xy
	 h3ghLwz4ds3cTaRzx7CCYZA5DSwT0BwUI+ss104mVw9rcDxqvEnPU9uEZOxgdSbcGGwVB
	 9UspniW4aovsvnac4HQwVAL6zJ4JtdabdwzIo9O9QziGDjz65zmHRscqZczj1lM3GClaO
	 gnRo6gRyE2W6OSif9wOv1d69BCswqrT0vyBzwUUx1Sa8BnP48PkHYq1zaJU44Myqix2TC
	 peucXBUKfe7uw/SFcD3HCRm1e/GO4zuuQUNHXdP53pOJWQwM3336kyd9Iyumnb3UE8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266417;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pyzYPm870oAWMbN0PwsFisoK0T/7HzAwQzEb6U/5vJo=;
	b=sjWvyD2R5DwJ4nnD/fAqOG1HfvKVNB2E3m2cEEeG+QNblRodecCChbYMHfQp2XxYAbi9
	 UKMyRNguVsUa1qDIAuojpf+erfmySGjJn4BJwDdEH1wxrkBRXzzv4y97fWJQCixrWPws8
	 uit0HHvfmb2CrP1SNgDDXOrZjQO5+agd2ub4l97gjj+ITdbnIAWuWhtG3z4e/p/yVny83
	 uzfyYvV86W7BN/9WWoHzj8FJCbcUGgcmQplIExBOeITm0IUoT8MtQuvgFymPQmhvg8jVj
	 gCmEu/Pp/iE3QJ/EypX09/JUYMj8ACYOaWN9CoZEDu/Jvk6FF405gM+b9bwZy8xeTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrvNCSbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8C606A320
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrvNCSbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AC51F000C0;
	Sat, 21 Nov 2026 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795266416;
	bh=pyzYPm870oAWMbN0PwsFisoK0T/7HzAwQzEb6U/5vJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrvNCSbIYWlTet7EaTd+/KzXICeIzLYmHeEe4c3zGgllNbqu0Am2slCTHf7N/+niX
	 uIXPrwZUUc026yDlbIzSafhqi18Os+0XPuWzbGFhonAMcVKZw4N2Wv1GZU/29REHIL
	 /UFB4gIbtLMB7kVwH58IAb8jxFxxxeCFBkyu6gu4r7Zu+Q0W2IMGQJJxuubcsQLIEX
	 yrxbF9oDBr3mBB0eOrt2S8A7FR64QuxT3mvh7wO1yHjvKxCIB+rcvnY88IH6g8/O0n
	 ycl1p0WD13gBWSYJw3EJds1AvOIb2FbgoHez0M/zMKAkYpSqr099yzJfydfY15ruQU
	 X4ZSlwYnnRemg==
Message-ID: <sashiko-outbox-227039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Convert pci.c to pci_power_t helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Cc: =?utf-8?b?bGludXgtcGNpQHZnZXIua2VybmVsLm9yZw==?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261121125811.50315-3-habilerenturker@hotmail.com>
References: <20261121125811.50315-1-habilerenturker@hotmail.com>
 <20261121125811.50315-3-habilerenturker@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 13:06:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI: calls to undeclared pci_power_t helpers in
  drivers/pci/pci.c break build
- [Low] PCI: redundant pci_power_t_eq() calls in pci_power_up() instead
  of using state
--

commit fce5ad9abe7af15ce366f015c47398276c333e5f
Author: Habil Eren T=C3=BCrker <habilerenturker@hotmail.com>

PCI: Convert pci.c to pci_power_t helpers

This commit converts Power Management Control/Status register accesses in
drivers/pci/pci.c to use pci_power_t_get(), pci_power_t_set(), and
pci_power_t_eq() helpers.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8a0d9d4c71ed4..f947458391a83 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1328,7 +1328,7 @@ void pci_update_current_state(struct pci_dev *dev, =
pci_power_t state)
>  			dev->current_state =3D PCI_D3cold;
>  			return;
>  		}
> -		dev->current_state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> +		dev->current_state =3D pci_power_t_get(pmcsr);
>  	} else {
>  		dev->current_state =3D state;
>  	}

[Severity: High]
Are pci_power_t_get(), pci_power_t_set(), and pci_power_t_eq() missing a
prerequisite patch?  None of these helpers are declared in the tree, so
drivers/pci/pci.c fails to compile.

> @@ -1525,12 +1525,11 @@ int pci_power_up(struct pci_dev *dev)
>  		return -EIO;
>  	}
> =20
> -	state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> +	need_restore =3D !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +			(pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot) ||
> +			dev->current_state >=3D PCI_D3hot);
> =20
> -	need_restore =3D (state =3D=3D PCI_D3hot || dev->current_state >=3D PCI=
_D3hot) &&
> -			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
> -
> -	if (state =3D=3D PCI_D0)
> +	if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D0))
>  		goto end;
> =20
>  	/*
> @@ -1540,7 +1539,7 @@ int pci_power_up(struct pci_dev *dev)
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> =20
>  	/* Mandatory transition delays; see PCI PM 1.2. */
> -	if (state =3D=3D PCI_D3hot) {
> +	if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot)) {
>  		pci_dev_d3_sleep(dev);
>  		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>  			ret =3D pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> @@ -1550,7 +1549,7 @@ int pci_power_up(struct pci_dev *dev)
>  				return -EIO;
>  			}
>  		}
> -	} else if (state =3D=3D PCI_D2) {
> +	} else if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D2)) {
>  		udelay(PCI_PM_D2_DELAY);
>  	}

[Severity: Low]
This isn't a bug, but local variable state in pci_power_up() is already
declared as pci_power_t.  Assigning state =3D pci_power_t_get(pmcsr) would
keep the existing state =3D=3D PCI_D* checks instead of repeating
pci_power_t_eq(pci_power_t_get(pmcsr), ...) four times, matching the
commit message note about keeping direct comparisons on pci_power_t
values.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121125811.5031=
5-3-habilerenturker@hotmail.com?part=3D1
