Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:44018 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945935Ab3FUTz3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 15:55:29 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so10022913oag.32
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 12:55:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t_qrzLqeR6tZ8ykbFEzx0dZtCREjz9wCwCDTDDFwic6-Q@mail.gmail.com>
References: <CAH9N0t_qrzLqeR6tZ8ykbFEzx0dZtCREjz9wCwCDTDDFwic6-Q@mail.gmail.com>
Date: Fri, 21 Jun 2013 12:55:28 -0700
Message-ID: <CAE9FiQWJV=NPn9yBX2nQ9z8hFc4_9tNHm5BWwsY4dG_h7yYmvA@mail.gmail.com>
Subject: Re: PCIe Hotplug Script Automatization.
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 21, 2013 at 12:19 PM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> pciehp is installed on system boot with modprobe pciehp pciehp_force=1.
> acpiphp.ko is loaded with modprobe acpiphp but it gives an error message
> saying that module acpiphp.ko does not exist although is there. Also if i
> run dmesg it apears in the dmesg-print info.
> Can you explain me the automatization mechanism?

What is kernel version ?

for v3.10-RC, acpiphp would get enabled always before pciehp.
will need to have acpiphp.disable to skip that.

when pciehp is loaded for pcie port, it will request msi irq to handle
hotplug.
when you put the card in and press the attension button.
hotplug controller will generate one MSI.
so pciehp will get enable the slot and scan the pci device.
drivers core will load pci driver for new added pci cards.

So you need to make sure your have pciehp work properly.

Yinghai
