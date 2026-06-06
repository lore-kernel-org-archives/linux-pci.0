Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E155757;
	Sat,  6 Jun 2026 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705600; cv=none; b=qK6T9mPy9utmCzECh10Moyv242m5Vyp4td8lMlMRSdZGTV8ubFUPhNEPvLXFATTOojOE+vyculCT5Za1fQv2Y+1u3yx5kzsU6KphAXSpmwif5fuaK9Z2cHtwN6xA+KzfxnNQAfo+YBlM39m9YmubyrsN0RfUgE1oZ5unc8jeli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705600; c=relaxed/simple;
	bh=eabtnNGyiRaelFJurUGbnDb2DpiSa04lmED97Tv8KtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGvT5PtELw8HhI0+MQRqLkGVGf4jC2TbZA6RRF0tIdpuQQ2AIo670yCNCkWSUvjt2y2Aw9kACFdXnOYdJBNAHVNaWxH/fWzsz53vFpFQo+p8BTHQIIHjf2jGUvgkGmTpU0CZob2z53RmP+gEg8I7IJIH980BYXz2DIjzvgPYuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/kwFOii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/kwFOii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791BF1F00898;
	Sat,  6 Jun 2026 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705598;
	bh=047dCBwK1aH6lj+IXH1tfAkZBsdAPilA6Wn2YROArCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/kwFOii6Jec1tNK0Bfw/mU9iraXTFQQ9TeYrai5g1+yFwpoWyNbr7DwY3gmG/vyI
	 lQROa0ufJ8+rr4gIonrpOV0Sgziz6IHaG3QvtQdjC2MR6t7EL2x8heMiY4/TKq66IX
	 jK6u3/X9fv9u4vVIgWq+QTVNTCXch082Kv85ZxsqEn7GWctdl9jGaQSZnxFHNgN3qr
	 gRJPGIHhkh+REHmlUqor4euCThCcnRTz2NJ9OU2OyRijSr8MFPS+Izxt1gFk40p9Ax
	 E+JYxEv1EONHl1PPY2eFPU6gICcyz/uQTwXKPfdKIKtXszuWFDmnJfVY36HZxKowFz
	 514DYKfA/dwcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/23] dmaengine: sdxi: Install administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-8-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-8-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:26:38 +0000
Message-Id: <20260606002638.791BF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing device stop on probe error path leads to hardware DMA use-=
after-free.
--

commit 982a4ee81c07402d7c367dae3f394c267f1ffedd
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Install administrative context
   =20
Serialize the context control block, akey table, and L1 entry for the
admin context, making its descriptor ring, write index, and context
status block visible to the SDXI implementation once it is activated.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 443c231303aff..cc99fe9ecf928 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

[Severity: High]
Could this regression occur where the error path returns a timeout without
stopping the hardware that was just commanded to start?

drivers/dma/sdxi/device.c:sdxi_dev_start() {
...
	ret =3D sdxi_dev_gsv_poll(sdxi, status,
				status =3D=3D SDXI_GSV_ACTIVE ||
				status =3D=3D SDXI_GSV_ERROR);
	if (ret) {
		dev_err(sdxi->dev, "activation timed out, current state: %s\n",
			gsv_str(status));
		return ret;
	}
...
}

During probe, sdxi_fn_activate() commands the hardware to transition to the
ACTIVE state by writing SDXI_GSRV_ACTIVE in sdxi_dev_start(), and then polls
for it. If this polling times out, sdxi_dev_start() returns -ETIMEDOUT and
the device probe fails:

drivers/dma/sdxi/device.c:sdxi_fn_activate() {
...
	err =3D sdxi_dev_start(sdxi);
	if (err)
		return err;
...
}

However, the driver does not invoke sdxi_dev_stop() on this error path, nor
does it register a devres action to stop the hardware on teardown. As devres
unwinds the probe failure, it frees the DMA memory for the L1 table,
L2 table, and admin context.

Because the hardware was commanded to start and never stopped, could it
transition to ACTIVE asynchronously after the timeout and access the freed
DMA memory, resulting in IOMMU faults or memory corruption?

Should sdxi_dev_stop() be explicitly called on the error path, or registered
as a devm action?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D8
