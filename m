Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0113.outbound.protection.outlook.com ([104.47.125.113]:47815
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751363AbeF3SNz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jun 2018 14:13:55 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Date: Sat, 30 Jun 2018 18:13:39 +0000
Message-ID: <KL1P15301MB0006780D045979A760DA4E2BBF4D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180613221509.GB12463@bjorn-Precision-5520>
 <KL1P15301MB0006CAB372940BA3C42F1C58BF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180629093927.GA9576@red-moon>
In-Reply-To: <20180629093927.GA9576@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, June 29, 2018 02:39
> To: Dexuan Cui <decui@microsoft.com>
> On Wed, Jun 13, 2018 at 10:50:05PM +0000, Dexuan Cui wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Wednesday, June 13, 2018 15:15
> > > > ...
> > > > It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
> > > > I guess Lorenzo may be on vacation.
> > > >
> > > > @Bjorn, can this patch go through your tree?
> > > > Should I resubmit it?
> > >
> > > No need to resubmit it, Lorenzo has been out for a bit, but I'm sure
> > > he'll pick this up as he catches up.
> > OK, I see. Thanks!
> >
> > > You might, however, fix the commit log:
> > >
> > >   This is not an issue because hv_pci_onchannelcallback() is not slow=
,
> > >   and it not a hot path.
> > >
> > > This has at least one typo (I think you mean "and *is* not a hot
> > > path").
> > Sorry -- yes, it's a typo. I hope Lorenzo can help to fix this, or I ca=
n
> > resubmit it if Lorenzo or you want me to do it.
> >
> > > I also don't understand the sentence as a whole because the
> > > hv_pci_onchannelcallback() comment says it's called whenever the host
> > > sends a packet to this channel, and that *does* sound like a hot path=
.
> > Sorry for not making it clear.
> > The host only sends a packet into the channel of the guest when there
> > is a change of device configuration (i.e. hot add or remove a device), =
or
> > the host is responding to the guest's request.
> >
> > The change of device configuration is only triggered on-demand by the
> > administrator on the host, and the guest's requests are one-off when
> > the device is probed.
> >
> > So IMO the callback is not a hot path.
> >
> > > I also don't understand the "hv_pci_onchannelcallback() is not slow"
> > > part.  In other words, you're saying hv_pci_onchannelcallback() is
> > > fast and it's not a hot path.  And apparently this has something to d=
o
> > > with the difference between local_bh_disable() and local_irq_save()?
> > >
> > > Bjorn
> > Actually in my original internal version of the patch, I did use
> > local_irq_save/restore().
> >
> > hv_pci_onchannelcallback() itself runs fast, but here since it's in a
> > loop (i.e. the while (!try_wait_for_completion(&comp.comp_pkt.host_even=
t)
> > loop), IIRC I was asked if I really need local_irq_save/restore(),
> > and I answered "not really", so later I switched to
> local_bh_disable()/enable().
> >
> > However, recently I found that if we enable CONFIG_PROVE_LOCKING=3Dy,
> > the local_bh_enable() can trigger a warning because the function
> > hv_compose_msi_msg() can be called with local IRQs disabled (BTW,
> > hv_compose_msi_msg() can also be called with local IRQS enabled in
> > another code path):
> >
> > IRQs not enabled as expected
> >   WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip
> >
> > Despite the warning, the code itself can still work correctly, but IMO =
we'd
> > better switch back to local_irq_save/restore(), and hence I made the pa=
tch.
> >
> > I hope the explanation sounds reasonable. :-)
>=20
> Sorry for the delay in replying. I need to understand if you are
> preventing a spurious lockdep warning or you are fixing a kernel
> bug. From your commit log, I assume the former option but I do
> not think that's what you are really doing.

Now my understanding is:
1) When hv_compose_msi_msg() is called with local irq ENABLED by the upper
level irq code, the current code is good and the lockdep warning is not tri=
ggered.

2) When hv_compose_msi_msg() is called with local irq DISABLED by the upper
level irq code, the current code *is* buggg: local_bh_enable() can potentia=
lly call
do_softirq(), which is not supposed to run when local irq is DISABLED.=20
I think the lockdep warning is triggered for this reason.

In summary, now I realized the warning is not spurious, and here at the fir=
st
place I should not use local_bh_disable()/enable(), which are not supposed =
to
be used when local irq can be DISABLED.

> Apart from the commit log typos fixes I would like a log that
> explains *why* this is not a kernel bug fix rather than a harmless
> lockdep warning prevention.
>=20
> Lorenzo

Now I realized there *is* a bug.
I'm going to send a v2 with a new changelog, though the changed code
will remain the same.=20

Thanks,
-- Dexuan
