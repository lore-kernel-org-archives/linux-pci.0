Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA50342160;
	Wed, 21 Jan 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991686; cv=none; b=jKvPo/fIAUrOLLAQFA3+XkPG64B0S5mYlmi50VORKHEMRQ/DqI4yilv8gZmZalPJK6vuNpOZoDjX7MBEBQJQwuq5su3anVjwfjlXYaI2ZP5teQ0qfbmSjzZv50qZwRr1jMk+ciZl5ijErppupMy9dVNFmtBfJnik/7CcKRTek78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991686; c=relaxed/simple;
	bh=GgrMcFlRB5wQqdwnzEfuoAuAkJ4ZgB9fpeaj7naaEj8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9meTQFPrcMd5yRSwL+DluOMoXXUnWHnInHdjbZ2jzXuECaSavePiEkSlGiWUrB5yFAXvI+mAwNO2Jj7RdoKp8TBWeAbhhIEd8wheUrrqpyo0Ca+l99DyVm2GKeRTCshOis8A9W8BjxyTxpTzDh3zUTjBtUUrQDucxAEk+KRgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx0t23ZvSzHnHCp;
	Wed, 21 Jan 2026 18:34:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D0E640569;
	Wed, 21 Jan 2026 18:34:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 10:34:35 +0000
Date: Wed, 21 Jan 2026 10:34:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 02/10] PCI: switch CXL port DVSEC defines
Message-ID: <20260121103433.00002ad1@huawei.com>
In-Reply-To: <20260120222610.2227109-3-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-3-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:02 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> The PCI core consumes CXL port DVSEC fields for reset handling, so
> switch it to use the shared CXL PCI header instead of the uapi header.
> This aligns the core with the header split and keeps internal code from
> depending on uapi-only definitions.

Why do you think they are uapi only?  Masses of kernel code relies on those
definitions.

Intent is to just have one source of truth for userspace tools and kernel
space ones.

Also, removing anything from those headers will probably break someone's
user space so is basically impossible to do safely.

J
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c             | 17 +++++++++--------
>  include/uapi/linux/pci_regs.h |  5 -----
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..8bb07e253646 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -30,6 +30,7 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <cxl/pci.h>
>  #include "pci.h"
> 
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -4842,7 +4843,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> -					 PCI_DVSEC_CXL_PORT);
> +					 CXL_DVSEC_PORT_EXTENSIONS);
>  }
> 
>  static bool cxl_sbr_masked(struct pci_dev *dev)
> @@ -4854,7 +4855,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	if (!dvsec)
>  		return false;
> 
> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CTL, &reg);
>  	if (rc || PCI_POSSIBLE_ERROR(reg))
>  		return false;
> 
> @@ -4863,7 +4864,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	 * bit in Bridge Control has no effect.  When 1, the Port generates
>  	 * hot reset when the SBR bit is set to 1.
>  	 */
> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
> +	if (reg & CXL_DVSEC_UNMASK_SBR)
>  		return false;
> 
>  	return true;
> @@ -4908,22 +4909,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
> 
> -	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL, &reg);
>  	if (rc)
>  		return -ENOTTY;
> 
> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
> +	if (reg & CXL_DVSEC_UNMASK_SBR) {
>  		val = reg;
>  	} else {
> -		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +		val = reg | CXL_DVSEC_UNMASK_SBR;
> +		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
>  				      val);
>  	}
> 
>  	rc = pci_reset_bus_function(dev, probe);
> 
>  	if (reg != val)
> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
>  				      reg);
> 
>  	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3add74ae2594..4f9e6dddc282 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1253,11 +1253,6 @@
>  #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
>  #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
> 
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> -
>  /* Integrity and Data Encryption Extended Capability */
>  #define PCI_IDE_CAP			0x04
>  #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> --
> 2.34.1
> 
> 

