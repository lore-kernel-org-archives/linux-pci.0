Return-Path: <SRS0=Eqlv=LA=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Eqlv=LA=intel.com=jonathan.derrick@kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"okaya@kernel.org" <okaya@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"poza@codeaurora.org" <poza@codeaurora.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Busch, Keith" <keith.busch@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Date: Fri, 17 Aug 2018 14:45:40 +0000
Message-ID: <1534517138.13356.6.camel@intel.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
	 <20180816154940.GD5762@bombadil.infradead.org>
	 <1534434641.17819.27.camel@intel.com>
	 <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
	 <1534452635.17819.53.camel@intel.com>
	 <20180817142529.GA128050@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180817142529.GA128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-cdWnbaIyYgHNiPkZFWrd"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--=-cdWnbaIyYgHNiPkZFWrd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thanks for your pov.

I'm going a lot of different ways on this one, but it seems like the
most reasonable option right now is to drop it until someone actually
presents a non-debugging need to disable DPC from sysfs or globally.

Best regards,
Jon

On Fri, 2018-08-17 at 09:25 -0500, Bjorn Helgaas wrote:
> On Thu, Aug 16, 2018 at 08:50:42PM +0000, Derrick, Jonathan wrote:
> > On Thu, 2018-08-16 at 15:31 -0500, Bjorn Helgaas wrote:
> > > On Thu, Aug 16, 2018 at 03:50:47PM +0000, Derrick, Jonathan
> > > wrote:
> > > > On Thu, 2018-08-16 at 08:49 -0700, Matthew Wilcox wrote:
> > > > > On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> > > > > > Some users may want to disable downstream port containment
> > > > > > (DPC),
> > > > > > so
> > > > > > give them this option
> > > > >=20
> > > > > Is it possible they might only want to disable DPC on a
> > > > > subset of
> > > > > the
> > > > > hierarchy rather than globally?
> > > >=20
> > > > Absolutely. I was hoping Logan's pci dev_str would land because
> > > > I
> > > > have
> > > > a few others I want to convert to that api for granular tuning
> > >=20
> > > What's the use case here?  I acknowledge there are cases where we
> > > need
> > > them, but I'm not a fan of kernel parameters in general because
> > > they're a real hassle for users.
> > >=20
> > > Is there something wrong with DPC?  Is there some way we can make
> > > it
> > > smarter so it does the right thing automatically?
> >=20
> > I've encountered some BIOS or switches (not sure who) who've
> > appeared
> > to have enabled DPC by default, prior to kernel setup. Some users
> > may
> > just not want this, but it was primarily intended for debugging
> > when I
> > conceived it.
> >=20
> > There's also the ongoing thread in linux-pci about err handling in
> > PPC
> > EEH, who may also desire to disable DPC until those issues are
> > resolved.
>=20
> I haven't caught up on that thread yet.  If DPC is incompatible with
> PPC EEH, there's always the possibility of a switch in the code to
> disable DPC automatically on PPC.
>=20
> > It can also be disabled with setpci, but is that any less of a
> > hassle?
> > Genuine question to understand your point of view.
>=20
> Keith already answered here; setpci is primarily for debugging and
> shouldn't be recommended as normal practice.
>=20
> > > I'm more OK with a blanket "nodpc" switch intended for debugging.
> > > If we add the complexity of subsets of the hierarchy it starts
> > > sounding like an administrative thing that makes me more
> > > hesitant.=20
> >=20
> > ...
> > To again understand your point of view, is there anything wrong
> > with
> > administrative things in kernel boot parameters? There will be
> > cases
> > where we may want to deviate from default or global pci=3D*
> > parameters
> > for certain hierarchies and they can't necessarily be set after the
> > fact (ex, hpmemsize).
>=20
> "There will be cases" sounds like we're doing something that *might*
> be useful in the future.  It's better if we wait until we actually
> discover a need for something.
>=20
> There's also a tendency among users to trip over a problem, discover
> a
> boot parameter like "pci=3Dnomsi", and conclude that the problem is
> "fixed".  In fact, we want the bug report so we can fix the kernel so
> no boot parameter is needed.
>=20
> I agree there are things that can't be set after boot.  Is this one
> of
> them?  This seems like something that could be controlled at run-
> time.
> But even there, I will ask what the requirement for it is, because we
> don't want to clutter sysfs with things only needed for debugging.
>=20
> Boot parameters are a hassle because it's hard to build a user
> interface on top of them, and they require a reboot to take effect.
--=-cdWnbaIyYgHNiPkZFWrd
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDgxNzE0NDUzOFowIwYJ
KoZIhvcNAQkEMRYEFME3SzrEISKgF7CgXF/GDdQu5kWLMA0GCSqGSIb3DQEBAQUABIIBAEcmiwWb
IIZp4Ug3blu1wD7E5WmQprFsN7kDp2N7cdTc30NWJbh3+twP8KW1NMyfJZfRE1rG+Zfft0LbNPlR
Q7YAJRNSWwB8xcf12QRluPcWO4jqrGfDI2e3ef6u698mCRQWmQWGDn0efoXrJkumQ0TeWka6muEe
NY/UrMxCzM+/tJ1VJAFOcbvvbD4kJKOfu+R5foPAnjt+GToS8X96vOctC2uTQEC4thUbVrXUNhVc
rJc8I/pZPTqbQBtTwciVLz2xu0Wo2UsoW49Zs9fkJBuLVJsKe5GApjfanjiWd1GI3mo3cZaBwUh5
/cG+OuK31lE+wxzk5pdU0ncvPqXTiicAAAAAAAA=


--=-cdWnbaIyYgHNiPkZFWrd--
