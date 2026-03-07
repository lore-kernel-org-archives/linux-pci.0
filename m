Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420C31327F;
	Sat,  7 Mar 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848523; cv=none; b=uwarjHqqMosmD3YD9lJXJWewY1dlNSNaelGJrzzTqUAcFuWUVYs6KwAIdZ0/yhW21Qer7Gp7dLzu+Beu1tVetGqxCg5ef+YqYbgkrgwUN5jIIn3WxacIJNK8IPN5XYySxdisbVllk3ENX6yFXKFNzghwHkYsAHM6XLA61DtNTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848523; c=relaxed/simple;
	bh=1pbulyyaHdnROOxoEekcoYd04b+yizj5yS2NshwLQGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+rR4olJPAjUIFD3itn6pSmmADek5ZatKurz1Mfibq12vnT6RJvfHYy8DddFFy8/nEHf2mers1oNcbpLvJzThnx/c1rgMkn+6xS9fjPYClMvWv39gQoyqmU2P+srMw12Moo7p2lJZZDtg6hSXSFj42BAZCfGt7eXIEhMNwg6MBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pML3nOja; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pML3nOja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lRVghRgViPUB3A2Q8rUhXefBk89HXbwxJircFMveMd8=;
	b=pML3nOjakIr0U+yo+p/4X5aiBDMm5Y6weGQagnM1U/K1caFwbuu0ni8EGEG0le
	h/HQKGkoyqSi/26SARbh6p/XOc/2ngShb5YiIy+tyreyC7O6lSD4pmKfHm50mBAI
	MdeUIkfI0SMJ7I9L9cJxfOQ4XGxP41ABXR/9bmHOdc230=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBn16FwhatpmHksPA--.8981S2;
	Sat, 07 Mar 2026 09:54:57 +0800 (CST)
Message-ID: <32b46d99-566e-41a8-b25f-6f0e1bed21e2@163.com>
Date: Sat, 7 Mar 2026 09:54:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Add PCIe event counters for groups 5 to 7 in
 DWC debugfs
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng Xin <chengqin1525@126.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com,
 mani@kernel.org
References: <20260306150754.41746-1-18255117159@163.com>
 <a07f2bf8-6c91-e89f-d07b-721e6f10805c@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <a07f2bf8-6c91-e89f-d07b-721e6f10805c@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn16FwhatpmHksPA--.8981S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxCF1xXw4fJF45tryrJFb_yoWrZw4kp3
	9Fkr4xKF48tr13ZwnxXas8Grn5ZFWkJrykGws3C343WFn3urn8JF1ayr1DZFy8Gry0qr1Y
	qF17KFyUG345A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5-BiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BHCZmmrhXFREQAA3v



On 3/7/26 00:11, Shawn Lin wrote:
> 在 2026/03/06 星期五 23:07, Hans Zhang 写道:
>> Extend the DesignWare PCIe controller's debugfs statistical counter
>> interface with event definitions from groups 5 through 7 as documented
>> in the DWC PCIe Databook (version 3.30a, section 3.8.2.3, Tables 3-59,
>> 3-60, 3-61). These counters provide visibility into Layer1 non-error
>> events (link state transitions,ASPM, L1 substates), Layer2 DLLP
>> exchanges, and Layer3 TLP transactions.
>>
>> The counters are exposed under the debugfs statistical counter directory,
>> allowing users to monitor link behavior and diagnose PCIe protocol issues
>> more effectively.
>>
>> Co-developed-by: Cheng Xin <chengqin1525@126.com>
>> Signed-off-by: Cheng Xin <chengqin1525@126.com>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Thank you, Cheng Xin, for providing the 3.30a version of the DWC PCIe 
>> Data Book.
>> ---
>>   .../controller/dwc/pcie-designware-debugfs.c  | 52 ++++++++++++++++++-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/ 
>> drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> index 0d1340c9b364..2efddb21b2b2 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> @@ -131,13 +131,16 @@ static const u32 err_inj_type_mask[] = {
>>    *                   supported in DWC RAS DES
>>    * @name: Name of the error counter
>>    * @group_no: Group number that the event belongs to. The value can 
>> range
>> - *          from 0 to 4
>> + *          from 0 to 7
>>    * @event_no: Event number of the particular event. The value ranges 
>> are:
>>    *        Group 0: 0 - 10
>>    *        Group 1: 5 - 13
>>    *        Group 2: 0 - 7
>>    *        Group 3: 0 - 5
>>    *        Group 4: 0 - 1
>> + *        Group 5: 0 - 13
>> + *        Group 6: 0 - 6
>> + *        Group 7: 0 - 25
>>    */
>>   struct dwc_pcie_event_counter {
>>       const char *name;
>> @@ -181,6 +184,53 @@ static const struct dwc_pcie_event_counter 
>> event_list[] = {
>>       {"completion_timeout", 0x3, 0x5},
>>       {"ebuf_skp_add", 0x4, 0x0},
>>       {"ebuf_skp_del", 0x4, 0x1},
>> +    {"l0_to_recovery_entry", 0x5, 0x0},
>> +    {"l1_to_recovery_entry", 0x5, 0x1},
>> +    {"tx_l0s_entry", 0x5, 0x2},
>> +    {"rx_l0s_entry", 0x5, 0x3},
>> +    {"aspm_l1_reject", 0x5, 0x4},
>> +    {"l1_entry", 0x5, 0x5},
>> +    {"l1_cpm", 0x5, 0x6},
>> +    {"l1.1_entry", 0x5, 0x7},
>> +    {"l1.2_entry", 0x5, 0x8},
>> +    {"l1_short_duration", 0x5, 0x9},
>> +    {"l1.2_abort", 0x5, 0xa},
>> +    {"l2_entry", 0x5, 0xb},
>> +    {"speed_change", 0x5, 0xc},
>> +    {"link_width_change", 0x5, 0xd},
>> +    {"tx_ack_dllp", 0x6, 0x0},
>> +    {"tx_update_fc_dllp", 0x6, 0x1},
>> +    {"rx_ack_dllp", 0x6, 0x2},
>> +    {"rx_update_fc_dllp", 0x6, 0x3},
>> +    {"rx_nullified_tlp", 0x6, 0x4},
>> +    {"tx_nullified_tlp", 0x6, 0x5},
>> +    {"rx_duplicate_tlp", 0x6, 0x6},
>> +    {"tx_memory_write", 0x7, 0x0},
>> +    {"tx_memory_read", 0x7, 0x1},
>> +    {"tx_configuration_write", 0x7, 0x2},
>> +    {"tx_configuration_read", 0x7, 0x3},
>> +    {"tx_io_write", 0x7, 0x4},
>> +    {"tx_io_read", 0x7, 0x5},
>> +    {"tx_completion_without_data", 0x7, 0x6},
>> +    {"tx_completion_w_data", 0x7, 0x7},
>> +    {"tx_message_tlp_pcie_vc_only", 0x7, 0x8},
>> +    {"tx_atomic", 0x7, 0x9},
>> +    {"tx_tlp_with_prefix", 0x7, 0xa},
>> +    {"rx_memory_write", 0x7, 0xb},
>> +    {"rx_memory_read", 0x7, 0xc},
>> +    {"rx_configuration_write", 0x7, 0xd},
>> +    {"rx_configuration_read", 0x7, 0xe},
>> +    {"rx_io_write", 0x7, 0xf},
>> +    {"rx_io_read", 0x7, 0x10},
>> +    {"rx_completion_without_data", 0x7, 0x11},
>> +    {"rx_completion_w_data", 0x7, 0x12},
>> +    {"rx_message_tlp_pcie_vc_only", 0x7, 0x13},
>> +    {"rx_atomic", 0x7, 0x14},
>> +    {"rx_tlp_with_prefix", 0x7, 0x15},
> 
> Hmm, 5.10a/5.60a databooks only list the first 21 events for Group 7,
> It's rather counterintuitive, perhaps it would make sense that debug 
> signals should keep adding more. Other parts look good to me.

Hi Shawn,

Thank you very much for your reply and reminder.

The version information in the commit message is incorrect. It should be 
"6.30a" instead of "3.30a". I will send the next version with corrections.

Best regards,
Hans

> 
>> +    {"tx_ccix_tlp", 0x7, 0x16},
>> +    {"rx_ccix_tlp", 0x7, 0x17},
>> +    {"tx_deferrable_memory_write_tlp", 0x7, 0x18},
>> +    {"rx_deferrable_memory_write_tlp", 0x7, 0x19},
>>   };
>>   static ssize_t lane_detect_read(struct file *file, char __user *buf,
>>

