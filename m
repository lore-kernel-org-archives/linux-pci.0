Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296121;
	b=UVztYePBn+/+bSv8eVNW4XRzFtpSnn1ml+MrKjoD9IC70dgSfS4MAT9mipYef0PC5xRw
	 WY1gvQReLpTgWsVQMJGwZ4QP69P5RZsnBvYhDn9KnlkXMylvSnvD4w8aIyi2Nhll1KcS4
	 SNCR7Z9BvNsd1d8anBTAogxaLSRZgpIhvv1GiZD1XYT6egpPzScGq65DAxR3YLWebOviw
	 1hHWt98ajR7KN+bU9z9c4CaKm2pZEit7OiBrOjPvVL5j+8bynSOAV2OgipfE0wZt0ntV8
	 GoN8VA1dH5jG4h6jqfSDpJY+DTph4RpNZcREqU3dCzpknSbWYEiarnLlFp0EdnCwoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9DMlLWJvde8wccRhIrUuWmQV2u0Aw/z18x+VnGnqLi8=;
	b=JnCr9vZIjWJ+XqM2HT0iAHsrCCNQ0iDCt1W/PyBKg6m6yj5G+vl+5R8i1kywfitMOL5L
	 YigfGrUwCF5JqzKE9KQ6ATXE5bAQ2qV9OBPc4Wl7DQIs6FnkI4VCGyzlObstl/8DyzTJi
	 qUTjVYGLn15eNDUPKo+BMjh4UcW4C0PWuMZXkHF/l1ry4lpFza7DJglvW2TQAg7t+9JVm
	 VhJcuXIpPJ8nznwjaViCweZmexd8NFgqtz/sMCjjdZQ847TIJCva1PdSPj08sgqz0dg6X
	 MeYBq7A/yyY5X4ZM2K+jFoDMDn+HIvKs7J4ZM1TdJY7f0tYrScI4puGxeckVCCSlUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB4wca6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0560A381C;
	Tue, 10 Nov 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB4wca6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975CC1F008A3;
	Tue, 10 Nov 2026 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296120;
	bh=9DMlLWJvde8wccRhIrUuWmQV2u0Aw/z18x+VnGnqLi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB4wca6Bcls0jWIWpnLtG4cyHOyLwU8FkzM/IdmnxTaSzh+eIYlLJ1mGHBCBIGS6f
	 D9S6CXq+NZKRoEoVDMtB3cZN151MZ/g+M30Xra7DGarnhjKanUXnSC1tAWKhAd6Cvu
	 E1qXSoFWWB3mFAzb2tKJvZ7N93XfT+NGHpc2i4wFDXXepF/Rkmemwq0+v4YXRBWTgK
	 q22GKEYNCd1T7fh3lWS4C6xTA5HI6f7H/CX6BZKcHehqIVeopwv1EvsdiO20FxUhXT
	 fKRxSCsmh8xD5nrkylPcVtlRNsf7+8NyFW6sIka8q7CBuh4vA1bE4+wn2TG/3E0DlZ
	 Inpqbvj9O+Abg==
Message-ID: <sashiko-outbox-206511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/19] driver core: Introduce a generic device trust
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] driver core: device_trust_prepare_full() breaks default boots
  with -EPERM
- [Medium] driver core: device_trust_prepare_full() calls
  trust_resolve() unlocked
--

commit cc9d85465ea19f97fc7a0889f6993f37d1a58048
Author: Leon Romanovsky <leon@kernel.org>

driver core: Introduce a generic device trust level

This commit adds generic device trust admission and a device_trust.default
boot parameter to resolve a device's trust policy into an active trust
level before driver probing.

> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> new file mode 100644
> index 0000000000000..6a71abf10b3bb
> --- /dev/null
> +++ b/drivers/base/trust.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <kunit/visibility.h>
> +
> +#include "base.h"
> +
> +static enum device_trust_policy device_trust_default_policy __ro_after_i=
nit;

[ ... ]

> +static int __device_trust_prepare(struct device *dev,
> +				  const struct device_driver *drv, bool full_only)
> +{
> +	enum device_trust_policy policy;
> +	enum device_trust_level level;
> +	int ret;
> +
> +	policy =3D dev->trust_policy;
> +
> +	if (policy =3D=3D DEVICE_TRUST_POLICY_DISABLED)
> +		return -EPERM;
> +	if (dev->bus && dev->bus->trust_resolve) {
> +		ret =3D dev->bus->trust_resolve(dev, drv, policy, &level);
> +		if (ret)
> +			return ret;
> +	} else {
> +		level =3D policy =3D=3D DEVICE_TRUST_POLICY_ADVERSARY ?
> +			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_FULL;
> +	}
> +	if (level =3D=3D DEVICE_TRUST_DISABLED)
> +		return -EPERM;
> +	if (full_only && level !=3D DEVICE_TRUST_FULL)
> +		return -EPERM;
> +	if (dev->p->trust_state =3D=3D DEVICE_TRUST_COMMITTED &&
> +	    dev->trust_committed_level !=3D level)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(dev->trust_committed_level, level);
> +	dev->p->trust_state =3D DEVICE_TRUST_COMMITTED;
> +	WRITE_ONCE(dev->trust_level, level);
> +	return 0;
> +}
> +
> +int device_trust_prepare(struct device *dev, const struct device_driver =
*drv)
> +{
> +	device_lock_assert(dev);
> +	return __device_trust_prepare(dev, drv, false);
> +}
> +
> +int device_trust_prepare_full(struct device *dev, const struct device_dr=
iver *drv)
> +{
> +	if (device_trust_default_policy !=3D DEVICE_TRUST_POLICY_FULL)
> +		return -EPERM;

[Severity: High]
Does requiring device_trust_default_policy =3D=3D DEVICE_TRUST_POLICY_FULL
here cause device_driver_attach_full() to fail with -EPERM on every
default boot where device_trust.default=3D is not passed on the command
line?

When device_trust.default=3D is omitted, device_trust_default_policy remains
DEVICE_TRUST_POLICY_DEFAULT, even though that policy resolves to
DEVICE_TRUST_FULL on buses without trust_resolve.  Callers converted to
device_driver_attach_full(), such as phy_attach_direct() when attaching
the generic PHY fallback driver and serio_bind_driver(), will then fail
with -EPERM unless the kernel is booted with device_trust.default=3Dfull.

> +
> +	return __device_trust_prepare(dev, drv, true);
> +}

[Severity: Medium]
Can device_trust_prepare_full() end up calling dev->bus->trust_resolve()
without holding the device lock?

The kernel-doc for struct bus_type::trust_resolve requires the device lock
to be held, and the kernel-doc for device_driver_attach_full() states that
buses with a trust resolver must use device_driver_attach().  Unlike
device_bind_driver(), which rejects dev->bus->trust_resolve with
-EOPNOTSUPP, device_trust_prepare_full() calls __device_trust_prepare()
unlocked without checking dev->bus->trust_resolve.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D11
