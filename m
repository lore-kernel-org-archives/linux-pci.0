Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5A3358BA
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582704; cv=none; b=okxonEuYWyEi0F8N5f6pf7MS1D1SA+gMdS24BpYbPqvIlIxEAaMe2sInB01reIU2w8SC3ttAN5MzooXzP2yoylAQYGL7Y5iskh7IJuypvYGXHg2TFTZbBVJ7KMdnArVAfWkeuBfzFd0BdVF8ypSB3CXNZANR87U+Mx9HlkhINdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582704; c=relaxed/simple;
	bh=mKd6gsYVdB4UdneLrcbH0Y+iktTVZrdto1kBwsznBVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nvo2gPLy5OzD3dT1zheJO9rvvKCroJwXiHpuG4/HtmNqP98bD2gmiUUU/1CjjhcV9KFANlt42Ju+15/zboL80v6MH37L5m9sMPy0BVE84noAieF5qo6apnomZKca52N9EmboOtk8xTUrdwpMG3eHWz1HA5ru6t4RP5CfynnxH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ/uSeTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ/uSeTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF86C19421;
	Wed, 28 Jan 2026 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769582703;
	bh=mKd6gsYVdB4UdneLrcbH0Y+iktTVZrdto1kBwsznBVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJ/uSeTlAhh0hdfnxWu0LPTHAb0a+qu3/v1ahM/3SFmlot66dLL+yJwgrZ4rzSIos
	 +2sDxJYFom6cxVSUMCWrE1blH7t2YA1tdceOiI7z4fe8mbU0k81abV+m3NZCOKKX8N
	 gcguqhMdn4GATu9ewgf26axOhr9Vbw3SEQFLJEA2s6+JHBj3VkKa89pdfhMzbMIOM3
	 yZqJERXmSydPKJdMUVtRZMT1RWH7vvW0U7wVJg1/oUDUfzeFRUp8rAC3/FAfvXoZ5p
	 YTqi/3dGtSoEhJvq4CJVRIrxRvqARoesqWuK7sWaLdYi2MGwr683cykp+qPG5YVqdM
	 JKEVgerkNVv3w==
Message-ID: <b0921701-3ce1-4d03-9a55-436ba09b8eb2@kernel.org>
Date: Wed, 28 Jan 2026 15:40:03 +0900
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
 "Maciej W. Rozycki" <macro@orcam.me.uk>, stable+noautosel@kernel.org,
 linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260127151038.1484881-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/26 12:10 AM, Niklas Cassel wrote:
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

Looks OK to me.
(one nit below)

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



> @@ -915,8 +907,21 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	 * NOTE: For outbound address translation, outbound iATU at index 0 is
>  	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
>  	 * index 1.
> +	 *
> +	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for

s/is/are

> +	 * CFG IOs.
>  	 */
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
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;



-- 
Damien Le Moal
Western Digital Research
