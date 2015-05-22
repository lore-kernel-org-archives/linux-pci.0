Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33831 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161057AbbEVSG7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2015 14:06:59 -0400
Received: by qgez61 with SMTP id z61so13085490qge.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2015 11:06:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555F5885.70105@mm-sol.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
 <1430743338-10441-3-git-send-email-svarbanov@mm-sol.com> <554783CD.50708@ti.com>
 <55478F1A.3000401@mm-sol.com> <20150519224143.GS31666@google.com>
 <555C8743.6020708@ti.com> <CAErSpo42N8YHWjrqUCj0ubqZLt4w-3g=ykPdR8ZMmWaW1GjWDw@mail.gmail.com>
 <555F5885.70105@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 May 2015 13:06:37 -0500
Message-ID: <CAErSpo6Cv+XOjA+ddds4i4YXCC4f=igR4MTcRwFO5eWLg-=LVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] phy: qcom: Add Qualcomm PCIe PHY
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo, Pratyush]

On Fri, May 22, 2015 at 11:25 AM, Stanimir Varbanov
<svarbanov@mm-sol.com> wrote:
> On 05/20/2015 04:23 PM, Bjorn Helgaas wrote:
>> On Wed, May 20, 2015 at 8:08 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Hi Bjorn,
>>>
>>>
>>> On Wednesday 20 May 2015 04:11 AM, Bjorn Helgaas wrote:
>>>>
>>>> On Mon, May 04, 2015 at 06:24:10PM +0300, Stanimir Varbanov wrote:
>>>>>
>>>>> On 05/04/2015 05:35 PM, Kishon Vijay Abraham I wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Monday 04 May 2015 06:12 PM, Stanimir Varbanov wrote:
>>>>>>>
>>>>>>> Add a PCIe PHY driver used by PCIe host controller driver
>>>>>>> on Qualcomm SoCs like Snapdragon 805.
>>>>>>>
>>>>>>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>>>>>>> ---
>>>>>>>    drivers/phy/Kconfig         |    9 ++
>>>>>>>    drivers/phy/Makefile        |    1 +
>>>>>>>    drivers/phy/phy-qcom-pcie.c |  291
>>>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>>
>>>>>>
>>>>>> Why do you need a new PHY driver for this? Why not use the existing QCOM
>>>>>> PHY driver. I can see the registers used here in
>>>>>> phy-qcom-ufs-qmp-14nm.h?
>>>>>
>>>>>
>>>>> I agree that on first glance there are similarities, but I'm not sure
>>>>> does the PHYs are the same IP blocks. Or at least they are different
>>>>> revisions which have too many differences. So trying to combine them
>>>>> will lead to more code than now.
>>>>>
>>>>> Either way I will try to understand how many the differences are.
>>>>
>>>>
>>>> Ping, where are we with this?  Should I wait for something else, or are
>>>> you
>>>> convinced there's enough difference to warrant a new PHY driver, Kishon?
>>>
>>>
>>> I'd like to wait to see if Stanimir can use existing driver instead of
>>> creating a new driver.
>>
>> OK, I'm waiting for a v3 with either tweaks to the QCOM PHY driver, or
>> stronger justification as to why that's impossible.  It's hard to
>> quantify statements like "there are similarities, but there are too
>> many differences," so you might have to actually attempt a patch for
>> the QCOM code and we can see how ugly that would turn out to be.
>
> Kishon,
>
> I'm still checking the differences, sorry for the delay.
>
> Bjorn, is the pcie driver looks good enough to be merged?

I haven't looked at that (I was waiting until I could deal with the
whole series).  But it sounds like it would be useful to merge patches
3-5 by themselves?  I'll take a look at those.

It would be good to get Arnd and Rob to take a look, especially at the DT parts.

And Jingoo and Pratyush since you use the DesignWare core.

Bjorn
