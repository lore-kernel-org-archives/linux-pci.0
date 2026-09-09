Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43E1DA62E;
	Wed,  9 Sep 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966953; cv=none; b=PKPrjKMrunez6OfVicrkz6x72KuyAph01f+hBrWOplWtL3S23I0DlUXtB6LkCIOjTYiet2twR4xog5raSb60GyHHcVaPUdpnv9h6NhJ7OFsAW1lx8mrLz0jib0O3V3MmeDiSyrjcyhixnq99FE3HES05wnguthEjTa9y6LXfRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966953; c=relaxed/simple;
	bh=xzL5jLVDUcIVNSyQO6ojFOnw5F3gLNaRBHz0ENW5HHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r6RFNDtnFsFeOhwrJ9WupzjMAvxqFPzoOyWqAokDTtnQEJTm4uHOt6xlHU7wz6RcBRMkmt3kqN38q3xR5KJJWFR6YfgqO3hnk+yuANMq6yIGJ1F787L372kzu108JH/0sWH6MNE6BamM5dx2zErdgYja7sBdHrRwtKB3M/Yb/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ5H3XLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ5H3XLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA281F00A3A;
	Wed,  9 Sep 2026 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966951;
	bh=zOpunk0DYvxuVu8SJ5MWt2pHj5oTk0F02LZtjnE/OfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJ5H3XLwV5VPnyYFztg0qvaNMurz1hu0y6VhkZiCJwBKBY0pK77AQ8L2XRPKYD1+x
	 xJiggrPAQPPgflplbUQIbaqkoJwToibE0HXORbi5HRCIpbo3H3RCC4hnguMVHDePC4
	 we5JKeYcb8e9jRKsufv6pA8k6VgbYJVkwR7BDVqpkIDTxfF4j0ggCp97WiaFi1LwKD
	 YiXWKRzmGwwrJWk3jBzV6tPYwKdmGmotJ76ECh7spejnERERpxmEGLxK8ZO+hT20IH
	 rWrFC5kTPg2TEXqghv3WQjY2TPm43XBKdi+3CDhgYqT4GRKeNUPusWiBK6WZG4Ua6+
	 cmymLYfSujJ+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260909-pci-tc9563-aux-v5-3-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-3-c9b33f56c8d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:15:50 +0000
Message-Id: <20260909151551.2DA281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Auxiliary device teardown via devres races with manual power off i=
n remove(), allowing I/O to powered-down hardware.
- [Low] Missing explicit `select AUXILIARY_BUS` in Kconfig for PCI_PWRCTRL_=
TC9563.
--

commit 6f8a88de67f080d18050c0ce0599dc8854f71eab
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
   =20
This commit adds an auxiliary device to represent the GPIO controller
embedded in the TC9563. It passes the regmap via platform data to enable
the gpio-tc9563 driver to register the GPIO chip.

> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> +	depends on GPIO_TC9563
>  	select REGMAP_I2C

[Severity: Low]
Since the driver now directly calls auxiliary bus symbols, should this conf=
ig
explicitly select AUXILIARY_BUS to prevent potential build failures if
transitive dependencies change?

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> +static int tc9563_pwrctrl_adev_add(struct device *dev, const char *name,
> +				   struct device_node *of_node,
> +				   void *priv_data)
> +{
[ ... ]
> +	ret =3D auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev);
> +}

[Severity: High]
Because the auxiliary device is queued for removal via devres, won't it be
destroyed after the driver's manual remove function executes?

If the hardware is shut down and the adapter reference is dropped in the=20
driver's manual remove path before the devres callbacks run, couldn't this
allow I/O to powered-down hardware if another process accesses the GPIO
sysfs interface during this teardown window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563=
-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D3
