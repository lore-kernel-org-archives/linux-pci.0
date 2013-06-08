Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43711 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3FHBvi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 21:51:38 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so5292447pbc.21
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2013 18:51:37 -0700 (PDT)
Date: Fri, 7 Jun 2013 19:51:33 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>, Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: make PCI host bridge/bus creating and
 destroying logic symmetric
Message-ID: <20130608015133.GB5874@google.com>
References: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
 <1370538609-28903-1-git-send-email-jiang.liu@huawei.com>
 <1370538609-28903-2-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQUDnU_DaXDKKnRh=VYQ6Y+FeWHsKB7rnN2Gn3d0EoGLPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUDnU_DaXDKKnRh=VYQ6Y+FeWHsKB7rnN2Gn3d0EoGLPg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 06, 2013 at 01:01:23PM -0700, Yinghai Lu wrote:
> On Thu, Jun 6, 2013 at 10:10 AM, Jiang Liu <liuj97@gmail.com> wrote:
> > This patch makes PCI host bridge/bus creating and destroying logic
> > symmetric by using device_initialize()/device_add()/device_del()/put_device()
> > pairs as discussed in thread at:
> > http://comments.gmane.org/gmane.linux.kernel.pci/22073
> >
> > It also fixes a bug in error recovery path in pci_create_root_bus()
> > which may kfree() an in-use host bridge object.
> >
> > Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > ---
> >  drivers/pci/probe.c  | 92 +++++++++++++++++++++++-----------------------------
> >  drivers/pci/remove.c |  3 +-
> >  2 files changed, 42 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2f81a0a..9e9cdfe 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > ...
> > +static void pci_release_host_bridge_dev(struct device *dev)
> > +{
> > +       struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
> > +
> > +       if (bridge->release_fn)
> > +               bridge->release_fn(bridge);
> > +
> > +       pci_free_resource_list(&bridge->windows);
> > +
> > +       kfree(bridge);
> > +}
> > +
> 
> should split pci_release_host_bridge_dev renaming and moving to another patch.

I split the rename/move to another patch and added both to my
pci/jiang-bus-lock-v3 branch.

> > @@ -1726,30 +1722,21 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> >                 goto err_out;
> >
> >         bridge->dev.parent = parent;
> > -       bridge->dev.release = pci_release_bus_bridge_dev;
> > -       dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
> >         error = pcibios_root_bridge_prepare(bridge);
> > -       if (error) {
> > -               kfree(bridge);
> > -               goto err_out;
> > -       }
> > +       if (error)
> > +               goto bridge_dev_reg_err;
> > +
> > +       error = device_add(&bridge->dev);
> > +       if (error)
> > +               goto bridge_dev_reg_err;
> >
> > -       error = device_register(&bridge->dev);
> > -       if (error) {
> > -               kfree(bridge);
> > -               goto err_out;
> > -       }

I think this function would be better if we created the host bridge
first, then the bus.  But your patch is an improvement, so we can look
at doing that later.

> looks like we don't need to split device_register to device_del and put_device.
> 
> we can make root bus removal to use device_unregister too, in the patches,

If we can use device_register()/device_unregister() directly instead of
splitting them into initialize/add/del/put, that would be awesome.

Anyway, http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/jiang-bus-lock-v3
is the current state of what I've got.  If you want to iterate on this some
more and improve things, that's great.  But please start with what's on my
branch and post your updates as a complete v4 because I did tweak some
changelogs and code formatting, and I don't want to lose that work.

Bjorn
