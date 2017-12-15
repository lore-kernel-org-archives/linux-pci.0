Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:15403 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdLOFtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Dec 2017 00:49:18 -0500
Subject: Re: [PATCH 5/5] PCI: cadence: add EndPoint Controller driver for
 Cadence PCIe controller
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <297fa17e12cf0f2fb223c05eeb18570707ff5bf1.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171201122048.GB25010@red-moon>
 <ed6d811e-608e-e6aa-7b07-2f2d2d68adbd@ti.com>
 <c2e9fd2b-e576-49bb-31e1-c65ff92cf9d3@free-electrons.com>
 <e43929c8-e283-f774-eca3-3b0ffcdfb49d@free-electrons.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4c1e8ba7-8084-7802-df4e-47c6f3ed7816@ti.com>
Date: Fri, 15 Dec 2017 11:19:06 +0530
MIME-Version: 1.0
In-Reply-To: <e43929c8-e283-f774-eca3-3b0ffcdfb49d@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Cyrille,

On Thursday 14 December 2017 10:33 PM, Cyrille Pitchen wrote:
> Le 13/12/2017 à 17:50, Cyrille Pitchen a écrit :
>> Hi Kishon,
>>
>> Le 05/12/2017 à 10:19, Kishon Vijay Abraham I a écrit :
>>> Hi,
>>>
>>> On Friday 01 December 2017 05:50 PM, Lorenzo Pieralisi wrote:
>>>> On Thu, Nov 23, 2017 at 04:01:50PM +0100, Cyrille Pitchen wrote:
>>>>> This patch adds support to the Cadence PCIe controller in endpoint mode.
>>>>
>>>> Please add a brief description to the log to describe the most salient
>>>> features.
>>>>
>>>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>>>> ---
>>>>>  drivers/pci/cadence/Kconfig           |   9 +
>>>>>  drivers/pci/cadence/Makefile          |   1 +
>>>>>  drivers/pci/cadence/pcie-cadence-ep.c | 553 ++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 563 insertions(+)
>>>>>  create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
> [...]
>>>>> +static int cdns_pcie_ep_write_header(struct pci_epc *epc,
>>>>> +				     struct pci_epf_header *hdr)
>>>>> +{
>>>>> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>>>> +	struct cdns_pcie *pcie = &ep->pcie;
>>>>> +	u8 fn = 0;
>>>>> +
>>>>> +	if (fn == 0) {
>>>>
>>>> I think there is some code to retrieve fn missing here.
>>>
>>> hmm.. the endpoint core has to send the function number which right now it's
>>> not doing though it has the function number info in pci_epf.
>>
>> Would it be OK if I add a new patch in the next series adding a
>> 'struct pcie_epf *epf' as a 2nd argument to all handlers in the
>> 'struct pcie_epc_ops'? This way I could have access to epf->func_no as needed.

I prefer we just pass the func_no as the second argument. Do you see a problem
with that?
>>
> 
> Except for pci_epc_start() and pci_epc_stop(), both only called from
> pci_epc_start_store(), I don't have trouble getting the epf value to be passed
> as a 2nd argument to all other handlers in 'struct pcie_epc_ops'.

pci_epc_start()/pci_epc_stop() is used to start/stop the end point controller
as a whole and shouldn't need epf.
> 
> Now my next question is: is it better to keep the 'struct pci_epc *epc' as
> the 1st argument of all those handlers or do you prefer me to remove it as
> the value can always be retrieved from epf->epc, since now we provide epf as
> a new argument ?

Do we really need to pass epf when func_no is all we need?

Thanks
Kishon
