Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60220 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2FEEiE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 00:38:04 -0400
Received: by lbbgm6 with SMTP id gm6so3591546lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 04 Jun 2012 21:38:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120605041146.GD6637@ram-ThinkPad-T61>
References: <20120605032627.GA23271@richard> <20120605041146.GD6637@ram-ThinkPad-T61>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 4 Jun 2012 21:37:41 -0700
Message-ID: <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
Subject: Re: One chart on pci bridge and its bus and their children
To: Ram Pai <linuxram@us.ibm.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 4, 2012 at 9:11 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Tue, Jun 05, 2012 at 11:26:27AM +0800, Richard Yang wrote:

>> BTW, the pci_bus->self, pci_bus->bridge seem to point the same thing.
>> So this is really necessary to do this?
>
> pci_bus->self points to the pci_dev structure, and pci_bus->bridge
> points to the device structure. Both correspond to the same bridge. BTW: device
> structure is the basic structure to represent any device in the system,
> not necessarily pci device.

That's true, but I don't think it answers the question.  If we have:

    pci_bus->bridge == pci_bus->self->dev

why would we need both "self" and "bridge"?  It would be interesting
to try to remove "bridge" and replace uses of it with "self->dev".
