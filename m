Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:32796 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbbG0SfH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 14:35:07 -0400
Received: by obdeg2 with SMTP id eg2so66345453obd.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2015 11:35:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B25CF7.4070403@broadcom.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
	<1437528583-855-4-git-send-email-rjui@broadcom.com>
	<20150724085103.GA30410@arm.com>
	<55B25CF7.4070403@broadcom.com>
Date: Mon, 27 Jul 2015 20:35:06 +0200
Message-ID: <CAOesGMgM1_F3JRKmS3mYJJZUYUTHYLbYjCD1oOh0PNREMa3FKQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: Add Broadcom iProc family support
From: Olof Johansson <olof@lixom.net>
To: Ray Jui <rjui@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 24, 2015 at 5:42 PM, Ray Jui <rjui@broadcom.com> wrote:
> Hi Will,
>
> On 7/24/2015 1:51 AM, Will Deacon wrote:
>> (adding Olof)
>>
>> On Wed, Jul 22, 2015 at 02:29:42AM +0100, Ray Jui wrote:
>>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>>> in the arm64 Kconfig and defconfig files
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> ---
>>>  arch/arm64/Kconfig           |    5 +++++
>>>  arch/arm64/configs/defconfig |    2 ++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 318175f..969ef4a 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>>
>>>  menu "Platform selection"
>>>
>>> +config ARCH_BCM_IPROC
>>> +    bool "Broadcom iProc SoC Family"
>>> +    help
>>> +      This enables support for Broadcom iProc based SoCs
>>> +
>>
>> The arm-soc guys have a patch moving the platform-related config options
>> out into Kconfig.platforms, so I think you need to co-ordinate with them.
>>
>
> Thanks for letting me know. I see that those patches are already merged
> into for-next under arm-soc. I guess I should generate a new patch
> series based on for-next and move this config option to Kconfig.platform?
>
> Olof, any comment?

Yeah, please do that and send that series with arm@kernel.org on cc,
we'll apply it from there!


Thanks,

-Olof
