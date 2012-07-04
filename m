Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57837 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab2GDN7e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 09:59:34 -0400
Received: by lbbgm6 with SMTP id gm6so11228126lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 04 Jul 2012 06:59:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJkVMNoYYb3vpP1T5Sq3nmzpwLJUG7oRxUyX5=M9byQQjW1aew@mail.gmail.com>
References: <CAJkVMNoYYb3vpP1T5Sq3nmzpwLJUG7oRxUyX5=M9byQQjW1aew@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 4 Jul 2012 07:59:12 -0600
Message-ID: <CAErSpo6PVQdu+nRJs43TJ2fCTk4papaeVLMyHZ1KbnRDCVtd0A@mail.gmail.com>
Subject: Re: 64 bit address to a pcie card
To: sumit chaudhary <flyingbee.linux@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 4, 2012 at 12:33 AM, sumit chaudhary
<flyingbee.linux@gmail.com> wrote:
> Hi,
> I have a 64 bit PCIe card that is connected to 64 bit PC running
> ubuntu (Linux ubuntu 3.0.0-12-generic #20-Ubuntu SMP Fri Oct 7
> 14:56:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux). Linux enumerate
> this PCIe card and assign 64 bit addresses to 64 bit BARS.
>
> Problem is that higher 4 bytes of these addresses are zero, even if
> they are 64 bit address
> they lies in 32 bit range.
>
> Is it somehow possible to assign real 64 bit addresses ?
>
> This is lspci output on my ubuntu PC.
>
> Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=4K]
> Region 2: Memory at fd000000 (64-bit, prefetchable) [size=8M]
> Region 4: Memory at fc800000 (64-bit, prefetchable) [size=8M]

Thanks for this report.  64-bit addresses should work, so there must
be a problem here.  Can you collect the complete dmesg log?  That will
contain more details about exactly what's going on.  A dmesg log from
a more recent kernel, e.g., 3.4, would also be useful, just in case
this problem has already been fixed.

Bjorn
