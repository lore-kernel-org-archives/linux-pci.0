Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14502 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbdJMDk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 23:40:27 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171013034025epoutp04982302bd573fd5440d3a9b91e5c4c981~tBClJxqyF1709117091epoutp04N
        for <linux-pci@vger.kernel.org>; Fri, 13 Oct 2017 03:40:25 +0000 (GMT)
Subject: Re: [PATCH] PCI: dwc: designware: don't sleep in atomic context
To: David Laight <David.Laight@ACULAB.COM>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <70cd34bd-01db-cd93-ddf7-d82114ccc61a@samsung.com>
Date: Fri, 13 Oct 2017 09:10:38 +0530
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00924BC@AcuExch.aculab.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
References: <CGME20171012075438epcas2p32599c2db4ed1512c81d1039bb1ed5607@epcas2p3.samsung.com>
        <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
        <063D6719AE5E284EB5DD2968C1650D6DD00924BC@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/12/2017 04:09 PM, David Laight wrote:
> From: Pankaj Dubey
>> Sent: 12 October 2017 08:55
>> In pcie-designware.c many places we are calling "usleep_range" which
>> are in atomic context. This patch fixes these potential BUGs and
>> replaces "usleep_range" with mdelay calls.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/pci/dwc/pcie-designware.c | 8 ++++----
>>   drivers/pci/dwc/pcie-designware.h | 3 +--
>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index 88abddd..35d19b9 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -138,7 +138,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>>   		if (val & PCIE_ATU_ENABLE)
>>   			return;
>>
>> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
>> +		mdelay(LINK_WAIT_IATU_MIN);
>>   	}
> Spinning for 9ms (possibly 10 times) isn't really a good idea.

Yes. It may not be a good idea, however in our experiment it never hit 
maximum retry count.
I just converted usleep_range to mdelay keeping min time limitation as 
it is, though I
am not sure, how do we arrived on these numbers in original code, may be 
Joao Pinto
from Synopsys have some idea, I will try to do few experiment and try to 
find out what
is sufficient minimum time in our hardware for these mdelay.

Thanks,
Pankaj Dubey
> 	David
>
>
>
>
