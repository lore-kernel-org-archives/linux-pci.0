Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91E3A6B6D;
	Wed,  2 Sep 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335594; cv=none; b=jmP4qWMU3DGKFc2T369FfGv91+87ncTqJfu9/dNJhVCLsbmPlURB4A9DweTxsxPE2uiqEjwCB2VI45NmjXdo2Ugu65Duo9DSPoWcAAjxG3fiPEgQiOJKCbJqehQifiXROaWRJADvuJryyGXQ/Xdyyz/FJwv84zMyzLiwaLElrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335594; c=relaxed/simple;
	bh=kETPZPU/C41/ijPKc4L/UB9khx1Jkgm9WprJggkRlFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYrGved2s3iGVQ9LLBOu+KhKeC9nBah98+C757zkQGg8zxAqA72Dp0stR2317uHLqC3Ou1sMBT6PN8B9obhp2POpup+85myDYk3xIRXzru+/wufuzEUcEhLZEdhmss5KYOyVuNrB0znEPrQz7y0qmU3fDstJEc/tQAUIGsRh2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeUwKnO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeUwKnO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A152C1F000E9;
	Wed,  2 Sep 2026 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335592;
	bh=8tmcnWUPyIMUbTM/uIlg1zfn7rYpCy3xO2rspCYwIYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YeUwKnO0aqAduF+uSSsSAmOGd/c2NJbpyp5zAMHi+oXtgRnWF9VRdFmwiKhlWzUHg
	 nldT/19uLnIos8sIHSv98f9k9FweM/xZEvaciZvX0vclTGFKi4JdHX4VHan28BGUYy
	 UqDwlaicU+KdKdOGPgEw0vRH4p6ehgakJYq9M/l8BQ1XxbfYln6YVIOhxHuoa9J2c0
	 tC0wl49PBWwUDF+mLZNDHURn+eJeQDincAO1W7P2onaX/MaSgJ7oeWoWZWhIorXrKF
	 SPybOKpwGREVSdAJc4O9DE+RKL2Lhdn5Ivc+t4BMFgoxmGay3rIj+NJ8HiSUIMv+hc
	 pFWyt3v+h138A==
Date: Wed, 2 Sep 2026 13:22:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Zhijian Han <hanzhijian1991@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: imx6: fix resource leaks in probe error paths
Message-ID: <kyuxfl6wmsytudadd2dazw7norz25mpsk6bjsfxsj2cpo7yj3h@eujfdbehavzm>
References: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824150454.3511203-1-hanzhijian1991@gmail.com>

On Mon, Aug 24, 2026 at 11:04:54PM +0800, Zhijian Han wrote:
> imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:
> 
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and adds device links to them, but nothing detaches the domains on
>   probe failure or deferral, so they leak.
> 
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
> 
> - A partial failure inside imx_pcie_attach_pd() leaks the power domains
>   that were already attached.
> 
> Add imx_pcie_detach_pd() to detach the power domains in reverse order of
> acquisition and call it from the probe error paths.  Add
> DL_FLAG_AUTOREMOVE_CONSUMER to the device links so the driver core
> removes them automatically when probe fails, instead of tracking and
> deleting them manually.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
> Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()")
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>

Frank, Richard, can I get your review for this patch?

- Mani
