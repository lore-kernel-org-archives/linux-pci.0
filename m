Return-Path: <SRS0=4w1L=IL=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=4w1L=IL=intel.com=jonathan.derrick@kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC: "myron.stowe@redhat.com" <myron.stowe@redhat.com>, "hch@lst.de"
	<hch@lst.de>, "helgaas@kernel.org" <helgaas@kernel.org>, "Bauer, Scott"
	<scott.bauer@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Fugate, David"
	<david.fugate@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 0/5] Enable an additional VMD device id
Date: Thu, 24 May 2018 16:36:48 +0000
Message-ID: <1527179806.8026.1.camel@intel.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
	 <20180524114452.GA20732@e107981-ln.cambridge.arm.com>
	 <1527178507.20527.2.camel@intel.com>
	 <20180524163420.GA24940@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180524163420.GA24940@e107981-ln.cambridge.arm.com>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-mncgF3VHNpcK3U4uyDOe"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--=-mncgF3VHNpcK3U4uyDOe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-05-24 at 17:34 +0100, Lorenzo Pieralisi wrote:
> On Thu, May 24, 2018 at 04:15:08PM +0000, Derrick, Jonathan wrote:
> > Hi Lorenzo,
> >=20
> > On Thu, 2018-05-24 at 12:44 +0100, Lorenzo Pieralisi wrote:
> > > On Fri, May 18, 2018 at 01:27:57PM -0600, Jon Derrick wrote:
> > > > This patchset enables an additional VMD device ID to the VMD
> > > > driver
> > > > supporting assignment of the membar addresses from shadow
> > > > registers
> > > > and
> > > > allows more flexibility in assigning bus numbers to a VMD PCIe
> > > > domain.
> > > > Additional VMD root port device ids have been added to the VMD
> > > > AER
> > > > quirk.
> > > >=20
> > > > Changes from rfc include comments, code structure, and using
> > > > pci_add_resource_offset to correctly assign addresses while
> > > > virtualized.
> > > >=20
> > > > Applies to Bjorn's next branch
> > >=20
> > > Hi Jon,
> > >=20
> > > You should base it on v4.17-rc1 and if there is a dependency on
> > > later -rc* or a branch in Bjorn/my queue please let us know.
> >=20
> > It looks like it applies cleanly to 4.17-rc1 and rc6.
> >=20
> > > > Jon Derrick (5):
> > > >   PCI: Add Intel VMD devices to pci ids
> > > >   PCI/VMD: Assign membar addresses from shadow registers
> > > >   PCI/VMD: Add offset to bus numbers if necessary
> > > >   x86/PCI: Add additional VMD device root ports to VMD AER
> > > > quirk
> > > >   PCI/VMD: Add an additional VMD device id to driver device id
> > > > table
> > > >=20
> > > >  arch/x86/pci/fixup.c    |  4 +++
> > > >  drivers/pci/host/vmd.c  | 91
> > > > +++++++++++++++++++++++++++++++++++++++++++------
> > > >  include/linux/pci_ids.h |  2 ++
> > > >  3 files changed, 87 insertions(+), 10 deletions(-)
> > >=20
> > > I need Bjorn's ACK on patch (4), or if Bjorn is keen on pulling
> > > the
> > > series, here's mine on the series:
> > >=20
> > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >=20
> > Would you like me to rebase it and resend with Bjorn's ack?
>=20
> No need to resend but I need Bjorn's ACK on patch (4) in order to
> queue it.
>=20
> Thanks,
> Lorenzo

Here's Bjorn's ack since you may not have it seen it yet:
https://patchwork.ozlabs.org/patch/916565/


Thanks,
Jon
--=-mncgF3VHNpcK3U4uyDOe
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDUyNDE2MzY0NlowIwYJ
KoZIhvcNAQkEMRYEFM5f9XOyjJvIyUbKUHHLXVwsvxFyMA0GCSqGSIb3DQEBAQUABIIBAI5yctUV
2AyDQCFVteeQQwxpGb3KUdT30WFUSk5sHBUjY9lvMHGgyukaUfg1Z4xVcUPOMiUYAphTVJ3aNBk0
625+uvtccrkEEj4ZiaA5ykklp4hKre7YDw12jxNbP4/Ty7bsrfIeTR9pryVdXn42/aw3oYvlqh8g
UIqk27mrnHRjhpGGrPrYPyoS2om8ZtA8kMNbxt6CKxb03fGP+RmXevZN/5vowkUNVD8lSeBW7/pM
JgIagFl9XoGZgEPEbxrvJFefpY698Zdqtlvnvt9fei+IPM260GuFi4jgRtocm9PHshtg/h6DZ9Lo
aZRAesNVry8u1Hpn6Cdf8gLlyBhWyP8AAAAAAAA=


--=-mncgF3VHNpcK3U4uyDOe--
