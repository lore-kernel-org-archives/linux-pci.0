Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Malte =?iso-8859-2?q?Schr=F6der?= <maltesch@gmx.de>
Subject: Re: PCI ACPI/IRQ-routing broken on H77 chipset + Ivy Bridge (kernel 3.5-rc7 and earlier)
Date: Sun, 15 Jul 2012 22:25:48 +0200
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <5002BC55.3050107@gmx.de>
In-Reply-To: <5002BC55.3050107@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Message-Id: <201207152225.49154.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC-ing linux-pci and Bjorn.

On Sunday, July 15, 2012, Malte Schröder wrote:
> Hello,
> this is yet another try to get someone to look at this ;)
> 
> I can't get PCI-devices to work on my DH77KC mainboard. I tested this
> using an AVM B1 ISDN card, a Fritz!PCI card and an old 3Com 905c NIC.
> I attached some dumps in case it helps. The CPU is a Core i7 3770.
> 
> PCI hardware is detected by the kernel, but it gives IRQ errors. Using
> irqpoll allows the PCI card to somewhat work, but it is unreliable.
> 
> There are some reports in Intel's support forums that also report
> PCI-problems with this mainboard, but Intel doesn't seem to be
> interested. So I hope this is something that is fixable on the kernel side.
> 
> If there is more information needed, please let me know.
> 
> 
> 

