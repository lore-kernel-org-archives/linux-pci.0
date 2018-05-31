Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0091.outbound.protection.outlook.com ([104.47.125.91]:55520
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750711AbeEaVBt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 17:01:49 -0400
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Date: Thu, 31 May 2018 21:01:34 +0000
Message-ID: <KL1P15301MB0006F8A3E876E7BEB5973B94BF630@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Thursday, May 31, 2018 09:41
> >
> > IMO we can disable the per-channel tasklet to exclude the race:
> > This way, when we exit the loop, we're sure hv_pci_onchannelcallback() =
can
> > not run anymore. What do you think of this?
>=20
> I've stared at this and the tasklet code over a couple of days now.  Addi=
ng the
> call to tasklet_disable() solves the immediate problem of preventing
> hv_pci_onchannelcallback() from calling complete() against a completion
> packet
> that has been popped off the stack.  But in doing so, it simply pushes th=
e core
> problem further down the road and leaves it unresolved.
>=20
> tasklet_disable() does not prevent the tasklet from being scheduled.  So =
if
> there
> is a response from Hyper-V to the original message, the tasklet still get=
s
> scheduled.  Because it is disabled, it will sit in the tasklet queue and =
be
> skipped
> over each time the queue is processed.  Later,  when the channel is
> eventually
> deleted in free_channel(), tasklet_kill() is called.  Unfortunately, task=
let_kill()
> will get stuck in an infinite loop, waiting for the tasklet to run.   The=
re aren't
> any tasklet interfaces to dequeue an already scheduled tasklet.

I think you're correct.
=20
> Please double-check my reasoning.  To solve this problem, I think the VMb=
us
> driver code will need some additional synchronization between rescind
> notifications and a response, which may or may not have been sent, and
> which could be processed after the rescind.  I haven't yet thought about
> what this synchronization might need to look like.
>=20
> Michael

Yes, it looks the VMBus driver needs to provide an API to cope with this.
I'll try to further investigate the issue.

-- Dexuan
