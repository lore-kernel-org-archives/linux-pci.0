Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:56127 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab3HLVej (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 17:34:39 -0400
Received: by mail-bk0-f51.google.com with SMTP id mx10so2044095bkb.24
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2013 14:34:37 -0700 (PDT)
Message-ID: <520954EA.2060308@message-id.googlemail.com>
Date: Mon, 12 Aug 2013 23:34:34 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg KH <gregkh@linux.com>, Oliver Neukum <oneukum@suse.de>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
References: <520747B6.8010309@message-id.googlemail.com> <1880950.SYaKzZm9j7@vostro.rjw.lan> <5207FFB8.3080202@message-id.googlemail.com> <11028683.ZZQRkho7yW@vostro.rjw.lan> <CAErSpo6HThAr7MXX1-qpzryy7=F7+eMfNK_zWuP9j5arLb1RXA@mail.gmail.com>
In-Reply-To: <CAErSpo6HThAr7MXX1-qpzryy7=F7+eMfNK_zWuP9j5arLb1RXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am 12.08.2013 19:21, schrieb Bjorn Helgaas:

> Thanks for the report, Stefan.  I opened
> https://bugzilla.kernel.org/show_bug.cgi?id=60736 so we don't forget
> about this.  If you could attach complete dmesg logs for both cases
> (working and failing) to that bugzilla, that would be great.  An
> acpidump might also be interesting, since the ACPI namespace
> determines what acpiphp does.

Ok, I added all that information to the bug.

> I suspect that we're being too aggressive about determining when we
> should use one or the other of acpiphp and pciehp.  We basically
> decide up front which one we expect the platform to use, and we only
> listen to signals from that one.  But I wonder if we should just
> prepare for signals from both.

Actually I booted an older Kernel (3.7.10, openSUSE 12.3 kernel) which
has both drivers configured as modules.
The interesting thing is: I was not able to load acpiphp there, it
errored out with ENODEV.
So maybe something changed, making acpiphp more (too?) relaxed.

Should I try building the latest kernel with both drivers as modules to
see if this makes a difference?

Best regards,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
