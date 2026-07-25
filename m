Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9A312815;
	Sat, 25 Jul 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970666; cv=none; b=i+JGF1bPAJMjfLmBNOcvls1zEnCwmUa8HKKm8oVMv6wNmtg9Xy93YQ+cuO0IBGyL8Ht088dmERLEeQWE5YtwaBkDPClpQukS3yhS1Dm2qlfHfBGOq8vWizFYEUTAcThmrCQs5fTyb4fEQuo2RMIj2CDMyNqXyyTHPpI7XWs897I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970666; c=relaxed/simple;
	bh=tk8krEReIFy9Qe/F5kwR4MMTj4FI+18tqCIa9hPdgek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+5VanlRJeC1dTQH5FwtKQhJz8U4TH7zkPAyFwKlaLxTTDeldZOZ30BJaYU5DoJsnX9o8J0jbaq+2OvVynAhr9e324PlpHJFxXnlbRMISgJjPN6syQhIrlpvcNzqbJLQxiIctZRvDzwa1ze1JXuEHsXO0IOck71YUsuV9CFZx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1aZ5JkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1aZ5JkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440AB1F000E9;
	Sat, 25 Jul 2026 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970665;
	bh=s3q7Ij0dNHvAcdBRsLZHIlhmKMr0GqiGO9YlWnwlSr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1aZ5JkLyCbnMS/D+d0DDsfzb/L4zaiSkycpqfzjt6ErvD5gFeUIbzKu4+1+Q+NEv
	 5ESn6rRUmJQjIee9amIk0GMeXF+L2CucdGFooXVDOHpzywyqirSi3n2OjU09uPmGA+
	 NttxJD/Cy7s1zM9Y8Nr3+2Ax8YF/k0MO4Y/EnPERU/cYPtP+k7guXU5toKAXrY7CTz
	 u7gXirgVBMIebGsrxe9dMbAlZIaVN294c4AriHUwTNOkyMWR1XBLrpfLTkhp27Dg4Z
	 7Qv0wvk2YQsNcYMQ3VrXQTwMnDwFCv0q+4pwxEZO3Q3XkXho+QVhM/ONZwEZrtTitE
	 M80saOD16GAGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:11:04 +0000
Message-Id: <20260725091105.440AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced regulator_bulk_disable in probe error path and remove f=
unction.
--

--- Patch [5]: [PATCH 5/6] PCI/pwrctrl: tc9563: Rename DSP3 to VDSP ---
commit c88ec5f207551e44e4f9a4f5673e22f3dde64e6e
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Rename DSP3 to VDSP

TC9563 Reference Manual calls DSP3 as VDSP (Virtual Downstream Port). Hence
name it as such to avoid ambiguity.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 28e9ec3e172ae..f1179737f221f 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> @@ -612,10 +612,10 @@ static int tc9563_pwrctrl_probe(struct platform_dev=
ice *pdev)
>  			break;
> =20
>  		/*
> -		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * The integrated Ethernet MAC Endpoint under VDSP is a single
>  		 * device whose functions share the same config registers.
>  		 */
> -		if (port =3D=3D TC9563_DSP3) {
> +		if (port =3D=3D TC9563_VDSP) {
>  			struct device_node *eth __free(device_node) =3D
>  					of_get_next_available_child(child, NULL);
>  			if (eth) {

[Severity: High]
This isn't a bug introduced by this patch, but does the probe error path ca=
use
an unbalanced regulator disable?

In tc9563_pwrctrl_probe(), if devm_pci_pwrctrl_device_set_ready() fails, the
code jumps to power_off:

	ret =3D devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
	if (ret)
		goto power_off;
...
power_off:
	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);

Since tc9563_pwrctrl_power_on() is meant to be called asynchronously by the
PCI subsystem and is never invoked during probe, wouldn't calling
tc9563_pwrctrl_power_off() here invoke regulator_bulk_disable() without a
preceding regulator_bulk_enable()?

This triggers a WARN_ON_ONCE in the regulator core, which crashes systems
with panic_on_warn enabled.

The same unconditional disable appears to occur in tc9563_pwrctrl_remove()
when unbinding the driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D5
