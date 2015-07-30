Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49631 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbbG3RGG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 13:06:06 -0400
Date: Thu, 30 Jul 2015 10:06:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
Message-ID: <20150730170603.GA14610@roeck-us.net>
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
 <20150729160903.GD31170@google.com>
 <CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
 <55B92DA5.4030409@roeck-us.net>
 <CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
 <55B93151.8040608@roeck-us.net>
 <20150729202639.GA13239@google.com>
 <CAE9FiQVmek758ZG2MfPCK5RsgUAfuD6zW5zHWQkid1POALnZSQ@mail.gmail.com>
 <55B9A554.9020901@roeck-us.net>
 <CAErSpo6SGXp7zNYENmaUPPNcQjHcPEJwc5Ezbs6W29Y2_9z6_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6SGXp7zNYENmaUPPNcQjHcPEJwc5Ezbs6W29Y2_9z6_g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 30, 2015 at 11:18:40AM -0500, Bjorn Helgaas wrote:
> >
> > My version is slightly different, but this one should work as well.
> >
> > The subject line got lost somehow.
> 
> Guenter, would you mind just sending me a fresh version of your patch
> with whatever Yinghai tweaks you want to keep?
> 
Sure, as soon as I completed testing. I am currently having trouble
with our infrastructure [again :-(], so it may take a couple of days.

> It's a PITA for me to deal with attachments.
> 
Same here.

Guenter
