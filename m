Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D330344D95;
	Thu, 30 Jul 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397628; cv=none; b=PJvavRv0Et215HxJeprLxPUPKdLzVMeM737Il8XM5dtND24hUELaMmASmSqy8y5tOs/yrbzjsqF+90FO2RRYTEH91bsSeFBP/rvAb2n4N1dSnv+YJ/W48QuvlZC7DPAGxvPo1eF1iJUeDJKTTOaJD7VUTXBy/afwUDTlpG6jm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397628; c=relaxed/simple;
	bh=vBG/+XjgNpk73GUFO/06lH1j86rx36DLCZeuYSpXlXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvYm28DFa0JGsLCQSRkryQfoHqqdkDoYyXhKrFIJdTVgnWY+0UMlFoe0AMEwMisud3NvfatQHnAM9rBI9bYHuixTemu7MKhIV1454JDY81JefM/hj5Jl2TOZdcFMyrVB7BM0GM9aezqmS35z559NcP40ccummEucJoZpL5Cs5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu5ITmSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu5ITmSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632C91F000E9;
	Thu, 30 Jul 2026 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785397627;
	bh=AcoHbhRxZ7Cx7jJrRogtuX35rh7buG53Pjs7XRBmccE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gu5ITmSYspBu46ExalHJ+y25JfehB+ZViCo0NSwglj52HJCGTL7irxvIw+pMJkHNi
	 OamZHDxaCsB/wN6w8Vljlaffxrkt/ogNiGkd4t0jHi1LmoGFkP2v4/M5bMC2eSPGvj
	 Kbmoeurxyl27+eATsV7K0qZGrnH0SBbU/N+g67q8J6WCj6FockjRUxM3LndHzXNDIq
	 i+Bos1iCh7MV7YYTHVW8M6WPmKYRZUU14oxxuFpjaaqtlHNwhGmflzMrxBCoKF/8/I
	 NX/g90+IfFnzTAxfzHgRB2LjmsOPDGkbMwrmTdWz/g6sI8dVymqSj2Dm0/nd/36rgu
	 BHbz3zT8reo/w==
Date: Thu, 30 Jul 2026 09:46:57 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
Message-ID: <dvarzmhaakmz5qycowdwxqggkwvezijjestz5miv2cqy4b3ilw@zek66ydqjo5l>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
 <dz43ty5hgpefk67lmgxfn2tmppng4ws6oy66zns5ajt3qwdfai@k3exaapdqvxh>
 <178539453673.553273.3197955075422858659.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178539453673.553273.3197955075422858659.b4-reply@b4>

On Thu, Jul 30, 2026 at 02:55:36PM +0800, Jia Wang wrote:
> On 2026-07-29 15:49 +0200, Manivannan Sadhasivam wrote:
> > On Tue, Jul 14, 2026 at 09:11:04AM +0800, Jia Wang via B4 Relay wrote:
> > > From: Jia Wang <wangjia@ultrarisc.com>
> > > 
> > > CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
> > > as a module when COMPILE_TEST or platform configuration allows it.  Using
> > > builtin_platform_driver() leaves the module build without the module
> > > init/exit plumbing and causes modpost failures for the generated .ko.
> > > 
> > > Use module_platform_driver() so the driver works for both module and
> > > built-in builds while keeping the existing tristate Kconfig entry.
> > > 
> > > Add a remove callback and call dw_pcie_host_deinit() during removal so the
> > > root bus is torn down before devres releases the controller data.
> > > 
> > > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > index 72ba5840b62d..9bee522a20e9 100644
> > > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > @@ -193,6 +193,13 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > >  	return 0;
> > >  }
> > >  
> > > +static void ultrarisc_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct ultrarisc_pcie *ultra = platform_get_drvdata(pdev);
> > > +
> > > +	dw_pcie_host_deinit(&ultra->pci.pp);
> > > +}
> > 
> > Since this driver registers an internal MSI controller, it is not safe to
> > remove it due to irq disposal concern. But you can build this driver as a
> > module though.
> >
> 
> Right, I missed that this was intentionally changed to
> builtin_platform_driver() to prevent irqchip removal. I will drop this
> patch entirely in the next revision. Thanks!
>  

No, you can still load the driver as a module, that is fine, but just do not
allow removing it. So your module_platform_driver() change is fine.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
