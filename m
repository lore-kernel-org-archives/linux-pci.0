Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A5370D49
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140801; cv=none; b=g3A/SMzphP3sHVRGjw9gN1ObMZC9kDO5hJ7WQbQfbSkx+/NATF37ODAbZstTw5ty6UlFByPmL/WUeFDpTfTyeCCgVwXmJp9jpJb591Pq/y0NmhPcJjuuUvAtMU8UfAimLXfcSY76RzFMVY6pSPwjMNwjYWMsjhPNffQZOhbJml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140801; c=relaxed/simple;
	bh=2xmj1KxLEO+ILazdOhyuK2FITGTDCwy3fIrYeaPxvsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ikfF4xFImt+Fi24RfvbhIPzTjU0IqqZF9b9eO9DWq5Se7wiAR+/tt7OniF5dtOUgoN5GVEVrWBiry+kZCqFhn3I9FRltMtEcEYMx13P0kgfb6vH2wbQgSGNDocmjLbg1KcItexvu6Z6NkO9Y4BwrdcIoFn+/rLe2ZGhNVm505Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/StLScR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/StLScR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC384C2BCC7;
	Thu,  7 May 2026 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140800;
	bh=2xmj1KxLEO+ILazdOhyuK2FITGTDCwy3fIrYeaPxvsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R/StLScRcHMfkD9y8aeOaTjNj0dLJ8QF17d0pHzpCciGT/tJcDHGaqIssXTcaFc0u
	 be2+YWSUVNZqfBj/6VjGF9I5DKoeEbDqPqd8UcwDyu8e0R9oV0BR4Y8HaNcU0MCL1s
	 T+QvA2PjosEuHzgCAXQK1KFqJpypACp1CUEatq99zmuUuhp/eEoyQdhFXcjwdJzRQe
	 8Fc1LJiMQdQHlxLMt79FygOQuHQeEo9yNNVj9yHDiyzHLJvyM5CWmdVroYLUiYvxU2
	 6jgKZeJ/64IG58F4gr2OI9doN5XX7kY0/Eilc+cVF1GSVITsZzfsLmwmtXspziEiJG
	 mmaO718hFJYVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 10/31] scsi: ufs: exynos: use dedicated API
 for updating PHY bus width
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260505100523.1922388-11-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-11-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 07:59:59 +0000
Message-Id: <20260507075959.EC384C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] In `samsung_ufs_phy_request_bus_width()`, if `samsung_ufs_phy_powe=
r_on()` fails, the PHY clocks are left disabled but the core `phy->power_co=
unt` remains elevated, causing unbalanced clock disables on teardown.
- [High] Early return on `phy_request_bus_width()` failure skips PHY power-=
on, causing fatal hardware bus errors when accessing unpowered PHY register=
s.
--

commit 69b368f4a4a2db532d3c3f014c5fffd55e2658d0
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

scsi: ufs: exynos: use dedicated API for updating PHY bus width

This commit introduces a new dedicated phy_request_bus_width() API to the=20
PHY core and updates the Exynos UFS driver to use it instead of hijacking
phy_set_bus_width() and phy_init(). This update allows the UFS HCD driver
to update the lane count cleanly without altering the PHY initialization and
power states unexpectedly.

> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/=
phy-samsung-ufs.c
> index ee665f26c2361..b09a35ab6acde 100644
> --- a/drivers/phy/samsung/phy-samsung-ufs.c
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
[ ... ]
> @@ -204,6 +203,31 @@ static int samsung_ufs_phy_power_off(struct phy *phy)
>  	return 0;
>  }
> =20
> +static int samsung_ufs_phy_request_bus_width(struct phy *phy, int bus_wi=
dth)
> +{
> +	struct samsung_ufs_phy *ss_phy =3D get_samsung_ufs_phy(phy);
> +	u8 old_lane_cnt =3D ss_phy->lane_cnt;
> +	int err =3D 0;
> +
> +	if (bus_width !=3D 1 && bus_width !=3D 2)
> +		return -EINVAL;
> +
> +	ss_phy->lane_cnt =3D bus_width;
> +
> +	if (phy->init_count)
> +		samsung_ufs_phy_init(phy);
> +
> +	/* If the init_count is 0, the power_count should also be 0 */
> +	if (phy->power_count) {
> +		samsung_ufs_phy_power_off(phy);
> +		err =3D samsung_ufs_phy_power_on(phy);

If samsung_ufs_phy_power_on() fails here, the PHY clocks are left disabled =
but
the core phy->power_count remains elevated because this cycle bypasses the =
core
PHY API.

When the UFS driver later cleans up and calls phy_power_off(), the PHY core
invokes samsung_ufs_phy_power_off() a second time.

Will this second call to samsung_ufs_phy_power_off() attempt to disable alr=
eady
disabled clocks and cause a clock enable count underflow warning?

> +		if (err)
> +			ss_phy->lane_cnt =3D old_lane_cnt;
> +	}
> +
> +	return err;
> +}
[ ... ]
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 77a6c8e44485b..b90876b268db7 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
[ ... ]
> @@ -947,30 +1009,11 @@ static int exynos_ufs_phy_init(struct exynos_ufs *=
ufs)
>  			ufs->avail_ln_rx, ufs->avail_ln_tx);
>  	}
> =20
> -	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
> -
> -	if (generic_phy->power_count) {
> -		phy_power_off(generic_phy);
> -		phy_exit(generic_phy);
> -	}
> -
> -	ret =3D phy_init(generic_phy);
> -	if (ret) {
> -		dev_err(hba->dev, "%s: phy init failed, ret =3D %d\n",
> -			__func__, ret);
> -		return ret;
> -	}
> -
> -	ret =3D phy_power_on(generic_phy);
> +	ret =3D phy_request_bus_width(generic_phy, ufs->avail_ln_rx);
>  	if (ret)
> -		goto out_exit_phy;
> -
> -	return 0;
> -
> -out_exit_phy:
> -	phy_exit(generic_phy);
> +		return ret;
> =20
> -	return ret;
> +	return exynos_ufs_phy_power_on(ufs);
>  }

If phy_request_bus_width() fails and returns an error (for example, -EINVAL
if ufs->avail_ln_rx is 0), this code will return early and skip the call to
exynos_ufs_phy_power_on().

However, looking at exynos_ufs_pre_link() which calls this function:

exynos_ufs_pre_link() {
...
	/* m-phy */
	exynos_ufs_phy_update_bus_width(ufs);
	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
		exynos_ufs_config_phy_time_attr(ufs);
		exynos_ufs_config_phy_cap_attr(ufs);
	}
...
}

The return value of exynos_ufs_phy_update_bus_width() is ignored, and
exynos_ufs_pre_link() proceeds unconditionally to access PHY attributes via
exynos_ufs_config_phy_time_attr() and exynos_ufs_config_phy_cap_attr().

Can accessing these registers while the PHY power domains and clocks are off
cause unhandled faults, bus errors, or hardware hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D10
