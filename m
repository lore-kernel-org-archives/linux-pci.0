Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB5C282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1032120879
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 12:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfAVMUa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:20:30 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:51745 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAVMU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jan 2019 07:20:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 5628318415;
        Tue, 22 Jan 2019 13:20:26 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id u2I8OeMQMxBU; Tue, 22 Jan 2019 13:20:25 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id C0F37183BD;
        Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADEF51A063;
        Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F011A05F;
        Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 936BC19F7;
        Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 893D980B46; Tue, 22 Jan 2019 13:20:24 +0100 (CET)
Date:   Tue, 22 Jan 2019 13:20:24 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liming Sun <lsun@mellanox.com>, Olof Johansson <olof@lixom.net>,
        David Woods <dwoods@mellanox.com>,
        Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Christoph Hellwig <hch@lst.de>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Message-ID: <20190122122022.ipn3jdfnxthhphrs@axis.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 05:02:21PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
> >
> > An external host can connect to a Mellanox BlueField SoC via an
> > interface called Rshim. The Rshim driver provides boot, console,
> > and networking services over this interface. This commit is
> > the common driver where the other backend (transport) driver will
> > use.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> 
> Hi Liming,
> 
> I've taken a new look at your patch series for drivers/soc/ now,
> thanks for your continued submissions.
> 
> This is again just a set of very high-level comments, but I think we
> should resolve some of the fundamental questions first.
> Incidentally, Vincent Whitchurch has recently posted another
> patch series with a very similar intention, but for other hardware
> and taking a different approach.
> 
> In both cases, the idea is to use virtio based drivers to provide
> services from a host machine into another Linux instance running
> on an embedded system behind a PCIe slot or similar. Your
> Bluefield SoC patches are well written, but are intentionally
> kept specific to a particular use case and tied to one piece
> of hardware. In contrast, Vincent uses the existing code from
> drivers/misc/mic/vop/ that is equally hardware specific, but he
> extends it to be applicable to other hardware as well.
> 
> It would be good if you could look at each other's approaches
> to see where we could take it from here. I think ideally we
> should have a common driver framework for doing the same
> thing across both of your devices and as well as others.

As far as I can see the biggest difference is that Rshim appears to
support interfaces which do not have shared memory between the host and
the card, which means that it has to jump through a lot more hoops to
make virtio work.

For example, the card side seems to use normal virtio-net and
virto-console drivers, but the drivers/soc/mellanox/tmfifo.c driver,
also running on the card, appears to have to actually look inside the
virtqueues and shuffle the data over the TmFifo interface, and this
driver has hard-coded support for only network and console, since it
apparently needs to know the details of how the virtio drivers use their
virtqueues (see tmfifo_virtio_rxtx()).

And the host side appears to _also_ run the virtio-net driver and there
the drivers/soc/mellanox/host/rshim_net.c code instead has to look
inside the virtqueues and shuffle the data over the other side of the
TmFifo interface.

So to me this looks very different from a traditional virtio
driver/device setup (which is what mic/vop uses).  I may be missing
something, but I don't quite understand why it's even using virtio in
the first place.
