Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-hk2apc01on0132.outbound.protection.outlook.com ([104.47.124.132]:11929
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754504AbeFMUc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jun 2018 16:32:27 -0400
From: Dexuan Cui <decui@microsoft.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Date: Wed, 13 Jun 2018 20:32:13 +0000
Message-ID: <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Dexuan Cui
> Sent: Wednesday, June 6, 2018 17:15
> To: Haiyang Zhang <haiyangz@microsoft.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> vkuznets@redhat.com; marcelo.cerri@canonical.com
> Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> hv_compose_msi_msg()
>=20
> > From: Haiyang Zhang
> > Sent: Friday, May 25, 2018 12:52
> > To: Dexuan Cui <decui@microsoft.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com
> > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.or=
g;
> > vkuznets@redhat.com; marcelo.cerri@canonical.com
> > Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > hv_compose_msi_msg()
> >
> > > From: Dexuan Cui
> > > Sent: Tuesday, May 22, 2018 8:18 PM
> > > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > <bhelgaas@google.com>; linux-pci@vger.kernel.org; KY Srinivasan
> > > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> > > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.=
org;
> > > Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> > > marcelo.cerri@canonical.com
> > > Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > > hv_compose_msi_msg()
> > >
> > >
> > > Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> > hv_compose_msi_msg()")
> > > uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() =
can
> > also
> > > run in tasklet context as the channel event callback.
> > >
> > > With CONFIG_PROVE_LOCKING=3Dy in the latest mainline, or old kernels =
that
> > > don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert =
IRQs
> > are
> > > disabled/enabled"), it turns out can we trigger a warning at the begi=
nning
> of
> > > __local_bh_enable_ip(), because the upper layer irq code can call
> > > hv_compose_msi_msg() with local irqs disabled.
> > >
> > > Let's fix the warning by switching to local_irq_save()/restore(). Thi=
s is not an
> > > issue because hv_pci_onchannelcallback() is not slow, and it not a ho=
t path.
> > >
> > > Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> hv_compose_msi_msg()")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > ---
> >
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Thanks you.
>=20
> Hi Lorenzo,
>=20
> Can I have your reply to this patch?
>=20
> -- Dexuan

It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
I guess Lorenzo may be on vacation.=20

@Bjorn, can this patch go through your tree?
Should I resubmit it?

Thanks,
-- Dexuan
