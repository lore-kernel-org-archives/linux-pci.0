Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39968 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753603Ab2AWTMa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Jan 2012 14:12:30 -0500
Received: by lahc1 with SMTP id c1so1832571lah.19
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2012 11:12:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6B=NYZvCGJDLmYC=KoT0fBp7zkAyw6bEnmUaY4nXD==w@mail.gmail.com>
References: <bug-42606-41252@https.bugzilla.kernel.org/> <CAErSpo5r8J9DAwkzAD2zJr1qp01XwCa_X2odQCB98zOU==Derw@mail.gmail.com>
 <CAErSpo7Gpd4OwbRPRd8ePdKDRQpZKT6E-UyEVL92as6C1Tqj7Q@mail.gmail.com>
 <4F1D9582.4030705@meinberg.de> <CAErSpo6B=NYZvCGJDLmYC=KoT0fBp7zkAyw6bEnmUaY4nXD==w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Jan 2012 12:12:08 -0700
Message-ID: <CAErSpo6RBvuq+j9Sab=V9Gbq6fYFpCAwdZsmFQoKOdPT8ZkTRg@mail.gmail.com>
Subject: Re: Fwd: [Bug 42606] New: PCI I/O range not assigned under newer kernels
To: Martin Burnicki <martin.burnicki@meinberg.de>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2012 at 10:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Windows shows the [io  0xf000-0xffff] range as being available under
> both host bridges, and the fact that those ports actually work under
> both bridges means they must actually be routed both places.

Oops, this is wrong.  We can't tell whether the [io  0xf000-0xffff]
range is routed to PCI0, because when the card under that bridge, the
BIOS puts it at [io  0xdc00-0xdcff] instead.

This is probably a BIOS bug (the resource assignment part puts the
card in the right area, but the ACPI _CRS doesn't match).  But the
fact remains that Windows does accept this _CRS and Linux doesn't but
probably should.

Bjorn
