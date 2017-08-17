Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:54010 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdHQLZs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 07:25:48 -0400
Subject: Re: [PATCHv3 6/9] PCI: designware: add accessors for write permission
 of DBI read-only registers
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Cc: "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1502859419-33696-7-git-send-email-Zhiqiang.Hou@nxp.com>
 <83b0ad83-bb8f-a899-86b3-7be910eb4b51@mm-sol.com>
 <VI1PR0402MB278292DAC81D4A49964FEC1B84830@VI1PR0402MB2782.eurprd04.prod.outlook.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <6fe4dcd2-4a85-5ccc-292a-8aacca75657d@mm-sol.com>
Date: Thu, 17 Aug 2017 14:25:41 +0300
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB278292DAC81D4A49964FEC1B84830@VI1PR0402MB2782.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 08/17/2017 06:03 AM, Z.q. Hou wrote:
> Hi Stanimir,
> 
> Thanks for your feedback!
> 
>> -----Original Message-----
>> From: Stanimir Varbanov [mailto:svarbanov@mm-sol.com]
>> Sent: 2017年8月16日 19:34
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
>> bhelgaas@google.com; jingoohan1@gmail.com; Joao.Pinto@synopsys.com
>> Cc: M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>;
>> Roy Zang <roy.zang@nxp.com>; niklas.cassel@axis.com;
>> jesper.nilsson@axis.com
>> Subject: Re: [PATCHv3 6/9] PCI: designware: add accessors for write
>> permission of DBI read-only registers
>>
>> Hi,
>>
>> On 08/16/2017 07:56 AM, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> The read-only DBI registers can be written over the DBI when set the
>>> "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
>>> MISC_CONTROL_1_OFF register.
>>>
>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> ---
>>> V3:
>>>  - No change
>>>
>>>  drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/pci/dwc/pcie-designware.h
>>> b/drivers/pci/dwc/pcie-designware.h
>>> index 7366c81..0c5f874 100644
>>> --- a/drivers/pci/dwc/pcie-designware.h
>>> +++ b/drivers/pci/dwc/pcie-designware.h
>>> @@ -76,6 +76,9 @@
>>>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>>>  #define PCIE_ATU_UPPER_TARGET		0x91C
>>>
>>> +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
>>> +#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
>>
>> Does those registers exist for dwc version 4.01a?
> 
> Joao, can you help to check this?
> I referred to DesignWare cores PCI Express controller databook version 4.21a.
> The Freescale Layerscape implement does not export the version of designware PCIe controller, I don't know which versions have those registers, if it does not work on qcom platform, I will remove the qcom related changes.

It won't work on two of the supported SoCs so I'd prefer to drop qcom
changes for now.

regards,
Stan
