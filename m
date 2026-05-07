Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2E37C111
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140804; cv=none; b=VAzJuID6P7Tl9gSGJlzE1dF6Zq+YVbDLfBuoZLLAQw1Luf0nWl2AI2UKuukuugOCTv9cPRoDmVPaPrBAR1vPBhW3W1gvIAN/Rn8ODx2+akCY9ZRFi00NywCEpSZQD36WCvslxpOpqtZpypFJ7y9ztO2FiySgVnA0hM1yXlDblnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140804; c=relaxed/simple;
	bh=zWJSTblMoNIj9xsEQg6h5VxF5Fho7k+w1XgwjqaVy0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxPTurDcm4l14w2tjmIiK+oLbP1MIkmC/5MbBfGDYOydlUs6ZuHRXQV5AexJOkEWg8IrFsIDg+FlONhZTac6R1ThB6L3ljGJYAdVV4NLaK8b0hk8My+PxMrUOLu9k6r1exqDI1QL+KpkyVjNRg0jXQ2IYZykX3U0C0bMyXai72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Mu/l/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Mu/l/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365FBC2BCB8;
	Thu,  7 May 2026 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140803;
	bh=zWJSTblMoNIj9xsEQg6h5VxF5Fho7k+w1XgwjqaVy0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V6Mu/l/cBsbj5S3RLsAfsZVs0EHd1RbsSS+IMjpvVQQOR/zll9eRXhOQDBHA2Dedr
	 uhM7nDEtj/zT+z2tRMMVGar18yOkkTqWHqNuOv6Fx4DS/T3rH4EbZvUr/mMVhcOy2v
	 f/EPePN0wmxFVSf21qa++TWn8zMJH/phYDkfX1HmZSYqdS7+kantC04Tvc8zYrH5II
	 +eWiX2Y8TZtLmqZ32hWZoCFgoVAdamd/EN395LFmXJ91DsBWSes1pgkk9sCCMp0WrM
	 u5s29tZy8LzttAJmsxrCF8D0sFAWBLHneP5fN69WjOpY9zQBE7NI1R9x9GKK0cXWAG
	 bE+p6oaejqa5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 13/31] scsi: ufs: qcom: keep separate track
 of PHY power state
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-14-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-14-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:02 +0000
Message-Id: <20260507080003.365FBC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Failing to clear `phy_powered_on` upon a `phy_power_off()` error l=
eads to calling `phy_power_off()` on an exited PHY during driver removal.
- [High] Silently ignoring `phy_power_off()` errors alters error propagatio=
n and can lead to system hangs.
--

commit 22afdb4c537193d799444f149b239ffbc8dfa455
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

scsi: ufs: qcom: keep separate track of PHY power state

This commit adds a phy_powered_on boolean to the Qualcomm UFS driver to
track the PHY power state. It wraps phy_power_on() and phy_power_off()
in helper functions that check and update this state to prevent unbalanced
calls.

> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c

[ ... ]

> +static void ufs_qcom_phy_power_off(struct ufs_qcom_host *host)
> +{
> +	int ret;
> +
> +	if (!host->phy_powered_on)
> +		return;
> +
> +	ret =3D phy_power_off(host->generic_phy);
> +	if (ret) {
> +		dev_warn(host->hba->dev, "Failed to power off PHY: %pe\n",
> +			 ERR_PTR(ret));
> +		return;
> +	}
> +
> +	host->phy_powered_on =3D false;
> +}

If phy_power_off() returns an error, the early return leaves
host->phy_powered_on set to true.

During driver removal, ufshcd_hba_exit() invokes ufs_qcom_exit(), which
calls ufs_qcom_phy_power_off() followed by phy_exit(). If the power off
fails here, phy_powered_on remains true.

When ufshcd_hba_exit() subsequently calls ufshcd_setup_clocks(hba, false),
it will invoke ufs_qcom_phy_power_off() again. Because the flag is still
true, could this result in calling phy_power_off() on an already exited PHY?

[ ... ]

> @@ -1420,20 +1453,14 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *=
hba, bool on,
>  				ufs_qcom_dev_ref_clk_ctrl(host, false);
>  			}
> =20
> -			err =3D phy_power_off(phy);
> -			if (err) {
> -				dev_err(hba->dev, "phy power off failed, ret=3D%d\n", err);
> -				return err;
> -			}
> +			ufs_qcom_phy_power_off(host);
>  		}
>  		break;

Because ufs_qcom_phy_power_off() returns void, it swallows the error from
phy_power_off(). Previously, this error was propagated back to the UFS core,
which correctly aborted the suspend or teardown flow.

By no longer returning the error, ufs_qcom_setup_clocks() silently returns =
0.
The UFS core will then proceed to disable the clocks while the PHY is still
active and powered on.

Would this early disabling of clocks lead to unclocked register accesses
and asynchronous aborts causing system hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D13
