Return-Path: <SRS0=BKQN=LS=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=BKQN=LS=intel.com=jonathan.derrick@kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "Busch, Keith"
	<keith.busch@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VMD: Set up firmware first if capable
Date: Tue, 4 Sep 2018 23:04:26 +0000
Message-ID: <1536102260.14847.0.camel@intel.com>
References: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
	 <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
	 <20180904130839.GA107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180904130839.GA107892@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-WKGY18M1AO5Eon5EFpRv"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--=-WKGY18M1AO5Eon5EFpRv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the comments.
I'll try to get those answers

On Tue, 2018-09-04 at 08:08 -0500, Bjorn Helgaas wrote:
> On Thu, Aug 30, 2018 at 06:30:03PM -0600, Jon Derrick wrote:
> > Some VMD devices will want to use firmware first error-handling on
> > the
> > entire domain. This is detected by the BIOS setting the VMD
> > endpoint's
> > interface to 0x1.
>=20
> I assume there's some spec that codifies this "programming interface
> 0x1 means firmware-first".  Can you reference that section of the
> spec?  Even if it's not public, it will help people who maintain this
> in the future.
>=20
> I also have questions along the lines of Keith's: how are errors
> reported in the non-firmware-first case, and in the firmware-first
> case, how are the errors passed on to the OS?
>=20
> > Detect this condition and propogate it to the entire domain.
> >=20
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  arch/x86/pci/common.c        | 17 ++++++++++++++++-
> >  drivers/pci/controller/vmd.c | 25 ++++++++++++++++++++++++-
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> > index d4ec117..f07f2e4 100644
> > --- a/arch/x86/pci/common.c
> > +++ b/arch/x86/pci/common.c
> > @@ -663,8 +663,23 @@ static void set_dma_domain_ops(struct pci_dev
> > *pdev) {}
> > =20
> >  static void set_dev_domain_options(struct pci_dev *pdev)
> >  {
> > -	if (is_vmd(pdev->bus))
> > +	if (is_vmd(pdev->bus)) {
> > +		struct pci_host_bridge *hb;
> > +		struct pci_dev *vmd;
> > +
> >  		pdev->hotplug_user_indicators =3D 1;
> > +
> > +		/*
> > +		 * The VMD endpoint is not PCIe, so will fail
> > +		 * pcie_aer_get_firmware_first(). Set and get the
> > raw member
> > +		 * instead.
> > +		 */
> > +		hb =3D pci_find_host_bridge(pdev->bus);
> > +		vmd =3D to_pci_dev(hb->dev.parent);
> > +
> > +		pdev->__aer_firmware_first =3D vmd-
> > >__aer_firmware_first;
> > +		pdev->__aer_firmware_first_valid =3D vmd-
> > >__aer_firmware_first_valid;
> > +	}
> >  }
> > =20
> >  int pcibios_add_device(struct pci_dev *dev)
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index fd2dbd7..74a1a04 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -44,6 +44,11 @@ enum vmd_features {
> >  	 * bus numbering
> >  	 */
> >  	VMD_FEAT_HAS_BUS_RESTRICTIONS	=3D (1 << 1),
> > +
> > +	/*
> > +	 * Device may request firmware first error-handling on the
> > domain
> > +	 */
> > +	VMD_FEAT_HAS_FIRMWARE_FIRST	=3D (1 << 2),
> >  };
> > =20
> >  /*
> > @@ -633,6 +638,23 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  			busn_start =3D 128;
> >  	}
> > =20
> > +	/*
> > +	 * Certain VMD devices may request firmware first error-
> > handling
> > +	 * support on the domain. These domains are virtual and
> > not described
> > +	 * by ACPI, so we must set it explicitly. This sets
> > firmware first on
> > +	 * the endpoint and has a corresponding domain setting in
> > +	 * arch/x86/pci/common.c
> > +	 */
> > +	if (features & VMD_FEAT_HAS_FIRMWARE_FIRST) {
> > +		u8 interface;
> > +
> > +		pci_read_config_byte(vmd->dev, PCI_CLASS_PROG,
> > &interface);
> > +		if (interface =3D=3D 0x1) {
>=20
> This test of the programming interface should have a spec reference
> so
> it doesn't look magical.
>=20
> > +			vmd->dev->__aer_firmware_first =3D 1;
> > +			vmd->dev->__aer_firmware_first_valid =3D 1;
> > +		}
> > +	}
> > +
> >  	res =3D &vmd->dev->resource[VMD_CFGBAR];
> >  	vmd->resources[0] =3D (struct resource) {
> >  		.name  =3D "VMD CFGBAR",
> > @@ -860,7 +882,8 @@ static int vmd_resume(struct device *dev)
> >  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_VMD_201D),},
> >  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> > PCI_DEVICE_ID_INTEL_VMD_28C0),
> >  		.driver_data =3D VMD_FEAT_HAS_MEMBAR_SHADOW |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> > +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > +				VMD_FEAT_HAS_FIRMWARE_FIRST,},
>=20
> Why is this connected to specific hardware versions?  The non-VMD
> firmware-first functionality is determined by firmware, independent
> of
> any particular PCI device.
>=20
> If there's a spec that says "programming interface 0x1 means
> something
> other than firmware-first" on some devices, you could cite it here.
> If early devices are an exception and programming interface will have
> a consistent meaning in the future, you might be able to invert this
> so you only have to mark the early devices instead of every new
> version.
>=20
> >  	{0,}
> >  };
> >  MODULE_DEVICE_TABLE(pci, vmd_ids);
> > --=20
> > 1.8.3.1
> >=20
--=-WKGY18M1AO5Eon5EFpRv
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDkwNDIzMDQyMFowIwYJ
KoZIhvcNAQkEMRYEFCEVl3Cemin9Li/WYzzla44QO3nwMA0GCSqGSIb3DQEBAQUABIIBAHqoAc6/
2TsvdSgKqF0byuOdkWhjB7drOPDXhgQGc8niSOhXWJmvIUNXKRdV8MdCggG6YkslH5qGmRZVe/NK
9e0Q6QcHMVkxblPRDYhi04IKypIITe+lhqndUcDLboCeH4qMDvJoPl4rrKtabGmc+uOsm1LLwlOh
2vKzgkmcdmnFyzGi0gGhr7AuhWQ1X9Iwbnndn6I30ut9Fqpwkx/wqxBiWbJcLZMn52h8Bhpgc8nh
SfnkcvOBzSvVFgiaWY5yVjEtpqgGY1oYO1r3hcMaqMMOgtbEdDLU4M1Jop0oOG59wX/TNk/+Y0Tm
H5U+lqW6Gur4SmkJcfInCbCSomTlsoMAAAAAAAA=


--=-WKGY18M1AO5Eon5EFpRv--
