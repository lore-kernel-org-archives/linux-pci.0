Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50309 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754548AbcKYRKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Nov 2016 12:10:55 -0500
Date: Fri, 25 Nov 2016 18:01:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161125170111.rvfszqqpsiylxv3t@pd.tnic>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
 <5e4a6800-251f-23e7-11f5-9993280fe8d5@ladisch.de>
 <20161125164622.tstsfztyojedi77b@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161125164622.tstsfztyojedi77b@ime.usp.br>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 25, 2016 at 02:53:00PM -0200, Rogério Brito wrote:
> Here is part from /proc/interrupts that contains interrupt 18 *without* irqpoll:
> 
> ---------------------------
>            CPU0       CPU1       CPU2       CPU3       
>   0:         47          0          0          0   IO-APIC   2-edge      timer
>   1:          0          0          0          2   IO-APIC   1-edge      i8042
>   7:          0          0          0          0   IO-APIC   7-edge      parport0
>   8:          0          0          0          1   IO-APIC   8-edge      rtc0
>   9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
>  10:          0          0          0          0   IO-APIC  10-edge      radeon
>  12:          0          0          0          4   IO-APIC  12-edge      i8042
>  16:          0         96          4        990   IO-APIC  16-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, snd_hda_intel:card0
>  17:          0       2457          1        140   IO-APIC  17-fasteoi   ehci_hcd:usb1
>  18:          1         11         43      99947   IO-APIC  18-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7

Can you connect the printer to a different port so that it doesn't use
OCHI to see if it makes any difference?

>  19:          0          0          0          0   IO-APIC  19-fasteoi   ehci_hcd:usb2
>  22:          0      22169        139       8731   IO-APIC  22-fasteoi   ahci[0000:00:11.0]
>  25:          0          0         11        753   PCI-MSI 1048576-edge      eth0
> (...)
> ---------------------------
-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
