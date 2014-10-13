Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:58422 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaJMPsB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Oct 2014 11:48:01 -0400
Received: by mail-qa0-f52.google.com with SMTP id dc16so4521410qab.39
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2014 08:48:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-86121-41252@https.bugzilla.kernel.org/>
References: <bug-86121-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Oct 2014 09:47:40 -0600
Message-ID: <CAErSpo5SvnNb7KteHPtr+_XZK3RJYfBNZOR_2cnxbBkF3x+tKA@mail.gmail.com>
Subject: Re: [Bug 86121] New: Regression: NVIDIA backlight not working after
 latest vgaarb change
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 12, 2014 at 8:55 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=86121
>
>             Bug ID: 86121
>            Summary: Regression: NVIDIA backlight not working after latest
>                     vgaarb change
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.16.5
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: petrihodju@yahoo.com
>         Regression: No
>
> Created attachment 153311
>   --> https://bugzilla.kernel.org/attachment.cgi?id=153311&action=edit
> kernel boot logs & config
>
> I have experienced a regression in backlight control with NVIDIA binary blob
> driver and kernel 3.16.5. I did a bisect between 3.16.4 and 3.16.5 and found
> out that the regression happens with commit "ce027dac vgaarb: Don't default
> exclusively to first video device with mem+io"
>
> I have attached kernel boot log with working backlight (commit 7babfd7f) and
> non-working one (commit ce027dac) plus the config used.
>
> I'm running Ubuntu 14.10
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
