Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56596 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbaGEWWK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 18:22:10 -0400
Received: by mail-qa0-f53.google.com with SMTP id j15so2323861qaq.26
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 15:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKb7UviYak+Jt6+RGFZc=OtNh2DVJaCvxnBpRRkw7zVn8u+9Vw@mail.gmail.com>
References: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>
 <53B4F0F7.9020403@huawei.com> <CALhae2jRz8hL0bwySAbP7r+vJGOG5aif4GA_Yjp0inGAwz5JEA@mail.gmail.com>
 <53B612FE.4080105@huawei.com> <CAKb7UviVFQYwYdp_dgxK7jJ5Ny9yG1y8LATydxtVtkzRh+aOKw@mail.gmail.com>
 <53B61B03.3070308@huawei.com> <CAKb7UvjFuu4Hm1pfmY-NMFORfv-+fx4oYeJicRoE8UTL_4Wp4A@mail.gmail.com>
 <53B625D9.9080500@huawei.com> <CAKb7UviYak+Jt6+RGFZc=OtNh2DVJaCvxnBpRRkw7zVn8u+9Vw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 5 Jul 2014 16:21:49 -0600
Message-ID: <CAErSpo7Dk+7THPn2SUO1p-P0bbfP7nSyOoiukXLgMsuGoJrMOA@mail.gmail.com>
Subject: Re: How to check for proper MSI support?
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Brian Becker <brian.johnathan.b@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 3, 2014 at 10:32 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> So let me get this straight -- you're suggesting I add a quirk for
> every PCI chipset that doesn't support MSI? There are probably
> hundreds of these... anything made before 1999 or so, and probably a
> bunch since then too. There _has_ to be a way to do this generically.
> Is the PCI spec version anywhere in the root hub?
>
> Perhaps we can check if every bridge on the way to the CPU has the MSI
> capability (including the root hub)? (And naturally _that_ won't
> work... on my sandybridge laptop, the host bridge doesn't have the MSI
> cap but the system most definitely supports MSI.)
>
> Adding Bjorn... perhaps you know? Some of the info has been stripped
> out by now, you can see the full lspci -vvvxxx at
> http://marc.info/?l=linux-pci&m=140443441730503&w=2

Huh, this stinks.  We don't really have a good way of figuring out
whether the system chipset supports MSI.  The ACPI FADT "MSI Not
Supported" bit (ACPI_FADT_NO_MSI) was added to the ACPI v3.0b spec in
October 2006, so that won't help the systems that predate that or
don't have ACPI.

We have quirks for some Serverworks, ATI, and VIA chipsets that
basically do the same as booting with "pci=nomsi".  But as you say,
it's unreasonable to add quirks for all old systems.

Brian, can you open a report at http://bugzilla.kernel.org and attach
a complete dmesg log, /proc/cpuinfo contents, and "lspci -vvv" output?

If I understand correctly, you have a P200MMX with a 430FX chipset.
I'm not a hardware guy, but sounds like that might be a 200MHz Pentium
with MMX (P54CS), which does have an integrated LAPIC, according to
wikipedia.

>From the PCI host bridge's perspective, an incoming MSI just looks
like a normal DMA write.  As long as that write reaches the CPU LAPIC,
it should work fine.  There's not really any specific MSI support
required, except to route the incoming write to the CPU LAPIC.  So
it's possible that a bridge designed before MSI was added to the PCI
spec might be able to support MSI.

But I don't know how much value there is in MSI on such old systems.
Maybe we could default to disabling MSI on BIOS dates before 1998 or
something.

Bjorn
