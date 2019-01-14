Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB7C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8821620659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 17:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfANR4y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:56:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:21400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANR4x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 12:56:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 09:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="p7s'?scan'208";a="125819986"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2019 09:56:53 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 14 Jan 2019 09:56:52 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.248]) with mapi id 14.03.0415.000;
 Mon, 14 Jan 2019 09:56:52 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Busch, Keith" <keith.busch@intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI/VMD: Configure MPS settings before adding devices
Thread-Topic: [PATCH] PCI/VMD: Configure MPS settings before adding devices
Thread-Index: AQHUkwF4E/yuLbBtjkGQX4uO4mfQC6V+1xAAgDDuFIA=
Date:   Mon, 14 Jan 2019 17:56:51 +0000
Message-ID: <1547488609.23809.0.camel@intel.com>
References: <1544718222-35404-1-git-send-email-jonathan.derrick@intel.com>
         <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
         <20181214144414.GC13491@localhost.localdomain>
In-Reply-To: <20181214144414.GC13491@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.36]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-q6n1U4dNnVbBXwq2PND7"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-q6n1U4dNnVbBXwq2PND7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

On Fri, 2018-12-14 at 07:44 -0700, Keith Busch wrote:
> On Thu, Dec 13, 2018 at 09:23:42AM -0700, Jon Derrick wrote:
> > In order to provide the most performance and/or compatible
> > settings,
> > ensure VMD root buses observe the pcie bus tuning settings by
> > configuring those settings prior to adding the devices to the pcie
> > tree.
> >=20
> > This patch open-codes pci_rescan_bus() and configures the buses
> > prior to
> > adding devices and attaching drivers.
> >=20
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>=20
> Makes sense.
>=20
> Reviewed-by: Keith Busch <keith.busch@intel.com>
>=20
> > ---
> >  drivers/pci/controller/vmd.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index e50b0b5..818dda8 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -585,6 +585,7 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	LIST_HEAD(resources);
> >  	resource_size_t offset[2] =3D {0};
> >  	resource_size_t membar2_offset =3D 0x2000, busn_start =3D 0;
> > +	struct pci_bus *child;
> > =20
> >  	/*
> >  	 * Shadow registers may exist in certain VMD device ids
> > which allow
> > @@ -712,7 +713,19 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	vmd_attach_resources(vmd);
> >  	vmd_setup_dma_ops(vmd);
> >  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > -	pci_rescan_bus(vmd->bus);
> > +
> > +	pci_scan_child_bus(vmd->bus);
> > +	pci_assign_unassigned_bus_resources(vmd->bus);
> > +
> > +	/*
> > +	 * VMD root buses are virtual and don't return true on
> > pci_is_pcie()
> > +	 * and will fail pcie_bus_configure_settings() early. It
> > can instead be
> > +	 * run on each of the real root ports.
> > +	 */
> > +	list_for_each_entry(child, &vmd->bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +
> > +	pci_bus_add_devices(vmd->bus);
> > =20
> >  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus-
> > >dev.kobj,
> >  			       "domain"), "Can't create symlink to
> > domain\n");
> > --=20
> > 1.8.3.1
> >=20
--=-q6n1U4dNnVbBXwq2PND7
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDExNDE3NTY0OVowIwYJ
KoZIhvcNAQkEMRYEFE7YQ0dzR1yUOigDVrqfKIz0toXnMA0GCSqGSIb3DQEBAQUABIIBAEPnuHcb
QqWZi90PKb7YsFpakW/08QfRnLIr9+pH5icHMThm6thGkV3wg7ah8TTEZz+yVDSAfEl1Gslo1IRK
+KnbO0cATEJvcXR0pymkiHjn9wQhscuMucus7psaC/P6MIxgSvf2i15NeYvK9/Zz9sR63HPOerL6
LrwQcLAAoOO81AMjsjgtgrrdE3xb0mQ2VQeshPJnzIzVuPSwJDKeJkB/aZVIUmpsSojLd48OUAre
ywl0kHPqB8qNBbvSeDBrUysSDj/y/sbwnpUwhEwzw1bX40JZzcHo/7hye6ZHUdI7JrCPqGUZvUA2
ObtX2FdmN3JMQVYafK653mGzrgAwe34AAAAAAAA=


--=-q6n1U4dNnVbBXwq2PND7--
