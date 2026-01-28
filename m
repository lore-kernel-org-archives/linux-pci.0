Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614E2D0C7B;
	Wed, 28 Jan 2026 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603302; cv=none; b=S2EilQTnkvr/NgFxLRWHoakKmBdexMLu7r3B1qOR0MpdRCxNg/HrsKOE3UviLiXlkpinFms2UjHDJPFIaKyXZKOC6jrMM9XP9ZdFMxd8kCRa8KRY2r/MB+Tvr58L006UeEiR0BbS87qXpb0EEat7zqqKWxxamkvtCF37uXD4R6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603302; c=relaxed/simple;
	bh=TEsbgfCjkK50Hp+lxmtEomnLLMAmp64lAtrsAstm9nc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G71TZDh1UJBV+JRZFsXkAT7MeaDcDFInylWLaA1otOKaKUEasQpShaGJOfZNMDGYXqR/nw7Eg0x59h9VmnR7nqS1U00aL67C5/3v7nxBMuumTw/Z9eLDLjpdPHSSUQQzqqCkn1KkZI31BL3P43cgzJXJg0BOOREon84zwDhP37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MfXLGDzF; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MfXLGDzF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769603290; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=WwAx+UlouUkOpUHrVPVThJ4hvVbsghTqW21747RuCBY=;
	b=MfXLGDzFCr6rB6E23QARv9WRaJLSZ0Q5KEKZOJSAvNcwKq690XN99NRMZUwlTl474D89SWc28Wrf0Zj0IyrQh0NCc506j7BD1s62sYQfq+vnKstF7MOI9e11dmRNh9WrkiXCyvoE9/jW/nA1rLEoUAmb5u/4EWLZ3oGfhF17ZZQ=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3MKEh_1769603288 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:28:09 +0800
Message-ID: <09cf1319-619d-4a6b-97f7-188c1a73aea0@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <20260127102402.00004da2@huawei.com>
In-Reply-To: <20260127102402.00004da2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:24 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:54 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The current implementation of pcie_do_recovery() assumes that the
>> recovery process is executed for the device that detected the error.
>> However, the DPC driver currently passes the error port that experienced
>> the DPC event to pcie_do_recovery().
>>
>> Use the SOURCE ID register to correctly identify the device that
>> detected the error. When passing the error device, the
>> pcie_do_recovery() will find the upstream bridge and walk bridges
>> potentially AER affected. And subsequent commits will be able to
>> accurately access AER status of the error device.
>>
>> Should not observe any functional changes.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h      |  2 +-
>>   drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
>>   drivers/pci/pcie/edr.c |  7 ++++---
>>   3 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 0e67014aa001..58640e656897 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -771,7 +771,7 @@ struct rcec_ea {
>>   void pci_save_dpc_state(struct pci_dev *dev);
>>   void pci_restore_dpc_state(struct pci_dev *dev);
>>   void pci_dpc_init(struct pci_dev *pdev);
>> -void dpc_process_error(struct pci_dev *pdev);
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev);
>>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>   bool pci_dpc_recovered(struct pci_dev *pdev);
>>   unsigned int dpc_tlp_log_len(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index bff29726c6a5..f6069f621683 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -260,10 +260,20 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>>   	return 1;
>>   }
>>   
>> -void dpc_process_error(struct pci_dev *pdev)
>> +/**
>> + * dpc_process_error - handle the DPC error status
>> + * @pdev: the port that experienced the containment event
>> + *
>> + * Return: the device that detected the error.
>> + *
>> + * NOTE: The device reference count is increased, the caller must decrement
>> + * the reference count by calling pci_dev_put().
>> + */
>> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)
> 
> Maybe it makes sense to carry the err_port naming for the pci_dev
> in here as well?  Seems stronger than just relying on people
> reading the documentation you've added.

Good point. I think renaming the parameter would improve clarity. However,
I'd prefer to handle it in a separate patch to keep this change focused on
the functional modification. Would that work for you?

>   
>>   {
>>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
>>   	struct aer_err_info info = {};
>> +	struct pci_dev *err_dev;
>>   
>>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>>   
>> @@ -279,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>>   			pci_aer_clear_nonfatal_status(pdev);
>>   			pci_aer_clear_fatal_status(pdev);
>>   		}
>> +		err_dev = pci_dev_get(pdev);
>>   		break;
>>   	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
>>   	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
>> @@ -290,6 +301,8 @@ void dpc_process_error(struct pci_dev *pdev)
>>   				"ERR_FATAL" : "ERR_NONFATAL",
>>   			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
>>   			 PCI_SLOT(source), PCI_FUNC(source));
>> +		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> +					    PCI_BUS_NUM(source), source & 0xff);
> 
> Bunch of replication in her with the pci_warn(). Maybe some local variables?
> Maybe even rebuild the final parameter from PCI_DEVFN(slot, func) just to make the
> association with the print really obvious?

Agreed. Here's the improved version:

--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -293,17 +293,28 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
                 break;
         case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
         case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
-               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
-                                    &source);
+       {
+               int domain, bus;
+               u8 slot, func, devfn;
+               const char *err_type;
+
+               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+
+               /* Extract source device location */
+               domain = pci_domain_nr(pdev->bus);
+               bus = PCI_BUS_NUM(source);
+               slot = PCI_SLOT(source);
+               func = PCI_FUNC(source);
+               devfn = PCI_DEVFN(slot, func);
+
+               err_type = (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
+                          "ERR_FATAL" : "ERR_NONFATAL";
+
                 pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
-                        status,
-                        (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
-                               "ERR_FATAL" : "ERR_NONFATAL",
-                        pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
-                        PCI_SLOT(source), PCI_FUNC(source));
-               err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
-                                           PCI_BUS_NUM(source), source & 0xff);
+                        status, err_type, domain, bus, slot, func);
+               err_dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
                 break;
+       }
         case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
                 ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
                 pci_warn(pdev, "containment event, status:%#06x: %s detected\n",

> 
> Is there any chance that this might return NULL?   Feels like maybe that's
> only a possibility on a broken setup, but I'm not sure of all the wonderful
> races around hotplug and DPC occurring before the OS has caught up.

Surprise Down events are handled separately in
dpc_handle_surprise_removal() and won't reach dpc_process_error().
Please correct me if I missed anything.

Thanks for valuable comments.

Best Regards,
Shuai
