Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06034EF02;
	Thu, 22 Jan 2026 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108330; cv=none; b=r1cy8waAmGekIzEr1Nj8kIU4D/07rvNAN8RSWgwAs2l7MdqK33qpQM8YR4wub33m5+8H5gYT3qkJ41tEZP/9AQRzhnVDWayLyPBYDd7TXQMfqkNiFCU/ISGpsdf114oZvbyxF47kMEfhMfnljzI5R15OLBsoA0Xk9FD2GZ5o/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108330; c=relaxed/simple;
	bh=xiwxQP9YVaQ4UDNDTrIloPNh+bXc8i3QSpGEZBDwKmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kmuCUISZuY2yId5ovhgsWyYdq8dUvNk3nWAHi7R8vfxuhk1FIy981M2tmIW4kWfHr0X/jLHAl2dcV19bJRcSTuSKSt0GFUb5H1bhzqUQTC9cF3TwDwU9pZK+B5BfhdwHL3SFImuq0vwE3W65dVu+W3iSyK9VlOQBSxbafN9RNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdHuHS57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdHuHS57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFCC116C6;
	Thu, 22 Jan 2026 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108328;
	bh=xiwxQP9YVaQ4UDNDTrIloPNh+bXc8i3QSpGEZBDwKmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jdHuHS57uSCrc/shmx9VKJTWGcsP0/d4LmWCEBL4wg9cGqUNt6nSHMaGysElurMaC
	 eS0YNZ/sAhga+kDy4lZ0/ImHEggq79hlmTwfOfk2EA6/cZOuC1wCu+Iha4xIH9/+8S
	 Sq/tTC+5CX223QIPXPIak+n6b6MNn/Hd83OUcflGVy8dEihMWKau3QOqxEBbX4hm6m
	 iqm4iO+QWVK3RT3hPXkeIcxiCAHlajcNsno5RpedNNX0xdr2ocmABIMsR2ofYPllPY
	 HRN7ACYZdZ73zxmznzkAlbQgIi95kjxYX4h1zhvk5QxxzZ3sZzYZnM9h87oVdgxL+5
	 nkm1FlSAMKPcg==
Date: Thu, 22 Jan 2026 12:58:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 01/34] PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20260122185847.GA36294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-2-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:22PM -0600, Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.

I'm looking a little bit askance at adding things to
uapi/linux/pci_regs.h and then renaming them.  I know it's OCD to
worry about that momentary blip, but changes in uapi potentially break
userspace.

Maybe we could rename them first, then move them to pci_regs.h?

Either way:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> The CXL DVSEC definitions will be renamed and reformatted to fit better
> with existing defines.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ----
> 
> Changes in v13->v14:
> - Add Jonathan's and Dan's review-by
> - Update commit title prefix (Bjorn)
> - Revert format fix for cxl_sbr_masked() (Jonathan)
> - Update 'Compute Express Link' comment block (Jonathan)
> - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
>   used (Jonathan)
> - Removed stray change (Bjorn)
> 
> Changes in v12->v13:
> - Add Dave Jiang's reviewed-by
> - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
>   message. (Jonathan)
> 
> Changes in v11 -> v12:
> - Change formatting to be same as existing definitions
> - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
> 
> Changes in v10 -> v11:
> - New commit
> ---
>  drivers/cxl/cxlpci.h          | 53 -----------------------------
>  include/uapi/linux/pci_regs.h | 64 ++++++++++++++++++++++++++++++++---
>  2 files changed, 59 insertions(+), 58 deletions(-)
> 
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
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3add74ae2594..6c4b6f19b18e 100644
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
> @@ -1338,4 +1333,63 @@
>  #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
>  #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
>  
> +/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +#define PCI_DVSEC_CXL_PORT				3
> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +
> +/*
> + * Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> +
> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE				0
> +#define  CXL_DVSEC_CAP_OFFSET				0xA
> +#define   CXL_DVSEC_MEM_CAPABLE				_BITUL(2)
> +#define   CXL_DVSEC_HDM_COUNT_MASK			__GENMASK(5, 4)
> +#define  CXL_DVSEC_CTRL_OFFSET				0xC
> +#define   CXL_DVSEC_MEM_ENABLE				_BITUL(2)
> +#define  CXL_DVSEC_RANGE_SIZE_HIGH(i)			(0x18 + (i * 0x10))
> +#define  CXL_DVSEC_RANGE_SIZE_LOW(i)			(0x1C + (i * 0x10))
> +#define   CXL_DVSEC_MEM_INFO_VALID			_BITUL(0)
> +#define   CXL_DVSEC_MEM_ACTIVE				_BITUL(1)
> +#define   CXL_DVSEC_MEM_SIZE_LOW_MASK			__GENMASK(31, 28)
> +#define  CXL_DVSEC_RANGE_BASE_HIGH(i)			(0x20 + (i * 0x10))
> +#define  CXL_DVSEC_RANGE_BASE_LOW(i)			(0x24 + (i * 0x10))
> +#define   CXL_DVSEC_MEM_BASE_LOW_MASK			__GENMASK(31, 28)
> +
> +#define CXL_DVSEC_RANGE_MAX				2
> +
> +/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
> +#define CXL_DVSEC_FUNCTION_MAP				2
> +
> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
> +#define CXL_DVSEC_PORT					3
> +#define   CXL_DVSEC_PORT_CTL				0x0c
> +#define    CXL_DVSEC_PORT_CTL_UNMASK_SBR		0x00000001
> +
> +/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
> +#define CXL_DVSEC_PORT_GPF				4
> +#define  CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET	0x0C
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK	__GENMASK(3, 0)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK	__GENMASK(11, 8)
> +#define  CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET	0xE
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK	__GENMASK(3, 0)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK	__GENMASK(11, 8)
> +
> +/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
> +#define CXL_DVSEC_DEVICE_GPF				5
> +
> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
> +#define CXL_DVSEC_REG_LOCATOR				8
> +#define  CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET		0xC
> +#define   CXL_DVSEC_REG_LOCATOR_BIR_MASK		__GENMASK(2, 0)
> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK	__GENMASK(31, 16)
> +
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.34.1
> 
