Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B31AABF;
	Sat, 25 Jul 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970591; cv=none; b=QBl/Wqu8fhUFM+jXGN2ETZH7stPuxg+AMI61M0Dng+5T/z/q9Q12Q2CQRNJFfqf4+XmpQ2G3hBQYkDOi36D7Dt+uxfZuEZkcWIkHbf5NphYFsm+r5w2j27tmbCPzKwyPLhV6Tu8h+eUD+TS4KQTNp7zGbss+DCwmWfqZ36/1fAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970591; c=relaxed/simple;
	bh=Gcmx9BdKaXHM3/ju7ep86feimotziGNvGig/egq4dpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2xjhF/4CPwTMLnamde/+AmnZPCxusN1cPZ+smVTNCFE8aK4sJE3w2wg3nR+FkSUL2TZjHq1Kxhg+EjLE43y+CDBqcGUxKpQdSO8xEf31cIaIjwX2F9NOhEPAkr8lVvyJyjyDgmuPiwtf3yvI2rMfhhmcOd1cp+grNl8MeOWzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8/Bbq2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8/Bbq2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516421F000E9;
	Sat, 25 Jul 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970589;
	bh=omSNBv7AWO4phjSTzbMBpgl4QLrKVw59zbdOk+S2PHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8/Bbq2ir2OuNcuQ6sblBqtPUxayRA9V7fM6GLgVBsLCzmtrsUVvVT/R9GIrNSts2
	 rdljMlxQ9jjWHjilg+E1ZWY8ek7IZ04y2X7lrdBX4dv5PhKxiy/D3TW27BKfogHJVn
	 nPgWyefAqvgZCDzbw4AHYDTHHzHQKoIIfv/PqLAErs0UrYEZyN7v4if6IV/ls95Ht6
	 ijpvtnFGKGPwqgyH2mYYy/jVwgLvFtv4eHqgIxXgwHf+hD89mgT1JWyI97apjECTal
	 XcglZaIbeVbgJTxM1wP4QNJre4KnA4itfrKMhkIXmfTyvqq49ZmmiqxUTAcZCZHzXH
	 3usMvvpI1032Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:09:48 +0000
Message-Id: <20260725090949.516421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Violation of Cleanup Subsystem rules by mixing `goto`-based error h=
andling and `__free` scope-based cleanup.

Pre-existing issues:
- [High] Out-of-bounds array access due to missing bounds check on `port` v=
ariable.
- [High] Unbalanced regulator disable in error and remove paths.
--

--- Patch [2]: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated =
Ethernet MAC Endpoint node ---
commit 23e1126e5da4215de8157dc6521fdb07d6e7dcfa
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Fix parsing the integrated Ethernet MAC Endpoint node

DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
config registers for configuring settings such as ASPM. The Endpoint
device has 2 physical functions and those 2 functions share the same
settings.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 488e1ec34a7fb..482e82e433dd5 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -596,12 +596,17 @@ static int tc9563_pwrctrl_probe(struct platform_dev=
ice *pdev)
>  		ret =3D tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
>  		if (ret)
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but does the outer loop in
tc9563_pwrctrl_probe() lack a bounds check on the port variable?

If there are 5 or more children in the device tree, port could reach
TC9563_MAX or greater, leading to an out-of-bounds write on the
tc9563->cfg array.

This could overwrite subsequent fields like reset_gpio or adapter, causing
a crash when those pointers are subsequently dereferenced.

> -		/* Embedded ethernet device are under DSP3 */
> +
> +		/*
> +		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * device whose functions share the same config registers.
> +		 */
>  		if (port =3D=3D TC9563_DSP3) {
> -			for_each_child_of_node_scoped(child, child1) {
> -				port++;
> +			struct device_node *eth __free(device_node) =3D
> +					of_get_next_available_child(child, NULL);

[Severity: Low]
Does introducing __free(device_node) here conflict with the goto-based error
handling used elsewhere in this function?

The cleanup guidelines state that the usage of goto and cleanup helpers
should never be mixed in the same function to avoid confusing ownership
semantics.

> +			if (eth) {
>  				ret =3D tc9563_pwrctrl_parse_device_dt(tc9563,
> -								child1, port);
> +								eth, TC9563_ETHERNET);
>  				if (ret)
>  					break;
>  			}

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the error path in
tc9563_pwrctrl_probe() and tc9563_pwrctrl_remove() cause an unbalanced
regulator disable?

If devm_pci_pwrctrl_device_set_ready() fails in tc9563_pwrctrl_probe():

    ret =3D devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
    if (ret)
        goto power_off;
...
power_off:
    tc9563_pwrctrl_power_off(&tc9563->pwrctrl);

It jumps to power_off and calls tc9563_pwrctrl_power_off() which disables
the regulators. However, the probe function never enabled them (they are
only enabled asynchronously by the PCI framework later).

Could this mistakenly disable shared regulators and cause system instabilit=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D2
