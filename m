Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:35900
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755677AbeEaQkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 12:40:51 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
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
Date: Thu, 31 May 2018 16:40:48 +0000
Message-ID: <SN6PR2101MB1120FF4297B3C7ED5E3AE032DC630@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Dexuan Cui
> Sent: Tuesday, May 29, 2018 12:58 PM
> Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has di=
sappeared
>=20
> > From: Michael Kelley (EOSG)
> > Sent: Monday, May 28, 2018 17:19
> >
> > While this patch solves the immediate problem of getting hung waiting
> > for a response from Hyper-V that will never come, there's another scena=
rio
> > to look at that I think introduces a race.  Suppose the guest VM issues=
 a
> > vmbus_sendpacket() request in one of the cases covered by this patch,
> > and suppose that Hyper-V queues a response to the request, and then
> > immediately follows with a rescind request.   Processing the response w=
ill
> > get queued to a tasklet associated with the channel, while processing t=
he
> > rescind will get queued to a tasklet associated with the top-level vmbu=
s
> > connection.   From what I can see, the code doesn't impose any ordering
> > on processing the two.  If the rescind is processed first, the new
> > wait_for_response() function may wake up, notice the rescind flag, and
> > return an error.  Its caller will return an error, and in doing so pop =
the
> > completion packet off the stack.   When the response is processed later=
,
> > it will try to signal completion via a completion packet that no longer
> > exists, and memory corruption will likely occur.
> >
> > Am I missing anything that would prevent this scenario from happening?
> > It is admittedly low probability, and a solution seems non-trivial.  I =
haven't
> > looked specifically, but a similar scenario is probably possible with t=
he
> > drivers for other VMbus devices.  We should work on a generic solution.
> >
> > Michael
>=20
> Thanks for spotting the race!
>=20
> IMO we can disable the per-channel tasklet to exclude the race:
>=20
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -565,6 +565,7 @@ static int wait_for_response(struct hv_device *hdev,
>  {
>         while (true) {
>                 if (hdev->channel->rescind) {
> +                       tasklet_disable(&hdev->channel->callback_event);
>                         dev_warn_once(&hdev->device, "The device is gone.=
\n");
>                         return -ENODEV;
>                 }
>=20
> This way, when we exit the loop, we're sure hv_pci_onchannelcallback() ca=
n not
> run anymore. What do you think of this?

I've stared at this and the tasklet code over a couple of days now.  Adding=
 the
call to tasklet_disable() solves the immediate problem of preventing=20
hv_pci_onchannelcallback() from calling complete() against a completion pac=
ket
that has been popped off the stack.  But in doing so, it simply pushes the =
core
problem further down the road and leaves it unresolved.

tasklet_disable() does not prevent the tasklet from being scheduled.  So if=
 there
is a response from Hyper-V to the original message, the tasklet still gets
scheduled.  Because it is disabled, it will sit in the tasklet queue and be=
 skipped
over each time the queue is processed.  Later,  when the channel is eventua=
lly
deleted in free_channel(), tasklet_kill() is called.  Unfortunately, taskle=
t_kill()
will get stuck in an infinite loop, waiting for the tasklet to run.   There=
 aren't
any tasklet interfaces to dequeue an already scheduled tasklet.

Please double-check my reasoning.  To solve this problem, I think the VMbus
driver code will need some additional synchronization between rescind
notifications and a response, which may or may not have been sent, and
which could be processed after the rescind.  I haven't yet thought about
what this synchronization might need to look like.

Michael

>=20
>=20
> It looks the list of the other vmbus devices that can be hot-removed is:
>=20
> the hv_utils devices
> hv_sock devices
> storvsc device
> netvsc device
>=20
> As I checked, the first 3 types of devices don't have this "send a reques=
t to the
> host and wait for the response forever" pattern. NetVSC should be fixed a=
s it has
> the same pattern.
>=20
> -- Dexuan
