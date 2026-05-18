Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00B3E0759
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092423; cv=none; b=apojaJcH6zItFbqAn77JmWFBOsT5A+Ww53psc/6zVFqvNHVc1Yu1eRWGAGhLEqOzVqwo1kQS/7tRrTBtwdbAUtDmBM9KjgZNwxvWj/DdwBBGwoAHKFZ/atipv4LRC1gWXwSLaGSn4mbSgdXGcxXhQhuUgbUqhSNuyh+z9que3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092423; c=relaxed/simple;
	bh=FurP3HEQ9b9LHdO+CXg7i/LiT5Ml3ld200d24ik4tk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcPaO0y+v+b037U6/nXAawe8MxLdlwAl6hfQEeD17tDhW8aL4zi9PFsjhtZ2sDNKMwRk/tRtf+vkMtvoHdHuVtw33IEbo22oq/ViJos7kjbPk+cdMc3bXrbOvJ/JtNijOY/fDGga6xaWXzIEIip0WQDyaJ2IbDc2nN4xEMpiAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8VzRWfI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8VzRWfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4229C2BCB7;
	Mon, 18 May 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092423;
	bh=FurP3HEQ9b9LHdO+CXg7i/LiT5Ml3ld200d24ik4tk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E8VzRWfIuz2gxpz/5L+hEaJsK01wu6jxOZUqeMAh7xgBX9u/1WeWq7MZaFFxUwYI3
	 jiQCtW0VjSPwmJ0WGwrKwnqx7qytSdk0o0wRDgnq7b88ESkXv6MJ91zqg+RwEu+r99
	 D8TZ0YZQxl+R5JLqQzBTtRLcQxC4pIWh0F3bKclyl3M16OpTrCA/QzkcA9BXnR+3TY
	 VwVsEt/2rfs154rYBZQV0KkfsTUWLF0aNJrchLKdiIHHO+tJsOFajcqv87QSxkgP6d
	 OL1l5rDg6WridJ1+BiUxrPKF0fRyL4WWJdQ+SDKeGCn3YcyqSJTz3aUgw69a/9RFhk
	 +/mTbP4FyUkWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: meson: Propagate devm_add_action_or_reset()
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuvam Pandey" <shuvampandey1@gmail.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <177909148011.9588.6639767953842842291@gmail.com>
References: <177909148011.9588.6639767953842842291@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 08:20:22 +0000
Message-Id: <20260518082022.F4229C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `.remove` callback or `.suppress_bind_attrs =3D true` leav=
es PCI subsystem and PHY active after driver unbind.
--

commit fde9e1cd9d05730f72b074fa8edf3a1233d11384
Author: Shuvam Pandey <shuvampandey1@gmail.com>

PCI: meson: Propagate devm_add_action_or_reset() failure

This commit updates meson_pcie_probe_clock() to check the return value
of devm_add_action_or_reset(). If it fails, the error is returned so
that the probe error path can unwind normally.

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 0694084f612b7..8d495bcc3a41a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -204,7 +204,9 @@ static inline struct clk *meson_pcie_probe_clock(stru=
ct device *dev,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
> +	ret =3D devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
> +	if (ret)
> +		return ERR_PTR(ret);

This isn't a bug introduced by this patch, but could this driver be unbound
via sysfs, triggering a use-after-free?

The meson_pcie_probe() function registers the PCI host controller via
dw_pcie_host_init(&pci->pp) and powers on the PHY via meson_pcie_power_on().

However, the driver does not implement a .remove callback to call
dw_pcie_host_deinit() and meson_pcie_power_off(), nor does it set
.suppress_bind_attrs =3D true in its platform_driver struct.

If the driver is unbound via /sys/bus/platform/drivers/meson-pcie/unbind,
the device core will trigger devres cleanup. This frees the mp structure,
unmaps IO memory, disables clocks, and releases resets.

Because the PCI subsystem is never explicitly unregistered via
dw_pcie_host_deinit(), the PCI core retains references to the destroyed root
bus and freed structures.

Can a subsequent access by the PCI subsystem or userspace cause a
use-after-free and system crash?

Additionally, the PHY is left permanently powered on without its required
clocks. Should the driver either implement a proper teardown in a .remove
hook or prevent unbinding by setting .suppress_bind_attrs =3D true?

> =20
>  	return clk;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/177909148011.9588.6=
639767953842842291@gmail.com?part=3D1
