Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbdDLPtd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 11:49:33 -0400
Date: Wed, 12 Apr 2017 10:49:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: mark.rutland@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] PCI: hisi: Fix DT binding (hisi-pcie-almost-ecam)
Message-ID: <20170412154927.GB25197@bhelgaas-glaptop.roam.corp.google.com>
References: <1490275097-39349-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490275097-39349-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 23, 2017 at 09:18:17PM +0800, Dongdong Liu wrote:
> The "hisilicon,pcie-almost-ecam", which goes against the usual DT
> conventions, and is non-sensical in that it describes the IP based on
> what it isn't. Fix the DT binding with "hisilicon,hip06-pcie-ecam"
> and "hisilicon,hip07-pcie-ecam".
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to for-linus for v4.11, thanks!

> ---
>  Documentation/devicetree/bindings/pci/hisilicon-pcie.txt | 10 ++++++++--
>  drivers/pci/dwc/pcie-hisi.c                              |  6 +++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> index b7fa3b9..a339dbb 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -44,13 +44,19 @@ Hip05 Example (note that Hip06 is the same except compatible):
>  	};
>  
>  HiSilicon Hip06/Hip07 PCIe host bridge DT (almost-ECAM) description.
> +
> +Some BIOSes place the host controller in a mode where it is ECAM
> +compliant for all devices other than the root complex. In such cases,
> +the host controller should be described as below.
> +
>  The properties and their meanings are identical to those described in
>  host-generic-pci.txt except as listed below.
>  
>  Properties of the host controller node that differ from
>  host-generic-pci.txt:
>  
> -- compatible     : Must be "hisilicon,pcie-almost-ecam"
> +- compatible     : Must be "hisilicon,hip06-pcie-ecam", or
> +		   "hisilicon,hip07-pcie-ecam"
>  
>  - reg            : Two entries: First the ECAM configuration space for any
>  		   other bus underneath the root bus. Second, the base
> @@ -59,7 +65,7 @@ host-generic-pci.txt:
>  
>  Example:
>  	pcie0: pcie@a0090000 {
> -		compatible = "hisilicon,pcie-almost-ecam";
> +		compatible = "hisilicon,hip06-pcie-ecam";
>  		reg = <0 0xb0000000 0 0x2000000>,  /*  ECAM configuration space */
>  		      <0 0xa0090000 0 0x10000>; /* host bridge registers */
>  		bus-range = <0  31>;
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index fd66a31..cf9d6a9 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -380,9 +380,13 @@ struct pci_ecam_ops hisi_pcie_platform_ops = {
>  
>  static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
>  	{
> -		.compatible = "hisilicon,pcie-almost-ecam",
> +		.compatible =  "hisilicon,hip06-pcie-ecam",
>  		.data	    = (void *) &hisi_pcie_platform_ops,
>  	},
> +	{
> +		.compatible =  "hisilicon,hip07-pcie-ecam",
> +		.data       = (void *) &hisi_pcie_platform_ops,
> +	},
>  	{},
>  };
>  
> -- 
> 1.9.1
> 
