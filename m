Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:12992
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966485AbeE2T60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 May 2018 15:58:26 -0400
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
Date: Tue, 29 May 2018 19:58:09 +0000
Message-ID: <KL1P15301MB0006B36AD458D43907DF82B0BF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB112020C6F949F7C72F52D6BEDC6D0@SN6PR2101MB1120.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Monday, May 28, 2018 17:19
>=20
> While this patch solves the immediate problem of getting hung waiting
> for a response from Hyper-V that will never come, there's another scenari=
o
> to look at that I think introduces a race.  Suppose the guest VM issues a
> vmbus_sendpacket() request in one of the cases covered by this patch,
> and suppose that Hyper-V queues a response to the request, and then
> immediately follows with a rescind request.   Processing the response wil=
l
> get queued to a tasklet associated with the channel, while processing the
> rescind will get queued to a tasklet associated with the top-level vmbus
> connection.   From what I can see, the code doesn't impose any ordering
> on processing the two.  If the rescind is processed first, the new
> wait_for_response() function may wake up, notice the rescind flag, and
> return an error.  Its caller will return an error, and in doing so pop th=
e
> completion packet off the stack.   When the response is processed later,
> it will try to signal completion via a completion packet that no longer
> exists, and memory corruption will likely occur.
>=20
> Am I missing anything that would prevent this scenario from happening?
> It is admittedly low probability, and a solution seems non-trivial.  I ha=
ven't
> looked specifically, but a similar scenario is probably possible with the
> drivers for other VMbus devices.  We should work on a generic solution.
>=20
> Michael

Thanks for spotting the race!=20

IMO we can disable the per-channel tasklet to exclude the race:

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -565,6 +565,7 @@ static int wait_for_response(struct hv_device *hdev,
 {
        while (true) {
                if (hdev->channel->rescind) {
+                       tasklet_disable(&hdev->channel->callback_event);
                        dev_warn_once(&hdev->device, "The device is gone.\n=
");
                        return -ENODEV;
                }

This way, when we exit the loop, we're sure hv_pci_onchannelcallback() can =
not=20
run anymore. What do you think of this?


It looks the list of the other vmbus devices that can be hot-removed is:

the hv_utils devices
hv_sock devices
storvsc device
netvsc device

As I checked, the first 3 types of devices don't have this "send a request =
to the
host and wait for the response forever" pattern. NetVSC should be fixed as =
it has
the same pattern.

-- Dexuan
