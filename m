Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3D481221;
	Wed, 21 Jan 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991514; cv=none; b=hGPezr1hI0ezSkfwWuAzjdlnzhI9IKNciqMIa/tH8w6eJZ48oCLeViRiOvrOk/PrkBBxSavu86tZ58xJQMX/KDG5vsFWboFAtVBCzJZp3QRywzz0yWBvuF572vltol4S7FhOjux+0LwkjQFDYpoZmMHKq0W6NvLOT4e//cg3D90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991514; c=relaxed/simple;
	bh=p1LFy6guL2aPbNSNGNxriJr6L7InPVl55N/BDO1fymY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY0wGMxcAtnqeAicvdnDR5bXAsq6W18RvrOxSar+8+IBiHn5p6g7e5uXqGAwQMAJmzBv/dWFcXVp0bjWyZJ7HbYXZrJTRQ1CWFtZ+Cq8s8KlTRig3CdSaHG5HK429pQJKu7f8PbPX1ngO5e+ecOKjrRwoIepvRdPdFCrCtiLczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx0pw5SqkzJ46C8;
	Wed, 21 Jan 2026 18:31:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id ACBF740571;
	Wed, 21 Jan 2026 18:31:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 10:31:45 +0000
Date: Wed, 21 Jan 2026 10:31:44 +0000
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
Subject: Re: [PATCH v4 01/10] cxl: move DVSEC defines to cxl pci header
Message-ID: <20260121103144.000073a3@huawei.com>
In-Reply-To: <20260120222610.2227109-2-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-2-smadhavan@nvidia.com>
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

On Tue, 20 Jan 2026 22:26:01 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> CXL DVSEC definitions are shared across PCI core and CXL drivers, so
> move the register macros into the common CXL PCI header. This keeps
> the DVSEC surface in one place and avoids duplication as the reset and
> config helpers build on these offsets and bitfields.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

These are moving in:
https://lore.kernel.org/all/20260114182055.46029-2-terry.bowman@amd.com/
However it is to the main uapi/linux/pci_regs.h file.

*fingers crossed* that should land this cycle and simplify your set a little.

Jonathan

> ---
>  drivers/cxl/core/pci.c  |  1 +
>  drivers/cxl/core/regs.c |  1 +
>  drivers/cxl/cxlpci.h    | 53 -----------------------------------
>  drivers/cxl/pci.c       |  1 +
>  include/cxl/pci.h       | 62 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 53 deletions(-)
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b023a0178a4..968babcc09a2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5ca7b0eed568..ecdb22ae6952 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 1d526bea8431..cdb7cf3dbcb4 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -7,59 +7,6 @@
> 
>  #define CXL_MEMORY_PROGIF	0x10
> 
> -/*
> - * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification. Names are taken straight from the specification with "CXL" and
> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
> - */
> -#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> -
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> -
> -#define CXL_DVSEC_RANGE_MAX		2
> -
> -/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> -#define CXL_DVSEC_FUNCTION_MAP					2
> -
> -/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> -#define CXL_DVSEC_PORT_EXTENSIONS				3
> -
> -/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
> -#define CXL_DVSEC_PORT_GPF					4
> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
> -
> -/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> -#define CXL_DVSEC_DEVICE_GPF					5
> -
> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> -
> -/* CXL 2.0 8.1.9: Register Locator DVSEC */
> -#define CXL_DVSEC_REG_LOCATOR					8
> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
> -#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
> -#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> -#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> -
>  /*
>   * NOTE: Currently all the functions which are enabled for CXL require their
>   * vectors to be in the first 16.  Use this as the default max.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3b2293dffb3f..55c767df4543 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -12,6 +12,7 @@
>  #include <linux/aer.h>
>  #include <linux/io.h>
>  #include <cxl/mailbox.h>
> +#include <cxl/pci.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..728ba0cdd289
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/*
> + * See section 8.1 Configuration Space Registers in the CXL 2.0
> + * Specification. Names are taken straight from the specification with "CXL" and
> + * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
> + */
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#define CXL_DVSEC_RANGE_MAX		2
> +
> +/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> +#define CXL_DVSEC_FUNCTION_MAP					2
> +
> +/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> +#define CXL_DVSEC_PORT_EXTENSIONS				3
> +#define   CXL_DVSEC_PORT_CTL		0xC
> +#define     CXL_DVSEC_UNMASK_SBR		BIT(0)
> +
> +/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
> +#define CXL_DVSEC_PORT_GPF					4
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
> +
> +/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> +#define CXL_DVSEC_DEVICE_GPF					5
> +
> +/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +
> +/* CXL 2.0 8.1.9: Register Locator DVSEC */
> +#define CXL_DVSEC_REG_LOCATOR					8
> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
> +#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
> +#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> +#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> +
> +#endif
> --
> 2.34.1
> 
> 

