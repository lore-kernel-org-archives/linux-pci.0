Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB481A9FBA;
	Wed, 13 May 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655682; cv=none; b=uVbBDlUJLRGc4L3qos9Ts3W6qCcXqgrLqVNbn0L4DXXNViKaWoS40c4l/VEBTphes89TjkvlXdL8/53gI1zeuh/WWyhg6Z8CupySX/beFfiyqvoyZsFvXIvPqoXW81tPk7ZpFEJaXDH9jj26ln5pP7GU++ultr55HAm/uTal+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655682; c=relaxed/simple;
	bh=Wf8CNP8dGStlyUkn5b1ajhv1fvl5mca8CWlkjooOauo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJsLtlRzORf4xXYDrNWb9K2ZFRJ/rl4DfbuCBgzil1kYRnLGQTjaP9N4+/eyNh2BOknRc857g5hLxX3PRyNWFGvpQNJc9wX1bvSCdpOdjMvasKRWCmqF6aoBjATKCr1fMR8ubw5VPNNQmbn9aVSadcAmlCB77p8/HfHs1ULaoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RD99yJzu; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RD99yJzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=8eoo5QvpB4Eb9ga+kJJMqXt8kq4OH6TS43RPJ0eaFgI=;
	b=RD99yJzu1OO09ZP8mmikLZxFnwdZQWaFTFeVn0Q4qXID1jguibJcDy+kX+1gYW
	opV5fmUjR3oop3oNQ4+rrB7hBP5ScnplUnQE2q08Qvv/WyzgYcTtSpkrq1rC5dhH
	MLX7jLYVcaioWBn4K7QvxOoeVYKRF8t770p+INk1exn8Y=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD35zZ1IQRqoYBUBA--.57222S2;
	Wed, 13 May 2026 15:00:06 +0800 (CST)
Message-ID: <581e91fb-2e57-43ed-b79d-19dbf384b955@163.com>
Date: Wed, 13 May 2026 15:00:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] PCI: aardvark: Add 100 ms delay after link
 training
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, vigneshr@ti.com, jingoohan1@gmail.com,
 thomas.petazzoni@bootlin.com, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, claudiu.beznea.uj@bp.renesas.com,
 mpillai@cadence.com, robh@kernel.org, s-vadapalli@ti.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506152346.166056-1-18255117159@163.com>
 <20260506152346.166056-7-18255117159@163.com>
 <20260512212531.jupoocz7acv22qyg@pali>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260512212531.jupoocz7acv22qyg@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD35zZ1IQRqoYBUBA--.57222S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw15GF4xZw1kGr1DZryUtrb_yoW5Zryfpa
	y3GF1SgFZ5tr45u3W7Xa1kuFyYganI9345Jrn7Kw13ZFnxCryUWF1jkrZavFy3Jw4kAF12
	vw42qFy8ua13ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UEPfLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxYBpGoEIXa5zQAA39



On 5/13/26 05:25, Pali Rohár wrote:
> On Wednesday 06 May 2026 23:23:44 Hans Zhang wrote:
>> The Aardvark PCIe controller driver waits for the link to come up but
>> does not implement the mandatory 100 ms delay after link training
>> completes for speeds greater than 5.0 GT/s (PCIe r6.0 sec 6.6.1).
>>
>> The driver already maintains a 'link_gen' field that holds the negotiated
>> link speed. Use it together with pcie_wait_after_link_train() to insert
>> the required delay immediately after confirming that the link is up.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/pci-aardvark.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>> index e34bea1ff0ac..526351c21c49 100644
>> --- a/drivers/pci/controller/pci-aardvark.c
>> +++ b/drivers/pci/controller/pci-aardvark.c
>> @@ -350,8 +350,10 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
>>   
>>   	/* check if the link is up or not */
>>   	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> -		if (advk_pcie_link_up(pcie))
>> +		if (advk_pcie_link_up(pcie)) {
>> +			pcie_wait_after_link_train(pcie->link_gen);
>>   			return 0;
>> +		}
>>   
>>   		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>>   	}
>> -- 
>> 2.34.1
>>
> 
> Are you sure that this is correct to do? Have you checked the A3720
> Functional Specification which describes how to bring PCIe link up?
> 
> A3720 PCIe controller is buggy and needs more timing hacks to make it
> behave. Playing with random sleeps can break its internal logic.
> I'm not sure if it could be safe without proper testing.
> 
> And IIRC A3720 PCIe controller is just PCIe2.0 with 5 GT/s.


Hi Pali,

1. This driver does not support A3720.

static const struct of_device_id advk_pcie_of_match_table[] = {
	{ .compatible = "marvell,armada-3700-pcie", },
	{},
};
MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);

If you need support for A3720, please submit the corresponding patch so 
that Bjorn and Mani can review it.


2. If A3720 only supports GEN2, you can configure "max-link-speed" to be 
2 in the DT. This will not affect the functionality of this patch.

3. This patch is a common delay requirement stipulated by the PCIe 
specification. If it is greater than GEN2, then msleep(100) will be 
added; otherwise, there will be no such delay.

4. For instance, we often come across the situation where some common 
APIs are modified, and in many cases, their functionality does not 
require the actual development board for verification. I believe that 
many other developers and maintainers have modified different parts of 
the code. For example, the recent submission:

commit 750277048afe7ce8ebfc0b120de7dfbc745058a7
Author: Nam Cao <namcao@linutronix.de>
Date:   Thu Jun 26 16:47:53 2025 +0200

     PCI: aardvark: Switch to msi_create_parent_irq_domain()

     Switch to msi_create_parent_irq_domain() from 
pci_msi_create_irq_domain()
     which was using legacy MSI domain setup.


And many controller drivers have been modified.


Best regards,
Hans


