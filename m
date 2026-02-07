Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10027FD49;
	Sat,  7 Feb 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770453346; cv=none; b=P/xvLYCyWJDprPfC6rjuqdH0CuUdLPj5E4qwJnfSlQrJAAsvd7D12cL2BxnNDWYLxe0LE8fnbtan/tpnJggIOwPzyisPDf2Borv3+/LMy6lgk2kydXQ57/PZX4bzcyqlyCHvvzpUaa20zSoF1taFTzt+iXRFystX2equSJGbC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770453346; c=relaxed/simple;
	bh=l35u3BZZOQIBM2GmLtf1KTRJgFIJqg9JBtiDeFx++70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHP+VT/DB6aPt7ikJPwIiiH8Q0KsTibZRGtPU5mqTv7wTOWNiMqjklA+Tq5uDHq+SXxCGUJwyEpbseyoyZmYhEkx3vI5bLabaaRTOUQsII5XtWty7+lEUBUihFjjs4SokPBscYJK7foNQHBbzcpIRp8751DwFPYLWZ0JtSNx2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nA8w0qCW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nA8w0qCW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770453334; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NdAVUBsBt+q9ht9jChQ+fU7/bdKbU4jceYqVa9txGzY=;
	b=nA8w0qCWPpx4zjbpLqFdkecvE4rI1OJHNMtmuxQvTKIF4nS7vEr2PUk8FMIF46bfkZrUCKe6PQP7qHiXXR/VEsWtfZIh5S2aWEGAVv9htRpDN13qun6kBIFTNZltjF+lCHUr7FffYnOwfeD5FS48VNrnSd2yUFuhxwyD+jHNaMU=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WyhXHoT_1770453333 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Feb 2026 16:35:34 +0800
Message-ID: <de195f39-8197-494e-8451-2cf8fde064ea@linux.alibaba.com>
Date: Sat, 7 Feb 2026 16:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
 <aYGsmgyVwvbj83YI@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGsmgyVwvbj83YI@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 4:06 PM, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 03:45:56PM +0800, Shuai Xue wrote:
>> The DPC driver clears AER fatal status for the port that reported the
>> error, but not for the downstream device that deteced the error.  The
>> current recovery code only clears non-fatal AER status, leaving fatal
>> status bits set in the error device.
> 
> That's not quite accurate:
> 
> The error device has undergone a Hot Reset as a result of the Link Down
> event.  To be able to use it again, pci_restore_state() is invoked by
> the driver's ->slot_reset() callback.  And pci_restore_state() does
> clear fatal status bits.
> 
> pci_restore_state()
>    pci_aer_clear_status()
>      pci_aer_raw_clear_status()
> 
>> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
>> status in the error device, ensuring all AER status bits are properly
>> cleared after recovery.
> 
> Well, pci_restore_state() already clears all AER status bits so why
> is this patch necessary?

You're right that many drivers call pci_restore_state() in their
->slot_reset() callback, which clears all AER status bits.  However,
since ->slot_reset() is driver-defined and not all drivers invoke
pci_restore_state(), there could be cases where fatal AER status bits
remain set after the frozen recovery completes.

> 
>> +++ b/drivers/pci/pcie/err.c
>> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	 */
>>   	if (host->native_aer || pcie_ports_native) {
>>   		pcie_clear_device_status(dev);
>> -		pci_aer_clear_nonfatal_status(dev);
>> +		pci_aer_raw_clear_status(dev);
>>   	}
> 
> This code path is for the case when pcie_do_recovery() is called
> with state=pci_channel_io_normal, i.e. in the nonfatal case.
> That's why only the nonfatal bits need to be cleared here.
> 
> In the fatal case clearing of the error bits is done by
> pci_restore_state().
> 
> I understand that this is subtle and should probably be changed
> to improve clarity, but this patch doesn't look like a step
> in that direction.
> 

I notice that pcie_clear_device_status()
(called just before pci_aer_clear_nonfatal_status()) already clears
*all* error bits in the Device Status register (CED, NFED, FED, URD),
including the Fatal Error Detected (FED) bit, regardless of whether
we're in a fatal or nonfatal recovery path.

So there's an inconsistency in the current design:
- pcie_clear_device_status() clears all error bits (including FED)
- pci_aer_clear_nonfatal_status() only clears nonfatal AER status

This means that even in the nonfatal case, the FED bit in Device
Status is cleared, even though we preserve the fatal bits in the AER
Uncorrectable Error Status register.

Would you prefer that I:
1. Make both pcie_clear_device_status() and the AER clearing
    conditional on the 'state' parameter, so that nonfatal recovery
    truly preserves fatal bits in both registers, or
2. Drop this patch and instead move the AER-specific clearing logic
    out of pcie_do_recovery() entirely (as you suggested earlier), so
    that each caller can handle the status clearing explicitly for the
    appropriate error sources and severity?

Thanks,
Shuai

