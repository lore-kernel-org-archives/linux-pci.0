Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51737 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbJTOwo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2015 10:52:44 -0400
Subject: Re: pcie-designware build fails in ARM64
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	"jg1.han@samsung.com" <jg1.han@samsung.com>
References: <56213393.8020606@synopsys.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1624ECFA@lhreml503-mbs>
CC: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56265538.40503@synopsys.com>
Date: Tue, 20 Oct 2015 15:52:40 +0100
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1624ECFA@lhreml503-mbs>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On 10/19/2015 8:04 AM, Gabriele Paoloni wrote:
> Hi Joao
> 
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
>> On Behalf Of Joao Pinto
>> Sent: 16 October 2015 18:28
>> To: jg1.han@samsung.com
>> Cc: Carlos Palminha; linux-pci@vger.kernel.org
>> Subject: pcie-designware build fails in ARM64
>>
>> Dear Jingoo Han,
>>
>> I am trying to build pcie-designware for ARM64 but with no success. Did you
>> ever
>> tried to build the core driver in this platform?
>>
> 
> Please look at "[PATCH v11 3/6] PCI: designware: Add ARM64 support"
> And respective patchset submitted in the mailing list.

Thanks, it worked well!

> 
> Regards
> 
> Gab
> 
>> Thanks you for you attention.
>>
>> Regards,
>> Joao Pinto
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
-Joao
