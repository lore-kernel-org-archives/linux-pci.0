Received: from mail-m10155.netease.com (mail-m10155.netease.com [154.81.10.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18323D7E3;
	Fri,  6 Mar 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818021; cv=none; b=fC822mDnPJNcQlhoTM8osGoVRrsm8iSFrqUTcKZgiozINTkDXYUrcLuW6bjPMmvIC6+qi9HPdTfvzbrwHu0sttKBJBhVg4KR/wYPgCAu/Ybw9u04j4Bld7xG8BEDs3TlKHYXyfxTRaDH4+TlqEShlGivW6FkTrUxN64h9jYgD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818021; c=relaxed/simple;
	bh=B9M5uCBl1KLhO43b2Y327KOuBcVGuNtqFbchQTgBDtM=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mNhIgmesVeWN8bLE7YuKvnXkKcpDZ8oFbo17+h4uFrQMsY8T5tZsFLXzc7lxQ4QIo+rlcKv+0lYP2l1Cn5A+t22xKseJlWG7iAu3C4clDN2eAnvcYU59abT+ZL3pRazuPtJ/giZn4+bZS6v30kTReslIIrm+T561W48BR+3mH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=F5PZv8gN; arc=none smtp.client-ip=154.81.10.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="F5PZv8gN"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 360a7ed70;
	Sat, 7 Mar 2026 00:11:08 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cheng Xin <chengqin1525@126.com>,
 lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
 bhelgaas@google.com, mani@kernel.org
Subject: Re: [PATCH] PCI: dwc: Add PCIe event counters for groups 5 to 7 in
 DWC debugfs
To: Hans Zhang <18255117159@163.com>
References: <20260306150754.41746-1-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a07f2bf8-6c91-e89f-d07b-721e6f10805c@rock-chips.com>
Date: Sat, 7 Mar 2026 00:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260306150754.41746-1-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cc3eac46809cckunm0f93ce74144eb8d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJDQ1ZNHx9PSU5JH0xCGUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=F5PZv8gNTDMjZCKX4vSQDyz8xU3dI4grkU8uWiQ/8UgNI8JA+uD5dkjG5gXhVjLSCboySJJN4IRn0FzCY2ubAMoMZAzYNj9jAaZ68b0sNQ9wuwr9uizvqdYRoGA0EjHDW4lF4b+HOJxGwV+sksAF0ePnW7Q9tlFb9dCbpitfTCY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hJiWJ8Vdvw44FSdcQBf/hz/zfP4GQr2RJizw/2T7UXc=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/06 星期五 23:07, Hans Zhang 写道:
> Extend the DesignWare PCIe controller's debugfs statistical counter
> interface with event definitions from groups 5 through 7 as documented
> in the DWC PCIe Databook (version 3.30a, section 3.8.2.3, Tables 3-59,
> 3-60, 3-61). These counters provide visibility into Layer1 non-error
> events (link state transitions,ASPM, L1 substates), Layer2 DLLP
> exchanges, and Layer3 TLP transactions.
> 
> The counters are exposed under the debugfs statistical counter directory,
> allowing users to monitor link behavior and diagnose PCIe protocol issues
> more effectively.
> 
> Co-developed-by: Cheng Xin <chengqin1525@126.com>
> Signed-off-by: Cheng Xin <chengqin1525@126.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Thank you, Cheng Xin, for providing the 3.30a version of the DWC PCIe Data Book.
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

Hmm, 5.10a/5.60a databooks only list the first 21 events for Group 7,
It's rather counterintuitive, perhaps it would make sense that debug 
signals should keep adding more. Other parts look good to me.

> +	{"tx_ccix_tlp", 0x7, 0x16},
> +	{"rx_ccix_tlp", 0x7, 0x17},
> +	{"tx_deferrable_memory_write_tlp", 0x7, 0x18},
> +	{"rx_deferrable_memory_write_tlp", 0x7, 0x19},
>   };
>   
>   static ssize_t lane_detect_read(struct file *file, char __user *buf,
> 
