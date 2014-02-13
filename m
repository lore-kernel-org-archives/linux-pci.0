Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:39034 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbaBMTwx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 14:52:53 -0500
Received: by mail-vb0-f45.google.com with SMTP id m10so8475300vbh.18
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2014 11:52:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
	<1392236171-10512-4-git-send-email-will.deacon@arm.com>
	<D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
	<20140213110721.GC13576@mudshark.cambridge.arm.com>
	<BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
Date: Thu, 13 Feb 2014 13:52:52 -0600
Message-ID: <CAL_JsqJ=yw5b++tR5Be1hd9Bn5-h26-qaY7ndKREebztLcMo0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
From: Rob Herring <robherring2@gmail.com>
To: Kumar Gala <galak@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 10:22 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Feb 13, 2014, at 5:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>
>> On Wed, Feb 12, 2014 at 09:51:48PM +0000, Kumar Gala wrote:
>>>
>>> On Feb 12, 2014, at 2:16 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>
>>>> This patch adds support for a generic PCI host controller, such as a
>>>> firmware-initialised device with static windows or an emulation by
>>>> something such as kvmtool.
>>>>
>>>> The controller itself has no configuration registers and has its address
>>>> spaces described entirely by the device-tree (using the bindings from
>>>> ePAPR). Both CAM and ECAM are supported for Config Space accesses.
>>>>
>>>> Corresponding documentation is added for the DT binding.
>>>>
>>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>> ---
>>>> .../devicetree/bindings/pci/arm-generic-pci.txt    |  51 ++++
>>>> drivers/pci/host/Kconfig                           |   7 +
>>>> drivers/pci/host/Makefile                          |   1 +
>>>> drivers/pci/host/pci-arm-generic.c                 | 318 +++++++++++++++++++++
>>>> 4 files changed, 377 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/pci/arm-generic-pci.txt
>>>> create mode 100644 drivers/pci/host/pci-arm-generic.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/arm-generic-pci.txt b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
>>>> new file mode 100644
>>>> index 000000000000..cc7a35ecfa2d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
>>>> @@ -0,0 +1,51 @@
>>>> +* ARM generic PCI host controller
>>>> +
>>>> +Firmware-initialised PCI host controllers and PCI emulations, such as the
>>>> +virtio-pci implementations found in kvmtool and other para-virtualised
>>>> +systems, do not require driver support for complexities such as regulator and
>>>> +clock management. In fact, the controller may not even require the
>>>> +configuration of a control interface by the operating system, instead
>>>> +presenting a set of fixed windows describing a subset of IO, Memory and
>>>> +Configuration Spaces.
>>>> +
>>>> +Such a controller can be described purely in terms of the standardized device
>>>> +tree bindings communicated in pci.txt:
>>>> +
>>>> +- compatible     : Must be "arm,pci-cam-generic" or "arm,pci-ecam-generic"
>>>> +                   depending on the layout of configuration space (CAM vs
>>>> +                   ECAM respectively)
>>>
>>> What's arm specific here?  I don't have a great suggestion, but seems odd
>>> for this to be vendor prefixed with "arm".
>>
>> Happy to change it, but I'm also struggling for names. Maybe "linux,..."?
>
> I was thinking that as well, I'd say go with "linux,".

Just drop the prefix altogether.

I'm wondering if this should have host or rc in the name.

Rob
