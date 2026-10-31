Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793432800;
	b=IbL4ZnoQlZphn11HLxunOoNRGgJowqdlVbJaQYv8C4GOyJFW5ak/QimWAgy9sP1ENwMK
	 kdkVU5R1hL4O/T+LbpsXLKO3T4JqeDRO9DAoKjTo5WAwSQjguRNzTnBPCgmirKSFSNIxH
	 tvATl1QUVJSzXdYhoMbkLGTW+oalF6VQRx64Z+vW2ylfX4u5a22EAD3+Uh07ipxVpLoNn
	 3TWroJgggEQRn3DvOcUOR/J2yJfUgl7bycjZrHNTABy90keJtcBh3drq5sHvFD+EUFoSS
	 EmVZr7Jh0DuwC83qTMm/rAJITRafc3PfqCY9cmhdfrQUwPTYLbyNOJsykceeAYeq2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793432800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bt7PFwgiNBJcY6GuDlp0RN7PS5+BEgxcno/jko3TFQU=;
	b=VjKwQSklJQWdATLW/rSz8k5qixeG/YMb3d7rEF0wBcm1HYvua/cO9XRyPg7p3Vfk8rC8
	 FfPqNksf0w27VnnhG4uqqwA+Dvrbk2bKSkzMlN0TiVtZuobvBbJnuaG9o+csMmr5JB9Nl
	 21X8TgVB43gfj5nRg3gtlrZwXjbfVdH/cB5rJ35FwuK3ImJ17JKEtNHbo1eP4rmeHo/Uz
	 KxzQef7WWeY3c0rdgjSkYkCsLbYRx3+UD2UgME79CcheH81O9AaIx0U9fMVkeeM4cbfbN
	 HeBUsNTYAPg0bKWcKV/BOO5l4Bu6BZxS5MZciJDH0Hmjhg7uD+UyKmw+b9rBxOxjpfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI2eLVS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C85606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI2eLVS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E7C1F000C1;
	Sat, 31 Oct 2026 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793432799;
	bh=bt7PFwgiNBJcY6GuDlp0RN7PS5+BEgxcno/jko3TFQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XI2eLVS4lfIoSpJbe+dR/IkigO222XYODKACQ8aLlyrOJCqrSwJAtgUuSqutPzmQ1
	 8yx7QFFBheKEfguLQTZrOFep4/kn3jaWfNuxyxk2XgiXg+ywhwIeVCyv4vQQ5dqMyv
	 ysOoNzfWcJ8k5jz44OF6nqp6aBNakns/Vh41PTtffRSkdiTGi8uU2C+JBfCoj7Vap9
	 48/6cE+f/71TUG2PennISwtsLZUa5MZflf1hd0s0XXhzY0sBcLBzx/ccDbxsGwNipa
	 +YA/dUogd5MAxtIlfKQ6Q9vEoitVg+0RudB05jUrQqtP6nE5WpxvSGeYr0d5JxGOJ1
	 h9f8OCZgIyZmA==
Message-ID: <sashiko-outbox-191809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261031073548.3916-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261031073548.3916-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 07:46:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: exynos: regulator refcount leak in exynos_pcie_suspend_noir=
q()
--

commit b886839653b4a8156d97c162a00a5d1ee22e14d1
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks return values from PHY initialization and power-on calls,
and tracks PHY and regulator state across probe, remove, suspend, and resume
to ensure proper error handling and cleanup.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..45163b1dad81d 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
[ ... ]
> @@ -332,22 +388,42 @@ static int exynos_pcie_probe(struct platform_device=
 *pdev)
[ ... ]
>  static int exynos_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct exynos_pcie *ep =3D dev_get_drvdata(dev);
> +	int ret;
> =20
>  	exynos_pcie_assert_core_reset(ep);
> -	phy_power_off(ep->phy);
> -	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +
> +	ret =3D exynos_pcie_phy_exit(ep);
> +	if (ret)
> +		dev_err(dev, "failed to exit PCIe PHY during suspend: %d\n", ret);
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret)
> +			dev_err(dev, "failed to disable regulators during suspend: %d\n", ret=
);
> +
> +		ep->supplies_enabled =3D false;
> +	}

[Severity: Medium]
In exynos_pcie_suspend_noirq(), if regulator_bulk_disable() fails, its error
recovery path re-enables any supplies that were already disabled during the
call and leaves ep->supplies enabled.

Unlike the error paths in exynos_pcie_probe(), exynos_pcie_remove(), and
exynos_pcie_resume_noirq(), ep->supplies_enabled is unconditionally set to
false here even when regulator_bulk_disable() returns an error.

When exynos_pcie_resume_noirq() later runs:

	if (!ep->supplies_enabled) {
		ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
		if (ret)
			return ret;

		ep->supplies_enabled =3D true;
	}

won't this call regulator_bulk_enable() a second time on already-enabled
supplies and leak a regulator enable reference count (or skip
regulator_bulk_disable() if the driver is removed first)? Should setting
ep->supplies_enabled =3D false be placed in an else branch as in the other
functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031073548.3916=
-1-sreekuttan2156239@gmail.com?part=3D1
