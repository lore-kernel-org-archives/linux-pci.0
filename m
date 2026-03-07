Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6B7263B;
	Sat,  7 Mar 2026 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849049; cv=none; b=EuRIIuHIkGYFpu5tSymRgaxp+s6WvKo/5V0iMSK/MXXHLDpP1EQzpyLAnIkDRpHr9iuIkxTVlZAKVI3gu3kBMN5iu4/ZV173cihUSXefZ4vdbHw+wB8O+9tp7yqfl3w9qswDLjXF3ps4fhc+mP6KUgHkKzE4GAlNQiPJjfyNbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849049; c=relaxed/simple;
	bh=jVl4QGQR8+geNXh8IDeiqAfACIOfEGtxx2VA2gRSsOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7U4hrtSe0iwxkvnDJTRNMgcY9zm2+pJsdcrzQsWYOHHR/2+reHU5ja2rxLUKNlA3hqjbvX7zHxDmkXNy9IEC7BKY7HIucUPRvjpeJtJVfHUutKVoY2PBFeUGA8X/ujLji+UiPcK0kmTyuK3c1seBeT3JQ9gvA6HTahSbXbpFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UdiVs7j9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UdiVs7j9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=V5CTttFS8UvEClJKhqB9Y8uqbhRTv3BkZD3I8qCcSqA=;
	b=UdiVs7j9clBI1/D2iwNpxcDyBsKG1XIdOGtmu0wBI8QbsX9QwZKx2J6YUx8s8R
	ny5pXCVJ1L2BKrEzML19jdkMn46CJjbGy1xKhEBNZxUPygDJLDVOqiCAPM2AckOa
	891Xlo6SaEkistrdl8xlkDpUo8dl4j7ANfYmLUSnsLRtI=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3_y2Bh6tp1ipDOg--.27363S2;
	Sat, 07 Mar 2026 10:03:45 +0800 (CST)
Message-ID: <0ba99020-3d4f-4526-8ef9-ab5a1225f707@163.com>
Date: Sat, 7 Mar 2026 10:03:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dwc: Add PCIe event counters for groups 5 to 7 in
 DWC debugfs
To: lpieralisi@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng Xin <chengqin195275@126.com>
References: <20260307020152.1224518-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260307020152.1224518-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3_y2Bh6tp1ipDOg--.27363S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4UKw1ktFyxZryDXr1DZFb_yoWrAw4fp3
	yqyr4xKF40qr13urnrWas8GrykZFWkXr97Gwsxu3sxWFnxurn8Jr13Kr4Uury8GrW0qr1Y
	vFy7tryUGry5t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Una9-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AFH6mmrh4F+FQAA3v

[+cc Shawn]

On 3/7/26 10:01, Hans Zhang wrote:
> Extend the DesignWare PCIe controller's debugfs statistical counter
> interface with event definitions from groups 5 through 7 as documented
> in the DWC PCIe Databook (version 6.30a, section 3.8.2.3, Tables 3-59,
> 3-60, 3-61). These counters provide visibility into Layer1 non-error
> events (link state transitions,ASPM, L1 substates), Layer2 DLLP
> exchanges, and Layer3 TLP transactions.
> 
> The counters are exposed under the debugfs statistical counter directory,
> allowing users to monitor link behavior and diagnose PCIe protocol issues
> more effectively.
> 
> Co-developed-by: Cheng Xin <chengqin195275@126.com>
> Signed-off-by: Cheng Xin <chengqin195275@126.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Thank you, Cheng Xin, for providing the 6.30a version of the DWC PCIe Data Book.
> 
> Changes for v3:
> - Correct the incorrect version information of the databook. Thank you, Shawn, for the reminder.
> 
> Changes for v2:
> - Sorry, I sent the patch multiple times in a row. The first version of
>    the email was incorrect. The email address of Cheng Xin has been corrected.
> ---
>   .../controller/dwc/pcie-designware-debugfs.c  | 52 ++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index 0d1340c9b364..2efddb21b2b2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -131,13 +131,16 @@ static const u32 err_inj_type_mask[] = {
>    *				   supported in DWC RAS DES
>    * @name: Name of the error counter
>    * @group_no: Group number that the event belongs to. The value can range
> - *	      from 0 to 4
> + *	      from 0 to 7
>    * @event_no: Event number of the particular event. The value ranges are:
>    *		Group 0: 0 - 10
>    *		Group 1: 5 - 13
>    *		Group 2: 0 - 7
>    *		Group 3: 0 - 5
>    *		Group 4: 0 - 1
> + *		Group 5: 0 - 13
> + *		Group 6: 0 - 6
> + *		Group 7: 0 - 25
>    */
>   struct dwc_pcie_event_counter {
>   	const char *name;
> @@ -181,6 +184,53 @@ static const struct dwc_pcie_event_counter event_list[] = {
>   	{"completion_timeout", 0x3, 0x5},
>   	{"ebuf_skp_add", 0x4, 0x0},
>   	{"ebuf_skp_del", 0x4, 0x1},
> +	{"l0_to_recovery_entry", 0x5, 0x0},
> +	{"l1_to_recovery_entry", 0x5, 0x1},
> +	{"tx_l0s_entry", 0x5, 0x2},
> +	{"rx_l0s_entry", 0x5, 0x3},
> +	{"aspm_l1_reject", 0x5, 0x4},
> +	{"l1_entry", 0x5, 0x5},
> +	{"l1_cpm", 0x5, 0x6},
> +	{"l1.1_entry", 0x5, 0x7},
> +	{"l1.2_entry", 0x5, 0x8},
> +	{"l1_short_duration", 0x5, 0x9},
> +	{"l1.2_abort", 0x5, 0xa},
> +	{"l2_entry", 0x5, 0xb},
> +	{"speed_change", 0x5, 0xc},
> +	{"link_width_change", 0x5, 0xd},
> +	{"tx_ack_dllp", 0x6, 0x0},
> +	{"tx_update_fc_dllp", 0x6, 0x1},
> +	{"rx_ack_dllp", 0x6, 0x2},
> +	{"rx_update_fc_dllp", 0x6, 0x3},
> +	{"rx_nullified_tlp", 0x6, 0x4},
> +	{"tx_nullified_tlp", 0x6, 0x5},
> +	{"rx_duplicate_tlp", 0x6, 0x6},
> +	{"tx_memory_write", 0x7, 0x0},
> +	{"tx_memory_read", 0x7, 0x1},
> +	{"tx_configuration_write", 0x7, 0x2},
> +	{"tx_configuration_read", 0x7, 0x3},
> +	{"tx_io_write", 0x7, 0x4},
> +	{"tx_io_read", 0x7, 0x5},
> +	{"tx_completion_without_data", 0x7, 0x6},
> +	{"tx_completion_w_data", 0x7, 0x7},
> +	{"tx_message_tlp_pcie_vc_only", 0x7, 0x8},
> +	{"tx_atomic", 0x7, 0x9},
> +	{"tx_tlp_with_prefix", 0x7, 0xa},
> +	{"rx_memory_write", 0x7, 0xb},
> +	{"rx_memory_read", 0x7, 0xc},
> +	{"rx_configuration_write", 0x7, 0xd},
> +	{"rx_configuration_read", 0x7, 0xe},
> +	{"rx_io_write", 0x7, 0xf},
> +	{"rx_io_read", 0x7, 0x10},
> +	{"rx_completion_without_data", 0x7, 0x11},
> +	{"rx_completion_w_data", 0x7, 0x12},
> +	{"rx_message_tlp_pcie_vc_only", 0x7, 0x13},
> +	{"rx_atomic", 0x7, 0x14},
> +	{"rx_tlp_with_prefix", 0x7, 0x15},
> +	{"tx_ccix_tlp", 0x7, 0x16},
> +	{"rx_ccix_tlp", 0x7, 0x17},
> +	{"tx_deferrable_memory_write_tlp", 0x7, 0x18},
> +	{"rx_deferrable_memory_write_tlp", 0x7, 0x19},
>   };
>   
>   static ssize_t lane_detect_read(struct file *file, char __user *buf,
> 
> base-commit: 325a118c12045239076b7ea9e66391dd6f56f72e

