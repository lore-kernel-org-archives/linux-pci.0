Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35488 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcGFRxX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 13:53:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id z126so120718181wme.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2016 10:53:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN7O0+KWutzXSX5Y_Ud9pspzghOEMx6iFo-56n1TJ3UW1t5RwQ@mail.gmail.com>
References: <CAN7O0+JsyQZd_BKNHYSzzyq0LePsT2U3iwC=VdJsjFW5iicHqA@mail.gmail.com>
 <CAN7O0+KWutzXSX5Y_Ud9pspzghOEMx6iFo-56n1TJ3UW1t5RwQ@mail.gmail.com>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Wed, 6 Jul 2016 10:53:21 -0700
Message-ID: <CAH=XD58Y8w5y-PQipAUutLguOuSwz45TVEv67rVoEzTu-4VT+w@mail.gmail.com>
Subject: Re: Need some help with pciehp hot-plug driver
To: vidya sagar <sagar.tv@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do not know if we really need ACPI for PCIe HP to work.

As long as the switch ports is capable of Hotplug operations and have
MSI vector to interrupt Linux OS should be able to work.

I have verified existing hotplug features on linux and extended for a
switch appliance. Both control and surprise hotplug work.

I used Cent 6.7 as well as Linux-3.8.1 kernel.

You should take a look at:

https://www.kernel.org/doc/ols/2005/ols2005v2-pages-9-18.pdf

and also hot plug specs.


On Tue, Jul 5, 2016 at 11:53 PM, vidya sagar <sagar.tv@gmail.com> wrote:
>
> Hi,
> I was going through the video
> https://www.youtube.com/watch?v=oCJOkoRvsSk and at 3:00 , it is
> mentioned that hot-plugging a switch is not supported by pciehp as of
> that date. Would like to know if it is supported in 3.18 or 4.4
> versions? I'm looking for pciehp support on an ARM platform and it
> doesn't have any ACPI.
> Also, Can you please help me with any links for the hot-plug framework
> (particularly pciehp) documentation if any?
>
> Thanks,
> Vidya Sagar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
