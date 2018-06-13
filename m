Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754526AbeFMWPL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jun 2018 18:15:11 -0400
Date: Wed, 13 Jun 2018 17:15:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Message-ID: <20180613221509.GB12463@bjorn-Precision-5520>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 13, 2018 at 08:32:13PM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Wednesday, June 6, 2018 17:15
> > To: Haiyang Zhang <haiyangz@microsoft.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com
> > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> > vkuznets@redhat.com; marcelo.cerri@canonical.com
> > Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > hv_compose_msi_msg()
> > 
> > > From: Haiyang Zhang
> > > Sent: Friday, May 25, 2018 12:52
> > > To: Dexuan Cui <decui@microsoft.com>; Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> > > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> > > apw@canonical.com; jasowang@redhat.com
> > > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> > > vkuznets@redhat.com; marcelo.cerri@canonical.com
> > > Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > > hv_compose_msi_msg()
> > >
> > > > From: Dexuan Cui
> > > > Sent: Tuesday, May 22, 2018 8:18 PM
> > > > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > > <bhelgaas@google.com>; linux-pci@vger.kernel.org; KY Srinivasan
> > > > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > > > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> > > > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> > > > Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> > > > marcelo.cerri@canonical.com
> > > > Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > > > hv_compose_msi_msg()
> > > >
> > > >
> > > > Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> > > hv_compose_msi_msg()")
> > > > uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
> > > also
> > > > run in tasklet context as the channel event callback.
> > > >
> > > > With CONFIG_PROVE_LOCKING=y in the latest mainline, or old kernels that
> > > > don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs
> > > are
> > > > disabled/enabled"), it turns out can we trigger a warning at the beginning
> > of
> > > > __local_bh_enable_ip(), because the upper layer irq code can call
> > > > hv_compose_msi_msg() with local irqs disabled.
> > > >
> > > > Let's fix the warning by switching to local_irq_save()/restore(). This is not an
> > > > issue because hv_pci_onchannelcallback() is not slow, and it not a hot path.
> > > >
> > > > Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> > hv_compose_msi_msg()")
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > ---
> > >
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > >
> > > Thanks you.
> > 
> > Hi Lorenzo,
> > 
> > Can I have your reply to this patch?
> > 
> > -- Dexuan
> 
> It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
> I guess Lorenzo may be on vacation. 
> 
> @Bjorn, can this patch go through your tree?
> Should I resubmit it?

No need to resubmit it, Lorenzo has been out for a bit, but I'm sure
he'll pick this up as he catches up.

You might, however, fix the commit log:

  This is not an issue because hv_pci_onchannelcallback() is not slow,
  and it not a hot path.

This has at least one typo (I think you mean "and *is* not a hot
path").

I also don't understand the sentence as a whole because the
hv_pci_onchannelcallback() comment says it's called whenever the host
sends a packet to this channel, and that *does* sound like a hot path.

I also don't understand the "hv_pci_onchannelcallback() is not slow"
part.  In other words, you're saying hv_pci_onchannelcallback() is
fast and it's not a hot path.  And apparently this has something to do
with the difference between local_bh_disable() and local_irq_save()?

Bjorn
