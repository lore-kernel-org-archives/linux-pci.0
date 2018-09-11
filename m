Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Sep 2018 08:48:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: Change maintainer to Gustavo Pimentel
Message-ID: <20180911134817.GE250890@bhelgaas-glaptop.roam.corp.google.com>
References: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 01:06:30PM +0100, Joao Pinto wrote:
> Currently I am managing the Synopsys drivers & tools team (full-time) and so I
> am passing the pcie-designware maintenance to Gustavo.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> CC: Jingoo Han <jingoohan1@gmail.com>

Applied to for-linus for v4.19, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b..e5e8984 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11153,7 +11153,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> -M:	Joao Pinto <Joao.Pinto@synopsys.com>
> +M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
> -- 
> 2.9.3
> 
> 
