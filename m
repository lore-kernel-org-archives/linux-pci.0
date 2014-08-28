Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:56540 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaH1EVx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Aug 2014 00:21:53 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so7416691iga.4
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2014 21:21:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5KBNmeh+pjZXyk47w28tHr95kO64KJKBKSky9ODWuM2w@mail.gmail.com>
References: <CAErSpo5KBNmeh+pjZXyk47w28tHr95kO64KJKBKSky9ODWuM2w@mail.gmail.com>
Date: Wed, 27 Aug 2014 21:21:50 -0700
Message-ID: <CAE9FiQW2WSAB93F80toP+MQAGrOd3CkM9-a=J0kW+d7YVaL87Q@mail.gmail.com>
Subject: Re: pciehp PCI_BASE_CLASS_DISPLAY check
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 27, 2014 at 3:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>
> Only pciehp_configure_device() has the PCI_BASE_CLASS_DISPLAY check.

That commit actually split the loop to two loops, so second loop still
have check.

but later

| Author: Praveen Kalamegham <praveen@nextio.com>
| Date:   Wed May 19 17:03:12 2010 -0500
|
|    PCI: hotplug: pciehp: Removed check for hotplug of display devices
|
|    Removed check to prevent hotplug of display devices within pciehp.
|    Originally this was thought to have been required within the PCI
|    Hotplug specification for some legacy devices.  However there is
|    no such requirement in the most recent revision. The check prevents
|    hotplug of not only display devices but also computational GPUs
|    which require serviceability.

only removed the first one in pciehp_configure_device().

So you can drop that checking.

Thanks

Yinghai
