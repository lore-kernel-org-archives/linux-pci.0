Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.146]:40444 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789Ab3IBIAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2013 04:00:49 -0400
Date: Mon, 2 Sep 2013 10:00:57 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Yinghai Lu <yinghai@kernel.org>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130902080057.GA14515@jtlinux>
References: <20130828133337.GA8544@jtlinux>
 <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
 <20130829082941.GA11203@jtlinux>
 <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
 <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
 <20130830080138.GA24908@jtlinux>
 <CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 30, 2013 at 12:46:27PM -0700, Yinghai Lu wrote:
> On Fri, Aug 30, 2013 at 1:01 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> >
> > I'll test on mainline and then check pci-busn-alloc, but I have this strange
> > feeling that it could be an interaction with Freescale's DPAA Ethernet, which is
> > not yet merged into mainline.
>
> please try for-pci-busn-alloc at
>      git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-busn-alloc-3.11
>
> it is based on linus's tree + pci/next
>
> Yinghai

Hi Yinghai,

I've tested the board with your for-pci-busn-alloc-3.11 branch. Initial
enumeration is just as it was before. With the difference that a "sysfs-rescan"
now results in:

root@generic-powerpc:~# lspci
00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
pci_bus 0000:00: scanning bus
pcieport 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pcieport 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pcieport 0000:00:00.0: rescan scaned bridge as broken one again ?
pci_bus 0000:00: bus scan returning with max=00
root@generic-powerpc:~# lspci
00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)

The good news for me is, I can work on your tree to try to resolve the issue.

Johannes
