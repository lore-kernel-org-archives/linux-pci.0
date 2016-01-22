Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:55950 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbcAVVbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jan 2016 16:31:10 -0500
Subject: Re: iProc bus scanning regression (after "PCI: iproc: Add PAXC
 interface support")
To: Ray Jui <rjui@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
References: <CACna6rx2t7Zg_xSVvYqZTW2dYEgRugaorV58Zy1YZ4Wy=+L4fQ@mail.gmail.com>
 <CACna6rzMK4Htci8AucHVi1TNjBkxdQiy60MWJ234J8=4B_vteA@mail.gmail.com>
 <569F41B1.6000005@broadcom.com>
 <CACna6rxyMoarw=Yq93gijXeXx5bm35hzAs-+9w3SaXg7e1thtQ@mail.gmail.com>
 <569FC9FA.4090607@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Hante Meuleman <meuleman@broadcom.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <56A29F99.8020207@hauke-m.de>
Date: Fri, 22 Jan 2016 22:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <569FC9FA.4090607@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/20/2016 06:55 PM, Ray Jui wrote:
> Hi Rafal,
> 
> On 1/20/2016 8:43 AM, Rafał Miłecki wrote:
>> On 20 January 2016 at 09:13, Ray Jui <rjui@broadcom.com> wrote:
>>> On 1/19/2016 11:02 PM, Rafał Miłecki wrote:
>>>>
>>>> On 20 January 2016 at 07:53, Rafał Miłecki <zajec5@gmail.com> wrote:
>>>>>
>>>>> In OpenWrt trunk code we use iProc driver for PCIe controllers on bcma
>>>>> bus (PCIE_IPROC_BCMA). Right now we use 4.1 kernel but we backported
>>>>> all iProc changes. Unfortunately backporting set queued for 4.5 broke
>>>>> bus scanning on some routers.
>>>>>
>>>>> Most BCM4708 / BCM4709 chipsets have 3 PCIe controllers. All known
>>>>> routers use only first 2 of them. Even if router has 3 PCIe cards, the
>>>>> last two cards are connected to the 2nd PCIe controller.
>>>>>
>>>>> So that PAXC patch broke support for routers with 3 cards, 2 of them
>>>>> at the 2nd controller. It doesn't affect routers with just 2 cards.
>>>>> This problem was tracked down in:
>>>>> https://dev.openwrt.org/ticket/21393
>>>>>
>>>>> I'm attaching two OpenWrt boot logs.
>>>>> 1) r48381
>>>>> It contains all backported iProc changes. The log looks "nice", but
>>>>> only one card (0000:01:00.0) was detected.
>>>>> 2) r48382
>>>>> It contains "Revert "PCI: iproc: Add PAXC interface support"" patch.
>>>>> It contains many "[Firmware Bug]: reg 0x??: invalid BAR (can't size)"
>>>>> messages but there are all 3 cards detected: 0000:01:00.0,
>>>>> 0001:03:00.0 and 0001:04:00.0 (see brcmfmac messages).
>>>>>
>>>>> Can you take a look at this problem, please?
>>>>
>>>>
>>>> linux-arm-kernel@ stopped my e-mail due to its size. Sending
>>>> compressed attachments.
>>>>
>>>
>>> I'm a bit confused by these logs that you provided. Based on the log,
>>> there
>>> seems to be 3 PCIe root complexes populated on the platform, domain
>>> 0000:00:00.0, 0001:00:00:0, 0002:00:00:0 are the 3 root complexes. Root
>>> complex 0002 seems to have nothing connected since it does not detect
>>> any
>>> EP.
>>>
>>> Is the first card installed on root complex 0 (domain 0000), but the
>>> second
>>> card and 3rd card are both installed on root complex 1 (domain 0001) on
>>> different slots or something?
>>>
>>> I suspect a potential issue is in this function:
>>>
>>> 173 static inline bool iproc_pcie_device_is_valid(struct iproc_pcie
>>> *pcie,
>>> 174                                               unsigned int slot,
>>> 175                                               unsigned int fn)
>>> 176 {
>>> 177         if (slot > 0)
>>> 178                 return false;
>>> 179
>>> 180         /* PAXC can only support limited number of functions */
>>> 181         if (pcie->type == IPROC_PCIE_PAXC && fn >= MAX_NUM_PAXC_PF)
>>> 182                 return false;
>>> 183
>>> 184         return true;
>>> 185 }
>>>
>>> Compared to the original code, it's different. Can you try passing bus
>>> number into the function as another argument and do the following
>>> check on
>>> line 177:
>>>
>>> if (busnum == 0 && slot > 0)
>>>      return false;
>>>
>>> instead of
>>>
>>> if (slot > 0)
>>>      return false;
>>
>> This did work, thanks! I can see again all these scary
>> [Firmware Bug]: reg 0x??: invalid BAR (can't size)
>> messages but also all 3 cards were detected!
>>
>> Will you submit a patch for this, please?
>>
> 
> Thanks for helping to test.
> 
> Let me run a few tests on my platforms today and after that I'll submit
> a fix.
> 
> Thanks,
> 
> Ray

Rafał is this a device with this PCIe switch chip? So are there really 2
PCie devices connetced to the 2nd controller?

To use the 3rd PCIe controller some special PCIe Phy setup is needed and
as far as I understood USB 3.0 will not work any more in this case,
because they are sharing the same Phy.

Hauke
