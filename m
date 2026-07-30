Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC802877DE
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414625; cv=none; b=dPEWlC34kAIfEPNQWJsQCiqiwLP2y4vY7nthqmGMjhklADrach3+dOREXKKpovRK1xLeRTGcIKWuJbbsvGJ1mf6IhIfuXPkxIwjhraszw2jHuQPsoM0C7ok4pWSumGGHDpVs6GbkN8lzPwpOuENXadnbE/qH2UZmGd6z4gskm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414625; c=relaxed/simple;
	bh=wXsgJL9lsN6srxyYGlykR56HOKar9rsmUuJizDslaE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTZzwzUeroLw3bUOMSdUhNWUdnxhkKKUCqs3tI/aXgNBfWq0AtOyFOvVivKwnhUKO9rJ6iu3fk+MKgXWdyqGvZFurZNBRrf9QKQGNQsrpLW/Z3fOHkJUBq24FOEyFMenxRIGdWTDrDhwxxLz0hz8qjqIRklFzpW7v4YLXQBK4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCWinGSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCWinGSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A541F000E9;
	Thu, 30 Jul 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414624;
	bh=b4dzvsTNq7j/B7baIGIrtRXBTgi5PJC4WC5MYffbCIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZCWinGShBTGl46Cse3HiV5oba9GBqFzy+HUlAn3j0wE14z4LIOL1zhNbtCHBtPJff
	 ExsznmIT3s3iIlMKb+kXdJ7VvUwfA3ufG5x+SQ1FE2MH3Ksv1wK2qVJxK3P8lyIcXA
	 UnLMWOTln6sNdEn9Z1YtFubAZ40cSa0rZLBN/qUSbLbB3PBHU/dPvZXax+qI5fOD4h
	 7FnrAJD58PQ2HQzMJMctiEuMPw7/z8k2aexN25gdEf+x/RcEwFwm/KEy2olzOO1OeI
	 Cfct4tZnHRDJlHRkEzKtt9IB0TTnEPZ9Q5tZnQrnaYtyYZG9z7L6TViY6veC1gtNsq
	 KXbLzJE7W/7eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Fix doorbell success logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730122045.1382749-5-cassel@kernel.org>
References: <20260730122045.1382749-4-cassel@kernel.org>
 <20260730122045.1382749-5-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:30:24 +0000
Message-Id: <20260730123024.91A541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of device-supplied BAR and offset allows arbitr=
ary out-of-bounds memory write and NULL pointer dereference.
- [High] Use-after-free and race condition in device removal due to imprope=
r teardown ordering.
--

--- Patch [1]: [PATCH 1/2] misc: pci_endpoint_test: Fix doorbell success lo=
gic ---
commit fca8adde489026db6a363f41e32f957940be89f4
Author: Niklas Cassel <cassel@kernel.org>

misc: pci_endpoint_test: Fix doorbell success logic

This patch modifies the pci_endpoint_test_doorbell function to ensure
that if triggering the doorbell fails, the test stores the error code
but continues on to disable the doorbell rather than returning early.

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index 3635741c3e7a7..26ab9252251f1 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1071,6 +1071,7 @@ static int pci_endpoint_test_doorbell(struct pci_en=
dpoint_test *test)
>  	struct pci_dev *pdev =3D test->pdev;
>  	struct device *dev =3D &pdev->dev;
>  	int irq_type =3D test->irq_type;
> +	int ret =3D 0;
>  	enum pci_barno bar;
>  	u32 data, status;
>  	u32 addr;
> @@ -1119,8 +1120,11 @@ static int pci_endpoint_test_doorbell(struct pci_e=
ndpoint_test *test)

[Severity: High]
This is a pre-existing issue, but since we are modifying the error handling
in pci_endpoint_test_doorbell(), is there an out-of-bounds write or NULL
pointer dereference possible just above this diff?

A malicious or malfunctioning PCIe endpoint can supply arbitrary values for
addr and bar. The code checks if bar is within the enum bounds, but does
not check if test->bar[bar] is actually mapped (i.e., non-NULL), nor does
it bounds-check addr against the mapped BAR's size before calling:

    writel(data, test->bar[bar] + addr);

Could this allow an arbitrary MMIO write to kernel space?

>  	status =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> =20
> -	if (!left || !(status & STATUS_DOORBELL_SUCCESS))
> +	if (!left || !(status & STATUS_DOORBELL_SUCCESS)) {
>  		dev_err(dev, "Failed to trigger doorbell in endpoint\n");
> +		/* Store error code, but continue to disable doorbell. */
> +		ret =3D -EINVAL;
> +	}
> =20
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_DISABLE_DOORBELL);
> @@ -1134,10 +1138,7 @@ static int pci_endpoint_test_doorbell(struct pci_e=
ndpoint_test *test)
>  		return -EINVAL;
>  	}
> =20
> -	if (!(status & STATUS_DOORBELL_SUCCESS))
> -		return -EINVAL;
> -
> -	return 0;
> +	return ret;
>  }
> =20
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,

[Severity: High]
This isn't a bug introduced by this patch, but looking at how ioctls are
handled here, is there a use-after-free race condition during device
removal?

If a PCIe hot-unplug event or driver unbind occurs while a userspace
process is executing an ioctl, pci_endpoint_test_remove() will execute
concurrently:

    pci_endpoint_test_release_irq(test);
    pci_endpoint_test_free_irq_vectors(test);
    misc_deregister(&test->miscdev);

misc_deregister() does not wait for existing active file operations to
complete. Because the test struct is managed by devm_kzalloc(), it is freed
immediately after remove() returns.

Could the concurrent ioctl handler:

    mutex_lock(&test->mutex);

access the freed test memory or interact with torn-down IRQs or MMIO
regions? Does the driver need to synchronize device teardown with active
ioctls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730122045.1382=
749-4-cassel@kernel.org?part=3D1
