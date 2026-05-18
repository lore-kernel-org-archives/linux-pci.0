Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED23446CE
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101131; cv=none; b=cCU2JyDeS4dZ5/d/ZANlF/lyJdTlMKFK/J9AMP3BhsaXKI3eKgUGNQuYxezWgr5OXi2hK6wuKH9JPV8gynrryegvtHpOyvi0H7tPjNlVZt5GaU2n4Pv27wariVZtU0u534Yx0MYAQyJ7akwq1Ts/ot7LpBbQWjOxwjLTL7eb+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101131; c=relaxed/simple;
	bh=6pBus6iTOgZXozhWSNePG8HoOoa1gUbo5YbkymdkIEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pm7+vrtawj3Jxnmz1vQAL6ileHnfxOp0/kAa9fES/MGpxK6L0Rk08/3FI60qCcknJCptz6B6NXIN8+CdthClqDAVU2Uj5MJNKTEKI1tndxQT7TGujI9wY2+1kYi93TXOJW4OSf5Y7SpbflMLmlv6RjSxmRq/VmSAr956tAxnnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWPvQQds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWPvQQds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CE6C2BCB8;
	Mon, 18 May 2026 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779101130;
	bh=6pBus6iTOgZXozhWSNePG8HoOoa1gUbo5YbkymdkIEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AWPvQQdsWtME3wSQ+EQbS30iMbzWXVX28v1DfxzyZqjHIribPJWiWOfLkRdmoILzv
	 bY40DG5+fMCUBe9QfNwWrJqVYQvMda1s+WaxOmadre56VILhEUZvirajT0BtPl3gwp
	 ODwInCAP407y+yOlYTUr6KR4HLwFSl2jtqRi0/GrW9ORqU+0UOoJolwBrvnCXr6z/6
	 zYx6pJk2Xr5Y9XUChen8B/v4tjFZFR22Eo5OmlLv5cC8kNFlGisxVpVEC44129dkfI
	 om10CakxPblez7/QfIss4U6MouRxwJkFHhRDUUs5OjzRD50MPag9macYlTQZdimh7s
	 2OhmPpi/z+YFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: lock device when calling device_is_bound()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 10:45:29 +0000
Message-Id: <20260518104530.57CE6C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If a device fails to power on (or is probe deferred), its successf=
ully powered-on children and previous siblings within its subtree are not p=
owered off, causing a resource leak.
--

commit 9be02f191b459f8fb2b5eb9ee177a3aa7076d6f1
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

PCI/pwrctrl: lock device when calling device_is_bound()

This commit adds device locking around device_is_bound() calls in the
PCI power control core to satisfy its kerneldoc requirements.

> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 97cff5b8ca885..cd08d590483b8 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c

[ ... ]

> @@ -205,7 +207,7 @@ static int __pci_pwrctrl_power_on_device(struct devic=
e *dev)
>  static int pci_pwrctrl_power_on_device(struct device_node *np)
>  {
>  	struct platform_device *pdev;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	for_each_available_child_of_node_scoped(np, child) {
>  		ret =3D pci_pwrctrl_power_on_device(child);
> @@ -217,12 +219,14 @@ static int pci_pwrctrl_power_on_device(struct devic=
e_node *np)
>  	if (!pdev)
>  		return 0;
> =20
> -	if (device_is_bound(&pdev->dev)) {
> -		ret =3D __pci_pwrctrl_power_on_device(&pdev->dev);
> -	} else {
> -		/* FIXME: Use blocking wait instead of probe deferral */
> -		dev_dbg(&pdev->dev, "driver is not bound\n");
> -		ret =3D -EPROBE_DEFER;
> +	scoped_guard(device, &pdev->dev) {
> +		if (device_is_bound(&pdev->dev)) {
> +			ret =3D __pci_pwrctrl_power_on_device(&pdev->dev);
> +		} else {
> +			/* FIXME: Use blocking wait instead of probe deferral */
> +			dev_dbg(&pdev->dev, "driver is not bound\n");
> +			ret =3D -EPROBE_DEFER;
> +		}
>  	}
> =20
>  	platform_device_put(pdev);

This problem wasn't introduced by this patch, but does returning here leak
resources on probe deferral?

If a device fails to power on or is probe deferred, the function returns
the error without reverting the state of the children that were already
successfully powered on in the for_each_available_child_of_node_scoped()
loop above.

The top-level caller pci_pwrctrl_power_on_devices() catches the error and
executes the err_power_off cleanup path, but that path only cleans up fully
successful top-level sibling trees up to the failing node. It appears to
skip the partially-powered subtree of the failing node itself.

Since probe deferrals are a normal and frequently repeated process during
system boot, could these leaked refcounts accumulate and eventually cause
resource exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518100700.4758=
1-1-bartosz.golaszewski@oss.qualcomm.com?part=3D1
