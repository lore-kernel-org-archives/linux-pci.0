Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63903 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754130Ab2DJAwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Apr 2012 20:52:14 -0400
Received: by lahj13 with SMTP id j13so3817581lah.19
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2012 17:52:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1333968563.5678.19.camel@infinity>
References: <1333968563.5678.19.camel@infinity>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Apr 2012 18:51:52 -0600
Message-ID: <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
Subject: Re: PCI resources above 4GB
To: Steven Newbury <steve@snewbury.org.uk>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 9, 2012 at 4:49 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
> Hi Bjorn,
>
> like many users here:
>
> https://bugs.launchpad.net/ubuntu/+source/nvidia-graphics-drivers-180/+bug/342926
>
> I've hit this bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=10461
>
> I was wondering whether an option to enable an algorithm which
> allocated all 64bit capable devices above 4GB would at least allow
> systems where the BIOS has not provided a sufficient PCI hole to
> initialise all PCI devices?  I've been digging into the code, but I'm
> not yet comfortable to seriously attempt this myself, certainly not
> without guidance.
>
> It's a shame TJ seems to have disappeared, it would have been great to
> have had a look at his code, I'm sure many of these problems would have
> been resolved.
>
> Any help, workarounds, guidance or patches welcome! :)

Please attach complete dmesg logs with and without "pci=use_crs" to
the bugzilla.

Bjorn
