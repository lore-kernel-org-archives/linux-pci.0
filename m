Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323548;
	b=xWpFoT9fVQQxORTHDL/CJNdtVSn9vAKpg1pv2ibHM6mcQA/NiXWKoVTA8DpFmQ9VY38T
	 WGeCaUUM+rZkyKLt8MrviXcpEDMOu6FsLAOAYyQPVogIB/5NTMsKe0AYt6YEI4H5AiyY0
	 FAfj8mR0KSDXaKkPfcgNyeSgZ/PvsnpTqqcbxyiOVVBC39q+GdTGNVBXgF5jNreTYVdDB
	 Bwu1o2p6OKwY5sZBPZ55jJOJUGOVM/vvuZu6qMe8e/orOqGUdZAN7WCiOdQXNH/6homJX
	 lojaRniShqj6lGbsYbrfRcHYUSswpRAKImWo4wffR/Mz/dpmDdV8hgBJaNYy0PFWgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6huyC42OcEJSJtNBsLbohvdWKdl0MB/0OpnZcQwVFMs=;
	b=JFLrEKiP3+ZgYNcYSW6e4RaVnY1f9Gz221fwyCIPefqAsMkP6GRxyAtyDDglJPHPO4Ie
	 q1ijSjT5xoUBBSebS7WZzEPcCXqd6OdnHmkINZku3Vh4DKKdX6bwn8BRciaGTHeAZvCzV
	 gRs7EGJw9oCuX/ZpgpgNWxCph+Jv0342tuTrIIrbPq8DLwTrwMjSMTMExIPhLKdhypkzM
	 +uZf1e1Hx4aqOiZC6ct9UZ97WDsNECHVsKkhpFNIW0X+sfmxmCC6hsoADBbIiojWT8OcW
	 j0MuUNboHakMrMIRuX25sB8jkIxv43U3TXYnHE77tb9A0FODyO0SLiOY0/gjEBhEcyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpfpxs9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476960A262C;
	Tue, 10 Nov 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpfpxs9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3991F008A7;
	Tue, 10 Nov 2026 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323548;
	bh=6huyC42OcEJSJtNBsLbohvdWKdl0MB/0OpnZcQwVFMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lpfpxs9emOazBU7AL1hCo/630IvsrlOz5UJdUCX+dEP38ciQK7jdOOzdcdj8WBu7/
	 RXSi9LKOQcoaDp2B6FNrt+YCu+R5yQnoGm5r8wZRMgGcQFk+o6ws5ur5/oelhKtm8r
	 r+biD8Khm7nt07eRZcUSrwxZwueHSob8JAVMrVzsZ80e07oIVI/ib06SKmv+LmG3rb
	 lB4VnKm+u0er+qwEmYO5SO0sNfgdOcR+g7A2Wo8kf2lHAzsKP8xb0/AQNppG6zeIoE
	 fnAmFSECXkYGaWHby7yF6C/mPqiqriIBqrLjB5LzMApvASBOHY2mYwiwkVyCLLvDW8
	 ADm8ozkBk56ug==
Date: Tue, 10 Nov 2026 17:12:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 11/19] driver core: Introduce a generic device trust
 level
Message-ID: <20261110151224.GM8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
 <sashiko-outbox-206511@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-206511@kernel.org>

On Tue, Nov 10, 2026 at 07:35:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] driver core: device_trust_prepare_full() breaks default boots
>   with -EPERM
> - [Medium] driver core: device_trust_prepare_full() calls
>   trust_resolve() unlocked
> --
> 
> commit cc9d85465ea19f97fc7a0889f6993f37d1a58048
> Author: Leon Romanovsky <leon@kernel.org>
> 
> driver core: Introduce a generic device trust level
> 
> This commit adds generic device trust admission and a device_trust.default
> boot parameter to resolve a device's trust policy into an active trust
> level before driver probing.
> 
> > diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> > new file mode 100644
> > index 0000000000000..6a71abf10b3bb
> > --- /dev/null
> > +++ b/drivers/base/trust.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/init.h>
> > +#include <linux/string.h>
> > +#include <kunit/visibility.h>
> > +
> > +#include "base.h"
> > +
> > +static enum device_trust_policy device_trust_default_policy __ro_after_init;
> 
> [ ... ]
> 
> > +static int __device_trust_prepare(struct device *dev,
> > +				  const struct device_driver *drv, bool full_only)
> > +{
> > +	enum device_trust_policy policy;
> > +	enum device_trust_level level;
> > +	int ret;
> > +
> > +	policy = dev->trust_policy;
> > +
> > +	if (policy == DEVICE_TRUST_POLICY_DISABLED)
> > +		return -EPERM;
> > +	if (dev->bus && dev->bus->trust_resolve) {
> > +		ret = dev->bus->trust_resolve(dev, drv, policy, &level);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		level = policy == DEVICE_TRUST_POLICY_ADVERSARY ?
> > +			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_FULL;
> > +	}
> > +	if (level == DEVICE_TRUST_DISABLED)
> > +		return -EPERM;
> > +	if (full_only && level != DEVICE_TRUST_FULL)
> > +		return -EPERM;
> > +	if (dev->p->trust_state == DEVICE_TRUST_COMMITTED &&
> > +	    dev->trust_committed_level != level)
> > +		return -EINVAL;
> > +
> > +	WRITE_ONCE(dev->trust_committed_level, level);
> > +	dev->p->trust_state = DEVICE_TRUST_COMMITTED;
> > +	WRITE_ONCE(dev->trust_level, level);
> > +	return 0;
> > +}
> > +
> > +int device_trust_prepare(struct device *dev, const struct device_driver *drv)
> > +{
> > +	device_lock_assert(dev);
> > +	return __device_trust_prepare(dev, drv, false);
> > +}
> > +
> > +int device_trust_prepare_full(struct device *dev, const struct device_driver *drv)
> > +{
> > +	if (device_trust_default_policy != DEVICE_TRUST_POLICY_FULL)
> > +		return -EPERM;
> 
> [Severity: High]
> Does requiring device_trust_default_policy == DEVICE_TRUST_POLICY_FULL
> here cause device_driver_attach_full() to fail with -EPERM on every
> default boot where device_trust.default= is not passed on the command
> line?
> 
> When device_trust.default= is omitted, device_trust_default_policy remains
> DEVICE_TRUST_POLICY_DEFAULT, even though that policy resolves to
> DEVICE_TRUST_FULL on buses without trust_resolve.  Callers converted to
> device_driver_attach_full(), such as phy_attach_direct() when attaching
> the generic PHY fallback driver and serio_bind_driver(), will then fail
> with -EPERM unless the kernel is booted with device_trust.default=full.

While I did this intentionally to make sure that missing option won't
leave system unprotected, I had second thought now as it will break
backward compatibility.

> 
> > +
> > +	return __device_trust_prepare(dev, drv, true);
> > +}
> 
> [Severity: Medium]
> Can device_trust_prepare_full() end up calling dev->bus->trust_resolve()
> without holding the device lock?

Not for the upstream code, both serio and PHY are connected to the
buses without ->trust_resolve().

Thanks

> 
> The kernel-doc for struct bus_type::trust_resolve requires the device lock
> to be held, and the kernel-doc for device_driver_attach_full() states that
> buses with a trust resolver must use device_driver_attach().  Unlike
> device_bind_driver(), which rejects dev->bus->trust_resolve with
> -EOPNOTSUPP, device_trust_prepare_full() calls __device_trust_prepare()
> unlocked without checking dev->bus->trust_resolve.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com?part=11
> 
