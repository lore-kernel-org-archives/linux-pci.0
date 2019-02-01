Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6AC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA721872
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfBAXTQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:19:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:40911 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXTP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 18:19:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 15:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="p7s'?scan'208";a="121379450"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2019 15:18:43 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Feb 2019 15:18:43 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.218]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 15:18:42 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "yinghai@kernel.org" <yinghai@kernel.org>
Subject: Re: [PATCH v2] PCI: Configure MPS on rescan
Thread-Topic: [PATCH v2] PCI: Configure MPS on rescan
Thread-Index: AQHUdg0VV3Naezzy4ESCiU/e+HvPPqXMnCyAgAAGuwA=
Date:   Fri, 1 Feb 2019 23:18:41 +0000
Message-ID: <1549063112.12182.14.camel@intel.com>
References: <20181106201242.2862-1-jonathan.derrick@intel.com>
         <20190201225427.GU229773@google.com>
In-Reply-To: <20190201225427.GU229773@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.150]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-Sgfai09OkcOgOK/E8bKv"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-Sgfai09OkcOgOK/E8bKv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,


On Fri, 2019-02-01 at 16:54 -0600, Bjorn Helgaas wrote:
> On Tue, Nov 06, 2018 at 01:12:42PM -0700, Jon Derrick wrote:
> > During pci_rescan_bus(), we may encounter new buses and devices
> > which
> > don't have MPS set for compatibility. Using this path, newly
> > discovered
> > buses and devices would then require their MPS to be configured
> > after
> > driver attachment, which may be too late for drivers which do
> > memory
> > transactions on probe.
>=20
> This definitely looks like something we need to do.  Have you tripped
> over an actual problem?  If so, it might be interesting to include a
> symptom here, e.g., Unsupported Request error for hot-added device,
> or
> whatever it is.
For some history I only ever hit this with vmd. There are a limited
number of callers of pci_rescan_bus() which should probably be fixed
individually if they have the same issue.

Otherwise the normal hotplug path configures it via
pciehp_configure_device()::pcie_bus_configure_settings().
The vmd case was resolved by the open coding patch Lorenzo pulled in
for v5.1.

After looking at the options I became pretty reluctant to do it in
pci_rescan_bus because it's triggered through sysfs and would modify
all MPS settings on the (live) bus. It seems like it would be harmless
because it *shouldn't* change any settings in its current code state. A
hypothetical case where I'd be concerned this wouldn't work: a device
is added that is MPS incompatible and is disabled. Then a new rescan
with this patch might change the MPS settings on the parent to make the
link compatible, but the MPS change makes the parent->parent link
incompatible.

>=20
> Can you clarify the "would then require their MPS to be configured"
> part?  Is there some path where we *do* configure MPS after driver
> attachment?  Or is this just a way of saying that "if we don't
> configure MPS *before* driver attachment, we would have to do it
> after"?
Nowhere at this moment. Poor wording on my part.

>=20
> I'm thinking we could simply say something like:
>=20
>   During pci_rescan_bus(), we may encounter new devices which haven't
>   had MPS configured.  Their MPS must be configured before we make
> the
>   devices available for driver attachment by calling
>   pci_bus_add_devices().
>=20
> > This additionally ensures that any pcie_bus_config kernel settings
> > will
> > be applied to the buses and devices discovered through this path
> > prior
> > to driver attachment.
> >=20
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> > v1: https://patchwork.kernel.org/patch/10642019/
> >=20
> >  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >=20
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b1c05b5054a0..126cd426b6f2 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -3156,6 +3156,34 @@ unsigned int
> > pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
> >  	return max;
> >  }
> > =20
> > +/*
> > + * Walks the PCI/PCIe tree to find the first instance of a PCIe
> > device and
> > + * hands off the PCIe bus to pcie_bus_configure_settings to walk
> > the rest.
> > + */
> > +static int pcie_rescan_bus_configure_settings(struct pci_dev *dev,
> > void *data)
> > +{
> > +	if (pci_is_pcie(dev)) {
> > +		struct pci_bus *child, *bus =3D dev->bus;
> > +
> > +		list_for_each_entry(child, &bus->children, node)
> > +			pcie_bus_configure_settings(child);
>=20
> It looks possible that this could call pcie_bus_configure_settings()
> a second time for a device that we've already configured.  For
> example, it's legal to call pci_rescan_bus() on an arbitrary bus even
> if there has been no hot-add event.
>=20
> Is there something that prevents us from touching this
> already-configured device?  *Probably* we would configure it the same
> way the second time, but a driver is likely already attached to it,
> and we shouldn't do anything to it.  Even if
> pcie_bus_configure_settings() happens to be idempotent, that seems
> like it would be hard to verify and keep true indefinitely.
>=20
I agree with you. There isn't anything preventing the configuration on
the live bus, but as mentioned above it *shouldn't* change the
setting... but I'm not 100% sure.

I'm fine dropping this patch

--=-Sgfai09OkcOgOK/E8bKv
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwMTIzMTgzMlowIwYJ
KoZIhvcNAQkEMRYEFESBHVsdrEBpN8IqHmdu/KrZWvLsMA0GCSqGSIb3DQEBAQUABIIBAGcXv+u1
0RzhbmTTSkacDHOLu+1e+ossJRKWLNXpF8znaFbb/0mtCNbjToYuY+G77Xxp3V0PQyzzJerUCYbc
89uWnYghZVRn/lt5yLHcn2DjL/bXNwJdIZf9R3uoG4yKCGJ0tWE2p6m7VP7oau8U3mjlbBxS6ubp
7pyukSsI4Zh8GsFUb/UPVTm5koVxXbjPbmpxkJ11zn1lVNEVDVGtAk58npiF3/fd3pPmurd3WRSS
6YOxa1XOGaaM9EIYgFyiMqaCmYjYTRvSpBgay2hkRmT2AppstKo56CkMOnbTrgkfL8jYVookmCKW
mWMfyKFUsS4z5EShr6b0+CPucCpgvdQAAAAAAAA=


--=-Sgfai09OkcOgOK/E8bKv--
