Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8914F112;
	Mon, 16 Mar 2026 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773624865; cv=none; b=XHJ/EkMCDSbPSq8lld9Ne0kskvrNGCmJNJsvqd9AzO1LKXJywpgGyUNkydA+apy+09k/z6xgmhiHsmeDlYlt6I81a2jWHNl0QbNLf8EfW7M8uutKZ9ub1NTD7TxMWAGsPGLvX6F3TSIL/NYrJequl+alg9iWogMeKjP7LUOAVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773624865; c=relaxed/simple;
	bh=sh9VGbG06AmkEsTW0w9Dj5wk0bvcHTXybJaPoqCrN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/CtXS9gDZHCNEWM6wwKf+CsBnARcDBmLNklfUrEJ9WwPXxm0bfqs02Jl4ADdLM1Yk7grYuVCyglGFBYb8xYp27vHPlH0xCkajKsjuRkF2N205hYPESuyRNoLCE3l3mVfA9J48o4/QT69b0kbzs9wOBnjhXISXhPq1wDaIGXfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+N8sMFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+N8sMFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D38C4CEF7;
	Mon, 16 Mar 2026 01:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773624865;
	bh=sh9VGbG06AmkEsTW0w9Dj5wk0bvcHTXybJaPoqCrN4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+N8sMFPn8NFRXlQaeT9/y4QrCdU+m2Ga/ZpTzWHqCFnLYSOoP7RQvgD+4CiQ8IvO
	 5d5za/mcxMXc3lLqL5BtkN4VFqAOaLZGXC4V7Y/UD+6B9OFZp2I0DoG5Ylyf/faIxh
	 hZpWJUjdElBBTiOUeyLQ+QSVYlN273aVD8T4h2BxzPhlRSCwu8GiKyoiqVg5PUZ3lh
	 RcSdy68HqY6CtSlocWb2K2OTBmRMLtBAcjcgoS9I5Mh4XwfGqPRPAGuabezmHrg4NG
	 axlbFDuRuUT1Fw2F+wQ1GSZGUx97SJzX8nQrAu/7LCJk6iuWGXydSqqb+VTPNTTZ/Z
	 yjRYLeS7g2SFw==
Date: Mon, 16 Mar 2026 07:04:07 +0530
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
Subject: Re: [PATCH v7 09/13] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
Message-ID: <disyrnus5ev37t7ysyr62nte4k3v2t7dmilubq4rms7hm25gbk@7vio6e7gb3zr>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-10-mmaddireddy@nvidia.com>
 <f556ofs7s7d3tzcefxhwqalzz3z6mmj3pc22frqii4ozkoseit@mbo43kjsvbwz>
 <95798840-8104-4fbe-a373-f33e30064d6e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95798840-8104-4fbe-a373-f33e30064d6e@nvidia.com>

On Sun, Mar 15, 2026 at 07:40:04PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/03/26 3:59 pm, Manivannan Sadhasivam wrote:
> > On Tue, Mar 03, 2026 at 12:24:44PM +0530, Manikanta Maddireddy wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > Only a Root Port initiates the L2 sequence. PCIe link is kept in L2 state
> > 
> > It is not Root Port, it is the host software which initiates the L2 entry
> > sequence.
> > 
> > And L2 is only guaranteed if the Vaux is available.
> > 
> I will fix the commit message.
> 
> > > during suspend. If Endpoint mode is enabled and the link is up, the
> > > software cannot proceed with suspend. However, when the PCIe Endpoint
> > > driver is probed, but the PCIe link is not up, Tegra can go into suspend
> > > state. So, allow system to suspend in this case.
> > > 
> > > Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > Changes V1 -> V7: None
> > > 
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
> > >   1 file changed, 25 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 5b79d3c28ba6..b2794be35cfe 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -2267,16 +2267,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
> > >   		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
> > >   }
> > > -static int tegra_pcie_dw_suspend_late(struct device *dev)
> > > +static int tegra_pcie_dw_suspend(struct device *dev)
> > >   {
> > >   	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> > > -	u32 val;
> > >   	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> > > -		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
> > > -		return -EPERM;
> > > +		if (pcie->ep_state == EP_STATE_ENABLED) {
> > > +			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
> > > +			return -EPERM;
> > > +		}
> > > +
> > > +		disable_irq(pcie->pex_rst_irq);
> > 
> > So you just disable PERST# IRQ during suspend? And even if the host deasserts
> > PERST#, EP is not going to wakeup?
> > 
> > Technically it is possible that whenever the EP wakes up, it will see PERST# IRQ
> > since PERST# is level triggered, but it just sounds dumb to let the endpoint
> > sleep after host deasserting PERST#.
> > 
> > - Mani
> > 
> I need to check if PERST# line in Tegra has wake feature and corresponding
> PMC changes are available. Anyway adding wake feature will be separate
> patch. In this current patch, I am trying to reduce the impact of Endpoint
> on suspend. If Endpoint is never initialized I don't see a reason to block
> suspend. Are you OK with this current patch to reduce the impact on suspend?
> Or do you have any suggestions?
> 

Fine with me. I was just checking the possibility of waking the endpoint during
PERST# deassert.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
