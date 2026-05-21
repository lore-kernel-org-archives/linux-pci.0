Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F291FBC8E;
	Thu, 21 May 2026 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324689; cv=none; b=PrHTOhqKP4qj5ByQNii/mx8twDxjUAUfGCxG2WfIoxMEsF84TbeT2yAaCTYZoMXaF+iMoANVjCKjjoFjsYToCcXaDJuUchDFQA+NQAG0epfPywd0dJtgVXdIZhv4fluohIt4Ce/mEfWNJqEeFb4FbUDiext3LZ3zNEcy2VKO8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324689; c=relaxed/simple;
	bh=hLgGHrBnDGf1y5CMf45tEqlbR/GI4/VI71B8BLXAIgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+ROfLi3GGDoAzf33++VgWCpOqfNyinpVzfhUSSVIPoRg1kJRfF3D9yUf5UZnx/LV0rERPKz3G1IT87ijqpL7kcscEbv37h3KPZzIbtY+59hBwhUK/XF2aEtktM/aPda2ww7/ttfuplTzr2NiW7Xe0r9nmWazi2Q3+W8I+USYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKhf/3mi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKhf/3mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586F91F000E9;
	Thu, 21 May 2026 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324687;
	bh=jWWP+qp7jQ77KZHCG3J/RMiofRIZyu1EU8RnS2mbzcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKhf/3mibnSt2KHesgXTQchrmMAelJIdqL7yftgYEbLkG6n8IgBZrWjPHhEFJVVv+
	 bXjkrTh5pdchdMHvfHakLzF0rNQUyTl3j/PpeIAKeO/JJ4Jl8SbUT7SIF2lQeUXqvm
	 ZMAYAFWfhNRidFxnFFUYsarUC+qacZ7WoMZy4DWhMboPoRZG3fOlKWTzOecFYVrFHr
	 5aa+YbcVGUtHMndyXiEjC/lKmaFxUgrdp/8+k6KD7FC2Ob8w5aYhogNPA/e/PCV7ql
	 GJTReTDMZcsl2L9vb94DuO/yIrH35CR3YoyFZHln+Bx3gfv+Evzpw3iaPjHYhRqeRB
	 IATrbDiOujV8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260520-dma_prep_config-v6-5-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-5-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 00:51:26 +0000
Message-Id: <20260521005127.586F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch fails to provide atomic configuration because dw_edma_de=
vice_prep_config_sg() calls dw_edma_device_config(), mutating global channe=
l state without synchronization.

Pre-existing issues:
- [High] Channel control functions like dw_edma_device_pause() modify state=
 without vc.lock, causing a TOCTOU race that permanently hangs the channel.
--

commit 248bbd394732f32660b56f83243ae2005c3e1952
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()

This commit passes dma_slave_config to dw_edma_device_transfer() to enable
atomic configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 92572dd8131e6..ba37bc983dcd2 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dc=
han,
>  	return 0;
>  }
> =20
> +static struct dma_slave_config *
> +dw_edma_device_get_config(struct dma_chan *dchan,
> +			  struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (config)
> +		return config;
> +
> +	chan =3D dchan2dw_edma_chan(dchan);
> +
> +	return &chan->config;
> +}
> +
>  static int dw_edma_device_pause(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);

[Severity: High]
This is a pre-existing issue, but does this function have a TOCTOU race
condition?

Because chan->status and chan->request are checked and modified without
acquiring chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_pause() {
    ...
    if (!chan->configured)
        err =3D -EPERM;
    else if (chan->status !=3D EDMA_ST_BUSY)
        err =3D -EPERM;
    else if (chan->request !=3D EDMA_REQ_NONE)
        err =3D -EPERM;
    else
        chan->request =3D EDMA_REQ_PAUSE;
    ...
}

Could the interrupt handler dw_edma_done_interrupt() run concurrently
(with vc.lock held) and transition chan->status to EDMA_ST_IDLE before
chan->request is set to EDMA_REQ_PAUSE?

If that happens, the channel would be left in an invalid state (IDLE with a
PAUSE request), which would cause subsequent calls to dw_edma_device_resume=
()
and dw_edma_device_issue_pending() to fail permanently.

[ ... ]
> @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan,=
 struct scatterlist *sgl,
>  	if (config && dw_edma_device_config(dchan, config))
>  		return NULL;
> =20
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, =
config));
>  }

[Severity: High]
Is a lockless mutation of global channel state still occurring here?

The commit message mentions supporting atomic configuration, but
dw_edma_device_config() is still called here before dw_edma_device_transfer=
().

Looking at dw_edma_device_config(), it modifies chan->non_ll and performs
a lockless memcpy over chan->config:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_config() {
    ...
    if (cfg_non_ll || non_ll)
        chan->non_ll =3D true;
    ...
    memcpy(&chan->config, config, sizeof(*config));
    chan->configured =3D true;
    ...
}

Will concurrent calls to prepare descriptors data race on chan->config and
chan->non_ll, corrupting the transfer configuration?

Additionally, dw_edma_device_transfer() still incorrectly relies on the
mutated chan->non_ll to calculate bursts_max.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D5
