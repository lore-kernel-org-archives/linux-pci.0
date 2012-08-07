Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41103 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab2HGESk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 00:18:40 -0400
Received: by lbbgm6 with SMTP id gm6so3221545lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2012 21:18:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120807T020525-624@post.gmane.org>
References: <loom.20120807T001740-895@post.gmane.org> <20120806224658.GA8579@kroah.com>
 <loom.20120807T010348-354@post.gmane.org> <CAErSpo5-U1AJr1+HbkGxXKKa8MQ0WOzSpVNy7ooj2rtPoXyHnQ@mail.gmail.com>
 <loom.20120807T020525-624@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 Aug 2012 21:18:17 -0700
Message-ID: <CAErSpo7FAjvnsaoao3m65K+b3i_u_pHtttREzZN7RqjJcZ0cDg@mail.gmail.com>
Subject: Re: accessing pci_dev
To: Paolo <paolopiace@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2012 at 5:13 PM, Paolo <paolopiace@gmail.com> wrote:
> Bjorn Helgaas <bhelgaas <at> google.com> writes:
>>
>> The user command "lspci -x" is a good way to see raw config space.
>
> Sure, Thanks. But I need & want to do everything with the functions
> pci_read_config_...
>
> They need the struct pci_dev whose pointer is returned by the BIOS (or Kernel?)
> as parameter of the probe function in the struct pci_driver
>
> There must be a way to get access to each and every pci_dev without resorting to
> the probe function.

pci_get_device().  In arch/mn10300/unit-asb2305/pci-irq.c,
pcibios_fixup_irqs() does something similar to what you're asking for.
