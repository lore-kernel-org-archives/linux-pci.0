Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:57208
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932727AbeE2ATT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 May 2018 20:19:19 -0400
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
Date: Tue, 29 May 2018 00:19:16 +0000
Message-ID: <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>=20
> Before the guest finishes the device initialization, the device can be
> removed anytime by the host, and after that the host won't respond to
> the guest's request, so the guest should be prepared to handle this
> case.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>=20

While this patch solves the immediate problem of getting hung waiting
for a response from Hyper-V that will never come, there's another scenario
to look at that I think introduces a race.  Suppose the guest VM issues a
vmbus_sendpacket() request in one of the cases covered by this patch,
and suppose that Hyper-V queues a response to the request, and then
immediately follows with a rescind request.   Processing the response will
get queued to a tasklet associated with the channel, while processing the
rescind will get queued to a tasklet associated with the top-level vmbus
connection.   From what I can see, the code doesn't impose any ordering
on processing the two.  If the rescind is processed first, the new
wait_for_response() function may wake up, notice the rescind flag, and
return an error.  Its caller will return an error, and in doing so pop the
completion packet off the stack.   When the response is processed later,
it will try to signal completion via a completion packet that no longer
exists, and memory corruption will likely occur.

Am I missing anything that would prevent this scenario from happening?
It is admittedly low probability, and a solution seems non-trivial.  I have=
n't
looked specifically, but a similar scenario is probably possible with the
drivers for other VMbus devices.  We should work on a generic solution.

Michael
