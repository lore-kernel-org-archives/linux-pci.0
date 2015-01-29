Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33532 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbbA2UFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 15:05:31 -0500
Received: by mail-qg0-f53.google.com with SMTP id a108so33485108qge.12
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2015 12:05:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <262B8C88-E706-4538-99D8-4E5058BE646D@ravnalaska.net>
References: <262B8C88-E706-4538-99D8-4E5058BE646D@ravnalaska.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Jan 2015 14:05:08 -0600
Message-ID: <CAErSpo7f=qAPiNDAjVgVttJyVQhZmh1bd=9b+_Z7rgmtUUzL3Q@mail.gmail.com>
Subject: Re: CentOS/Kernel 3.18.4/Thunderbolt2
To: Israel Brewster <israel@ravnalaska.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 29, 2015 at 1:46 PM, Israel Brewster <israel@ravnalaska.net> wrote:
> My company recently purchased and installed a new SuperMicro server with a Thunderbolt 2 (Falcon Ridge) card installed, specifically an AOC-TBT-DSL5320. I then installed CentOS 6, and, since to my understanding thunderbolt support is only in more recent kernels, I went ahead and upgraded the kernel to version 3.18.4 from ElRepo. However, I have not seen any indication yet that Thunderbolt is working - although I may just not be looking in the right place. Over on Google+ Greg Kroah-Hartman indicated that I need the PCI hot plug controller driver enabled, and Matthew Garrett indicated that I specifically need the ACPI PCI hotplug driver rather than the native PCIe hotplug driver. To check, I ran the following command:
>
> egrep -i HOTPLUG /boot/config-3.18.4-1.el6.elrepo.x86_64
>
> Which returned the following potentially relevant results:
>
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_HOTPLUG_PCI=y
>
> but also the following:
>
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
>
> So perhaps that's the entire problem - that CONFIG_HOTPLUG_PCI_ACPI is not set? If so, what's going to be the easiest solution?

Yep, if you need the ACPI PCI hotplug driver, CONFIG_HOTPLUG_PCI_ACPI
should be enabled.  I think you should be able to use "make
menuconfig" to enable it at:

  Bus options
    Support for PCI Hotplug
      ACPI PCI Hotplug driver

I'm not  RedHat/CentOS person, so I don't know the distro details, but
I would try "make install" as a starting point.
