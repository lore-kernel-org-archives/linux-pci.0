Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C66253958
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289872; cv=none; b=GrSRzCNxTzyCU1T+KZCP74YUqp2fFmwQvwytBvZyDrDn/p8+tixqTvW23Ayj/kgOPPHgfCsMcdZbgiRWTBEybkjqOnB18ABYSRPaKR8cjp+tL24h+Xyh3awF4TThzHH9avkPjIP6wMQJIoAnmENAPVDR6ZenVQtejQtItE9VvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289872; c=relaxed/simple;
	bh=FLIbfth0krIfNC+shsxQw4mXeHVFCf0RhFqqFnn0jmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FiK/k0ZNSKidfW9n0pftFi/QyU4H+gXbLoL3LcKg4FShhX2gDTo6JpPP/3pLnybs7/steN8g8vmefOWp3PAznbWctHqFyPmT0cizm2y3kPeNy/+i9BwMf3wnDabA9+najgtT6k8Spi795HRLFjkZDofB8wQIebyZwgnYv0QRDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcFwThCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcFwThCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B01F000E9;
	Sun,  5 Jul 2026 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289870;
	bh=Ip6/WpZe8X2FfBMitT+L6rHSezP1CFKVA5c0PIlYKJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NcFwThCVnhf+8/6bTqaPfzYxiFBfZPLG7kAdWZ5051ICwkyns/Ox9oujLjr7GGAnv
	 dS40okwAe/FAc7Ne4UgrPlhpf8cR2XEZhbbhZ6em45WOMBzjFzIWNb9clKY5YU4rZ8
	 eSV9fHk4rgMsTXx5w+40b4togPvIAQsszoVveKFUxO8e+6qDYv+qboTaKrzb2yNJkK
	 Z8ywXYa8zt//ul4iN7FSccavgvv7q4lamb9gd8Ytsat3Z8fglHWEII5pIS9jZzu2C4
	 59Txhhtlj64+erSMhxyKK9geU87QnStnMR267xQIIeRjqgQmZnmz0IZ0kxqJe93TAc
	 /+/hYO+Fu3DxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] device core: Initial device trust infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-9-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-9-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:17:49 +0000
Message-Id: <20260705221750.615B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A device's operational trust level (`dev->p->trust`) is persistent=
ly mutated before probe and not reverted on failure or unbind, leaking elev=
ated privileges.
- [High] Providing an invalid `trust=3D` module parameter silently bypasses=
 the restrictive module trust policy.
- [Low] The kernel fails to compile when CONFIG_DEVICE_TRUST is disabled du=
e to an undeclared require_trust variable.
--

commit b17dbaab0dbd4dc3c3e572b9b6cec407be3b263a
Author: Dan Williams <djbw@kernel.org>

device core: Initial device trust infrastructure
   =20
Introduce a per-device trust concept. To start, it plumbs "auto" and
"none" levels to enable a scheme of requiring explicit opt-in to operate a
device. This supports a Confidential Computing use case of operating a
limited / vetted device and driver set to bootstrap the environment.
   =20
Link: http://lore.kernel.org/2026032621-astound-mounted-07a6@gregkh
Link: https://lwn.net/Articles/865918/

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 60c005223844d..f0b2d58c89a07 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -857,6 +857,11 @@ static int __driver_probe_device(const struct device=
_driver *drv, struct device
>  	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
>  		drv->bus->name, __func__, drv->name);
> =20
> +	if (!device_trust_bind(drv, dev)) {
> +		dev_dbg(dev, "not trusted to bind\n");
> +		return -ENODEV;
> +	}
> +

[Severity: High]
If really_probe() fails later in this function, or if the driver is unbound=
 via
sysfs, does the device retain its newly elevated operational trust level?

When device_trust_bind() is called, it destructively overwrites dev->p->tru=
st:

drivers/base/trust.c:device_trust_bind() {
        ...
        if (drv_trust !=3D DEVICE_TRUST_UNSET)
                dev->p->trust =3D drv_trust;
        ...
}

Should there be a mechanism to rollback the device's trust level to its
baseline state on probe failure or driver unbind?

>  	pm_runtime_get_suppliers(dev);
>  	if (dev->parent)
>  		pm_runtime_get_sync(dev->parent);

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..3e1fe9966d50b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c

[ ... ]

> @@ -3375,6 +3382,11 @@ static int unknown_module_param_cb(char *param, ch=
ar *val, const char *modname,
>  		return 0;
>  	}
> =20
> +	if (strcmp(param, "trust") =3D=3D 0) {
> +		module_driver_trust(mod, val);
> +		return 0;
> +	}
> +

[Severity: High]
Can a malicious or unvetted driver bypass the explicit opt-in policy
(require_trust=3D1) by passing an invalid trust parameter?

If an unrecognized value like "trust=3Dgarbage" is passed, device_trust_par=
se()
returns DEVICE_TRUST_UNSET (0). module_driver_trust() will then overwrite
mod->trust with DEVICE_TRUST_UNSET.

Because this function unconditionally returns 0 (success) without checking =
for
invalid input, the module load succeeds. During probe, device_trust_bind()
ignores DEVICE_TRUST_UNSET and falls back to the device's existing trust le=
vel:

drivers/base/trust.c:device_trust_bind() {
        enum device_trust drv_trust =3D driver_trust(drv->owner);

        if (drv_trust !=3D DEVICE_TRUST_UNSET)
                dev->p->trust =3D drv_trust;
        return dev->p->trust > DEVICE_TRUST_NONE;
}

This seems to erase the restrictive DEVICE_TRUST_NONE default policy and mi=
ght
allow an unvetted driver to successfully attach. Should we return an error =
or
reject the load on invalid trust=3D values?

>  	/* Check for magic 'dyndbg' arg */
>  	ret =3D ddebug_dyndbg_module_param_cb(param, val, modname);

[ ... ]

> @@ -3544,6 +3556,7 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>  		goto bug_cleanup;
> =20
>  	mod->async_probe_requested =3D async_probe;
> +	module_driver_trust_init(mod, require_trust);
> =20

[Severity: Low]
Does this cause a build failure when CONFIG_DEVICE_TRUST is disabled?

The require_trust variable is declared inside an #ifdef CONFIG_DEVICE_TRUST
block earlier in this file, but it is passed unconditionally here.=20

Since module_driver_trust_init() is defined as a static inline function in
include/linux/device/trust.h when the config is disabled, the compiler will
still evaluate its arguments, which would result in an undeclared variable
error.

>  	/* Module is ready to execute: parsing args may do that. */
>  	after_dashes =3D parse_args(mod->name, mod->args, mod->kp, mod->num_kp,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D8
