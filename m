Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE23280318;
	Thu, 22 Jan 2026 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107056; cv=none; b=Ria+HBQ7RO/0z1LMTovhwuiKtkWahh2l6RV84WMZd2DgNYNGbZnYNz9/tIyxaDK7glI2EdMIUaHl4mosa1wu6jD429yqE60obMgHHVWYOLZEZGYPLuYqzAz4UEKqd1FLli7eceXisOskbMlqzD/8Bqt6+xv1DFLsiByGfF5o/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107056; c=relaxed/simple;
	bh=KlU7uY4kEYOZ9bah3d+bUMYIIAbJLRQ4l2xL0sI3MuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sVus2Egj5z/c+qSJyLuy3aTbrpaex2O8Tb5ZqK5A7eFkCkXUowVMhE6HYlCshP6Cfm4dygbhCFhh/DuDnFISTE1ZJZ3spmHg+GwlrvVwkXuM2Vmg9YS+MyLkCEcW6ZKLZUvOkT3DCUgJJbTXZfF1lzTIx3LrK9WZI/YMiuu+T4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdhrveOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdhrveOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1BC116C6;
	Thu, 22 Jan 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769107054;
	bh=KlU7uY4kEYOZ9bah3d+bUMYIIAbJLRQ4l2xL0sI3MuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sdhrveOKLdbe7/XezUCOF9XoLXFdOjX6JS0BRH33eS52rj6AxDD8ON5uHwq9Xsy1Z
	 MyskEQepZhLjMmK7PkzCEz9h6ROgGipX8xq5R9HoZlxAXFsz0eM0n8/bzPkXbLWcZ8
	 o1mS8iKdbkWyzag+C0SnS3BjCXX+5D/+wKmlhTqqY6g8u/Zfp91fuH0p7bz0nZGr0D
	 MKgIXkCJQHhRENnvZxjcv/4Z/EyhDt8/MXc9rCJYn8ZRwcdADLj8QjjbCqrD8JDpeN
	 9oXzXa/swfIMEtCTxWD1zPVjSsTx45nFT/+mHYTinGVK/9FPiqAmn3sKpqk0w6sGXB
	 WLKtMxPf77KZw==
Date: Thu, 22 Jan 2026 12:37:33 -0600
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
Subject: Re: [PATCH v14 02/34] PCI: Update CXL DVSEC definitions
Message-ID: <20260122183733.GA17357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-3-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:23PM -0600, Terry Bowman wrote:
> CXL DVSEC definitions were recently moved into uapi/pci_regs.h, but the
> newly added macros do not follow the file's existing naming conventions.
> The current format uses CXL_DVSEC_XYZ, while the new CXL entries must
> instead use the PCI_DVSEC_CXL_XYZ prefix to match the conventions already
> established in pci_regs.h.
> 
> The new CXL DVSEC macros also introduce _MASK and _OFFSET suffixes, which
> are not used anywhere else in the file. These suffixes lengthen the
> identifiers and reduce readability. Remove _MASK and _OFFSET from the
> recently added definitions.
> 
> Additionally, remove PCI_DVSEC_HEADER1_LENGTH, as it duplicates the existing
> PCI_DVSEC_HEADER1_LEN() macro.
> 
> Update all existing references to use the new macro names.
> 
> Finally, update the inline documentation to reference the latest revision
> of the CXL specification.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I do agree that PCI_DVSEC_CXL_CAP seems possibly a little too generic
given that there may be more CXL-related DVSECs, so I like Jonathan's
PCI_DVSEC_CXL_DEVICE_CAP idea.

Keep my ack either way.

> ---
> 
> Changes in v13->v14:
> - New patch. Split from previous patch such that there is now a separate
>   move patch and a format fix patch.
> - Formatting update requested (Bjorn)
> - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
>   PCI_DVSEC_HEADER1_LEN() (Bjorn)
> - Add Dan's review-by
> ---
>  drivers/cxl/core/pci.c        | 58 ++++++++++-----------
>  drivers/cxl/core/regs.c       | 14 +++---
>  drivers/cxl/pci.c             |  2 +-
>  include/uapi/linux/pci_regs.h | 94 ++++++++++++++++-------------------
>  4 files changed, 81 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b023a0178a4..077b386e0c8d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -86,12 +86,12 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  	i = 1;
>  	do {
>  		rc = pci_read_config_dword(pdev,
> -					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> +					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
>  					   &temp);
>  		if (rc)
>  			return rc;
>  
> -		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
>  		if (valid)
>  			break;
>  		msleep(1000);
> @@ -121,11 +121,11 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  	/* Check MEM ACTIVE bit, up to 60s timeout by default */
>  	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
>  		if (rc)
>  			return rc;
>  
> -		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> +		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
>  		if (active)
>  			break;
>  		msleep(1000);
> @@ -154,11 +154,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> -				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> +				  d + PCI_DVSEC_CXL_CAP, &cap);
>  	if (rc)
>  		return rc;
>  
> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
>  	for (i = 0; i < hdm_count; i++) {
>  		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>  		if (rc)
> @@ -186,16 +186,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	u16 ctrl;
>  	int rc;
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc < 0)
>  		return rc;
>  
> -	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
>  		return 1;
> -	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
> +	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>  	ctrl |= val;
>  
> -	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> +	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -211,7 +211,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
> +	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
>  	if (rc < 0)
>  		return rc;
>  	if (rc > 0)
> @@ -273,11 +273,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		return -ENXIO;
>  	}
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
>  	if (rc)
>  		return rc;
>  
> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
>  	}
> @@ -288,7 +288,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * driver is for a spec defined class code which must be CXL.mem
>  	 * capable, there is no point in continuing to enable CXL.mem.
>  	 */
> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> @@ -297,11 +297,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * disabled, and they will remain moot after the HDM Decoder
>  	 * capability is enabled.
>  	 */
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
>  		return rc;
>  
> -	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> +	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
>  	if (!info->mem_enabled)
>  		return 0;
>  
> @@ -314,35 +314,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			return rc;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
>  			return rc;
>  
>  		size = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
>  		if (rc)
>  			return rc;
>  
> -		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> +		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW;
>  		if (!size) {
>  			continue;
>  		}
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
>  		if (rc)
>  			return rc;
>  
>  		base = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
>  		if (rc)
>  			return rc;
>  
> -		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> +		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW;
>  
>  		info->dvsec_range[ranges++] = (struct range) {
>  			.start = base,
> @@ -1068,7 +1068,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>  		is_port = false;
>  
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
>  	if (!dvsec)
>  		dev_warn(dev, "%s GPF DVSEC not present\n",
>  			 is_port ? "Port" : "Device");
> @@ -1084,14 +1084,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  
>  	switch (phase) {
>  	case 1:
> -		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> -		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> -		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL;
> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE;
> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE;
>  		break;
>  	case 2:
> -		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> -		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> -		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL;
> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE;
> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE;
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5ca7b0eed568..a010b3214342 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
>  static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  				struct cxl_register_map *map)
>  {
> -	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> -	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID, reg_lo);
> +	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR, reg_lo);
>  	u64 offset = ((u64)reg_hi << 32) |
> -		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
>  
>  	if (offset > pci_resource_len(pdev, bar)) {
>  		dev_warn(&pdev->dev,
> @@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -					   CXL_DVSEC_REG_LOCATOR);
> +					   PCI_DVSEC_CXL_REG_LOCATOR);
>  	if (!regloc)
>  		return -ENXIO;
>  
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> -	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +	regloc_size = PCI_DVSEC_HEADER1_LEN(regloc_size);
>  
> -	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> -	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> +	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1;
> +	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1) / 8;
>  
>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0be4e508affe..b7f694bda913 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  	cxlds->serial = pci_get_dsn(pdev);
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
>  	if (!cxlds->cxl_dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 6c4b6f19b18e..662582bdccf0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1333,63 +1333,57 @@
>  #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
>  #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> -
>  /*
> - * Compute Express Link (CXL r3.2, sec 8.1)
> + * Compute Express Link (CXL r4.0, sec 8.1)
>   *
>   * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> - * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * is "disconnected" (CXL r4.0, sec 9.12.3). Re-enumerate these
>   * registers on downstream link-up events.
>   */
> -#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> -
> -/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE				0
> -#define  CXL_DVSEC_CAP_OFFSET				0xA
> -#define   CXL_DVSEC_MEM_CAPABLE				_BITUL(2)
> -#define   CXL_DVSEC_HDM_COUNT_MASK			__GENMASK(5, 4)
> -#define  CXL_DVSEC_CTRL_OFFSET				0xC
> -#define   CXL_DVSEC_MEM_ENABLE				_BITUL(2)
> -#define  CXL_DVSEC_RANGE_SIZE_HIGH(i)			(0x18 + (i * 0x10))
> -#define  CXL_DVSEC_RANGE_SIZE_LOW(i)			(0x1C + (i * 0x10))
> -#define   CXL_DVSEC_MEM_INFO_VALID			_BITUL(0)
> -#define   CXL_DVSEC_MEM_ACTIVE				_BITUL(1)
> -#define   CXL_DVSEC_MEM_SIZE_LOW_MASK			__GENMASK(31, 28)
> -#define  CXL_DVSEC_RANGE_BASE_HIGH(i)			(0x20 + (i * 0x10))
> -#define  CXL_DVSEC_RANGE_BASE_LOW(i)			(0x24 + (i * 0x10))
> -#define   CXL_DVSEC_MEM_BASE_LOW_MASK			__GENMASK(31, 28)
> +
> +/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE				0
> +#define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
> +#define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
> +#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
>  
>  #define CXL_DVSEC_RANGE_MAX				2
>  
> -/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
> -#define CXL_DVSEC_FUNCTION_MAP				2
> -
> -/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
> -#define CXL_DVSEC_PORT					3
> -#define   CXL_DVSEC_PORT_CTL				0x0c
> -#define    CXL_DVSEC_PORT_CTL_UNMASK_SBR		0x00000001
> -
> -/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
> -#define CXL_DVSEC_PORT_GPF				4
> -#define  CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET	0x0C
> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK	__GENMASK(3, 0)
> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK	__GENMASK(11, 8)
> -#define  CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET	0xE
> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK	__GENMASK(3, 0)
> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK	__GENMASK(11, 8)
> -
> -/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
> -#define CXL_DVSEC_DEVICE_GPF				5
> -
> -/* CXL 3.2 8.1.9: Register Locator DVSEC */
> -#define CXL_DVSEC_REG_LOCATOR				8
> -#define  CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET		0xC
> -#define   CXL_DVSEC_REG_LOCATOR_BIR_MASK		__GENMASK(2, 0)
> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK	__GENMASK(31, 16)
> +/* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
> +#define PCI_DVSEC_CXL_FUNCTION_MAP			2
> +
> +/* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
> +#define PCI_DVSEC_CXL_PORT				3
> +#define  PCI_DVSEC_CXL_PORT_CTL				0x0c
> +#define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +
> +/* CXL r4.0, 8.1.6: GPF DVSEC for CXL Port */
> +#define PCI_DVSEC_CXL_PORT_GPF				4
> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL		0x0C
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE	__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE	__GENMASK(11, 8)
> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL		0xE
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE	__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE	__GENMASK(11, 8)
> +
> +/* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE_GPF			5
> +
> +/* CXL r4.0, 8.1.9: Register Locator DVSEC */
> +#define PCI_DVSEC_CXL_REG_LOCATOR			8
> +#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR			__GENMASK(2, 0)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
>  
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.34.1
> 
