Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6D37C936
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140802; cv=none; b=c9g+wKubgjHvi6ZAml456u3SCIh04afSS4A+wCFu67hCVH8mRZJqVaOYSZYVSlhPCgdVuPujT14l6Qrks3f6OsGv/i82k56o1+VizZlv0jbVity0SR5z+ywkdyTajEkuFnpd51NkUUQuEUGlZCi179OqKhycm9nHySNJ5XVGCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140802; c=relaxed/simple;
	bh=vJ62qumG08PeknTr7gYBqsK6MRDSnl9se9nS77auLw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CjavMXKPN94DByBme2uoiCb9dou8GsUEhH2o0IefRQBR4ySnopfx9vzsIt+33PCA1opdZHhSFCybOfrigq9m6pqxxbLqdp95dwfEAnJIyRMqlXEPXMPJAeipCCbdnVzHkWeN8dbopAXOFZerRktNyWIdyGBC31sjDGxZlKRUEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeoc+MLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeoc+MLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B8C2BCB8;
	Thu,  7 May 2026 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140801;
	bh=vJ62qumG08PeknTr7gYBqsK6MRDSnl9se9nS77auLw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oeoc+MLZVH9BidiXnNVxuXVvU7yD2Dztiln2lxQh5xVTtT4mK0u7eOorcIsOOL/wI
	 zNatHLihMjUQDpVBATmijDHg/gzr8PzcwUwJLWNoWpxIjs+eoZmOiJXPCRlAXAaW9u
	 4+MWJBppe7rPBjiiR69DKBohAcSVnhRItlXyw48W2vZh+gqgMA88KgDeSTOQCOcE28
	 OlIj292Ay+1Koem3KUvcegP1giuCbEnMCT8b4Q/2ZYaxBKvN2fZu81ZyYrrmM9FL+S
	 g5iJ43uleyWhbMJC4CJeUluyXAfdlNuUnOOs8yU/R+5UlXNXCT+QzdwVtrsIBNlO02
	 wP+fVM1XnDfRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 11/31] scsi: ufs: qcom: call phy_init()
 before phy_power_on()
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-12-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-12-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:00 +0000
Message-Id: <20260507080001.508B8C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compilation error by removing a label but le=
aving a `goto` statement referencing it.
--

commit a9b6eda8b500b1bd6c9826051626a38b21091a29
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

scsi: ufs: qcom: call phy_init() before phy_power_on()

This commit changes the order of PHY API calls in the Qualcomm UFS driver to
comply with the Generic PHY API expectations. It moves phy_init() to
ufs_qcom_init() and removes the vestigial initialization from
ufs_qcom_power_up_sequence().

> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index bc037db46624a..9039b087bf214 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
[ ... ]
> @@ -513,13 +513,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba=
 *hba)
> =20
> =20
>  	/* phy initialization - calibrate the phy */
> -	ret =3D phy_init(phy);
> -	if (ret) {
> -		dev_err(hba->dev, "%s: phy init failed, ret =3D %d\n",
> -			__func__, ret);
> -		return ret;
> -	}
> -
>  	ret =3D phy_set_mode_ext(phy, mode, host->phy_gear);
>  	if (ret)
>  		goto out_disable_phy;

Does this cause a compilation error? The goto statement jumps to the
out_disable_phy label, but the label is removed by this patch at the end of
the function.

[ ... ]
> @@ -529,23 +522,18 @@ static int ufs_qcom_power_up_sequence(struct ufs_hb=
a *hba)
[ ... ]
>  	ufs_qcom_select_unipro_mode(host);
> =20
>  	return 0;
> -
> -out_disable_phy:
> -	phy_exit(phy);
> -
> -	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D11
