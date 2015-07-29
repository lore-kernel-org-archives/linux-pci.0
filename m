Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34865 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbbG2U0o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 16:26:44 -0400
Received: by oihq81 with SMTP id q81so11524211oih.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 13:26:44 -0700 (PDT)
Date: Wed, 29 Jul 2015 15:26:39 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
Message-ID: <20150729202639.GA13239@google.com>
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
 <20150729160903.GD31170@google.com>
 <CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
 <55B92DA5.4030409@roeck-us.net>
 <CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
 <55B93151.8040608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B93151.8040608@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 01:02:25PM -0700, Guenter Roeck wrote:
> On 07/29/2015 12:53 PM, Yinghai Lu wrote:
> >On Wed, Jul 29, 2015 at 12:46 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >>On 07/29/2015 12:30 PM, Yinghai Lu wrote:
> >>
> >>>
> >>>so PCI_BUS_FLAGS_SUPPORTS_IO will never get set.
> >>>
> >>
> >>excellent catch. Unfortunately, I don't know how to make it
> >>work with the reversed flag. The idea here was that the flag
> >>propagates from parent to child. This makes sense for an
> >>"it doesn't work" flag to be inherited from the child,
> >>but not for an "it works" flag.
> >>
> >
> >also would be better if we can add has_ioport in hostbridge instead.
> >like has_mem64 in https://patchwork.ozlabs.org/patch/500926/
> >and use
> >
> >to_pci_host_bridge(bus->bridge)->has_ioport
> >
> >to replace pci_root_has_io_resource()
> >
> 
> Sure, that would make sense.
> 
> Bjorn, how do you want to handle the flag problem ?
> Do you have an idea on how to make it work with
> the reversed definition ?

I'll wait for the revised patch.  Sorry for screwing this up.
