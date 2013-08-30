Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63860 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3H3Tq1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2013 15:46:27 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so3529775ieb.17
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2013 12:46:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130830080138.GA24908@jtlinux>
References: <20130828133337.GA8544@jtlinux>
	<CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
	<20130829082941.GA11203@jtlinux>
	<CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
	<20130829150723.GA32730@jtlinux>
	<CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
	<20130830080138.GA24908@jtlinux>
Date: Fri, 30 Aug 2013 12:46:27 -0700
Message-ID: <CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
Subject: Re: PCI reset problem
From: Yinghai Lu <yinghai@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 30, 2013 at 1:01 AM, Johannes Thumshirn
<johannes.thumshirn@men.de> wrote:
>
> I'll test on mainline and then check pci-busn-alloc, but I have this strange
> feeling that it could be an interaction with Freescale's DPAA Ethernet, which is
> not yet merged into mainline.

please try for-pci-busn-alloc at
     git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn-alloc-3.11

it is based on linus's tree + pci/next

Yinghai
