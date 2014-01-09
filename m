Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60445 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbaAISbr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 13:31:47 -0500
Received: by mail-ie0-f173.google.com with SMTP id u16so1526693iet.4
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 10:31:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+sq2CfthYc3Eda3GRa-Q-TA9gq+ygBTLrPjvzhRquikm220GA@mail.gmail.com>
References: <CA+sq2CfthYc3Eda3GRa-Q-TA9gq+ygBTLrPjvzhRquikm220GA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Jan 2014 11:31:24 -0700
Message-ID: <CAErSpo6rigeEY7RbpcRrm2N7gKxA+rAwEX7_iD7r706hvM0_MA@mail.gmail.com>
Subject: Re: Query regarding ARI configuration of a on-board PCIe device.
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 9, 2014 at 3:51 AM, Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> Hi,
>
> I have a platform which has a on-board PCIe device attached to PCIe port.
> This device is an ethernet device with SRIOV capability having morethan
> 8 virtual functions.
>
> I am going through Linux's ARI configuration code and saw that it is checking
> if upstream bridge supports ARI or not. In our case its a on-board device and
> no bridge is involved.
>
> Need some help or ideas on how i can configure ARI on the device so that
> all VFs gets added.
>
> Do i need to change the ARI configuration code or is there a way to fake a
> PCI bridge for this purpose ?

I assume you're referring to pci_configure_ari().  A PCIe endpoint
such as your ethernet device always has an upstream bridge.  In your
case, the device is on-board and there's no PCIe switch involved, but
the root port is the upstream device, and it is handled as a bridge.

It looks like pci_configure_ari() should enable ARI by default when it
is supported.  But apparently it isn't being enabled on your system?
Can you collect the "lspci -vv" output for the root port and the NIC?

Bjorn
