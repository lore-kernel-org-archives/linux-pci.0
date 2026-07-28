Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81937E5CF
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256352; cv=none; b=gAoWLOJ0A+XM3/8jTPyBgdvmvrXrEGc96YikobZ5tr5QfzR8enxSSABn5Hoc1QzPBtuGbSII8U4SLQMG7YEtcQisFUixkakKosqQYczbuLYNGw4b7odmaeiqEgnh40KIaUbu/L0nDHFYqTAfyMgdGkBv1RRyUMHbSkq5rh0D/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256352; c=relaxed/simple;
	bh=LftMJ+VvU0PYwPUmPR1OGtczjJlqETGjzthZAcRyZLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJNKFrqKw3DB0uNnJ61BFTjmhxs5VpAAydZtLkNma5zli8wl3JbffQmOJgKuU3KWUwN2GuqV8XLEXJd5iuz4YD/6aVc8sa6eWMRTUiWau/pwUQhnBWoBGDkLMU+b/XUBC5hiTsjX2qwpOhn/p2V1zMaRzu9CeZ/crw8JtccUkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyS3MNDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyS3MNDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785941F000E9;
	Tue, 28 Jul 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256350;
	bh=hX60/Ysft4fivaYbeANfFbGIjBCQwm1xVAybpIS77Ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DyS3MNDvb6ORsCbGVcaDuBWivqpv9S74GeRCD5un0BGrBW8CqZzrqwHmnaGkGeNyX
	 TLKYLok5UCf+TAvV2nQY6mEEI1HYImyVSYhgEo0pYopIAAWnlHSvIpX7SqEOQISjE1
	 6cR1R5Bei7Ok34RIJlT9+9ruKiD7+L5ZDHYp3HIsZCBkjcHHq06OG0JZDZ9KW0ECJ2
	 LEuF+n3Cv/nZEcshrDJVZ75lrkuQO1nfwF6N+1T5WSuWBzJh6k9lLmoaImxNV6cM5K
	 h13P1iWoIHAkel/n3rebffWy5w63md74lVtYsC/6zRLh9pFJ3yuVQG7UpK+0JYUK8R
	 9GEMIQKZ1lbaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/8] i3c: master: Support IBI-based wakeup capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728155308.142713-3-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:32:30 +0000
Message-Id: <20260728163230.785941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `of_node_get()` when assigning `boardinfo->of_node` to the=
 device, causing reference count corruption when the device is released.
--

--- Patch [2]: [PATCH V2 2/8] i3c: master: Support IBI-based wakeup capabil=
ity ---
commit a4a974dcadbb70afc57836a361635db60b65ebde
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Support IBI-based wakeup capability

This commit adds an ibi_wakeup flag to struct i3c_master_controller to
allow controller drivers to advertise support for IBI-based wakeup. It also
marks IBI-capable I3C devices as wakeup capable during registration.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 874f6e11b296d..cf3345265ac0b 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2008,6 +2008,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master=
_controller *master)
>  		if (desc->boardinfo)
>  			desc->dev->dev.of_node =3D desc->boardinfo->of_node;

[Severity: High]
This is a pre-existing issue, but does this assignment miss an
of_node_get()?

It looks like boardinfo->of_node holds a reference count acquired in
of_i3c_master_add_i3c_boardinfo():

    boardinfo->of_node =3D of_node_get(node);

However, when this pointer is copied to desc->dev->dev.of_node here, the
reference count is not incremented. Later, when the device is released,
i3c_device_release() unconditionally drops a reference:

    of_node_put(i3cdev->dev.of_node);

If the device registration fails or if it is later unregistered (e.g., due
to a hot-remove event), this would drain the reference conceptually owned
by boardinfo.=20

If the device is then recreated during a subsequent hot-join, could
boardinfo reassign the now-freed of_node pointer and cause a use-after-free
and double-free on the next release?

> =20
> +		/*
> +		 * In the case of IBI wakeup, any IBI-capable device can
> +		 * wakeup.
> +		 */
> +		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
> +			device_set_wakeup_capable(&desc->dev->dev, true);
> +
>  		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D2
