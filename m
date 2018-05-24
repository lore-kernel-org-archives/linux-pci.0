Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:40384
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965059AbeEXXzu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 19:55:50 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: 'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
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
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Date: Thu, 24 May 2018 23:55:35 +0000
Message-ID: <KL1P15301MB00064024E9BB60BF9FD48128BF6A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, May 24, 2018 05:41
> On Wed, May 23, 2018 at 09:12:01PM +0000, Dexuan Cui wrote:
> >
> > Before the guest finishes the device initialization, the device can be
> > removed anytime by the host, and after that the host won't respond to
> > the guest's request, so the guest should be prepared to handle this
> > case.
> >
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_dev
> *hv_pcidev,
> >  static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
> >  static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
> >
> > +/*
> > + * There is no good way to get notified from vmbus_onoffer_rescind(),
> > + * so let's use polling here, since this is not a hot path.
> > + */
> > +static int wait_for_response(struct hv_device *hdev,
> > +			     struct completion *comp)
> > +{
> > +	while (true) {
> > +		if (hdev->channel->rescind) {
> > +			dev_warn_once(&hdev->device, "The device is gone.\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		if (wait_for_completion_timeout(comp, HZ / 10))
> > +			break;
> > +	}
> > +
> > +	return 0;
>=20
> This is pretty racy, isn't it ? Also, I reckon you should consider the
> timeout return value as an error condition unless I am completely
> missing the point of what you are doing.
>=20
> Lorenzo

Actually, this is not racy: we only exit the loop when=20
1) the channel is rescinded=20
or
2) the channel is not rescinded, and the event is completed.

wait_for_completion_timeout() returns 0 if timed out: in this case,
we keep spinning in the loop every 0.1 second, testing the 2 conditions.

If the chanel is not rescinded, here we should wait for the event=20
forever, as the host is supposed to respond to us quickly, and the
event will be completed accordingly. This is what the current code
does. But, in case the channel is rescinded, we need to exit the loop=20
immediately with an error return value: this is the only change
made by the patch.

Ideally, we should not use this ugly "polling" method, and the
rescind-handler, i.e. vmbus_onoffer_rescind(), should notify=20
wait_for_response(), but as I mentioned, there is no good way
to get notified from vmbus_onoffer_rescind(), so I'm proposing
this "polling" method: it's simple and it can work correctly,
and this is not a hot path.

Thanks,
-- Dexuan
