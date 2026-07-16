Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D523329E5A
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193923; cv=none; b=uzX3P+sCUXLUHKYwHVqb6HA1QE7g+HbP63VjoRTJz4CwyHjRKvrNuq6XPTolJh3CBj9iiNLVQFfwmdT/CiD/4jOTgPR8l2K5mF4C6fJCLizszKPrjZbQ094cn3iwhwSzZhTtvwYLeSXjagyRCYIldQse5HomQ+INYUZTiX8qKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193923; c=relaxed/simple;
	bh=Ka+MiYwZXO9ZZk3ZdrXKIr03QaEUVx8pkcBqrszIYCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8jCKrAPxeQH+BHjYguKBqqEaPpLYOr0ESqm19kEPMT6TxcDolLp1s6Fdby2sJ551fGj/l5917cBpFW+G84mSGvSmS2i1SIJDG4Xlu6SK3K8cYSGl7Q81F2TgrswbSk0WH5IxSYHh4gywWhpq4XhohKXJ90Ke/i2JuhHw4FVtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAPuNffc; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAPuNffc"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso1309727f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784193921; x=1784798721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2umLa0OP6cXw7OYRebqCIfZ0tp2RQ5ZMbVPQ4YiGsA=;
        b=DAPuNffcfoaREG4/yWXNtcDLU4eZ7rJyEXimYKLxR2MFv78E9RRdtPmlmuPPGzYUSS
         YcVmkMajOcyRJJL1B5hINKLf/FdGjMyVfyPiOULAC3ME+F6NN8ez6PcHGgbdvPkCwqp0
         fDnB4lUfRi3iULGL9zWSMY8NV4Nx7BRUgvV1vrQblRmTtxrnA3Xdqngal7GFZbXggj2+
         ZdYgZb+qgU+1OLErKPFZ3p2nNk6ckLsQBwS1/rjKoCwltvXWngz3tG0Q+TOusGct5AIG
         TRr4y8XnfoTKvkjG+4HvU06pLyulm7Yn15D8Vgt6MuYLq399552RAGN/3OFWRf2u+9Kq
         nm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193921; x=1784798721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2umLa0OP6cXw7OYRebqCIfZ0tp2RQ5ZMbVPQ4YiGsA=;
        b=eDDF+k9hmXmc4/Jog99QA8t087F9texj02UQdhLK5k4sgkfTyZrtShoK13EF7nmOdl
         kd0CvIDnKJfKuLmGqIJUOCi3xTNlgNVuur0knvWuA+8gsSbqQE4Gd6w6TvfLaX3ZQHv6
         gU7FMeaF2XdwF9z+EfdSnjkAN7IEXdVmfnoY99tvUZgk3CNBqiiJBiWRIhThFl687yyE
         wl90m3nco4qBWMNx/pXFbeqE+uIq5ezvO60igOl8wpNHHCHwgTEQqLLpc9uPX7bWSvlV
         A7Z1p5wpJlNtAZrHypRu0sxWP63dRDmmWgAqO3LiOJb/U/wf3AIIE/2zwd5OlBGv7U7G
         Qw+w==
X-Forwarded-Encrypted: i=1; AHgh+RqZTamA1N4rrK2BbXzNArwLflC6qK4DTsu3y8Gwi081AXdB4GZPJ4wQR7F0K6GEAoHpivQku7w1x9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0YdepSz9bqcOoh81pV/g9HdOueuA/2yZ6LZVo1bqNCVI8enW
	Iq9pjxQhr3bQBRDTsjCEJ/rI3Mr6SMMp8hcoe7lFbC1fGzcH5L1HZiX5
X-Gm-Gg: AfdE7cm6P0Oh274ETE23AmjfQDKmRK8eHNQLD2bhXpoaF/kmFk2N7BwLj3MkiFDMt+/
	oKLAHredGMzBrA7wkW7WkqeUN6bgDgMy3gwx42u9ZehjKJr4lpcNIv355wiKk4lj0olG0F1drFI
	LvYNyZilDqTght0GFrx5ocNh9mQF39neW5YOhW6mQ8T63uHBLDHjxNUufhD+HtgeChWHq4Ln/yz
	0Jkb398Bttdi4Ne7R9HTvJ6yTxahlkTqILj0MV5Fnr2DUAC2c1NOW1dAiuxw8v+cv4FGuRbUmp+
	hMsm6++WitTzubegRR3FB3yBeZXvmRSWD/8yPR/Xg9TbAXXCFnqI9AXhDZsvzUT5hMkOlS2JDhf
	LHUMM/1ny5tOiTO8EEL/zrdu+H0JRgc/3TJYN3flDdN4VP8E9i2wky53bKdiI06XftMCnNJJl7f
	1ihF8/lepm5TgHhu3v5tWoTRE=
X-Received: by 2002:a05:6000:26c7:b0:46d:55a5:8ec5 with SMTP id ffacd0b85a97d-47f2dcf9e3emr22598452f8f.33.1784193920312;
        Thu, 16 Jul 2026 02:25:20 -0700 (PDT)
Received: from [192.168.101.113] ([110.93.227.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm22937744f8f.7.2026.07.16.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:25:19 -0700 (PDT)
Message-ID: <0b5cc400-1680-4f2e-ba41-5f391fcf979e@gmail.com>
Date: Thu, 16 Jul 2026 14:25:16 +0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: plda: Synchronize chained IRQs during
 deinitialization
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daire McNamara <daire.mcnamara@microchip.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260714175852.GA1387886@bhelgaas>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20260714175852.GA1387886@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 10:58 PM, Bjorn Helgaas wrote:
> On Tue, Jul 14, 2026 at 10:43:45PM +0500, Ali Tariq wrote:
>> During driver unbind or probe failure teardown,
>> plda_pcie_irq_domain_deinit() unlinks the chained interrupt
>> handlers for the main, MSI, and INTx interrupts using
>> irq_set_chained_handler_and_data(). However, this function
>> only updates the handler pointers and does not wait for any
>> in-flight interrupt handlers running on other CPUs to finish.
>>
>> If a PCIe interrupt fires concurrently with the teardown
>> process, the handler could continue running on another CPU.
>> If the hardware clocks are disabled shortly after in
>> host_deinit(), the executing handler will attempt to read
>> un-clocked PCIe registers, triggering a fatal system bus
>> fault (external abort) or kernel panic.
>>
>> Add synchronize_irq() after clearing each chained handler to
>> guarantee that any executing handlers have fully completed
>> before proceeding with interrupt domain removal and hardware
>> deinitialization.
>>
>> Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
>> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
>> ---
>>   drivers/pci/controller/plda/pcie-plda-host.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
>> index f9a34f323ad8..f6759e255c75 100644
>> --- a/drivers/pci/controller/plda/pcie-plda-host.c
>> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
>> @@ -560,8 +560,13 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
>>   static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
>>   {
>>   	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>> +	synchronize_irq(pcie->irq);
>> +
>>   	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
>> +	synchronize_irq(pcie->msi_irq);
>> +
>>   	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
>> +	synchronize_irq(pcie->intx_irq);
> 
> Several other drivers call irq_set_chained_handler_and_data(..., NULL)
> without synchronize_irq().  Do they need similar fixes?
> 
>>   	irq_domain_remove(pcie->msi.dev_domain);
>>   
>> -- 
>> 2.34.1
>>

Hi Bjorn,

Thanks for the question. I looked at the wider pattern across the tree,
and severity does seem to depend heavily on what happens immediately
after the teardown in each specific driver, so I don't think a single
change is safe to apply broadly. I'll follow up separately with more
detail on what I found there.

For this specific driver, though, I think my patch needs to be
withdrawn. Tracing through kernel/irq/manage.c, synchronize_irq()'s
wait relies on the IRQD_IRQ_INPROGRESS flag, which is set and cleared
by handle_irq_event() in the normal interrupt dispatch path. Chained
handlers bypass that path entirely (dispatch goes straight to
desc->handle_irq), so this flag is never touched for them. The
fallback in that case is to query the irqchip directly via
.irq_get_irqchip_state(), but none of this driver's irq_chip
structures implement that callback, so the fallback also does
nothing.

The practical effect is that synchronize_irq() here returns
immediately regardless of whether a chained handler is still
executing, so this patch doesn't actually close the race it was meant
to fix.

I'd like to withdraw this specific patch and rework it, likely with an 
explicit in-driver flag around the chained handlers rather than relying 
on synchronize_irq(), since I don't think .irq_get_irqchip_state() maps
cleanly onto this driver's handler structure either (the status
register gets acked partway through handling, before the rest of the
dispatch work is done).

Regards,
Ali

