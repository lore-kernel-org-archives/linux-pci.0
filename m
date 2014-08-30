Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:51584 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaH3ABb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 20:01:31 -0400
Received: by mail-qc0-f178.google.com with SMTP id x13so3123361qcv.23
        for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2014 17:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW2WSAB93F80toP+MQAGrOd3CkM9-a=J0kW+d7YVaL87Q@mail.gmail.com>
References: <CAErSpo5KBNmeh+pjZXyk47w28tHr95kO64KJKBKSky9ODWuM2w@mail.gmail.com>
 <CAE9FiQW2WSAB93F80toP+MQAGrOd3CkM9-a=J0kW+d7YVaL87Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 29 Aug 2014 18:01:10 -0600
Message-ID: <CAErSpo7DvOVOKecCLkWanyZCn04hUhBX5iDYg4n2yaVgwJjLtw@mail.gmail.com>
Subject: Re: pciehp PCI_BASE_CLASS_DISPLAY check
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 27, 2014 at 10:21 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Aug 27, 2014 at 3:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>
>> Only pciehp_configure_device() has the PCI_BASE_CLASS_DISPLAY check.
>
> That commit actually split the loop to two loops, so second loop still
> have check.
>
> but later
>
> | Author: Praveen Kalamegham <praveen@nextio.com>
> | Date:   Wed May 19 17:03:12 2010 -0500
> |
> |    PCI: hotplug: pciehp: Removed check for hotplug of display devices
> |
> |    Removed check to prevent hotplug of display devices within pciehp.
> |    Originally this was thought to have been required within the PCI
> |    Hotplug specification for some legacy devices.  However there is
> |    no such requirement in the most recent revision. The check prevents
> |    hotplug of not only display devices but also computational GPUs
> |    which require serviceability.
>
> only removed the first one in pciehp_configure_device().
>
> So you can drop that checking.

Great, thanks!  I missed the fact that the check was there before.

Bjorn
