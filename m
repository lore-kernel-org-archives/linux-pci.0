Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:33244 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbbBTOjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Feb 2015 09:39:03 -0500
Message-ID: <54E74701.9080107@mm-sol.com>
Date: Fri, 20 Feb 2015 16:38:57 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC: Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pci: spear: Drop __initdata from spear13xx_pcie_driver
References: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru> <54E7072C.30303@mm-sol.com> <CAJs94EbZFLc1iz8zoV5PO2grKMzE3R41-8zC_anQ4QchNjK_SA@mail.gmail.com>
In-Reply-To: <CAJs94EbZFLc1iz8zoV5PO2grKMzE3R41-8zC_anQ4QchNjK_SA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/20/2015 12:13 PM, Matwey V. Kornilov wrote:
> 2015-02-20 13:06 GMT+03:00 Stanimir Varbanov <svarbanov@mm-sol.com>:
>> On 02/19/2015 07:41 PM, Matwey V. Kornilov wrote:
>>> spear13xx_pcie_driver.driver is allocated in text.init section
>>> and then the pointer to it is passed futher. This patch is to avoid
>>> crashes like the following, when freed memory is used.
>>>
>>> Also, __init has been dropped from the probe() function referred from the struct
>>> and all called functions.
>>>
>>
>> <snip>
>>
>>>
>>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>>> ---
>>> Changes from v2:
>>>  - Drop __init from all probing functions to allow deferred probing.
>>> Changes from v1:
>>>  - Use platform_driver_probe instead of platform_driver_register to make linker happy.
>>>
>>>  drivers/pci/host/pcie-designware.c | 2 +-
>>>  drivers/pci/host/pcie-spear13xx.c  | 6 +++---
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>> index df781cd..5b8a056 100644
>>> --- a/drivers/pci/host/pcie-designware.c
>>> +++ b/drivers/pci/host/pcie-designware.c
>>> @@ -339,7 +339,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>>>       .map = dw_pcie_msi_map,
>>>  };
>>>
>>> -int __init dw_pcie_host_init(struct pcie_port *pp)
>>> +int dw_pcie_host_init(struct pcie_port *pp)
>>>  {
>>
>> we need to fix up the other pci drivers which use dw_pcie_host_init(), too.
>>
>> pci-exynos, pci-imx6, pci-keystone and pci-layerscape.
>>
>> Could you prepare a patch with above drivers included?
> 
> What is wrong with them? To call ordinary function from __init section
> is perfectly legal.

I thought in context of probe defer. But this will be subject to another
patch. So ignore my comment.

-- 
regards,
Stan
