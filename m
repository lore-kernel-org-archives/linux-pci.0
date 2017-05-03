Return-Path: <SRS0=VeQY=4J=twosheds.srs.infradead.org=BATV+93275f64741d25f31276+5001+infradead.org+dwmw2@kernel.org>
Return-Path: <SRS0=VeQY=4J=twosheds.srs.infradead.org=BATV+93275f64741d25f31276+5001+infradead.org+dwmw2@kernel.org>
Message-ID: <1493835543.4904.5.camel@infradead.org>
Subject: Re: [Xen-devel] [PATCH] xen: do not re-use pirq number cached in
 pci device msi msg data
From: David Woodhouse <dwmw2@infradead.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Bjorn Helgaas
 <helgaas@kernel.org>, stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,  linux-pci@vger.kernel.org, linux-kernel
 <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 xen-devel@lists.xenproject.org, Dan Streetman
 <dan.streetman@canonical.com>, Dan Streetman <ddstreet@ieee.org>
In-Reply-To: <3379a82f-04b7-152a-1577-bf99b1c638cc@oracle.com>
References: <04f2a09f-59be-a720-bc98-4afb53171790@oracle.com>
	 <20170113200751.20125-1-ddstreet@ieee.org>
	 <20170113223035.GE23066@char.us.oracle.com>
	 <CALZtONDL2Ph0MMMfSuqvofNZ-+6jPi9aKsE4mL30i15Up6Bvug@mail.gmail.com>
	 <0c2b4d6a-93e7-90a2-ffaf-fa423fb022d5@suse.com>
	 <72f8b025-e858-5e54-d900-50fbec46fea6@oracle.com>
	 <20170222142810.GA28359@bhelgaas-glaptop.roam.corp.google.com>
	 <3379a82f-04b7-152a-1577-bf99b1c638cc@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-R/c40iR1ypzDbeF6EvTO"
Date: Wed, 03 May 2017 20:19:03 +0200
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


--=-R/c40iR1ypzDbeF6EvTO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-02-22 at 10:14 -0500, Boris Ostrovsky wrote:
> On 02/22/2017 09:28 AM, Bjorn Helgaas wrote:
> >=20
> > On Tue, Feb 21, 2017 at 10:58:39AM -0500, Boris Ostrovsky wrote:
> > >=20
> > > On 02/21/2017 10:45 AM, Juergen Gross wrote:
> > > >=20
> > > > On 21/02/17 16:31, Dan Streetman wrote:
> > > > >=20
> > > > > On Fri, Jan 13, 2017 at 5:30 PM, Konrad Rzeszutek Wilk
> > > > > <konrad.wilk@oracle.com> wrote:
> > > > > >=20
> > > > > > On Fri, Jan 13, 2017 at 03:07:51PM -0500, Dan Streetman wrote:
> > > > > > >=20
> > > > > > > Revert the main part of commit:
> > > > > > > af42b8d12f8a ("xen: fix MSI setup and teardown for PV on HVM =
guests")
> > > > > > >=20
> > > > > > > That commit introduced reading the pci device's msi message d=
ata to see
> > > > > > > if a pirq was previously configured for the device's msi/msix=
, and re-use
> > > > > > > that pirq.=C2=A0=C2=A0At the time, that was the correct behav=
ior.=C2=A0=C2=A0However, a
> > > > > > > later change to Qemu caused it to call into the Xen hyperviso=
r to unmap
> > > > > > > all pirqs for a pci device, when the pci device disables its =
MSI/MSIX
> > > > > > > vectors; specifically the Qemu commit:
> > > > > > > c976437c7dba9c7444fb41df45468968aaa326ad
> > > > > > > ("qemu-xen: free all the pirqs for msi/msix when driver unloa=
d")
> > > > > > >=20
> > > > > > > Once Qemu added this pirq unmapping, it was no longer correct=
 for the
> > > > > > > kernel to re-use the pirq number cached in the pci device msi=
 message
> > > > > > > data.=C2=A0=C2=A0All Qemu releases since 2.1.0 contain the pa=
tch that unmaps the
> > > > > > > pirqs when the pci device disables its MSI/MSIX vectors.
> > > > > > >=20
> > > > > > > This bug is causing failures to initialize multiple NVMe cont=
rollers
> > > > > > > under Xen, because the NVMe driver sets up a single MSIX vect=
or for
> > > > > > > each controller (concurrently), and then after using that to =
talk to
> > > > > > > the controller for some configuration data, it disables the s=
ingle MSIX
> > > > > > > vector and re-configures all the MSIX vectors it needs.=C2=A0=
=C2=A0So the MSIX
> > > > > > > setup code tries to re-use the cached pirq from the first vec=
tor
> > > > > > > for each controller, but the hypervisor has already given awa=
y that
> > > > > > > pirq to another controller, and its initialization fails.
> > > > > > >=20
> > > > > > > This is discussed in more detail at:
> > > > > > > https://lists.xen.org/archives/html/xen-devel/2017-01/msg0044=
7.html
> > > > > > >=20
> > > > > > > Fixes: af42b8d12f8a ("xen: fix MSI setup and teardown for PV =
on HVM guests")
> > > > > > > Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
> > > > > > Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > > > This doesn't seem to be applied yet, is it still waiting on anoth=
er
> > > > > ack?=C2=A0=C2=A0Or maybe I'm looking at the wrong git tree...
> > > > Am I wrong or shouldn't this go through the PCI tree? Konrad?
> > > Konrad is away this week but since pull request for Xen tree just wen=
t
> > > out we should probably wait until rc1 anyway (unless something big co=
mes
> > > up before that).
> > I assume this should go via the Xen or x86 tree, since that's how most
> > arch/x86/pci/xen.c patches have been handled, including af42b8d12f8a.
> > If you think otherwise, let me know.
>
> OK, I applied it to Xen tree's for-linus-4.11.

Hm, we want this (c74fd80f2f4) in stable too, don't we?

--=-R/c40iR1ypzDbeF6EvTO
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDzUw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggU9MIIEJaADAgECAhBqC1BYlVMtBFBN4igR/howMA0GCSqGSIb3DQEBCwUAMIGbMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
MRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYxMjIwMDAwMDAwWhcN
MTcxMjIwMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwbTrFaiGdvN2pThnR9q+4eaXB2wQZQNqhter5ZrJ
pPO47e87bZ+f1tmYoh6+rB90G/XN24NErPRfvU4zVzNT9pCtCzSSVnBlZQBpaEYMKhcXo5PGKNsm
An8BoGwNXjlxwbBNRaNO+ky0wNCaMNd1JLxEuvqg9J7rrcpHhWmnpXD5IKa8gv9GyVAJgOpiBOts
p91sShc2kHvWJ5waPEWPCHDH9J+twGGKqKIIU7fdbURLUgUL1wlDSAHf/lgIAVCSj2H2HpoGqHpy
HgOAClX9iRSLNa0Znj8HTaqfOwxXevsz1KkLFY+Ahm426GIEqdfkK2iT6Hhgc7tjNO3f8i5ALQID
AQABo4IB8TCCAe0wHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFILE
dmHLtK6oxmFJZvBhTQhvqrS0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQA+AfvNhFwtapF5Lzjapgul3zYuEnMfR538Ya1vhP8wuOkcoJeT2gEFXzVO2WUu
eWM0g0/DumnRB53htV/Qq/+vsL0i6a2+iOO7kHi5O7bZkgbdNv0t2lzonDUHi6LTa7NUj+tv+j6y
hW+iNquC3ACP1dIZH8gJmicHblW63qRgp6wxhn315MLBeavi3uiSag2eeKFePiTIwJjN2UYq6kWg
PL5G/Ycf9x/xN1XBTfJiURc0FsXhrA98VMWnt52C5Lo4txhGjzTI+IZg40b3YDs6E7mTYb5KKmbc
QZA9priOFDdj1z5W9BdWhU6I/D0P9y8Z4Tr6+ZscMUVD0RqWy2LeMIIFPTCCBCWgAwIBAgIQagtQ
WJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMB4XDTE2MTIyMDAwMDAwMFoXDTE3MTIyMDIzNTk1OVowJDEiMCAGCSqG
SIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMG06xWohnbzdqU4Z0favuHmlwdsEGUDaobXq+WayaTzuO3vO22fn9bZmKIevqwfdBv1zduD
RKz0X71OM1czU/aQrQs0klZwZWUAaWhGDCoXF6OTxijbJgJ/AaBsDV45ccGwTUWjTvpMtMDQmjDX
dSS8RLr6oPSe663KR4Vpp6Vw+SCmvIL/RslQCYDqYgTrbKfdbEoXNpB71iecGjxFjwhwx/SfrcBh
iqiiCFO33W1ES1IFC9cJQ0gB3/5YCAFQko9h9h6aBqh6ch4DgApV/YkUizWtGZ4/B02qnzsMV3r7
M9SpCxWPgIZuNuhiBKnX5Ctok+h4YHO7YzTt3/IuQC0CAwEAAaOCAfEwggHtMB8GA1UdIwQYMBaA
FJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSCxHZhy7SuqMZhSWbwYU0Ib6q0tDAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQED
BQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYB
BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0
dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8v
Y3J0LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0R
BBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAPgH7zYRcLWqReS84
2qYLpd82LhJzH0ed/GGtb4T/MLjpHKCXk9oBBV81TtllLnljNINPw7pp0Qed4bVf0Kv/r7C9Iumt
vojju5B4uTu22ZIG3Tb9Ldpc6Jw1B4ui02uzVI/rb/o+soVvojargtwAj9XSGR/ICZonB25Vut6k
YKesMYZ99eTCwXmr4t7okmoNnnihXj4kyMCYzdlGKupFoDy+Rv2HH/cf8TdVwU3yYlEXNBbF4awP
fFTFp7edguS6OLcYRo80yPiGYONG92A7OhO5k2G+Sipm3EGQPaa4jhQ3Y9c+VvQXVoVOiPw9D/cv
GeE6+vmbHDFFQ9Ealsti3jGCA9MwggPPAgEBMIGwMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0Eg
TGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEGoLUFiVUy0EUE3iKBH+GjAwDQYJYIZIAWUDBAIBBQCgggHzMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDUwMzE4MTkwM1owLwYJ
KoZIhvcNAQkEMSIEINS2Z99o9diwlGaGuu6IwwXl9XHA4vQtFM9rXFgR0eZfMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQB3VbUn7MCclShbuclDencEbwqp/rRMkEBd7poFRNtANoCR26LMyVzNhhMH8Z7RWizcYik+oQke
FHMVNB8FMgRkD9v9ITOtHP45EpaPHrprOQBSSOu1rDKeArLRz0iDljz8UEDAUfxU5hAL1ixyWIvL
qTu4B1qKrCqenirxsa/TpNBjN0Ukfd1kbaWw6JtK4YjNaMhVo27N5A/VLaPhBgkCdE24YBzMWDcC
CvItLT6yKeGMjf11aH/MXSgsUfLKkK05FkF/wQVpUIwh8BmDelX5VfypKkfWwxVeATN2F2G4R+GG
utNwx5VA+dejthgkJ1eqOFrcQCiFgvtWQwev0b1RAAAAAAAA


--=-R/c40iR1ypzDbeF6EvTO--
