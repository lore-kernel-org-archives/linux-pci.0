Return-Path: <SRS0=wz13=HA=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=wz13=HA=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Workaround hardware bugs in ACS functionality by
 implementing it as a quirk
To: James Puthukattukaran <james.puthukattukaran@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
References: <e6a55432-8c56-9c99-ce99-4ae80a0ed3ba@oracle.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1ee75028-6f58-399c-b772-cf2d5d3c617c@codeaurora.org>
Date: Wed, 11 Apr 2018 12:57:46 -0400
MIME-Version: 1.0
In-Reply-To: <e6a55432-8c56-9c99-ce99-4ae80a0ed3ba@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/11/2018 11:58 AM, James Puthukattukaran wrote:
> 
> There are bugs in ACS implementations by certain switch vendors that cause ACS violations in perfectly normal accesses. This patch provides the framework for enabling and disabling the functionality at certain points during endpoint bringup in the form of a quirk.
> 
> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>

Small nits below. Need to see what Bjorn and Alex to say about this.

>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6f..0c93b3e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2097,21 +2097,44 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>      return true;
>  }
> 
> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>                  int timeout)
>  {

There is no point in changing this function contents now. Just change the header
in this code. Please revert your other changes in this function.


> +
> +
> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +                int timeout)
> +{
> +    bool ret;
> +    int enable = -1;

no need for initialization.

> +
> +    enable = pci_bus_specific_acs_quirk(bus, devfn, false, false);
> +
> +    ret = __pci_bus_read_dev_vendor_id(bus, devfn, l, timeout);
> +
> +    if (enable > 0)
> +        pci_bus_specific_acs_quirk(bus, devfn, enable, ret);
> +
> +    return ret;
>  }

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
