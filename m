Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42642 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab3IBWSs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2013 18:18:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k14so8604677iea.5
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2013 15:18:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130902080057.GA14515@jtlinux>
References: <20130828133337.GA8544@jtlinux>
	<CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
	<20130829082941.GA11203@jtlinux>
	<CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
	<20130829150723.GA32730@jtlinux>
	<CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
	<20130830080138.GA24908@jtlinux>
	<CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
	<20130902080057.GA14515@jtlinux>
Date: Mon, 2 Sep 2013 15:18:48 -0700
Message-ID: <CAE9FiQVb4GHFS6jwLbGKcPjF0HJ_mkACsj_kPrXvOKsjNDHd8g@mail.gmail.com>
Subject: Re: PCI reset problem
From: Yinghai Lu <yinghai@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 2, 2013 at 1:00 AM, Johannes Thumshirn
<johannes.thumshirn@men.de> wrote:

> I've tested the board with your for-pci-busn-alloc-3.11 branch. Initial
> enumeration is just as it was before. With the difference that a "sysfs-rescan"
> now results in:
>
> root@generic-powerpc:~# lspci
> 00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
> root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> pci_bus 0000:00: scanning bus
> pcieport 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> pcieport 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> pcieport 0000:00:00.0: rescan scaned bridge as broken one again ?
> pci_bus 0000:00: bus scan returning with max=00
> root@generic-powerpc:~# lspci
> 00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)

please send out whole boot log with "debug ignore_loglevel initcall_debug" ?
please make sure you have "CONFIG_PCI_DEBUG=y" in .config.

Yinghai
