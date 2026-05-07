Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1D37F754
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140803; cv=none; b=eVzGUgE6Z4AbBi1JI58Ble5hKpoMQr3mBvo2sUeWqZKO/n/+8hF2++fqms8gzuRn6/3EfUWaUSxPj1DHbWaGJQaU5kihW2+jvOV9vBu2oOyc4JuB5Xs2ncSqPlxZE+SiByxsm8WQCQz+ohdV5bCW4MC4NFdoc0KwdMjhIOD+WGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140803; c=relaxed/simple;
	bh=Se8DNUOvARlazVwQdghiZ4bqy4wOyzPNEesapZqAZWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKeStt7TF+rGWId60s41iflIBhKydWYKhcGNttyBVq+OYZdwyeNXfKV3pbh5z7GGdmbTKBJdOrYQnXFKL5H+OiL3e4HBWUH0i+UVDaeXQRtqajkgbN8siukdIGjuzL3Jd6Kz1rnGtOTnGcu09ZFQjZKptXACM75HFgu//JdaiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLen/GEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLen/GEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B01C2BCC7;
	Thu,  7 May 2026 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140802;
	bh=Se8DNUOvARlazVwQdghiZ4bqy4wOyzPNEesapZqAZWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tLen/GEitFcX9OO6XiB8RDZs60SJY9YCOxLauAzY+hDYkIAUIA1LJgerE4bPtTJeR
	 hEkNpyLlCwx8ZDcyjG0/ebvGSAsVxtR5Y4zwt2ud2d6QwhYTfgdBb3eQECeNYyzUvs
	 3BG756naDgKeUv1xBgUmcEETYtdW8ER8sTJ9IIKYa0yE9z+Lz6Nqk188P/q/rCFPMx
	 NHockbfAx2GyENCZY2LeLkqYts43W8MnQls0cp8BvwhVi/U+bmpgWcJ1FiXEtyk/gM
	 T8DuOyCnteGS39UqJ+WWbRfbECwgLjXtsrdspr6Jc6StoIZAma76AgaLa6ULHMGUPy
	 A0fKRYyzXAtKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 12/31] scsi: ufs: qcom: make use of QMP PHY
 dynamic gear switching ability
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-13-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-13-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:01 +0000
Message-Id: <20260507080002.75B01C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing error check on qmp_ufs_power_on() leads to a system crash =
on unclocked register access.
- [Medium] Bypassing the PHY framework for power cycling desynchronizes the=
 framework's power state, causing resource double-disables on failure.
--

commit f4f0468d1ef7ec1cda5450a4d318d324cf1517f6
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

scsi: ufs: qcom: make use of QMP PHY dynamic gear switching ability

This commit absorbs the PHY power cycling and calibration sequence into
qmp_ufs_set_mode() to simplify the consumer driver. It updates both the UFS
HCD consumer and the QMP PHY provider simultaneously to avoid breaking the
power sequence.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualco=
mm/phy-qcom-qmp-ufs.c
> index 771bc7c2ab505..e4e7966eb39a6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -2012,6 +2012,12 @@ static int qmp_ufs_set_mode(struct phy *phy, enum =
phy_mode mode, int submode)
>  	qmp->mode =3D mode;
>  	qmp->submode =3D submode;
> =20
> +	if (phy->power_count) {
> +		qmp_ufs_power_off(phy);
> +		qmp_ufs_power_on(phy);

Does the return value of qmp_ufs_power_on() need to be checked here?

If qmp_ufs_power_on() fails, the PHY clocks and regulators will remain
disabled.

Because the error is ignored, execution unconditionally proceeds to
qmp_ufs_phy_calibrate(), which performs read/modify/write operations on the
PHY memory-mapped registers. Accessing peripheral registers while their
clocks are disabled can cause a synchronous external abort and a kernel
panic.

Additionally, does calling the internal power routines directly cause issues
with the PHY framework state tracking?

By calling qmp_ufs_power_off() and qmp_ufs_power_on() instead of the public
phy_power_off() and phy_power_on() APIs, phy->power_count remains unchanged.

If qmp_ufs_power_on() fails leaving the hardware unpowered, the framework
will still believe the PHY is powered on. During error handling or teardown,
the core might call phy_power_off(). Would this result in a second call
to qmp_ufs_power_off() and cause reference count underflow warnings for the
clocks and regulators?

> +		return qmp_ufs_phy_calibrate(phy);
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D12
