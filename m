Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8617D6;
	Wed,  8 Jul 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506031; cv=none; b=SlNV+LhI89ssZQb5jXqBEdhurYkkX9c3T1WXYswTlCiHY9938esPbUGZckRS7knv8So5wITOw9vgTuWpwuMYd8pmuNrywk7ZFwoooe3TTPkF2227PRSU6ED3skCKQja4HE6yaoD0o2xBjZryxndMA3/qz/f+wAeI4GxKUXheHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506031; c=relaxed/simple;
	bh=WYNZUnXirK+6lLCPzR/nXOkJj4My/J/jPn68vblgvQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxCWuHHi9Wy+3kFOpH/s0IMY8G+b4P0QggVzwM6fd3WxGzbP8743Xqz0jWOQuK+T5GrOuTDpoRJvqyVigUJqlGD8Rezlfi1TDbgScbSiCePwFYDBlj1to/EuYgps6/3NAJ9xokus/zqlZ/OXDTCeQsuh4oVvYx8KnFQVRBOD1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knKCt8l9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knKCt8l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E084E1F000E9;
	Wed,  8 Jul 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783506030;
	bh=WXeAUfPwr6viqeAXlsuGQGyHEM5ZrU79PN0IfExktEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knKCt8l9K/xyhinwnHtZCPv5oahKpkZEP6pfJMFMnnw6feJ8tv3b+C8rxNE73lf4h
	 1G+ZRkYtDgra55xMWJ2CRztXlcb7f6vwrU/1foj+rjPLxP2NYN79l6MTGwy48tR1nZ
	 ZEhHKqlqPjoP+Jo5PiT2O3r3r3uDAWZRx+sHyjtcmC9VvH7dPyOnWpkuZnENEHGxpZ
	 tqCRYhArz74xYbqHcud6WdyVue7l8b1tXNFVa0DnxoZXQJ9kDeONch9o5EIgFYRdVp
	 KbgglpRC0s0Q8Z/e6AH5LHFW8iiuZV5/ytFJ+dkI3Qyk1lc54KEEjwcjkrWtHIFIiR
	 0Wh5Tdr0luqog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/9] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-4-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:20:29 +0000
Message-Id: <20260708102029.E084E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver overwrites the platform device's fwnode and devlink dev=
ice pointer during probe, but fails to restore them on probe failure or dri=
ver unbind, leading to a Use-After-Free.
--

--- Patch [3]: [PATCH v9 3/9] pinctrl: cs42l43: Use fw_devlink_set_device()=
 ---
commit 80d27bc87210331a635e646eedd21068256104a4
Author: Herve Codina <herve.codina@bootlin.com>

pinctrl: cs42l43: Use fw_devlink_set_device()

This patch updates the CS42L43 pinctrl driver to use the dedicated
fw_devlink_set_device() helper instead of directly modifying the fwnode->dev
field.

> diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/c=
irrus/pinctrl-cs42l43.c
> index 8990fab0446cf..563070aba3d81 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> @@ -576,7 +576,7 @@ static int cs42l43_pin_probe(struct platform_device *=
pdev)
>  				return ret;
> =20
>  			if (!child->dev)
> -				child->dev =3D priv->dev;
> +				fw_devlink_set_device(child, priv->dev);

[Severity: High]
This isn't a bug introduced by this patch, but could this setup leave a dan=
gling
pointer that leads to a use-after-free on unbind?

If the device is instantiated via a Device Tree overlay, the driver fetches=
 the
child node, takes a reference to it, and registers a devres action
(cs42l43_fwnode_put) to drop this reference on teardown.

Later in cs42l43_pin_probe(), the driver calls:

    device_set_node(priv->dev, fwnode);

This overwrites the platform device's fwnode with the child node without ta=
king
an additional reference.

If the driver is unbound manually via sysfs or fails probe, the devres acti=
on
drops the driver's reference to the child node, but pdev->dev.fwnode is left
pointing to it. If the DT overlay is then removed, the OF core detaches the
node, causing the child node to be freed.

Finally, the OF core notifier triggers platform device removal, and
device_del() attempts to access dev->fwnode->dev to clear the devlink,
dereferencing the freed child node.=20

Does this require a cleanup action to restore the original fwnode and devli=
nk
device pointer on teardown?

>  			fwnode =3D child;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D3
