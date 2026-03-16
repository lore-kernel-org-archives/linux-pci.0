Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA27263B;
	Mon, 16 Mar 2026 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773624512; cv=none; b=E4mPxfZoy0rCh39rSgs+Hc+w1W3IjbZ9G02FgJt48fmVIGl5nmK0FUZmS54RGGkV6TPCzA+L02tps2KolWH5iGlyLO5V3zZ1Dkb9/6sC4urUZ49iinjoKgkJpb7zd21L7BqglagHYWYci+84lW1ziLl7+piWpbzG8OPaFfbpCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773624512; c=relaxed/simple;
	bh=3wmu8XhCYc4ozx5ksbO2XRoEhyImvzo0wuqKDGjwa48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf5Aat/K+0PLllEei9oqvJj5i3eL8FEmJ37poPVmUWUV3l1GN8R9xcL8ICMpY34BN2N77MsZ7401rIQAW/MRKh4+uxCcRLnjfgBe4xF0bJ0YmDXuWZRsX6xSJ06Zx42cCG3kIWVi6E4JZLGOtvV1FWX6fFfBJJKu2O8UL8ZFACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqcBKNEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqcBKNEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A476C4CEF7;
	Mon, 16 Mar 2026 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773624512;
	bh=3wmu8XhCYc4ozx5ksbO2XRoEhyImvzo0wuqKDGjwa48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqcBKNEeDZuVsCpyzfPxRqQHU6uuQONlCegPpkvbknsqQ45Ujf7o4MUfOUMho8yg2
	 FNIs9kUzLB1FAp8u3N5hGVf/+mnYHJS6YzaO1DWoZtQ0HU+dyFqFrQeVR9FvLaSpAf
	 6hiapekXYZK2zLMat9XFOr8c8j6BDRPzrdIHBjpNu1AmOaw+aGIH4nujRK0AuTgQDi
	 LkDPrTmeIQ+1NkCqtxo4ySeRbThT92IUI6aF66ynUBcmXGdUtJaWMb066KdcecIA87
	 rvktS40u5OZxoMWnpVy1h2rsvXmUb38pBI5KIYAwNTAmhQFeifi7UHZCHc+BAUpn6k
	 U3VeG+QrZ6UJw==
Date: Mon, 16 Mar 2026 06:58:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, 
	Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp" <den@valinux.co.jp>, 
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>, 
	"18255117159@163.com" <18255117159@163.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
Message-ID: <qzpib5l3kaum32eh76tpmjzx6rehevjw3yxn2gbevuhzvp4r7v@v25joiibkrnw>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-8-mmaddireddy@nvidia.com>
 <x5m2omsus72plxulgt66hov5giw2t5madb6zfzyr2e2o5ojm4b@uhyuycoa6gpw>
 <e05d3b86-8c80-4ae2-bbdf-c346afd32c6d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e05d3b86-8c80-4ae2-bbdf-c346afd32c6d@nvidia.com>

On Sun, Mar 15, 2026 at 07:19:47PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/03/26 3:48 pm, Manivannan Sadhasivam wrote:
> > On Tue, Mar 03, 2026 at 12:24:42PM +0530, Manikanta Maddireddy wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > LTR message should be sent as soon as the Root Port enables LTR in the
> > > Endpoint. Set snoop & no snoop LTR timing and LTR message request before
> > > PCIe links up. This ensures that LTR message is sent upstream as soon as
> > > LTR is enabled.
> > > 
> > 
> > 
> > 
> > > Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > Changes V6 -> V7: Retain FIELD_PREP() usage
> > > Changes V1 -> V6: None
> > > 
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++++++++---------
> > >   1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 2da3478f0b5f..b50229df890e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -485,15 +485,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> > >   	if (val & PCI_COMMAND_MASTER) {
> > >   		ktime_t timeout;
> > > -		/* 110us for both snoop and no-snoop */
> > > -		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
> > > -		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
> > > -		      LTR_MSG_REQ |
> > > -		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
> > > -		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
> > > -		      LTR_NOSNOOP_MSG_REQ;
> > > -		appl_writel(pcie, val, APPL_LTR_MSG_1);
> > > -
> > >   		/* Send LTR upstream */
> > >   		val = appl_readl(pcie, APPL_LTR_MSG_2);
> > >   		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
> > > @@ -1803,6 +1794,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > >   	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
> > >   	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
> > > +	/* 110us for both snoop and no-snoop */
> > > +	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
> > > +	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
> > > +	      LTR_MSG_REQ |
> > > +	      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
> > > +	      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
> > > +	      LTR_NOSNOOP_MSG_REQ;
> > 
> > As per the spec, the device is not permitted to request Snoop/No-Snoop latencies
> > greater that the Max Snoop/No-Snoop latencies set by the host depending on the
> > platform requirement.
> > 
> > But here the driver is just using a hardcoded value without reading Max values.
> > It may be assuming that the host is always going to be another NVidia platform,
> > so it sends out fixed LTR latencies, but that's not going to be true always.
> > 
> > Also, the host can update the Max latencies at any point of time during runtime.
> > 
> > - Mani
> > 
> Agree, but this patch is only addressing case where max latencies are not
> yet programmed by the host.  Without this programming Endpoint sends 0
> latencies to the host. Once host sets max latencies in the config space, HW
> compares the above latencies and the max latencies configured by host and
> sends appropriate values to the host.
> 

Okay, this should also be clarified in commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
