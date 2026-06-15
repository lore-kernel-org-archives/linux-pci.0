Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3D3382F9
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530974; cv=none; b=EnTsr+XGP/dP6b/m7ddYDE931pNXfu6U5AffCxV8hZEcHl/KJdleP6SV+yMjm13GsOOqW4k04w+an6desHguO4b6wb8b/DjXovAMN1fR6jc7xtmwv2Xh/28VQBpwWilAAuaRVwCcFPqVnZcMNHWBUYimF/QY8GR0YF0oj7qmwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530974; c=relaxed/simple;
	bh=f5f7Z6u1SV5B6OzuF6QYHl/O3M/Vxmop4f9iEucRW3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WEn3yWy398MnZV3R6WWUW5gqbkc8UMiXNjl/IMIk+A/uPzDHM1MWrU2q7bRl1bB1zyQD+B1CCaT1yFazUADLujB3IuxZsgtMcz75CqznZ0pcRw+GB56DVlHYie6Tu8CchufxBNysi2/2UHAocvPs0zjV0RtvZncIZDD4Nldg6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlyVimpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlyVimpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34A21F000E9;
	Mon, 15 Jun 2026 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781530972;
	bh=x/MthiyHVXkyqC1RRkQaO/5GpytpZEssf6u3r6EbzwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QlyVimpGz/ZUA1om2WbMJbh2vPc6+sa1zqaTeErWYFIDFLxpHlF6lFYVV2A4s/o+V
	 gINV6pUEAYwuYr1uqa+Abipm6w/V82ISbEs2ByyoTx7jmXyT42XJ+g0R4Qu4xv6Tf8
	 uso89Fp77/Dv4y9vkAIc1pAHNBD08wsIjdC7g+bxQJllJLqnBkucCt8aTis8JqP3OY
	 eFiyPpXZLfUBet/8DU0wp+bWsG/zsRtXuG2vkydfgPgx/ypK+xxrkOPdA65xpGq66Q
	 hWXMCpI5v1wVKBX+p0fiHekDZ4WuGhIUN8zfYLANxah46F4UUdTk4lvWGxQUUQkPGg
	 Av80QKArIkqDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
References: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:42:52 +0000
Message-Id: <20260615134252.B34A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Asynchronous PM runtime put during device removal path leaves hard=
ware stuck in D0.
- [Medium] The patch unconditionally resumes the device to D0 for any DOE t=
ransfer type, contradicting the commit message's stated power management re=
quirement.
--

commit ef77945b44ebbc6f448bd2fb94eac66fe80392e2
Author: Lukas Wunner <lukas@wunner.de>

PCI/TSM: Resume device to D0 for CMA-SPDM operation

Per PCIe r7.0 sec 6.31.3, CMA-SPDM operation in non-D0 states is optional.
The spec does not define a way to determine if it's supported, so resume
to D0 unconditionally for the duration of a CMA-SPDM exchange. Vivaik has
talked to Windows engineers and they said that Windows does the same.

> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-de=
v-tsm.c
> index 46f2539d2d5ab..d99b835d2b7c6 100644
> --- a/drivers/crypto/ccp/sev-dev-tsm.c
> +++ b/drivers/crypto/ccp/sev-dev-tsm.c

[ ... ]

> @@ -38,6 +40,10 @@ static int sev_tio_spdm_cmd(struct tio_dsm *dsm, int r=
et)
>  	if (ret <=3D 0)
>  		return ret;
> =20
> +	PM_RUNTIME_ACQUIRE(&dsm->tsm.base_tsm.pdev->dev, pm);
> +	if ((pm_ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm)))
> +		return pm_ret;
> +

[Severity: Medium]
The commit message mentions that "resuming to D0 needs to (only) be done in
code paths which use DOE specifically for CMA-SPDM", but does this code
unconditionally resume the device to D0 regardless of the operation?

Looking at sev_tio_spdm_cmd(), the resume happens before the loop checks if
the operation is actually PCI_DOE_FEATURE_CMA or PCI_DOE_FEATURE_SSESSION.
Could this cause unnecessary power transitions for generic operations where
accessing the config space in D3hot would be sufficient?

[Severity: High]
Does using PM_RUNTIME_ACQUIRE() here risk leaving the hardware permanently
stuck in D0 during the device removal path?

The PM_RUNTIME_ACQUIRE() macro queues an asynchronous pm_runtime_put() when
dropping the reference. If sev_tio_spdm_cmd() is called during teardown
sequences, the pending asynchronous suspend can be cancelled by a subsequent
device_del() call, which disables runtime PM.=20

Should a synchronous runtime put be used here to ensure the device actually
suspends before the removal completes?

>  	/* ret > 0 means "SPDM requested" */
>  	while (ret =3D=3D PCI_DOE_FEATURE_CMA || ret =3D=3D PCI_DOE_FEATURE_SSE=
SSION) {

[ ... ]

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 5fdcd7f2e8207..af1817e86b30d 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c

[ ... ]

> @@ -894,6 +896,10 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 ty=
pe, const void *req,
>  	if (!tsm->doe_mb)
>  		return -ENXIO;
> =20
> +	PM_RUNTIME_ACQUIRE(&pdev->dev, pm);
> +	if ((rc =3D PM_RUNTIME_ACQUIRE_ERR(&pm)))
> +		return rc;
> +

[Severity: Medium]
Similarly to sev_tio_spdm_cmd(), does this code unconditionally resume the
device to D0, ignoring the type parameter?

If a generic DOE transfer is requested that does not strictly require D0, it
appears this will still force a transition to D0, contradicting the commit
message's stated power management requirements.

[Severity: High]
Is this exported API also susceptible to the same asynchronous put regressi=
on
mentioned above?

If pci_tsm_doe_transfer() is invoked during a teardown sequence, the async
idle and suspend queued by the macro might get canceled by device_del(),
leaving the device in D0.

>  	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
>  		       resp, resp_sz);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7bdfaf14d7e5a466f3f=
650150c688a60e947a7a9.1781527060.git.lukas@wunner.de?part=3D1
