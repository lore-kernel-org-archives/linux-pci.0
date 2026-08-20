Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB0392825
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251803; cv=none; b=LP8ZT8JZknX/lvsF97UB4e/UQUBzdjZDrQIeuGi65SmUgp3+8bVi8bdxBxgWGGS/qIiVJIDK8gzEkVPuJXhD+w/pk+lRYs3vJmNtvvd9QGPhabnfYwRJT7e8F85M9ZEqKXkUOoAvL6FqdQS3V8hVg/uUYP1vLNlbfbjpJ2vE3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251803; c=relaxed/simple;
	bh=rxIQyk2en/dg5PSSKRpVwFwsesoO6uXKqXWYuLkYPzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EC0mADhC3NRg/+SHV+CPsoMdnYRwHQ6CGKc/fdX0lpN25um0gWWQ/WVxfDQtjM+9p3LEaAvnsNlr3eNXS1sSTgYXu/cqzzxcWSAaNht2W88ufExclofRfBRPxCw6clFWlVBLF0+6+X6zwrIrSXu6vPGDvrFlMnDg8qekxAid24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDhApWmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDhApWmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE2C1F000E9;
	Thu, 20 Aug 2026 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251802;
	bh=Ewpoh26+cF3ArCf7rkuWYvTcR5bJUILkQb6am2UCUkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KDhApWmH9hvH2GzDGyAcLiQpe7P5nB1baEjulQuDLbm9Zi8+mA+iAgl+dtBMvthHj
	 QvO6OMXyEsqWCl6DMpDJ2Y/+7q+8gJWHpVtckVcnmIhYieKHMRJTwfQorUhtUPl9U/
	 +YjWzyW25lMsFzVH5Q7EIFOwv0dBQdkl5AZeIjulKfupl09Kv3095aXhKjT+6IZHOI
	 A1wZVC2+dfl/zeBYiFCqoyKDpb0N4Cm4f0SHyRSWK2anYA8sSxPZ8etMlIvt7oM7+G
	 f9ssuBq5sRR5eTlKih7zoCUdZnYCuGGnveACZTjfgYs5IKUCKQqsIhHc/LkCHhQEgJ
	 nLc5t8XPgMsgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: document the link speed and width attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ferran Duarri" <ferran.duarri@me.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820184228.166566-1-ferran.duarri@me.com>
References: <20260820184228.166566-1-ferran.duarri@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 18:50:01 +0000
Message-Id: <20260820185002.1CE2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The added documentation incorrectly describes `max_link_speed` a=
nd `max_link_width` as the negotiated link ceiling (the minimum of what bot=
h ends support), which contradicts the underlying implementation. The `max_=
link_speed_show()` and `max_link_width_show()` sysfs callbacks return the d=
evice's own capabilities, not the negotiated link ceiling. The documentatio=
n for `max_link_speed` contradicts its own first sentence by subsequently a=
cknowledging the endpoint will report its own higher speed. Furthermore, th=
e `current_link_speed` documentation incorrectly advises users to "use max_=
link_speed if what they want is the ceiling" of what the link will actually=
 deliver, which can lead user-space tools to overestimate the link capacity=
 if the upstream port is slower. Lastly, the claim that the speed is "Read =
from the Max Link Speed field of the device's Link Capabilities register" i=
s outdated; since PCIe r3.0, the kernel determines this primarily via the S=
upported Link Speeds Vector in the Link Capabilities 2 Register (PCI_EXP_LN=
KCAP2).
--

--- Patch [1]: [PATCH] PCI/sysfs: document the link speed and width attribu=
tes ---
commit 24d4206c0d1e19c29d8e3f471fd2f8be01ffaa11
Author: Ferran Duarri <ferran.duarri@me.com>

PCI/sysfs: document the link speed and width attributes

This commit documents the max_link_speed, max_link_width, current_link_spee=
d,
and current_link_width sysfs attributes. It clarifies that current link
attributes represent instantaneous values and should be sampled under load.

> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
> index b767db2c52cb7..ad18bd634ee6a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -174,6 +174,71 @@ Description:
>  		similiar to writing 1 to their individual "reset" file, so use
>  		with caution.
> =20
> +What:		/sys/bus/pci/devices/.../max_link_speed
> +Date:		September 2018
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		The maximum link speed this device's link can operate at, as a
> +		human-readable string such as "16.0 GT/s PCIe". Read from the
> +		Max Link Speed field of the device's Link Capabilities register.

[Severity: Medium]
Is the claim that this is read from the Max Link Speed field of the Link
Capabilities register fully accurate?

Since PCIe r3.0, the kernel primarily determines this capability via the
Supported Link Speeds Vector in the Link Capabilities 2 Register
(PCI_EXP_LNKCAP2).

> +
> +		This is the ceiling the link may negotiate, which is the lower
> +		of what the two ends of the link support. An endpoint capable of
> +		a higher speed than the port above it will report that higher
> +		speed here while the port above it reports the lower one, and
> +		the link will train at the lower of the two. To reason about a
> +		link, read this attribute on both ends.

[Severity: Medium]
Does this description contradict itself and the sysfs implementation?

The documentation states this is the "ceiling the link may negotiate, which=
 is
the lower of what the two ends of the link support", but then acknowledges =
the
endpoint will report its own higher capability.=20

Because the max_link_speed_show() and max_link_width_show() sysfs callbacks
return the device's own capabilities rather than the negotiated link ceilin=
g,
calling it the "ceiling the link may negotiate" could cause user-space tools
to overestimate link capacities.

[ ... ]

> +What:		/sys/bus/pci/devices/.../current_link_speed
> +Date:		September 2018
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		The speed the link is operating at right now, as a
> +		human-readable string such as "16.0 GT/s PCIe". Read fresh from
> +		the device's Link Status register on every read of this file;
> +		nothing is cached.
> +
> +		This value is instantaneous and may change at any time. A link
> +		is permitted to retrain to a lower speed and back, and devices
> +		with aggressive link power management (GPUs in particular) do so
> +		routinely while idle. Two reads seconds apart, with no
> +		configuration change in between, can legitimately differ by
> +		several generations.
> +
> +		Consequently, comparing this attribute against max_link_speed is
> +		not by itself a test for a degraded link: an idle device will
> +		frequently report a lower speed and is working correctly.
> +		Callers that need a figure representing what the link will
> +		actually deliver should sample while the device is under load,
> +		or use max_link_speed if what they want is the ceiling.

[Severity: Medium]
Is it correct to advise users to use max_link_speed if they want the link's
functional ceiling?

If the upstream port is slower than the device, relying on the device's
max_link_speed will overestimate what the link will actually deliver. This
could lead user-space tools to incorrectly evaluate the available capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820184228.1665=
66-1-ferran.duarri@me.com?part=3D1
