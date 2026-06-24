Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906F21ABD7
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308369; cv=none; b=PskCaRYjutDxRolBaUFu6NvtVZrlGPFU7QOiROoC57EC6bw1Cq6XXC+/Hl4TXbLGysPhoNCQ5TMbHskhNC1i0chm0FMoDygh65E2seOlfeQT/QjlCW1g4F/2t/V+FLpDyD110oOTTMmTErjx095MNdpq36J7fTLZCFNbZHhtfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308369; c=relaxed/simple;
	bh=4bH7pMbc4ELFfNjjDRu9Y5MQskEN4J7QlXqBCxjO44M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnD2xVymv3aOHRgz4VSj2x0YJZSFyAFhlrto0HLzOPWEtoV9HPp4tlTKlBZ6LoVsa8RrZsi/2mWb0KFwO1PPGEgEW5OCQ14HjaXRnmFX1RIwTzdNchUil5GA8szyMIDGIYr0aYGFzr13DtTG0caVf7oxeJ1vKWBptTTUvttHBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMcM7Ka/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMcM7Ka/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4844B1F000E9;
	Wed, 24 Jun 2026 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308368;
	bh=TAohLdESkntti2tgXD8a8kvSBK2nixk37vgMee6r8CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMcM7Ka/CUOVhYrtRkFd9XuKBDu+1ppNGoEy0JaAU4CG+6+AVcJXxp5rwcnJxK/tR
	 mzPa4fQu0KFb69oF/SsOtwaKNI+I1vO8/2dBFGOMEvgNO/000c1UZn5Jzqh206A9y2
	 zgzsb8wWM7mH3nmwvXOeiqvZ0bVVibWEJurKnDR11KehebxtMYiLSu7bXCraqXsnFs
	 XOsEDl1N3kACYX4aI28AgbYzof+xSPMMGVqw+zu/3LODv7dsPd6u6clSDcBh55qEyC
	 n9/dbreDMrUxE9XTTjfiaxTksjgNIpVogVO+4EqKg5vaiTaoWsGxtZgJYdPbj505q5
	 T5CXUIAN8ZKsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: qcom-ep: Fix runtime PM reference leak in probe
 error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260624132943.40718-1-vulab@iscas.ac.cn>
References: <20260624132943.40718-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:39:27 +0000
Message-Id: <20260624133928.4844B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double-disable of runtime PM on `devm_pm_runtime_enable()` failure=
 permanently breaks runtime PM.
- [High] Double-put of the runtime PM usage counter due to unhandled fall-t=
hrough on `pm_runtime_put_sync()` failure.
--

commit c1b17f3fe6107b8e2d84d7608e5bf717e1aa999e
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI: qcom-ep: Fix runtime PM reference leak in probe error paths

This commit updates qcom_pcie_ep_probe() to distinguish between error
paths before and after devm_pm_runtime_enable() succeeds. It adds
manual cleanup for early errors and uses pm_runtime_put_sync() for
later errors to prevent runtime PM reference leaks.

> - On the successful probe path: call pm_runtime_put_sync() to drop
>   the initial reference. The return value of pm_runtime_put_sync()
>   is ignored because errors like -EAGAIN or -EBUSY only indicate
>   that the device cannot be suspended at this moment and do not
>   represent a fatal probe failure.

[Severity: High]
The commit message states that the return value of pm_runtime_put_sync()
is ignored, but the code still checks the return value and jumps to the
error path if it fails.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -892,16 +892,16 @@ static int qcom_pcie_ep_probe(struct platform_devic=
e *pdev)
>  	pm_runtime_set_active(dev);
>  	ret =3D devm_pm_runtime_enable(dev);
>  	if (ret)
> -		return ret;
> +		goto err_manual_cleanup;

[Severity: High]
If devm_pm_runtime_enable() fails (for example, due to a devres memory
allocation failure), it internally guarantees its cleanup action is execute=
d,
which already calls pm_runtime_disable().

By jumping to err_manual_cleanup and calling pm_runtime_disable() again,
will this incorrectly increment the device's disable_depth to 2? Could this
permanently leave runtime PM disabled for the device on subsequent deferred
probe attempts?

[ ... ]

> @@ -932,6 +932,13 @@ static int qcom_pcie_ep_probe(struct platform_device=
 *pdev)
>  err_ep_deinit:
>  	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
> =20
> +err_put_ref:
> +	pm_runtime_put_sync(dev);
> +	return ret;

[Severity: High]
Because the patch leaves the original error check intact on the successful
probe path:

    ret =3D pm_runtime_put_sync(dev);
    if (ret < 0) {
        dev_err(dev, "Failed to suspend device: %d\n", ret);
        goto err_disable_irqs;
    }

If the initial put returns a transient error like -EAGAIN, the usage count
has already been decremented by the PM core. However, the code jumps to
err_disable_irqs, unwinds the probe, and falls through to err_put_ref here.

Could this result in calling pm_runtime_put_sync() a second time, causing
a usage counter underflow?

> +err_manual_cleanup:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624132943.4071=
8-1-vulab@iscas.ac.cn?part=3D1
