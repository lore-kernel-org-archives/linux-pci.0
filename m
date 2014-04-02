Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949AbaDBFee (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Apr 2014 01:34:34 -0400
Message-ID: <533BA157.6030004@ti.com>
Date: Wed, 2 Apr 2014 11:04:15 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"'Marek Vasut'" <marex@denx.de>,
	"'Richard Zhu'" <r65037@freescale.com>
Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com> <2CC2A0A4A178534D93D5159BF3BCB66189FEB13752@EAPEX1MAIL1.st.com> <000001cf4e33$946db4b0$bd491e10$%han@samsung.com> <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 02 April 2014 11:03 AM, Mohit KUMAR DCG wrote:
> Hello Jingoo,
> 
>> -----Original Message-----
>> From: Jingoo Han [mailto:jg1.han@samsung.com]
>> Sent: Wednesday, April 02, 2014 10:53 AM
>> To: Mohit KUMAR DCG
>> Cc: 'Bjorn Helgaas'; linux-pci@vger.kernel.org; Pratyush ANAND; 'Marek
>> Vasut'; 'Richard Zhu'; 'Kishon Vijay Abraham I'
>> Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
>>
>> On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
>>> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
>>>>
>>>> According to the spec, the synopsys core does not implement the
>>>> optional BARs such as BAR0/1. This is based on the assumption that
>>>> the RC host probably has registers on some other internal bus and
>>>> has knowledge and setup access to these registers already.
>>>> So, remove unnecessary RC BAR setting.
>>>>
>>> - Normally BARs in RC are not used but somehow available in the
>>> design. One possible BAR use can be if RC has some memory connected to
>> the BAR that needs to be accessed through link.
>>>
>>> Otherwise we can ignore BARs setup here.
>>
>> Hi Mohit KUMAR DCG,
>>
>> Thank you for your feedback.
>>
>> I want to know whether or not other SoCs such as ST, Freescale, TI support
>> BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary RC BAR setting
>> code should  be removed.
>>
> 
> - We are not currently using RC's BAR0/1 in any application but no such restriction from HW as
> ST SoCs support BARs in HW design. 

Neither do we in DRA7xx.

Cheers
Kishon
> 
> Regards
> Mohit
> 
>> Best regards,
>> Jingoo Han
>>
>>>
>>> Thanks
>>> Mohit
>>>
>>>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>>>> ---
>>>> Tested on Exynos5440.
>>>>
>>>>  drivers/pci/host/pcie-designware.c |    4 ----
>>>>  1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-designware.c
>>>> b/drivers/pci/host/pcie- designware.c index 6d23d8c..7bee01f 100644
>>>> --- a/drivers/pci/host/pcie-designware.c
>>>> +++ b/drivers/pci/host/pcie-designware.c
>>>> @@ -798,10 +798,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>  	}
>>>>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>>>
>>>> -	/* setup RC BARs */
>>>> -	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
>>>> -	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
>>>> -
>>>>  	/* setup interrupt pins */
>>>>  	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
>>>>  	val &= 0xffff00ff;
>>>> --
>>>> 1.7.10.4
> 
