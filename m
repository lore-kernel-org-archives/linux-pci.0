Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF220ED;
	Mon, 16 Mar 2026 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631860; cv=none; b=I1QsUIuNWp0C9NHju302AXBaHp0fZMhTYADGimJ3Kt+viobWbt3E0BzMnFJvvmvy+a70j0qcMec+C5yAlp0OhXC7xMiTG2k+jFxKNfv0yOGztIw5IBz6gFdkVpDqoVaD9dpxACilAkx75nas/pwPw5oiIltJ/4WMRxk4pqhXVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631860; c=relaxed/simple;
	bh=eh+2ggFPzUJNuNykNrUdyYe8tOgYiW2yDLBJTwnCtPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgSe4Srv9dlHe29SpJ5CWF+fesap6cYu6TIxkHGLg4VvmBJvaVZl8hzBY4ZJpfwaZRN/gsKnCZgG0JTiY/IZUcat/uiUbdoGUPR9An4p4QWZByHu1x/GiwUDZ/LZNOGGBHMVCeS8kzI/EX5RpfLgiVscnp/o5EWpwvs0XQmzoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmDlrH8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmDlrH8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C32C19425;
	Mon, 16 Mar 2026 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773631860;
	bh=eh+2ggFPzUJNuNykNrUdyYe8tOgYiW2yDLBJTwnCtPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmDlrH8nHQOac2XasyowcxoU+9di5SWNLZi620a63eH+9GpQjlyCcOoJepcMYWPhw
	 GZ3/IBl6kTtUFHm+q2nV+O2cPiw+7vCB0iDwyBye1/oM6kOmnBj1+Fk/EE1ZifQSGD
	 qv3dCnaINPEt30l9cbHjvy7GWEJ/T0Tn/MtGXbxWg+7eZWB4Klt+T20OEjy/kASaCd
	 ppr9xyTnoXwTg4iVY5yaYc23XYrWoiOCwc53HaVS1khFcjoX3kUv6tv6MkiIX7dlvW
	 f3H0m/BZr+thTcWUPu/2kUDmOWvWy/xLyQ6G/k4/+IzJZ8Z/DZNIxqrCfhU6S6JbiZ
	 VNgSrLANPTx7Q==
Date: Mon, 16 Mar 2026 09:00:49 +0530
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
Subject: Re: [PATCH v7 8/9] PCI: tegra194: Add core monitor clock support
Message-ID: <mm6bvkorzs2d2vgc67hg2unvqjlhc6fg2of7ksoxactvsxahgm@6hpn7lxuoki3>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-9-mmaddireddy@nvidia.com>
 <p5eoraarj2v5oh5z4qxvixcs3whlt5vlzlgblytaeasujseupz@zjo4nufie2fy>
 <a0b424dd-6b5d-4ef6-839d-0692e2ae6155@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b424dd-6b5d-4ef6-839d-0692e2ae6155@nvidia.com>

On Sun, Mar 15, 2026 at 11:36:30PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/03/26 4:42 pm, Manivannan Sadhasivam wrote:
> > On Tue, Mar 03, 2026 at 12:27:57PM +0530, Manikanta Maddireddy wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > Tegra supports PCIe core clock monitoring for any rate changes that may be
> > > happening because of the link speed changes. This is useful in tracking
> > > any changes in the core clock that are not initiated by the software. This
> > > patch adds support to parse the monitor clock info from device-tree and
> > > enable it if present.
> > > 
> > 
> > Reword the description in imperative mood and avoid 'This patch...'.
> > 
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > Changes V1 -> V7: None
> > > 
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 070eb7f4058d..e0455d322166 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -249,6 +249,7 @@ struct tegra_pcie_dw {
> > >   	struct resource *atu_dma_res;
> > >   	void __iomem *appl_base;
> > >   	struct clk *core_clk;
> > > +	struct clk *core_clk_m;
> > >   	struct reset_control *core_apb_rst;
> > >   	struct reset_control *core_rst;
> > >   	struct dw_pcie pci;
> > > @@ -945,6 +946,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
> > >   	}
> > >   	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > +	if (clk_prepare_enable(pcie->core_clk_m))
> > > +		dev_err(pci->dev, "Failed to enable core monitor clock\n");
> > >   	return 0;
> > >   }
> > > @@ -1017,6 +1020,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
> > >   		val &= ~PCI_DLF_EXCHANGE_ENABLE;
> > >   		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
> > > +		/*
> > > +		 * core_clk_m is enabled as part of host_init callback in
> > > +		 * dw_pcie_host_init(). Disable the clock since below
> > > +		 * tegra_pcie_dw_host_init() will enable it again.
> > > +		 */
> > > +		clk_disable_unprepare(pcie->core_clk_m);
> > 
> > Again, this change should be in a separate patch.
> This patch is handling only one feature, which is enabling monitor clock.
> Monitor clock is enabled in tegra_pcie_dw_host_init(), this function is
> executed twice when handling DLFE fix, so this line is disabling the clock
> before executing tegra_pcie_dw_host_init() 2nd time.
> I think one patch is sufficient for this, otherwise it will introduce
> unbalanced clock enable error.
> 

Oh yes, brain fart. You can ignore the above comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
