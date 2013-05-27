Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35738 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab3E0RiC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2013 13:38:02 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so520955iej.15
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 10:38:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t8-6CgmhQhiu7zy1r4UnYyjJqkmAnrDRhjt3t71F7SxNA@mail.gmail.com>
References: <CAH9N0t_dNJ+u+9BLFTsqRNnbRO4xMaGYqE6_du_u+joZfzBYyA@mail.gmail.com>
	<CAErSpo7TXMOake9=oXwa-JA9qd9FmwNtHqM6RSt12QO=WORshA@mail.gmail.com>
	<CAH9N0t8-6CgmhQhiu7zy1r4UnYyjJqkmAnrDRhjt3t71F7SxNA@mail.gmail.com>
Date: Mon, 27 May 2013 10:38:01 -0700
Message-ID: <CAE9FiQV4Okzz2jomvwzg7_jS5sKS9Br7LtjbMDy5=BHebTvyDA@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
From: Yinghai Lu <yinghai@kernel.org>
To: pricardofc@ipfn.ist.utl.pt
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 27, 2013 at 9:45 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> My card includes a PCIe Switch.
> My coordinators told me that a solution for hotplug (remove/insert
> board without shutting down the system) could be the PCIe Port Bus
> Driver Model using also pciehp.ko already installed in Linux System.

can you post
lspci -vvxxx
lspci -tv
with and without your card/fpga working?

If your card have a pcie switch, then you can make your down port has
pcie slot cap that support pciehp.

Yinghai
