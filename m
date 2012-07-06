Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:65081 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab2GFAOu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2012 20:14:50 -0400
Received: by vbbff1 with SMTP id ff1so5815726vbb.19
        for <linux-pci@vger.kernel.org>; Thu, 05 Jul 2012 17:14:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5_srroOSahe3tdeD_UQVfbqe4ixZtKfVJqc7a9-j3SQg@mail.gmail.com>
References: <CAJkVMNoYYb3vpP1T5Sq3nmzpwLJUG7oRxUyX5=M9byQQjW1aew@mail.gmail.com>
	<CAErSpo6PVQdu+nRJs43TJ2fCTk4papaeVLMyHZ1KbnRDCVtd0A@mail.gmail.com>
	<CAJkVMNpZaMKm8tc+axdOBySpp68_j=EegEUOO+B=cYudsxNCgw@mail.gmail.com>
	<CAErSpo5_srroOSahe3tdeD_UQVfbqe4ixZtKfVJqc7a9-j3SQg@mail.gmail.com>
Date: Thu, 5 Jul 2012 17:14:49 -0700
Message-ID: <CAE9FiQWCeBRfwA2D+GoLCv+97KbzA5c-Fv76NZz7BOyLE7HoWQ@mail.gmail.com>
Subject: Re: 64 bit address to a pcie card
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: sumit chaudhary <flyingbee.linux@gmail.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 5, 2012 at 8:16 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [Added back cc: linux-pci so others can help, too]
>
> What exactly is the problem?  Is there a device that isn't working as expected?
>
> The device at 07:00.0 does indeed have 64-bit BARs, and they happen to
> be assigned addresses below 4GB:
>
> pci 0000:07:00.0: reg 10: [mem 0xfddff000-0xfddfffff 64bit]
> pci 0000:07:00.0: reg 18: [mem 0xbf000000-0xbfffffff 64bit pref]
> pci 0000:07:00.0: reg 20: [mem 0x40000000-0x7fffffff 64bit pref]
>
> This is perfectly normal.  The fact that the BAR supports a full
> 64-bit address doesn't mean it has to be assigned space above 4GB.
> The BIOS assigned these addresses, and Linux found no reason to change
> them, so we just left them alone.

The system only has 1G ram installed, and the card need 1G 64bit pref.

Maybe BIOS could push that above 4G, if the system get 4G RAM installed.

Yinghai
