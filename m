Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaBNTqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 14:46:24 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCI memory BAR assigned by u-boot not honored when using recent
 kernel
Date: Fri, 14 Feb 2014 19:46:18 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704696859@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704695360@DFLE11.ent.ti.com>
	<20140214164444.GA29491@google.com>
	<3E54258959B69E4282D79E01AB1F32B704696651@DFLE11.ent.ti.com>
 <CAE9FiQWRvQNpGXhDJXFGV1rhqPrRctBO5HO9dzwGk1xSzJgE=Q@mail.gmail.com>
In-Reply-To: <CAE9FiQWRvQNpGXhDJXFGV1rhqPrRctBO5HO9dzwGk1xSzJgE=Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of Yinghai Lu
>Sent: Friday, February 14, 2014 2:24 PM
>To: Karicheri, Muralidharan
>Cc: Bjorn Helgaas; linux-pci@vger.kernel.org
>Subject: Re: PCI memory BAR assigned by u-boot not honored when using recent kernel
>
>On Fri, Feb 14, 2014 at 9:32 AM, Karicheri, Muralidharan
>>>There is no guarantee that the kernel will keep the BAR assignments
>>>done by firmware or a bootloader.  Usually the kernel *does* keep
>>>them, as long as they are valid, but you can not rely on that.
>
>Not sure what arch in your case.
>
Yinghai,

Thanks for the response

The arch is ARM 32bit (V7 cortex A8 processor)

>You need to have code like pcibios_resource_survey() in x86 to checking and reserve
>resource from firmware.
>
>Also firmware need to make sure mmio assignments are valid otherwise kernel will reject
>and reassign a new one.
>

I see pcibios_resource_survey() is used only on non ARM architectures. This driver works fine on
v3.10 kernel, but got issues with v3.13. So I am currently debugging this.

Murali
>Thanks
>
>Yinghai
