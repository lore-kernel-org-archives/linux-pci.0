Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600A47B42C;
	Tue, 12 May 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570054; cv=none; b=Tj4Kb4Dpp5MSVCqfSCHARCkFRMhiKOQVJxXv6q5edGyrzWIqYoBr8WL/Kl09zaVkDDHUkqo5ap8d2xrdEmjBDI9zjczBKyeb1adDl4+m7RxYOQqE0rgzVyO6veCwzJFUi/L6sO2M/cDls14HHqoL0q+dtuDx7//VG5Vx1Vv7I7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570054; c=relaxed/simple;
	bh=g1gkbUsnWSdMZI7g7vFCqTGaKHg+bWKWO9fa+1v1mR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx1lYZES5kK8/TBnPu8xn5dWF30Y6OIBhMVVEArkHTi83DfWDmqkLixZJxR/mHLGD21MiusuVjpWaj9+3/bZMsSnTKqt9Gmii1qr8swjcynXdYKJtIt/k4XuIquz56gIGGS0ALthxMqiSzASKvisHX2voszHUJdKsjgRmmU3Abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDnAZVaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDnAZVaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD69C2BCB0;
	Tue, 12 May 2026 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778570052;
	bh=g1gkbUsnWSdMZI7g7vFCqTGaKHg+bWKWO9fa+1v1mR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDnAZVazU1CPPk/nR7LPIrHfBHawgO8KnJnNyWNW1GvJ8DytEDFjlYXLsLSA83jBF
	 tWosRUCbAF44OkS9wcWhOR0ypjISXSJ6hsaRMwZpj36T1uSCct8VCUZ2Txya5OVjVJ
	 Ks3HxzT02BxSkQaq0N31sIF1AP9w4d+XOSZk0t3ZGMO4EDFwBfQ56wZRTD7FaVCA3h
	 eWhUqUqRpFFSt0buIk745fgfSWhO4H42PTmBg41AI7YlDuyxYVLHtd3DFE/UXVKNnF
	 AyktHd+C2E6JezY3FEEpzmR3pXHFIVRaRLgWtz83ulBiv3SMbLwM9ch/pREkmCmuER
	 7D4WxzB4wl/Jg==
Date: Tue, 12 May 2026 16:14:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, mani@kernel.org, 
	vigneshr@ti.com, jingoohan1@gmail.com, thomas.petazzoni@bootlin.com, 
	pali@kernel.org, ryder.lee@mediatek.com, claudiu.beznea.uj@bp.renesas.com, 
	mpillai@cadence.com, robh@kernel.org, s-vadapalli@ti.com, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, claudiu.beznea@tuxon.dev, linux-mediatek@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] PCI: dwc: Use common
 pci_host_common_link_train_delay() helper
Message-ID: <20260512071328.GA3606279@rocinante>
References: <20260511055923.37117-1-18255117159@163.com>
 <20260511055923.37117-5-18255117159@163.com>
 <20260511070139.GA1096586@rocinante>
 <e600d0a4-b93e-425f-a5f1-c76802c65622@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e600d0a4-b93e-425f-a5f1-c76802c65622@163.com>

Hello,

> > > -	/*
> > > -	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> > > -	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > > -	 * after Link training completes before sending a Configuration Request.
> > > -	 */
> > > -	if (pci->max_link_speed > 2)
> > > -		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > +	pci_host_common_link_train_delay(pci->max_link_speed);
> > 
> > This comment could move to the helper you added.
> 
> Hi Krzysztof,
> 
> Will add.

No need.  Per Mani's feedback about macro being well documented.

Thank you nonetheless!

	Krzysztof
