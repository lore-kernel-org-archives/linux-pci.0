Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40995156236
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580793; cv=none; b=FaK+I8aVu8vjRfsMXp36CKvWNFK/25Q5XaNjKLBbV8m2EesGL29ULvuMYyOseF/3Va+YVdSIV1qhWUI38mFsB9SHkJvfnF/bnq5ud8+8OlrJ8UqZQLuPyJCjZ+2lr4JNHDxrArySn+qJmNE1hQxnrEaWcvxzbLFBNROGsJRL1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580793; c=relaxed/simple;
	bh=jT9WhzgxnQnkwLSYPn4UcTksmhGjeBYUVt4K+UspRpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4Oj7Rq8fzm0DqNxi+VSbyQNY379oeY/RJ/H17qfVxTC/B+/s9sR5y7IAbwwoSfnnZ8J853+bPUJUxFBBHOUrK4bthquvBhrzFwEr3+UBTDU1yGZzqrgAInfSw1PCZyRvtLtC0VDTgcLZ/2uqyV53HwMqG6RFNyR2OE13wAoPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com; spf=pass smtp.mailfrom=ecosda.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ecosda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecosda.com
X-QQ-mid: esmtpgz12t1769580719t7a23f7d0
X-QQ-Originating-IP: BsNZ+3YR15Y5ItxMOI2v3pmaVnmb2ezihpX8wcoS86M=
Received: from [192.168.51.35] ( [140.206.53.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Jan 2026 14:11:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4577222137846970871
Message-ID: <D757144492686280+d1430db0-5d2a-40ee-bf56-09ee9689035a@ecosda.com>
Date: Wed, 28 Jan 2026 14:11:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 stable+noautosel@kernel.org, linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-8-cassel@kernel.org>
Content-Language: en-US
From: Hans Zhang <zhanghuabing@ecosda.com>
In-Reply-To: <20260127151038.1484881-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ecosda.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NNF5uPB+5DRWPT0OJg2zcsrGNZxkgoq2fh25t9xHY1aIHM4QPg4iDQ2C
	oRz6lRAf/AX4iYTgjrkxF5O38KagDxOLbOqdbtvETDkWmA/hZPWkmLTrIOnLbjsr23ioynZ
	ipW0YiGfQra6VkUKKuaN5aBsJfVufjhq1osrWnzLjtvq4XPcTufgkSRV39m0RuF+6vBb5CT
	7yQPhfZq4TPLuyie4sd2bUmNmMb2cRoo+J5J8ALUlKdPyOKGt+UuEHT4fUwzpR2UU/YZeQW
	UtLfOhsUqQ7q0NcXWueewR3V4Z8PA4/5gc3av64f1hFjmP+hZTJcRrMTFIUhcEcjdcHMVsz
	UmmOMewB51jKJtu0xUP9IE9R9m4y6dQCcGgCC+Y3//HMv95/ZCm3g/xlb7ceT+UMD/vdsNq
	OJsMWoiUMLM5erCmUMOW8XjWSJ5vFU2m8q9gKlLHjW3fQJ0hBEN4RTTfoHsgnaBaV513Knw
	K5PgwwBgsLewqRiQN9xbwRhzV/oqOBwJIT7aL0rqimxRz5R8dN3CiukhNhlSlG4nrciZRn6
	1WoFFgI7qAVtpO4RK3ta7U9savVajn5yeVALNPs+U32+U+VpK+YyqaodB0KXhROkJG+2qAS
	iioJKcrby2JIX6eQEI7jcmOInCOUxjCGlJud+Cz2XWJp+74YrUJQY3+R2ys6FPblk98zfpM
	B9eaGYawWKlWgbtlK2ZoF8faF9peHpRtOao0ymOXQ3VuM9mfog7KdzlcXh5BTGRegvrOTkL
	Fp5QHn9egNxwX7fK5Ojp3cK7miGMfNQgoWCmjRCpT6UABr8lpehPLTuvXLTL5UA3031WVRF
	qLh+veUYrxtey1qfbqgoxVbi937s5WCBZHfJOwrqJ9zoPtTzZ+A4iX7o1zGkE3cdVlTZbUC
	1HICbUIV78bzDl+hkBYnfDdRAsdn9I/t93mbqTeS1Zp1+mnxmQB5YlLhDPvhItTWBjwqwdd
	13PC4Uf8Y66fhIMorQlsyQSZ3r3cKGZCj2QQesjz/FBZ/QBCVAcCCC21MsJ+GFkH5U1TKga
	zjo8O8Ok2hWjdWOFNPBs7WXYmuRplCSYITIZ2xOXvIo9+Dv1oW3DCGC5rcJm6Ftn+2xGFEC
	nwinuxORDvF
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0



On 1/27/2026 11:10 PM, Niklas Cassel wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access
> 
> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> enabled.
> 
> Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_inbound_atu() such that an error is returned if trying to
> program an iATU that is outside the number of iATUs provided by the
> controller.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Cc: stable+noautosel@kernel.org # depends on Clean up iATU index usage in dw_pcie_iatu_setup()
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>

> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++-------
>   drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
>   2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 87e6a32dbb9a..bc2e08ec515e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -641,14 +641,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (ret)
>   		goto err_free_msi;
>   
> -	if (pp->ecam_enabled) {
> -		ret = dw_pcie_config_ecam_iatu(pp);
> -		if (ret) {
> -			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> -			goto err_free_msi;
> -		}
> -	}
> -
>   	/*
>   	 * Allocate the resource for MSG TLP before programming the iATU
>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -915,8 +907,21 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   	 * NOTE: For outbound address translation, outbound iATU at index 0 is
>   	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
>   	 * index 1.
> +	 *
> +	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for
> +	 * CFG IOs.
>   	 */
> -	ob_iatu_index = 1;
> +	if (pp->ecam_enabled) {
> +		ob_iatu_index = 2;
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
> +			return ret;
> +		}
> +	} else {
> +		ob_iatu_index = 1;
> +	}
> +
>   	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>   		resource_size_t res_size;
>   
> @@ -985,8 +990,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>   			 * be shared between I/O space and CFG IOs, by
>   			 * temporarily reconfiguring the iATU to CFG space, in
>   			 * order to do a CFG IO, and then immediately restoring
> -			 * it to I/O space.
> +			 * it to I/O space. This is only implemented when using
> +			 * dw_pcie_other_conf_map_bus(), which is not the case
> +			 * when using ECAM.
>   			 */
> +			if (pp->ecam_enabled) {
> +				dev_err(pci->dev, "Cannot add outbound window for I/O\n");
> +				return -ENOMEM;
> +			}
>   			pp->cfg0_io_shared = true;
>   		}
>   	}
> @@ -1157,7 +1168,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	 * the platform uses its own address translation component rather than
>   	 * ATU, so we should not program the ATU here.
>   	 */
> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>   		ret = dw_pcie_iatu_setup(pp);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 18331d9e85be..5741c09dde7f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -532,6 +532,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>   	u32 retries, val;
>   	u64 limit_addr;
>   
> +	if (atu->index >= pci->num_ob_windows)
> +		return -ENOSPC;
> +
>   	limit_addr = parent_bus_addr + atu->size - 1;
>   
>   	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> @@ -605,6 +608,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>   	u64 limit_addr = pci_addr + size - 1;
>   	u32 retries, val;
>   
> +	if (index >= pci->num_ib_windows)
> +		return -ENOSPC;
> +
>   	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
>   	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
>   	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {


