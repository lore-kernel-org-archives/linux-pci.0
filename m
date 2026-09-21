Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FB2EEE67;
	Mon, 21 Sep 2026 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969720; cv=none; b=cMcfsTTxZuUUqNlCljhRjXevR0LtgN7rt9O6QYNjMdPCoyr3uU81om9HzZbgF1mpR9XiTNJeFPeWHmAA4JaPsFfq7CXlhy0xBEr5a0a0p9dTtZNFSrd+jzwtqaKE/Mc18SKQ9ZUWYwscOIZVFvp6HbXfRT8lmV9jgKLzSTzNzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969720; c=relaxed/simple;
	bh=tSLdVNxGhAOvRbRGY2uyDn443CrPrm2agd3NFZcpIaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQGXGoWnAWo/d3WhDAW8Fx9cZFJluqaMZDg96NHt6LrQe4yaK3hHNrheLGkWpuY6At1woldZlC8A+E4CqTeg6q8zX5SypZ4p/nxvK1LfO53/9odQXQE8AYgmk84DzucAbkVeDv3IhhV65VD7xojfPfyhGXncuDhXX8uouWzQDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD8a4zwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD8a4zwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7201F000FF;
	Mon, 21 Sep 2026 05:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969719;
	bh=SA6nxX+JUVKT1zZ5uXHnnmcttjZ30G41Ui3mYtPxDNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mD8a4zwpNKOOL/TtLZ1KMnWO7jrOcjYqqRoR0d4RN5tityLyMJegOSxaT/NxxMwQQ
	 wvCCK/G8TTfhnO/vISDi0FmotXUqPE78Z2xa948Q/uvey+n/hCAZMt71oDUju20tZz
	 txTcw0oyT4NL+JBFipTOVXSwP7XqP4OelZVqQHcdWWwrF3xQEyCnHmV4CVC20r+14g
	 HB0P0QekIB+y/okzKnby4Xo1cmUxKv77G78jHi8qoMj8+K+DUSHt470UKs3rhOkGam
	 7SzEy8WVeyOnZ8OP4AhEY3FBEt2fa7DSBTC54qlLXn2mQeqFb7+5zZbF4uFZp6jpet
	 a0ITtT6nhjpnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] phy: qcom: qmp-pcie: Refactor common multiphy
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, olteanv@gmail.com
In-Reply-To: <20260921-nord-v4-5-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-5-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:48:38 +0000
Message-Id: <20260921054838.BB7201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] devres: UAF of parent-allocated qmp in child's devres action
--

commit 959cd8885f7d94827203cfb4fa89bce224f75fb7
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

phy: qcom: qmp-pcie: Refactor common multiphy handling

Refactors the multiphy handling to reuse port resource arrays and attach
power domains to individual PHY devices instead of the parent device. It
also validates the clock-output-names property count.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/=
phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
[ ... ]
> @@ -398,45 +386,39 @@ static const struct phy_ops qmp_pcie_phy_ops =3D {
>  static void qmp_pcie_pd_detach(void *data)
>  {
>  	struct qmp_pcie *qmp =3D data;
> -	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
>  	int i;
> =20
> -	for (i =3D 0; i < cfg->num_pds; i++) {
> +	for (i =3D 0; i < qmp->cfg->num_pds; i++) {
>  		if (!IS_ERR_OR_NULL(qmp->pd_devs[i]))
>  			dev_pm_domain_detach(qmp->pd_devs[i], true);
>  	}
>  }
> =20
> -static int qmp_pcie_pd_init(struct qmp_pcie *qmp)
> +static int qmp_pcie_pd_init(struct qmp_pcie *qmp, struct phy *phy)
>  {
>  	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> -	struct device *dev =3D qmp->dev;
> +	struct device *pd_dev =3D &phy->dev;
>  	int i, ret;
> =20
>  	if (!cfg->num_pds)
>  		return 0;
> =20
> -	qmp->pd_devs =3D devm_kcalloc(dev, cfg->num_pds, sizeof(*qmp->pd_devs),
> +	qmp->pd_devs =3D devm_kcalloc(pd_dev, cfg->num_pds, sizeof(*qmp->pd_dev=
s),
>  				    GFP_KERNEL);
>  	if (!qmp->pd_devs)
>  		return -ENOMEM;
> =20
> +	ret =3D devm_add_action_or_reset(pd_dev, qmp_pcie_pd_detach, qmp);

[Severity: High]
Can this code introduce a use-after-free regression during device unbind?

The qmp structure is allocated via devm_kcalloc() and tied to the parent
platform device's devres (qmp->dev) in qmp_pcie_multiphy_probe().
However, the cleanup action qmp_pcie_pd_detach() is now added to the child
PHY device's devres (pd_dev =3D &phy->dev).

If the parent device is unbound while a consumer holds a reference to the
PHY (e.g., via phy_get()), the parent's devres executes first and frees
the qmp array.

When the consumer later releases the PHY, the child PHY device's devres
executes, calling qmp_pcie_pd_detach() on the already freed qmp pointer.
This would lead to a use-after-free when accessing qmp->cfg->num_pds.

> +	if (ret)
> +		return ret;
> +
>  	for (i =3D 0; i < cfg->num_pds; i++) {
> -		qmp->pd_devs[i] =3D dev_pm_domain_attach_by_name(dev,
> -							       cfg->pd_names[i]);
> -		if (IS_ERR_OR_NULL(qmp->pd_devs[i])) {
> -			ret =3D PTR_ERR(qmp->pd_devs[i]) ? : -ENODATA;
> -			goto err_detach;
> -		}
> +		qmp->pd_devs[i] =3D dev_pm_domain_attach_by_name(pd_dev, cfg->pd_names=
[i]);
> +		if (IS_ERR_OR_NULL(qmp->pd_devs[i]))
> +			return PTR_ERR_OR_ZERO(qmp->pd_devs[i]) ? : -ENODATA;
>  	}
> =20
> -	return devm_add_action_or_reset(dev, qmp_pcie_pd_detach, qmp);
> -
> -err_detach:
> -	while (--i >=3D 0)
> -		dev_pm_domain_detach(qmp->pd_devs[i], false);
> -
> -	return ret;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D5
