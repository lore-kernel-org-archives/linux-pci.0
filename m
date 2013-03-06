Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:48309 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3CFEJW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2013 23:09:22 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so3177106obc.40
        for <linux-pci@vger.kernel.org>; Tue, 05 Mar 2013 20:09:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50EDF8FE.6040607@fold.natur.cuni.cz>
References: <50EDF8FE.6040607@fold.natur.cuni.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 5 Mar 2013 21:09:01 -0700
Message-ID: <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi,
>   I am following up on a former thread
> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
> It happened to me that my hotplug of express cards stopped working so it made me to
> to dive in a figure out what driver did I do to my .config, and what combinations
> of drivers and kernel command-line parameters work and which not. This email will
> cover just one case.
>
> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
> is that I must use pcie_aspm=off.

I confess I am completely bewildered here.  Something is clearly badly
broken, but I'm having a hard time figuring out exactly what it is.  I
think I'm overwhelmed by all the data :)

>From your previous "3.2.11: PCI Express card cannot be re-detected
withing cca 60sec timeframe" thread, I think:

1) With pciehp, insertion and removal of an NEC uPD720200 USB3.0 card
doesn't work correctly [1].  The insertion/removal events don't seem
to be detected immediately.
2) Insertion/removal of firewire card works correctly [2]
3) Insertion/removal of AXAGO ECA-SP serial/parallel card works correctly [3]
4) When the xhci driver is not loaded, insertion/removal events of the
NEC USB3.0 card *are* detected correctly [4]

The ExpressCard slot is below the 00:1c.7 root port, and this port
supports native PCIe hotplug.  When CONFIG_HOTPLUG_PCI_PCIE=y, Linux
requests control over PCIe native hotplug, and I think your BIOS
grants it.

In this thread ("Dell Vostro 3550: pci_hotplug+acpiphp require
'pcie_aspm=force' on kernel command-line for hotplug to work"), I
think you are saying that if you disable pciehp and use acpiphp and
the "pcie_aspm=off" parameter, the ExpressCard slot works perfectly.

But I think it's a bad idea to go down the road of using acpiphp.
Native PCIe hotplug (pciehp) is the default when it is supported, and
as far as I can tell, it *is* supported on this system.  If we had
some indication that it's not supported, e.g., if the BIOS declined to
grant us control over PCIe native hotplug, then of course we would
fall back to using acpiphp.  But I don't think we do, so we should
figure out how to make pciehp work.

If it's really true that pciehp works perfectly except when xhci is
loaded, that seems like a good clue, and we should look for some
interaction between xhci and pciehp.

Martin, can you confirm my assumptions above or correct any mistakes I made?

Bjorn


[1] http://marc.info/?l=linux-pci&m=133236584826563&w=1
[2] http://marc.info/?l=linux-pci&m=133457374507707&w=1
[3] http://marc.info/?l=linux-pci&m=133460527222076&w=1
[4] http://marc.info/?l=linux-kernel&m=133547823904339&w=1
