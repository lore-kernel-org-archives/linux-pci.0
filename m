Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42879 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbcGUKLd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2016 06:11:33 -0400
Subject: Re: [PATCH 2/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
To: Jisheng Zhang <jszhang@marvell.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
 <1467802782-3024-3-git-send-email-jszhang@marvell.com>
 <2e9d2b8c-f4c3-aa6d-38be-314213db7727@synopsys.com>
 <20160718103851.7cd3984a@xhacker>
CC: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <c79de6c7-5d86-4090-085b-63163d2467e7@synopsys.com>
Date: Thu, 21 Jul 2016 11:11:23 +0100
MIME-Version: 1.0
In-Reply-To: <20160718103851.7cd3984a@xhacker>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Jisheng,

On 7/18/2016 3:38 AM, Jisheng Zhang wrote:
> Dear Joao,
> 
> On Fri, 15 Jul 2016 16:10:24 +0100 Joao Pinto wrote:
> 
>> Hi,
>>
>> On 7/6/2016 11:59 AM, Jisheng Zhang wrote:
>>> The link may be UP but still in link training. In this case, we can't
>>> think the link is up and operating correctly. So we need to teach
>>> dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.
>>>
>>> This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
>>> it's consistent with other MACROS.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> ---
>>>  drivers/pci/host/pcie-designware.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>> index 9df879a..29e10dd 100644
>>> --- a/drivers/pci/host/pcie-designware.c
>>> +++ b/drivers/pci/host/pcie-designware.c
>>> @@ -73,7 +73,8 @@
>>>  /* PCIe Port Logic registers */
>>>  #define PLR_OFFSET			0x700
>>>  #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
>>> -#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
>>> +#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
>>> +#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)  
>>
>> According to the databook bit 29 is inside a range that is dedicated to M-PCIe.
>> Have you checked bit 29 state by experience?
> 
> bit 29 here is bit 61 of cxpl_debug_info(64bit) in databook, the debug info is
> composited by debug 0 and debug 1 registers.

You are absolutely correct... I misread the databook in this subject.
In the latest Core versions this is also valid.

Acked-By: Joao Pinto <jpinto@synopsys.com>
