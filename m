Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45005 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbbBGTml (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 14:42:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo6MV_obn_31J3zTSfR0ke7kNYdr0mxgyuMYstr5RJcQHA@mail.gmail.com>
References: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6MV_obn_31J3zTSfR0ke7kNYdr0mxgyuMYstr5RJcQHA@mail.gmail.com>
Date: Sat, 7 Feb 2015 11:42:41 -0800
Message-ID: <CAE9FiQXsk3WK2K6nXrcFczY8oNhn=AiW--Ks7xT+0e_3Z-HHDg@mail.gmail.com>
Subject: Re: [PATCH] PCI: disable auto realloc detection for lsi devices
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"3.12+" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 7, 2015 at 6:14 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> The BIOS sets the BAR.  Why does the device work when the BIOS sets
> the BAR but not when Linux does?

If you reset the firmware with disable/enable pcie link, the new BAR will
work.
...
>
>
> This is pretty ugly.  Do you have evidence that *all* LSI devices have
> an issue like this?

I hit the problem when I was working on pci bus number allocation ...
all lsi cards that I touch including the ones that use mpt2sas and megaraid_sas
have this problem.

I guess they are sharing some core code in the firmware.

>
> Can you use the usual quirk style rather than polluting common code
> paths like this?
>
> There's an IORESOURCE_PCI_FIXED flag that might be useful in this situation.
>

Let me check if i can have that work when pci=realloc is passed via command.

Yinghai
