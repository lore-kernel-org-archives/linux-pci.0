Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbeHWRHx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Aug 2018 13:07:53 -0400
Date: Thu, 23 Aug 2018 08:38:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
Message-ID: <20180823133805.GE154536@bhelgaas-glaptop.roam.corp.google.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
 <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
 <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
 <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
 <36bd086d-8d26-5162-ae24-95b259571221@gmail.com>
 <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPpJ_edz3H81EqRSg5jeOXoULt7AKwcTpNFL6Ntt8rhQBPFBFQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 23, 2018 at 06:46:28PM +0800, Jian-Hong Pan wrote:
> > On 22.08.2018 13:44, Thomas Gleixner wrote:
> >> Can you please do the following:
> 
> Tested on ASUS X441AUR equipped with RTL8106e.
> This is the laptop whose ethernet does not come back after resume, if
> it does not fallback to MSI.
> ...

> dev@endless:~$ sudo lspci -xnnvvs 02:00.0
> ...
> 00: ec 10 36 81 07 04 10 00 07 00 00 02 10 00 00 00
> 10: 01 e0 00 00 00 00 00 00 04 00 10 ef 00 00 00 00
> 20: 0c 00 00 e0 00 00 00 00 00 00 00 00 43 10 0f 20
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> 
> After comparing, there is no difference between before suspend and
> after resume.

It'd be better to compare the hex data directly and ignore the lspci
decoding, since lspci doesn't decode everything.  You only dumped the
first 0x40 bytes of config space, and all capabilities, including the
MSI and MSI-X capabilities, are past that:

> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800

In addition, some of the MSI-X information for this device is in BAR
4.  "lspci -xxx" will dump all config space, and you can use a tool
like http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c or
https://github.com/billfarrow/pcimem to dump the BAR contents.
