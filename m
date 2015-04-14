Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434AbbDNKtQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Apr 2015 06:49:16 -0400
Date: Tue, 14 Apr 2015 12:49:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150414124742-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150413093708.GE17059@ad.nay.redhat.com>
 <CAErSpo7ARr7GHNUCMAa04Mk-cG-dufE=_ajB1txTuGRxzCqZwA@mail.gmail.com>
 <20150414114433-mutt-send-email-mst@redhat.com>
 <20150414104505.GA32015@ad.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150414104505.GA32015@ad.nay.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 14, 2015 at 06:45:05PM +0800, Fam Zheng wrote:
> On Tue, 04/14 11:47, Michael S. Tsirkin wrote:
> > I have investigated this, and I at this point I think the hang is basically
> > a non issue. So the commit log should say
> > 
> > 	if the driver hasn't registered an interrupt handler for it, the interrupt
> > 	is never deasserted and causes spurious interrupts, typically
> > 	followed by kernel disabling the irq.
> 
> Or, how about disabling intx immediately too?
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..dd7dcc1 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -452,6 +452,7 @@ static void pci_device_shutdown(struct device *dev)
>                 drv->shutdown(pci_dev);
>         pci_msi_shutdown(pci_dev);
>         pci_msix_shutdown(pci_dev);
> +       pci_intx(pci_dev, 0);
> 
>  #ifdef CONFIG_KEXEC
>         /*

Needs to happen before msi shutdown then.
There are also drivers which call pci_intx from interrupt
handler, which will conflict.

> > 
> > 
> > > >> [bhelgaas: changelog]
> > > >> Reported-by: Fam Zheng <famz@redhat.com>
> > > >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >> CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
> > > >> CC: Ulrich Obergfell <uobergfe@redhat.com>
> > > >> CC: Rusty Russell <rusty@rustcorp.com.au>
> > > >> ---
> > > >>  drivers/pci/pci-driver.c |    2 --
> > > >>  1 file changed, 2 deletions(-)
> > > >>
> > > >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > >> index 3cb2210de553..38a602cb9fb7 100644
> > > >> --- a/drivers/pci/pci-driver.c
> > > >> +++ b/drivers/pci/pci-driver.c
> > > >> @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
> > > >>
> > > >>       if (drv && drv->shutdown)
> > > >>               drv->shutdown(pci_dev);
> > > >> -     pci_msi_shutdown(pci_dev);
> > > >> -     pci_msix_shutdown(pci_dev);
> > > >>
> > > >>  #ifdef CONFIG_KEXEC
> > > >>       /*
> > > >>
