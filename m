Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 06/26] edd: deprecate pci_get_bus_and_slot()
To: linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-7-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <43c72767-7e12-3fc8-b857-460c53c360c9@codeaurora.org>
Date: Wed, 3 Jan 2018 07:48:20 -0500
MIME-Version: 1.0
In-Reply-To: <1513661883-28662-7-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, gregkh@suse.de,
 open list <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org,
 hpa@linux.intel.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Domain number is not available in struct edd_info. Hard-coding the domain
> number as 0.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/firmware/edd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
> index e229576..60a8f13 100644
> --- a/drivers/firmware/edd.c
> +++ b/drivers/firmware/edd.c
> @@ -669,10 +669,10 @@ static void edd_release(struct kobject * kobj)
>  	struct edd_info *info = edd_dev_get_info(edev);
>  
>  	if (edd_dev_is_type(edev, "PCI") || edd_dev_is_type(edev, "XPRS")) {
> -		return pci_get_bus_and_slot(info->params.interface_path.pci.bus,
> -				     PCI_DEVFN(info->params.interface_path.pci.slot,
> -					       info->params.interface_path.pci.
> -					       function));
> +		return pci_get_domain_bus_and_slot(0,
> +				info->params.interface_path.pci.bus,
> +				PCI_DEVFN(info->params.interface_path.pci.slot,
> +				info->params.interface_path.pci.function));
>  	}
>  	return NULL;
>  }
> 

Any feedback here? most of the remaining patches have the ACK except these.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
