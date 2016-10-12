Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Oct 2016 05:42:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 02/11] pci: endpoint: introduce configfs entry for
 configuring EP functions
Message-ID: <20161012124210.GB942@infradead.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-3-git-send-email-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <1473829927-20466-3-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao.Pinto@synopsys.com,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Joao Pinto <jpinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 hch@infradead.org, m-karicheri2@ti.com, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, mingkai.hu@nxp.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 10:41:58AM +0530, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index a6d827c..f1dd206 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -13,7 +13,9 @@ config PCI_ENDPOINT
>  
>  	   Enabling this option will build the endpoint library, which
>  	   includes endpoint controller library and endpoint function
> -	   library.
> +	   library. This will also enable the configfs entry required to
> +	   configure the endpoint function and used to bind the
> +	   function with a endpoint controller.
>  
>  	   If in doubt, say "N" to disable Endpoint support.

This needs to grow a

	depends on CONFIGFS_FS

> +/**
> + * pci-ep-cfs.c - configfs to configure the PCI endpoint

Please don't use the file name in the top of the file comment, it's
only bound to get out of date..

> +struct pci_epf_info {
> +	struct config_item pci_epf;
> +	struct pci_epf *epf;
> +};

Any reason not to simply embedd the config_item into the pci_epf structure?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
