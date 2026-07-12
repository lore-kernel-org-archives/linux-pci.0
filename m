Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CB4A0C
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879481; cv=none; b=GGLTddRvKKKg4riCcWHEo94kpA/TxNKD9bhMgdLU5WuwIDzyWQN0iqz8psx5vOyUc96zK4bnyx5mqxq8mxHj+Zog5QJMF1b+fqyF3d1C+diPM6g1KEuQAMm5UguyFOEr3QUdNw6KRc9/clTo5GScZHJTVdzlNeG5Jul3h5ROeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879481; c=relaxed/simple;
	bh=V8O5utpmd+dGZ4lw7JGrO7MyBI9hzNdzhw0ygRXiZCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdZ8B5EDDbKfBg4ug5uJUQlMXnpjLXMAzh/awiI8ttdk2JVrOx98nWu4XtBGq4uCtIChdnTM3NsvYqjcAmpixP3NV6hLSPO5XFAzk7Ux4NoIm67NwXnPcMLu27wxt/fC/ak08cL6GRnJeOkFg2Cf72ePe9PFoWhvr+tEyIhnCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBi/ttT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBi/ttT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423421F000E9;
	Sun, 12 Jul 2026 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783879480;
	bh=DiYr5ooiX1L3b4lEmAcVS0NmFUsdcPVc+6RfUnGqh8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBi/ttT1AIG8KuqNIwOMcYyR+tJveDm6hb9RVnjZ5e8D8+h5jTx8ghIkrj08vLuYz
	 m+UDQQSteqmhOs4+at121mWYKgV1DbGAchUr6jcPG/RPma0ZvXquGPebFTmzIxojkA
	 aQAxPexEAfBQFmwK1mvmLGcHQb44jDxsmJWZOeYXVyU223QaxJ6zvbM6fXsZsNsKMT
	 jC3HnM57enkQTr+57KKDhHh6PD9idCrDAWkYbqbdwkBgqlaNQTyt3YGS+IqyVmaJWr
	 1JYvfL3Mrgl5DmPcuyM+tDxTqCjZ5NAyVhjN91gYG55JGiZDy8idJvZqVKTM3NL6Cy
	 olgXe3uKbzfTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() in
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260712175427.232234-1-alitariq45892@gmail.com>
References: <20260712175427.232234-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 18:04:39 +0000
Message-Id: <20260712180440.423421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver's removal path incorrectly calls asynchronous pm_runtim=
e_put() before pm_runtime_disable(), and tears down PM references before di=
sabling the hardware.
- [High] Failure in starfive_pcie_clk_rst_init() returns directly without p=
owering off the PHY, causing a resource leak.
- [High] Missing return statement after regulator_enable() failure causes a=
 silent fallthrough, later leading to an unbalanced regulator_disable().
--

--- Patch [1]: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() i=
n probe ---
commit 83a329f8aee98c4aec071468fc96ecc89497124e
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

This patch replaces pm_runtime_get_sync() with pm_runtime_resume_and_get()
in starfive_pcie_probe() to properly handle runtime resume failures. It
adds error handling to disable runtime PM and bail out of the probe
function if the device fails to resume, preventing unbalanced usage
counters and hardware configuration on an unpowered device.

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..e9a472985b8ac 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -410,7 +410,11 @@ static int starfive_pcie_probe(struct platform_devic=
e *pdev)
>  		return ret;
> =20
>  	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0) {
> +		pm_runtime_disable(&pdev->dev);
> +		return dev_err_probe(dev, ret, "failed to resume device\n");
> +	}
> =20
>  	plda->host_ops =3D &sf_host_ops;
>  	plda->num_events =3D PLDA_MAX_EVENT_NUM;

[Severity: High]
This isn't a bug introduced by this patch, but looking at starfive_pcie_rem=
ove():

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_remove() {
    ...
	pm_runtime_put(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
	plda_pcie_host_deinit(&pcie->plda);
    ...
}

Does this leave the hardware in an active power state upon module unload?

Since pm_runtime_put() is asynchronous, wouldn't calling pm_runtime_disable=
()
immediately afterward risk canceling the idle/suspend work?

Also, does tearing down the PM reference before stopping the PCIe host
controller via plda_pcie_host_deinit() reverse the proper teardown order?
Could this cause the device to power off while still being actively accessed
by the core?

[Severity: High]
This is a pre-existing issue, but I noticed a potential resource leak in
starfive_pcie_host_init():

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
    ...
	ret =3D starfive_pcie_enable_phy(dev, pcie);
	if (ret)
		return ret;
    ...
	ret =3D starfive_pcie_clk_rst_init(pcie);
	if (ret)
		return ret;
    ...
}

If starfive_pcie_clk_rst_init() fails, it returns the error code directly.
Does this fail to clean up the successfully initialized PHY?

Since plda_pcie_host_init() detects this initialization failure and returns
early without invoking host_deinit, does this result in permanently leaked
PHY resources and an unbalanced power state?

[Severity: High]
This is a pre-existing issue, but does this code swallow the regulator erro=
r?

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
    ...
	if (pcie->vpcie3v3) {
		ret =3D regulator_enable(pcie->vpcie3v3);
		if (ret)
			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
	}
    ...
}

Because there is no return statement after dev_err_probe(), the function
proceeds and eventually returns success at the end. Could this cause the
driver to continue operating with unpowered hardware?

Later on, starfive_pcie_host_deinit() unconditionally calls
regulator_disable(). Since the regulator was not successfully enabled,
would this trigger an unbalanced disable warning in the regulator core and
corrupt regulator use counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712175427.2322=
34-1-alitariq45892@gmail.com?part=3D1
