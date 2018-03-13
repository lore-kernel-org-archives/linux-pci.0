Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0139.outbound.protection.outlook.com ([104.47.125.139]:6304
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbeCMSX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 14:23:58 -0400
From: Dexuan Cui <decui@microsoft.com>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'bhelgaas@google.com'" <bhelgaas@google.com>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
        'Jack Morgenstein' <jackm@mellanox.com>
Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Date: Tue, 13 Mar 2018 18:23:39 +0000
Message-ID: <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Dexuan Cui
> Sent: Wednesday, March 7, 2018 13:40
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; linux-
> kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Haiyang
> Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; stable@vger.kernel.org; Jack
> Morgenstein <jackm@mellanox.com>
> Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_=
msg()
>=20
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Wednesday, March 7, 2018 04:35
> > On Tue, Mar 06, 2018 at 06:21:56PM +0000, Dexuan Cui wrote:
> > > 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> > > (4900be8360), the recent v4.15 and newer kernels always hang for 1-vC=
PU
> > > Hyper-V VM with SR-IOV. This is because when we reach
> > hv_compose_msi_msg()
> > > by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_sta=
rtup()
> > >  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> > > msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> > > disabled in __setup_irq().
> > >
> > > Fix this by polling the channel.
> > >
> > > 2. If the host is ejecting the VF device before we reach
> > > hv_compose_msi_msg(), in a UP VM, we can hang in
> hv_compose_msi_msg()
> > > forever, because at this time the host doesn't respond to the
> > > CREATE_INTERRUPT request. This issue also happens to old kernels like
> > > v4.14, v4.13, etc.
> >
> > If you are fixing a problem you should report what commit you are fixin=
g
> > with a Fixes: tag and add a CC: stable@vger.kernel.org to the commit lo=
g
> > to send it to stable kernels to which it should be applied; mentioning
> > kernel versions in the commit log is useless and should be omitted.
>=20
> Hi Lorenzo,
> Thanks for your comments!
> This patch does have a "Cc: stable@vger.kernel.org" in the sign-off area.=
 :-)
>=20
> Here the patch is made to resolve 2 issues:
> #1 is triggered by the x86 global reservation mode (4900be8360) patch.
> 4900be8360 in itself is good. It's just that drivers/pci/host/pci-hyperv.=
c
> should be fixed.
>=20
> #2 is a longstanding issue since the first day the pci-hyperv driver was
> accepted into the kernel.
>=20
> So IMO actually we don't really need to add a Fixes: tag, which is usuall=
y
> used to specify a specific commit that introduces a bug that is being fix=
ed.
>=20
> > Side note: you should not have stable@vger.kernel.org in the email
> > addresses CC list you are sending the patches to (you mark patches for
> > stable by adding an appropriate CC tag in the commit log).
>=20
> Sorry, I didn't know this, but actually I didn't add stable@vger.kernel.o=
rg
> manually. Instead I used "git send-email" to send this patchset, and it t=
old
> me "The Cc list above has been expanded by additional addresses found
> in the patch commit message."
>=20
> I didn't find a way to disable this behavior of "git send-email" by check=
ing
> its manual and googling it. This is strange.
>=20
> > Here:
> >
> > git.kernel.org/.../Documentation/process/stable-kernel-rules.rst
> >
> > Last but not least, most of the patches in this series do not justify
> > sending them to stable kernels at all so you should remove the
> > corresponding tag from the patches.
>=20
> I hope at least these 2 patches can go into the stable kernels:
> [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
> [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
> Especially the second one, which fixes a real hang issue for UP virtual
> machines running v4.15 and newer.
> And,  IMO the patches are small enough (<100 lines) , but definitely
> the maintainers make the final call.
>=20
> >
> > Thanks,
> > Lorenzo
> >
> > > Fix this by polling the channel for the PCI_EJECT message and
> > > hpdev->state, and by checking the PCI vendor ID.
> > >
> > > Note: actually the above issues also happen to a SMP VM, if
> > > "hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.
> > >
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> > > Tested-by: Chris Valean <v-chvale@microsoft.com>
> > > Cc: stable@vger.kernel.org
> > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Jack Morgenstein <jackm@mellanox.com>
> > > ---
> > >  drivers/pci/host/pci-hyperv.c | 58
>=20
>=20
> Thanks,
> -- Dexuan

Hi Lorenzo, Bjorn, and all,
Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd=20
the patchset.

Should I send a v4 that just removes the "CC: stable@vger.kernel.org" tag
for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would be=20
easier if you just remove the tags if you belive it's necessary (IMHO all t=
he
6 paches are not big and it would be great if we can have all of them in=20
the old stable kernels, but I respect your decision).

Please let me know if I missed something when addressing the comments,
 and if I should send a v4.

Thanks!
-- Dexuan
