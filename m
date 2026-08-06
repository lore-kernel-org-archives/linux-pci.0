Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC938F950
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024596; cv=none; b=iBeG42pYTbt1ZLSueI3H69JcFkmxSLGyh8ptXqq9Bzl63BTn5jgYv8wK1qYNcG0Aeo+9Wxu+kN6y21J/nBMV9iwr6vYd4Pf0vzlODdPYqzukgenIET4tdX0wmK07q2ZPzzbrbfO56Vh+VHDQB7KxFt0vnbN/rw1F4U/+MtkLlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024596; c=relaxed/simple;
	bh=SiMEw0IAZDSb/+HM1Rq6YxwfjxI+wW3Ehe+Qaot31PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dWIsOX+ZDE0yGgX33gENfM1It8U1Agklr87tFBdhg0acgyQrz08JvSD7y3maDMX1ER/Ud2h7YY39lDEW/SOZYYp7j2bPK6I7weG2n+SM1VBVtdt2eaLSVfdMAjWHH6Ja7fr6QJ+LZgnHZ2I9woh7+X3sEXR3kJ/fG772yulE7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/xJ8tPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/xJ8tPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825E81F000E9;
	Thu,  6 Aug 2026 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024594;
	bh=/A/AH5CyAtad2ksSWwXUJ+I90wFitKIRLKNDBuWDSgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/xJ8tPJXi2BI8qy6Rm7GU2g5v/lW9Hu98NT88V9CLi1UWufSuQGfVFr7dckAKobD
	 fXz0tYDkpTbs9ZZAz98XMz8aB0dJdgJtAPLRMXXTep8Cse6lL0pz5nrZG2emVqghcZ
	 vFi2MDgFX4Eg9hQj1PhTJb4gGxzuAEVoBIzlMFy4vjUXoQKNCObHf3YcLfMnXKYhJf
	 eGsRoY0XNVZIj90sEsv5eZlCO1J5Ccmvw6TREfSz8sV889MGjkGZgovKdUUQwsBhFa
	 6qW79bxLXCtom37QmxyGDLb350BskEaxKW9cFs4sDSqnpvc+3szrkzU0aixzv/1+Vk
	 vSX1jXVFH42lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org
In-Reply-To: <20260806131857.119830-13-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-13-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:56:32 +0000
Message-Id: <20260806135634.825E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The driver dynamically overwrites the user-controlled `dev->powe=
r.should_wakeup` policy during suspend.
--

--- Patch [12]: [PATCH V4 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeu=
p requirements to PCI ---
commit 317489fcad21bddef17def19e22782f047f99dc7
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI

This commit updates the driver to keep the PCI wakeup state aligned with
the wakeup requirements of the attached I3C devices. During suspend, it
checks whether any HCI instance has a wakeup-enabled device and alters the
PCI function wakeup state accordingly.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers=
/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 5a9e2a43eff8d..42c172e82622f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c

[ ... ]

> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *=
dev)
>  	if (!hci->info->control_instance_pm)
>  		return 0;
> =20
> +	pm_data.can_wakeup =3D device_can_wakeup(dev);
> +
>  	ret =3D device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_s=
uspend_instance);
> -	if (ret)
> +	if (ret) {
>  		for (int i =3D 0; i < pm_data.dev_cnt; i++)
>  			i3c_hci_rpm_resume(pm_data.dev[i]);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	if (device_may_wakeup(dev) !=3D pm_data.may_wakeup)
> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);

[Severity: Medium]
The commit message notes that the PCI device power/wakeup sysfs attribute no
longer provides independent wakeup control. However, does this approach
conflict with the PM core architecture expectation that the should_wakeup
state and device_set_wakeup_enable() belong strictly to userspace?

By dynamically altering the core device PM state here in
mipi_i3c_hci_pci_suspend(), the driver clobbers any user-configured wakeup
policy on every system or runtime suspend. Is there an alternative way to
handle the I3C wakeup propagation without overriding the sysfs UAPI contrac=
t?

> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D12
