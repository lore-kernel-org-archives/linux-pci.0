Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:36738 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbG0SpB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 14:45:01 -0400
Subject: Re: [PATCH v4 3/4] arm64: Add Broadcom iProc family support
To: Olof Johansson <olof@lixom.net>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-4-git-send-email-rjui@broadcom.com>
 <20150724085103.GA30410@arm.com> <55B25CF7.4070403@broadcom.com>
 <CAOesGMgM1_F3JRKmS3mYJJZUYUTHYLbYjCD1oOh0PNREMa3FKQ@mail.gmail.com>
CC: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55B67C28.4010706@broadcom.com>
Date: Mon, 27 Jul 2015 11:44:56 -0700
MIME-Version: 1.0
In-Reply-To: <CAOesGMgM1_F3JRKmS3mYJJZUYUTHYLbYjCD1oOh0PNREMa3FKQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Olof,

On 7/27/2015 11:35 AM, Olof Johansson wrote:
> On Fri, Jul 24, 2015 at 5:42 PM, Ray Jui <rjui@broadcom.com> wrote:
>> Hi Will,
>>
>> On 7/24/2015 1:51 AM, Will Deacon wrote:
>>> (adding Olof)
>>>
>>> On Wed, Jul 22, 2015 at 02:29:42AM +0100, Ray Jui wrote:
>>>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>>>> in the arm64 Kconfig and defconfig files
>>>>
>>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>> ---
>>>>  arch/arm64/Kconfig           |    5 +++++
>>>>  arch/arm64/configs/defconfig |    2 ++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 318175f..969ef4a 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>>>
>>>>  menu "Platform selection"
>>>>
>>>> +config ARCH_BCM_IPROC
>>>> +    bool "Broadcom iProc SoC Family"
>>>> +    help
>>>> +      This enables support for Broadcom iProc based SoCs
>>>> +
>>>
>>> The arm-soc guys have a patch moving the platform-related config options
>>> out into Kconfig.platforms, so I think you need to co-ordinate with them.
>>>
>>
>> Thanks for letting me know. I see that those patches are already merged
>> into for-next under arm-soc. I guess I should generate a new patch
>> series based on for-next and move this config option to Kconfig.platform?
>>
>> Olof, any comment?
> 
> Yeah, please do that and send that series with arm@kernel.org on cc,
> we'll apply it from there!
> 
> 
> Thanks,
> 
> -Olof
> 

Note this patch series contains some iProc PCIe patches as per-requsite
that need to be applied before the ARCH_BCM_IPROC arm64 patch. Without
the PCIe patch, arm64 build out of defconfig would be broken.

Bjorn has acked the PCIe patches. I'll re-send the entire patch series
to you and arm@kernel.org and you can merge them there.

Thanks,

Ray
