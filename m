Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792926;
	b=zeWDsGAh6+shnBfGyIi06SMkhM9exf8pQOOVRTlA2lTuJrZKHObepbENmjm6LolU8f28
	 amCsKuCSIj7Ue819XbvRbyIoOFGUkNCs7TYWqULJBYnBUymdok466GsQ/L6Ah0U5yeHHz
	 98fsZjwyPWa29FwN0EyulwF6SzEaDmcWuAqZ0PKx6bMlNp+94zC8vwV05b+VSfSQBG8rE
	 u+1H6P/s8O33eU5a6QVIT/REwQ0jt64sf+mDVTTc5fedsFZS0+39P59+oGuM+MYmzWxqy
	 00APzjRkqNZQs8D0AsxS5Top1NXQT/mD5aabNsbP8jGejayeuhPtJXNHg1o7B8/HYMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j6pYOxlVju0otp73S38A8oQYjRbHBBhimsS5eCYDmjM=;
	b=esCdidXZg77KZLrXrwz3UZl0H6EuAvpCG51rH7z2zw9mK6zpQFSPRBpWGk8GgxV3iFKC
	 7jfBOaVNcwC3oWfmTe8mHkNqJNPMGFI999c9KSJdN1VG+DfNEel6vwWZleL6J6JIz767F
	 HqV13rBM7/DiY2P13rpuULXnVz+SxbdenrK+hXYk1fUROXLSTrCr0B4nq3SvzMdMjqO+9
	 jv9b+Yws4JuA46SJ5ntAnUKPg6nwzX7S3rFyGp3/h1JVZWFRbLKUEKu1Bjy7BqaHFwKSm
	 +OuWsb2RRdut4yPZxkGr0VxIycsqruZcNX+hSJyO3Wd7tZgvkzaZ9mp3AbFvxhoFpWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHHOMBqI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B022606A339;
	Wed,  4 Nov 2026 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHHOMBqI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73291F00A17;
	Wed,  4 Nov 2026 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792926;
	bh=j6pYOxlVju0otp73S38A8oQYjRbHBBhimsS5eCYDmjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHHOMBqIORHvflCIo/p9dgLE5SenJxCYJJNkmL34vSUhQQuF6zvayFBGXu+im6YYv
	 +ZlLgILJ1kCo5P8ondqwBgW1hafptl9xIdy+DK+75/YLXOmBPBKSvXcs24MQ66LKxJ
	 d9bDM1/2xDwPxMJJZbbU+2RnXZK7B40BEXuv5fabzPXUOuStxr7OrGq1tiAuVTP+GJ
	 T3FBW5jvSXGLR5743BmRe0eGfTHtjWdzxRvbckGaGiu+lzFJuTR9iCL0OpPVGuKVjq
	 s2oUdmDXjUWSYpdmqx3qtpuRKoyKWjL3zhaQonjwVn4gAgYUYndqxSzdH5Dut4r9U6
	 g4psKK01tGqxg==
Message-ID: <sashiko-outbox-197211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI/pwrctrl: Export per-device APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104-apple-pcie-pwren-v2-1-216a4066965f@cyberchaos.dev>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
 <20261104-apple-pcie-pwren-v2-1-216a4066965f@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:48:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] PCI/pwrctrl: leak of child devices on error in pci_pwrctrl_creat=
e_device()
- [Low] PCI/pwrctrl: missing !CONFIG_PCI_PWRCTRL stubs and device_node decl=
aration
- [Low] PCI/pwrctrl: invalid kernel-doc annotations and duplicated comment =
in core.c
- [Low] PCI/pwrctrl: commit message omits exported create and destroy devic=
e APIs
--

commit 99f4514cfa7c5abc8881197d44fe3f03f5d6e806
Author: Yureka Lilian <yureka@cyberchaos.dev>

PCI/pwrctrl: Export per-device APIs

This commit exports pci_pwrctrl_power_on_device(),
pci_pwrctrl_power_off_device(), pci_pwrctrl_create_device(), and
pci_pwrctrl_destroy_device() for per-port power control management in PCIe
host controller drivers.

>     PCI/pwrctrl: Export per-device APIs
>    =20
>     Export the `pci_pwrctrl_power_on_device()` and
>     `pci_pwrctrl_power_off_device()` functions to allow PCIe host drivers
>     to call manage power control on a per-port basis.
>    =20
>     Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

[Severity: Low]
This isn't a bug, but the patch also exports pci_pwrctrl_create_device()
and pci_pwrctrl_destroy_device(). Should the commit message mention those
two functions as well?

> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 0e2387cf46577..b59dbedf251bc 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -191,7 +191,16 @@ static int __pci_pwrctrl_power_off_device(struct dev=
ice *dev)
>  	return pwrctrl->power_off(pwrctrl);
>  }
> =20
> -static void pci_pwrctrl_power_off_device(struct device_node *np)
> +/**
> + * pci_pwrctrl_power_off_device - Power off pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
> + * Recursively traverse all pwrctrl devices for the devicetree hierarchy
> + * below the specified PCI port or device and power them off in a depth
> + * first manner.
> + */
> +void pci_pwrctrl_power_off_device(struct device_node *np)

[ ... ]

> @@ -245,11 +255,21 @@ static int __pci_pwrctrl_power_on_device(struct dev=
ice *dev)
>  	return pwrctrl->power_on(pwrctrl);
>  }
> =20
> -/*
> +/**
> + * pci_pwrctrl_power_on_device - Power on pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
>   * Power on the devices in a depth first manner. Before powering on the =
device,
>   * make sure its driver is bound.
> + * Recursively traverse all pwrctrl devices for the devicetree hierarchy
> + * below the specified PCI port or device and power them on in a depth
> + * first manner.  Before powering on the device, make sure its driver is=
 bound.
> + *
> + * Return: 0 on success, -EPROBE_DEFER if any pwrctrl driver is not boun=
d, an
> + * appropriate error code otherwise.
>   */
> -static int pci_pwrctrl_power_on_device(struct device_node *np)
> +int pci_pwrctrl_power_on_device(struct device_node *np)

[Severity: Low]
In the kernel-doc comments for pci_pwrctrl_power_off_device(),
pci_pwrctrl_power_on_device(), pci_pwrctrl_create_device(), and
pci_pwrctrl_destroy_device(), the parameter is documented as @device_node
rather than @np, and pci_pwrctrl_create_device() omits @parent.

Also, in pci_pwrctrl_power_on_device(), the previous two-sentence comment
was left in place right above the new description that repeats the same
text. Could these kernel-doc blocks be cleaned up to avoid kernel-doc
warnings?

[ ... ]

> @@ -335,7 +356,17 @@ int pci_pwrctrl_power_on_devices(struct device *pare=
nt)
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
> =20
> -static int pci_pwrctrl_create_device(struct device_node *np,
> +/**
> + * pci_pwrctrl_create_device - Create pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
> + * Recursively create pwrctrl devices for the devicetree hierarchy below
> + * the specified PCI port or device in a depth first manner.
> + *
> + * Return: 0 on success, negative error number on error.
> + */
> +int pci_pwrctrl_create_device(struct device_node *np,
>  				     struct device *parent)
>  {
>  	struct platform_device *pdev;
> @@ -368,6 +399,7 @@ static int pci_pwrctrl_create_device(struct device_no=
de *np,
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_pwrctrl_create_device);

[Severity: Medium]
Does pci_pwrctrl_create_device() leak already-created child platform
devices on failure?

Inside pci_pwrctrl_create_device():

	for_each_available_child_of_node_scoped(np, child) {
		ret =3D pci_pwrctrl_create_device(child, parent);
		if (ret)
			return ret;
	}
	...
	pdev =3D of_platform_device_create(np, NULL, parent);
	if (!pdev) {
		dev_err(parent, "Failed to create pwrctrl device for node: %s\n", np->nam=
e);
		return -EINVAL;
	}

When pci_pwrctrl_create_device() was only called from
pci_pwrctrl_create_devices(), the caller cleaned up partially created
devices on error by calling pci_pwrctrl_destroy_devices(parent).

Now that pci_pwrctrl_create_device() is exported for direct per-port calls,
if device creation fails for a later sibling child or for np itself, any
child platform devices already created during the call remain registered
with OF_POPULATED set. Should pci_pwrctrl_create_device() unwind and
destroy the already-created children on error, similar to the err_power_off
rollback in pci_pwrctrl_power_on_device()?

[ ... ]

> diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
> index 1192a2527521d..f27be6489b50f 100644
> --- a/include/linux/pci-pwrctrl.h
> +++ b/include/linux/pci-pwrctrl.h
> @@ -59,6 +59,10 @@ int pci_pwrctrl_create_devices(struct device *parent);
>  void pci_pwrctrl_destroy_devices(struct device *parent);
>  int pci_pwrctrl_power_on_devices(struct device *parent);
>  void pci_pwrctrl_power_off_devices(struct device *parent);
> +int pci_pwrctrl_create_device(struct device_node *np, struct device *par=
ent);
> +void pci_pwrctrl_destroy_device(struct device_node *np);
> +int pci_pwrctrl_power_on_device(struct device_node *np);
> +void pci_pwrctrl_power_off_device(struct device_node *np);
>  #else
>  static inline int pci_pwrctrl_create_devices(struct device *parent) { re=
turn 0; }
>  static void pci_pwrctrl_destroy_devices(struct device *parent) { }

[Severity: Low]
Will drivers calling these new functions fail to build when
CONFIG_PCI_PWRCTRL is disabled?

The declarations are added under #if IS_ENABLED(CONFIG_PCI_PWRCTRL), but
there are no corresponding static inline stub definitions in the #else
block. In addition, include/linux/pci-pwrctrl.h forward-declares struct
device and struct device_link, but does not forward-declare struct
device_node, which can trigger compiler warnings if this header is included
before linux/of.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-apple-pcie=
-pwren-v2-0-216a4066965f@cyberchaos.dev?part=3D1
