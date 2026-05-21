Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F91CEADB;
	Thu, 21 May 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387016; cv=none; b=tpyVTbNTPDHwqfcdm8Put/RYO3Sxt4nS9AT813mSm7esdo5d2s2/TabzHTotAiEnKi17liElptB24zTFnFsjioa8g8KVzBvo8YdFctHsmn+pcuIHV62hFCVSsiDJDP8dR5FWLZRAA8CUecjuM4SsnWn3By1OL2hObzvLNd0Gn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387016; c=relaxed/simple;
	bh=/hjXgGmkCAE6dfZ52uP51sEu0D/7KbLdg6scovMlUxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=No0b1AzAXIfK8qGKSEwUt/SQrhwML+4uvbtJ5JhCcHpFFi31AammPfvXby4iSQmKMcM9kBLG/XuqYcVia1WZJrGHC1uyuHdvs3813xoxCXyfs/RUA9C3byJM2sn2M4cQ4Z3nfS5KKf9fkWYvOaHhPumsaXbkPHqR163uooHEtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRE5PNak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRE5PNak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DCE1F000E9;
	Thu, 21 May 2026 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779387015;
	bh=2EkGJZJIfhQbYuZ8f7SlbkmxES0QTvAZpIMeYS+NdLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRE5PNakM/B+F+fAeG3h/+8eTHhIHCsH1RQXyYYIS/wD8df31JqmMoYgG0t/j52gt
	 h5SVlSQU6RNoS3Rhk03Rivf1+SDpnOwv1mbKdyt2gcPvcwrYvruChfqVxtdhNIMGOv
	 8iwJB0OyXMVHel7YfNP/+VZoLKBqVAfBwyus31QhRmmy3hX9wz78hj/Kh4vVQ0fff+
	 374b2Cq6t7PSRXhDdB/lcRzIoEUMgHqzIyjzoL1Eh7+/JKA5EH/yA7uMcLgy5IGEMm
	 hnNAD6He1c/jLvJO/EqwvbUJ06mP4vQZffkIKrER/fZcWQ0eQ5ae45go+MFGkmPIq9
	 yoY1yWUNhf8Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521-dma_prep_config-v7-5-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-5-1f73f4899883@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:10:14 +0000
Message-Id: <20260521181014.C4DCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch claims to support atomic configuration but continues to =
locklessly mutate and read global channel state, causing data races and bro=
ken atomicity.
--

commit e550cfd0855adb0abdce8c07ba7dc3b15ac63f86
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()

This commit updates dw_edma_device_transfer() to take a dma_slave_config
argument. It intends to support atomic configuration and descriptor
preparation when a non-NULL config is provided to device_prep_config_sg().

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

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
This is a pre-existing issue, but does this actually achieve the intended
atomic configuration and descriptor preparation mentioned in the commit
message?

Looking at dw_edma_device_prep_config_sg(), it still explicitly calls
dw_edma_device_config() before delegating to dw_edma_device_transfer().

The dw_edma_device_config() function locklessly mutates global channel stat=
e:

static int dw_edma_device_config(...)
{
    ...
    if (cfg_non_ll || non_ll)
        chan->non_ll =3D true;
    ...
    memcpy(&chan->config, config, sizeof(*config));
    chan->configured =3D true;
    ...
}

If multiple threads use this API concurrently for the same channel, could t=
hey
race on this memcpy() and global state updates?

Additionally, dw_edma_device_transfer() continues to read the globally muta=
ted
chan->non_ll state to determine burst limits:

static struct dma_async_tx_descriptor *
dw_edma_device_transfer(...)
{
    ...
    bursts_max =3D chan->non_ll ? 1 : chan->ll_max;
    ...
}

Because chan->non_ll is evaluated globally rather than from the locally pas=
sed
config, could a concurrent preparation silently alter the hardware burst
behavior of an ostensibly atomic and isolated descriptor preparation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-dma_prep_c=
onfig-v7-0-1f73f4899883@nxp.com?part=3D5
