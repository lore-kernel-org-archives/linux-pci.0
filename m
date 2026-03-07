Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com [220.197.32.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AA27991E;
	Sat,  7 Mar 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874373; cv=none; b=UV+6Qc6MUuPVmo0bhyW/8rzMgxumbwgd7GnMrBcVODyTiYTmKxxdHGwwh4HD5O1VLVEOJVzbZKpQMwjM+OB8v1ut/xwc8Hpou9e08TZ1xa03vUmbYb079UPZZ3t23E8MibMhYCJOmvhXi8gnMMcidbEc12WFrbhOoQLujpDlJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874373; c=relaxed/simple;
	bh=XlP6woD6SgVJp7HCdE0v1sN/12rhaomgKReGhyBJoA0=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hjG6lv0jHhDohcFRVrCND4RwGAN2xK5gE6fZrauuTCNWiDyglvcDZ4gWnJTojQQLuyLHC2YpELh7lQF36crEMLiKhnDeF0v+9zqoACbm65WzD97TQ03ljeW7reWQ7yZFFvCq4yAyZVsbcfjLmvSLXReO+uGuS0WNPjO7H/HTCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cUpeKtrN; arc=none smtp.client-ip=220.197.32.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cUpeKtrN"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3613d2aa9;
	Sat, 7 Mar 2026 11:23:09 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cheng Xin <chengqin195275@126.com>,
 lpieralisi@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v3] PCI: dwc: Add PCIe event counters for groups 5 to 7 in
 DWC debugfs
To: Hans Zhang <18255117159@163.com>
References: <20260307020152.1224518-1-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b6881a0e-d640-ee0a-c4ff-733b2b5fae89@rock-chips.com>
Date: Sat, 7 Mar 2026 11:23:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260307020152.1224518-1-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cc65203bc09cckunm40188020148e247
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJKTlZJHx5DSx0fTBpPQhpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cUpeKtrNMGC5CPzro90UIOcMqaYMB+d1ZZee5GTSCnUZJBvCrvac3CgflC4azElVgtRP6rBYasyp0Na/0qFkQ46/cOZn4k5+yzBS5ryuVTNv8Awz75KX85Fy4a4RbZBsoO0LSX46+2jh2GV6Sy+O3+dIENJTx+5WxQTocS87rTE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=K/zDbBp0YZRvd44mlW0NZO+rxdGHxAlw6NniMLz/gkM=;
	h=date:mime-version:subject:message-id:from;

ÔÚ 2026/03/07 ÐÇÆÚÁù 10:01, Hans Zhang Ð´µÀ:
> Extend the DesignWare PCIe controller's debugfs statistical counter
> interface with event definitions from groups 5 through 7 as documented
> in the DWC PCIe Databook (version 6.30a, section 3.8.2.3, Tables 3-59,
> 3-60, 3-61). These counters provide visibility into Layer1 non-error
> events (link state transitions,ASPM, L1 substates), Layer2 DLLP
> exchanges, and Layer3 TLP transactions.
> 

Re-check the events one by one against the v6.30a databook, the new
events are correct.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

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
> 
