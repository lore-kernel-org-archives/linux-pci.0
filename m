Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751794AbeE3Nzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 May 2018 09:55:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UDsHmm196569
        for <linux-pci@vger.kernel.org>; Wed, 30 May 2018 09:55:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j9ve1asnw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 30 May 2018 09:55:52 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bryantly@linux.ibm.com>;
        Wed, 30 May 2018 07:55:52 -0600
Subject: Re: [PATCH v2 1/1] powerpc/pseries: fix EEH recovery of some IOV
 devices
To: Sam Bobroff <sbobroff@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: mpe@ellerman.id.au, bhelgaas@google.com,
        bryantly@linux.vnet.ibm.com
References: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
From: "Bryant G. Ly" <bryantly@linux.ibm.com>
Date: Wed, 30 May 2018 08:55:46 -0500
MIME-Version: 1.0
In-Reply-To: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <6cc94197-7b29-1a73-e9d5-f99f97e1a2c1@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 5/24/18 7:31 PM, Sam Bobroff wrote:
> EEH recovery currently fails on pSeries for some IOV capable PCI
> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> certain device tree properties for the device. (Found on an IOV
> capable device using the ipr driver.)
>
> Recovery fails in pci_enable_resources() at the check on r->parent,
> because r->flags is set and r->parent is not.  This state is due to
> sriov_init() setting the start, end and flags members of the IOV BARs
> but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing.
>
> Correct this by zeroing the resource flags for IOV BARs when they
> can't be configured.
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> Hi,
>
> This is a fix to allow EEH recovery to succeed in a specific situation,
> which I've tried to explain in the commit message.
>
> As with the RFC version, the IOV BARs are disabled by setting the resource
> flags to 0 but the other fields are now left as-is because that is what is done
> elsewhere (see sriov_init() and __pci_read_base()).
>
> I've also examined the concern raised by Bjorn Helgaas, that VFs could be
> enabled later after the BARs are disabled, and it already seems safe: enabling
> VFs (on pseries) depends on another device tree property,
> "ibm,number-of-configurable-vfs" as well as support for the RTAS function
> "ibm_map_pes". Since these are all part of the hypervisor's support for IOV it
> seems unlikely that we would ever see some of them but not all. (None are
> currently provided by QEMU/KVM.) (Additionally, the ipr driver on which the EEH
> recovery failure was discovered doesn't even seem to have SR-IOV support so it
> certainly can't enable VFs.)
>
> Cheers,
> Sam.
> ====== v1 -> v2: ======
>
> Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
> * Moved the BAR disabling code to a function.
> * Also check in pseries_pci_fixup_resources().
>
> ====== v1: ======
>
> Patch 1/1: powerpc/pseries: fix EEH recovery of IOV devices
>
>  arch/powerpc/platforms/pseries/setup.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index b55ad4286dc7..0a9e4243ae1d 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -645,6 +645,15 @@ void of_pci_parse_iov_addrs(struct pci_dev *dev, const int *indexes)
>  	}
>  }
>
> +static void pseries_disable_sriov_resources(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	pci_warn(pdev, "No hypervisor support for SR-IOV on this device, IOV BARs disabled.\n");
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> +		pdev->resource[i + PCI_IOV_RESOURCES].flags = 0;
> +}
> +
>  static void pseries_pci_fixup_resources(struct pci_dev *pdev)
>  {
>  	const int *indexes;
> @@ -652,10 +661,10 @@ static void pseries_pci_fixup_resources(struct pci_dev *pdev)
>
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -	if (!indexes)
> -		return;
> -	/* Assign the addresses from device tree*/
> -	of_pci_set_vf_bar_size(pdev, indexes);
> +	if (indexes)
> +		of_pci_set_vf_bar_size(pdev, indexes);
> +	else
> +		pseries_disable_sriov_resources(pdev);
>  }
>
>  static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
> @@ -667,10 +676,10 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
>  		return;
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -	if (!indexes)
> -		return;
> -	/* Assign the addresses from device tree*/
> -	of_pci_parse_iov_addrs(pdev, indexes);
> +	if (indexes)
> +		of_pci_parse_iov_addrs(pdev, indexes);
> +	else
> +		pseries_disable_sriov_resources(pdev);
>  }
>
>  static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,

Acked-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
