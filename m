Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55118 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab2EJDpI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2012 23:45:08 -0400
Received: by pbbrp8 with SMTP id rp8so1333994pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 09 May 2012 20:45:07 -0700 (PDT)
Date: Wed, 9 May 2012 20:45:03 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Francois Rigaut <frigaut@gmail.com>
Cc: Jiang Liu <liuj97@gmail.com>,
	Nico Schottelius <nico-linux-20120419@schottelius.org>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux Support for Thunderbolt using Apple Monitor
Message-ID: <20120510034503.GB18543@kroah.com>
References: <4FA358ED.1080705@gmail.com>
 <20120504184851.GB11223@kroah.com>
 <CAE9FiQWuePNRWV=ncJkF57aQZ0ZT91xxZ0sZMexq8HgN9NcAfA@mail.gmail.com>
 <CAE9FiQWcyRfLKB+YivOfa-GydbhoaMx06n6a4VMDWoTOMkj7ig@mail.gmail.com>
 <4FA4AA3E.1070903@gmail.com>
 <4FA544B1.3070705@gmail.com>
 <20120505164819.GA21599@schottelius.org>
 <4FA5EE63.1050208@gmail.com>
 <20120509160555.GA13437@kroah.com>
 <4FAB1EAF.2090305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FAB1EAF.2090305@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2012 at 11:49:35AM +1000, Francois Rigaut wrote:
> Greg,
> 
> I went ahead and contacted John Ronciak at intel.
> He gave a presentation on thunderbolt at the 2011 linux plumber conference.
> Here is his answer:
> 
> "You are correct that most if not all issues related to Thunderbolt
> on Linux is due to BIOS problems. We have not seen anything other
> BIOS issues regarding Thunderbolt issues on Linux. When the BIOS is
> working correctly the hot-plug PCIe works fine wrt the kernel. These
> are things that cannot be fixed in the drivers or in kernel
> infrastructure. So newer systems are going to be better than older
> ones due to these BIOS issues."

Thanks for letting us know, so there's nothing we can do for these
machines, and we just have to hope the next-generation machines get this
correct.

greg k-h
