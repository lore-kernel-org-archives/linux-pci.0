Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF430C64EB0
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E23213A2
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 19:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E23213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJJDNi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:13:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:4864 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbeJJDNi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 23:13:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 12:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,361,1534834800"; 
   d="p7s'?scan'208";a="90583465"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga003.jf.intel.com with ESMTP; 09 Oct 2018 12:51:59 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 9 Oct 2018 12:51:59 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.122]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.186]) with mapi id 14.03.0319.002;
 Tue, 9 Oct 2018 12:51:59 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Thread-Topic: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Thread-Index: AQHURH6KcvSO5AbAY0iJeWyy2oo9C6UX3y4AgAAf5YA=
Date:   Tue, 9 Oct 2018 19:51:58 +0000
Message-ID: <1539114641.8364.34.camel@intel.com>
References: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
         <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.163]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-l5foc3QdziBACJ34Xfoh"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-l5foc3QdziBACJ34Xfoh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Tue, 2018-10-09 at 12:56 -0500, Bjorn Helgaas wrote:
> On Tue, Sep 04, 2018 at 12:33:09PM -0600, Jon Derrick wrote:
> > During probe, the port driver will disable error reporting and
> > assumes
> > it will be enabled later by the AER driver's pci_walk_bus()
> > sequence.
> > This may not be the case for host-bridge enabled root ports, who
> > will
> > enable first error reporting on the bus during the root port probe,
> > and
> > then disable error reporting on downstream devices during
> > subsequent
> > probing of the bus.
>=20
> I understand the hotplug case (see below), but help me understand
> this
> "host-bridge enabled root ports" thing.  I'm not sure what that
> means.
Sorry for the confusion. I meant a device which doesn't expose the root
ports with firmware but has to expose the root ports using
pci_create_root_bus or similar methods. These methods use a host bridge
aperture on the backend.


>=20
> We run pcie_portdrv_probe() for every root port, switch upstream
> port,
> and switch downstream port, and it always disables error reporting
> for
> the port:
>=20
>   pcie_portdrv_probe          # pci_driver .probe
>     pcie_port_device_register
>       get_port_device_capability
>         services |=3D PCIE_PORT_SERVICE_AER
>         pci_disable_pcie_error_reporting
>           # clear DEVCTL Error Reporting Enables
>=20
> For root ports, we call aer_probe(), and it enables error reporting
> for the entire tree below the root port:
>=20
>   aer_probe                   # pcie_port_service .probe
>     aer_enable_rootport
>       set_downstream_devices_error_reporting(dev, true)
>         pci_walk_bus(dev->subordinate, set_device_error_reporting)
>           set_device_error_reporting
>             if (Root Port || Upstream Port || Downstream Port)
>               pci_enable_pcie_error_reporting
>                 # set DEVCTL Error Reporting Enables
>=20
> This is definitely broken for hot-added switches because aer_probe()
> is the only place we enable error reporting, and it's only run when
> we
> enumerate a root port, not when we hot-add things below that root
> port.

I don't currently have the hardware to test hotplugging a switch,
although I think it should be possible to test with Thunderbolt. Mika?=20
:)

>=20
> > A hotplugged port device may also fail to enable error reporting as
> > the
> > AER driver has already run on the root bus.
> > Check for these conditions and enable error reporting during
> > portdrv
> > probing.
> >=20
> > Example case:
>=20
> pcie_portdrv_probe(10000:00:00.0):
> > [  343.790573] pcieport 10000:00:00.0:
> > pci_disable_pcie_error_reporting
>=20
> aer_probe(10000:00:00.0):
> > [  343.809812] pcieport 10000:00:00.0:
> > pci_enable_pcie_error_reporting
> > [  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
> > [  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
> > [  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
> > [  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
> > [  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
> > [  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
> > [  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
> > [  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
> > [  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting
>=20
> pcie_portdrv_probe(10000:01:00.0):
> > [  343.918900] pcieport 10000:01:00.0:
> > pci_disable_pcie_error_reporting
>=20
> pcie_portdrv_probe(10000:02:00.0):
> > [  343.968426] pcieport 10000:02:00.0:
> > pci_disable_pcie_error_reporting
>=20
> ...
> > [  344.028179] pcieport 10000:02:01.0:
> > pci_disable_pcie_error_reporting
> > [  344.091269] pcieport 10000:02:02.0:
> > pci_disable_pcie_error_reporting
> > [  344.156473] pcieport 10000:02:03.0:
> > pci_disable_pcie_error_reporting
> > [  344.238042] pcieport 10000:02:04.0:
> > pci_disable_pcie_error_reporting
> > [  344.321864] pcieport 10000:02:05.0:
> > pci_disable_pcie_error_reporting
> > [  344.411601] pcieport 10000:02:06.0:
> > pci_disable_pcie_error_reporting
> > [  344.505332] pcieport 10000:02:07.0:
> > pci_disable_pcie_error_reporting
> > [  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting

The main issue leading to this sequence of events is that the root port
and tree is enumerated, then the tree has drivers attached in-order.
During driver probe, the root port services are attached which enables
AER on the entire bus. Then the port's service drivers are attached,
which disables AER during initialization.


It looks like I don't see this issue in the non-host-bridge case
because this statement isn't executed:
#ifdef CONFIG_PCIEAER
        if (dev->aer_cap && pci_aer_available() &&
            (pcie_ports_native || host->native_aer)) {
                services |=3D PCIE_PORT_SERVICE_AER;

                /*
                 * Disable AER on this port in case it's been enabled
by the
                 * BIOS (the AER service driver will enable it when
necessary).
                 */        =20
                pci_disable_pcie_error_reporting(dev);
        }                                                             =20
#endif


So I think re-enabling or strictly enabling error reporting is the
correct course of action for hotplug support at the least. And doing it
after port service driver probe is done and IRQs are requested should
eliminate or reduce races with initialization, which is what above code
snippet looks to be doing in the first place along with
pcie_init_services.

> >=20
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c
> > index 7c37d81..fdd953a 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -343,6 +343,16 @@ int pcie_port_device_register(struct pci_dev
> > *dev)
> >       if (!nr_service)
> >               goto error_cleanup_irqs;
> > =20
> > +#ifdef CONFIG_PCIEAER
> > +     /*
> > +      * Enable error reporting for this port in case AER probing
> > has already
> > +      * run on the root bus or this port device is hot-inserted
> > +      */
> > +     if (dev->aer_cap && pci_aer_available() &&
> > +         (pcie_ports_native || pci_find_host_bridge(dev->bus)-
> > >native_aer))
> > +             pci_enable_pcie_error_reporting(dev);
> > +#endif
>=20
> I plan to apply this after we clarify the changelog a bit, but I
> don't
> really like this patch because it (and the corresponding code added
> by
> 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port
> initialization")) seem a little out of place.
>=20
> The way I think this *should* work is that the PCI core should
> arrange to
> handle AER interrupts when it enumerates the devices that can
> generate
> them (Root Ports and Root Complex Event Collectors), even before it
> enumerates the devices below the Root Port.
To add to this, I'm not the biggest fan of the current way of having
AER enable notification for ports on the tree, but then having every
other PCI driver enable their own notification. It seems inconsistent
for the port driver to not do it.


>=20
> Then the PCI core could directly enable the AER interrupts on all
> devices
> as it enumerates them.  I would envision both cases being handled
> somewhere
> like pci_aer_init() in pci_init_capabilities().
>=20
> This would also allow us to get rid of the
> pci_enable_pcie_error_reporting()
> calls that are currently sprinkled around in drivers, because that
> would be
> handled by the core for all devices.
I agree with you here. It seems to make the most sense to handle it
inclusively and exclude devices as necessary.


>=20
> Bjorn
--=-l5foc3QdziBACJ34Xfoh
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
AG6qjTBc2iB2iz6IVnzrBtQT5DR3KM6EqbMTwur8keTC11xls7lwWexzsSgt37V9UNKAqfsZPgcX
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQUJRdznv8EeAa3g+3F5NKtNNctuBcwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA5LNb+VnWY0V21FlNjnQ2BIb5gmlED29zwQiC5yezn
2SexgvN31129iJSkXuiBHdcVJiUAUPHYuxPRwumwbrkY6m+sYi9kIzKt+ZKNNAN4WbnavsbyRBlb
cIn2E5swqD+sks8AmKivHmg+gFeboLaOf+EqVihIz1Wec1PpbX98R1t2ep7Y/81DD1fIjAWHl6Mq
TJwjKQuYB01kkJdXZAGPXUQSARR1y2D1YpCkDqfGH2STaB4nenD4INSyhTGo5RV9wwTAibyrIq50
rnmvBnHTmICQVdHuIhG1gGmDLUAGqfrU3W2QJr9gkICdrTMgIEdd8s73wknaZxZKqfRxnMVQMYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAKye+0C3syvSXOcAAAAArJ4wCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MTAwOTE5NTA0MVowIwYJ
KoZIhvcNAQkEMRYEFGorcJHqouAEVoxD21VrE8hb3cPIMA0GCSqGSIb3DQEBAQUABIIBAKU1daST
iSctxS7hB4wl0rC3TRtmilGUW8Xncvke1yUuJ/CcCzp1Vu5T4Q56BvDtnKwmATHo5MggqvWBWj8F
i+/XOtUheVM9ZrKAUmSL+mySiqScUwuKf56XRoccAnyGAuEpK9EpwDJJRyx4/EtJaC3KqoOdMzmL
VbJtxF9fF6jdvQDXvS60ABdhl+SwNK8gBNUJCrModCtsxzoTvU+IzIB/LT65c+p4kB8aM5s4QsSp
5DDgvPVWW2ePWtTV7c/0mWA4lJO1ytvgNPQv5SqcjC9jM5DPUQYSWYy/+XlVXhE6PbSiJe6dpFHW
pMdSnYWnFKOwdfQZQz7elLSPq/E6auEAAAAAAAA=


--=-l5foc3QdziBACJ34Xfoh--
