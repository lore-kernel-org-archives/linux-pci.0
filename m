Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Stephen Warren' <swarren@wwwdotorg.org>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"mturquette@linaro.org" <mturquette@linaro.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Fri, 12 Apr 2013 20:28:30 +0530
Subject: RE: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B36FB2FD@BGMAIL01.nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <51630852.1000107@wwwdotorg.org>
In-Reply-To: <51630852.1000107@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >  	err = regulator_disable(pcie->pex_clk_supply);
> >  	if (err < 0)
> > -		dev_err(pcie->dev, "failed to disable pex-clk regulator:
> %d\n",
> > +		dev_warn(pcie->dev, "failed to disable pex-clk regulator:
> %d\n",
> >  			err);
> >
> >  	err = regulator_disable(pcie->vdd_supply);
> >  	if (err < 0)
> > -		dev_err(pcie->dev, "failed to disable VDD regulator: %d\n",
> > +		dev_warn(pcie->dev, "failed to disable VDD regulator:
> %d\n",
> >  			err);
> 
> Please explain why that change is correct. If the regulators only exist on
> Tegra20, please represent that fact in the SoC data. Regulators must always
> exist, so enable/disable should never fail due to missing regulators. Actual
> run-time failures seem like something that really is an error.
> 
[>] These regulators are needed for both tegra20 & tegra30. Since we are not returning error here, so changed to dev_warn.

