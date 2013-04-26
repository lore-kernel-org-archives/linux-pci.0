Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55881 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab3DZWtc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2013 18:49:32 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so5592325ieb.31
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2013 15:49:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4SKVeCYwP6n+ra03=wCUyKeAwK2F1_ZWsU3Anidmf2_A@mail.gmail.com>
References: <CAErSpo5_4HfGP_-4jzQCBHok6tFvAmCg+6G4_b9fYX=vuA00hg@mail.gmail.com>
	<CAE9FiQVKkfGMAy3vVALjaSTXK-n1ZiaLwPm7GEgNQXiOhe9bMA@mail.gmail.com>
	<CAErSpo4SKVeCYwP6n+ra03=wCUyKeAwK2F1_ZWsU3Anidmf2_A@mail.gmail.com>
Date: Fri, 26 Apr 2013 15:49:31 -0700
Message-ID: <CAE9FiQW5yy=fks=AZVa=kQOZ7g4__pqk-r3wfDwbrJ3UL5+Zhw@mail.gmail.com>
Subject: Re: device_unregister() for PCI host bridge removal
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 26, 2013 at 3:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>
>     acpi_pci_root_remove
>       pci_stop_root_bus
>         device_del(&host_bridge->dev)
>       pci_remove_root_bus
>         put_device(&host_bridge->dev)
>
> This seems unnecessarily difficult to analyze.  It would be better if
> we had symmetric device_register()/device_unregister() paths, or if
> that can't be done, symmetric device_add()/device_del() paths.
>
> Don't bother to generate a quick patch to just replace
> device_register() with explicit calls to device_initialize() and
> device_add(), though.  Maybe someday we can clean up that and more.
> Anyway, thanks for fixing my confusion.

Yes, Jiang Liu at some pointer to split device_register() to
device_add and put device.
but is get dropped ...
