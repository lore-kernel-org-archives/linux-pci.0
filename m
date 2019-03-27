Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EBC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033D62070B
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubcHDwF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfC0KCo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:02:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfC0KCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 06:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Date:MIME-Version:Content-Type
        :References:In-Reply-To:CC:To:From:Subject:Message-ID:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cdLcDD5KmlfZGlHscpsbBfVh8P92mqyRmBVXg98fXSA=; b=ubcHDwF2O5SsyQ88ziuhDcGMy
        QoalejSdgYWUfQPXCUbId8vFu6WSRVfQqZF3CdWJTzNTWpPRt9in1awavP+lKwOtQD7RGXTOXIPVZ
        aLZUwwJ5Apu707CI996HuvgUBm3xTxGg+SNYsp3X0qqZW6D9y2yXlFcnMNQ9HUi2OZ5xTY46X932R
        Xq9QmMC1nKRaIYY3ogPGrS/hQP2MXk/yXz70rVQwK7/c143ROgem+DtgAgs0Uoj7RCY4tNg/Z2nU3
        ex8lWr6FQIs+4f7I8JzFrxp9/4zPDACYoZrpTjqvoDMcFwd97t6aRkJr3WEC1A6GVTGEELDkinf5E
        AZ+o4/65w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h95ON-0001v0-31
        for linux-pci@vger.kernel.org; Wed, 27 Mar 2019 10:02:43 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.91 #2 (Red Hat Linux))
        id 1h95OL-003pXk-MY
        for linux-pci@vger.kernel.org; Wed, 27 Mar 2019 10:02:41 +0000
Message-ID: <7bab98421e2144a934d369e49454f0424c2a3758.camel@amazon.co.uk>
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
From:   David Woodhouse <dwmw@amazon.co.uk>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Chocron <jonnyc@amazon.com>
CC:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <vaerov@amazon.com>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <zeev@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
         <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
         <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
Organization: Amazon Development Centre (London) Ltd.  Registered at 1
 Principal Place, Worship Street, London EC2A 2FA, UK, Europe.
Content-Type: multipart/signed; micalg=sha-256;
        protocol="application/x-pkcs7-signature"; boundary="=-t757H6yKqoFg9RlYqJ8W"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
MIME-Version: 1.0
Date:   Wed, 27 Mar 2019 09:43:26 +0000
X-Evolution-Source: 1536993732.1602.4@u3832b3a9db3152.ant.amazon.com
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-t757H6yKqoFg9RlYqJ8W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-03-26 at 12:17 +0000, Lorenzo Pieralisi wrote:
> This code is basically identical to (apart from the string matching
> the DBI resource)
>=20
> drivers/pci/controller/pcie-hisi.c
>=20
> because, as you said, that's a DW quirk that is really not
> platform specific AFAICS.
>=20
> Not that I am really fond of the idea but in practice we can
> create a quirk that applies to all host controllers DW based,
> in case they want to boot with ACPI, this patch is basically
> code duplication.

Having chatted to Jonny in a little more detail... this isn't quite
duplicate code. On the Annapurna implementation we have fixed the
alignment constraints so we can just use pci_generic_config_read()
directly instead of forcing alignment. We only need to filter out the
"ghost" devices on bus zero.

There might eventually be scope for some form of consolidation, but it
doesn't really seem clear at this point that it would be worth it.

There are three separate quirks needed for different versions of the DW
controller.

One is that the config space of the controller itself shows up multiple
times in all slots of bus zero.

The second is that bus zero cannot be accessed through ECAM and must be
accessed through a separate MMIO region.

The third is the requirement for 32-bit alignment of the host
controller's config space (through the special MMIO region).

Some vendors have managed to work around some of these issues, for
example Annapurna fixing the alignment one. It looks like the three DT
matches in pci-host-generic.c which use pci_dw_ecam_bus_ops are
assuming the hardware suffers only issue #1 from the list above, and
not the other two.

The Annapurna hardware gives us a new combination, and that's why it
isn't quite a duplicate. Again, there may be scope for consolidation in
the future but it's not clear what it should look like. Especially as
when exposed through DT, both the hisi and al versions seem to do
things quite differently and need their own specific code there anyway.
=20

There will be a DT variant of the AL driver coming in the near future,
but when it's exposed via ACPI in the "as close to ECAM compliant as we
could make it in this iteration of the hardware" mode, it's relatively
simple so we did that patch first.



--=-t757H6yKqoFg9RlYqJ8W
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEE4w
ggUuMIIEFqADAgECAhEArUDv6+74dq3c2eBL08L87zANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjAwMTAyMjM1
OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAN2pISRkvUNV4yw2EDL6+sjW2wB5usKaF8RaGtUQswDeHkJ26xAJwnkz
hi6WV53Ta/X16t8nRvl8ayd415N7b5Wfttfxv5B5Y1TCMElPP16LOvTh0YSeO51aUUMp9jtBsD8n
HdYrV2c+DCvqsRE5MH4FyKIlU0ZK8xhtcsG3k4CPE+AkPPailHH3DdoWa5uuMoLTtELwcaDoXdyR
9T40IF5u1UILs73+3UsfMfk8QCnp5TZ4udVCIo2XL9VOFXF8nkJH7rBFHr0nGpU/ichL3/p0nF0w
u0LEuyavxmgY3uSfJTPvnlX2+Nf9eW1Kn8MGxMfGXkxoZxLL6EGMUM+wP08CAwEAAaOCAecwggHj
MB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRV0Rb8VJdXONbe1ows
lxjL1P9RnjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcD
BAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQEC
AQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoGA1UdHwRT
MFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRp
Y2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJ
aHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRT
ZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMBwG
A1UdEQQVMBOBEWR3bXdAYW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUAA4IBAQBleXwqG1xXp96Y
OuoFMwoPBvXGe13r4ZEF+yFiw8BJO9LHZ6WIo98S45nfSPkNFwV7GrV98vMXgbNo1adTtBJOEGq+
RV074oILoCnQRjjVrLLPXk6SPHBD2XhwUgh32di5ihWCXBGIrjpgw6+iUYEKIEh2jilWL90xCava
X8zcLdfv+Kswr26P0OeVMC1qTeXhbp2PZhkJVQ2eNfOKn7VfvE6cdJyW6tVyIPDYnwbPLeuKfZkE
ClokUbw3jLoKECkD7YD9zqqAe2vHmJr7Sa2XzKkDrHAOBAxqbkpb3kDd/7xwM4ezBWa7mR/wWE95
CQOptkW7af3IHqpTCloPU9j2MIIFLjCCBBagAwIBAgIRAK1A7+vu+Hat3NngS9PC/O8wDQYJKoZI
hvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01P
RE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEw
MjAwMDAwMFoXDTIwMDEwMjIzNTk1OVowIjEgMB4GCSqGSIb3DQEJARYRZHdtd0BhbWF6b24uY28u
dWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDdqSEkZL1DVeMsNhAy+vrI1tsAebrC
mhfEWhrVELMA3h5CdusQCcJ5M4Yulled02v19erfJ0b5fGsneNeTe2+Vn7bX8b+QeWNUwjBJTz9e
izr04dGEnjudWlFDKfY7QbA/Jx3WK1dnPgwr6rEROTB+BciiJVNGSvMYbXLBt5OAjxPgJDz2opRx
9w3aFmubrjKC07RC8HGg6F3ckfU+NCBebtVCC7O9/t1LHzH5PEAp6eU2eLnVQiKNly/VThVxfJ5C
R+6wRR69JxqVP4nIS9/6dJxdMLtCxLsmr8ZoGN7knyUz755V9vjX/XltSp/DBsTHxl5MaGcSy+hB
jFDPsD9PAgMBAAGjggHnMIIB4zAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNV
HQ4EFgQUVdEW/FSXVzjW3taMLJcYy9T/UZ4wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAw
IAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNV
HSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21v
ZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01P
RE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcB
AQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAcBgNVHREEFTATgRFkd213QGFtYXpvbi5jby51azANBgkqhkiG9w0B
AQsFAAOCAQEAZXl8KhtcV6femDrqBTMKDwb1xntd6+GRBfshYsPASTvSx2eliKPfEuOZ30j5DRcF
exq1ffLzF4GzaNWnU7QSThBqvkVdO+KCC6Ap0EY41ayyz15OkjxwQ9l4cFIId9nYuYoVglwRiK46
YMOvolGBCiBIdo4pVi/dMQmr2l/M3C3X7/irMK9uj9DnlTAtak3l4W6dj2YZCVUNnjXzip+1X7xO
nHSclurVciDw2J8Gzy3rin2ZBApaJFG8N4y6ChApA+2A/c6qgHtrx5ia+0mtl8ypA6xwDgQMam5K
W95A3f+8cDOHswVmu5kf8FhPeQkDqbZFu2n9yB6qUwpaD1PY9jCCBeYwggPOoAMCAQICEGqb4Tg7
/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
dGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTEzMDEx
MDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVk
MT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4A5jTxhh2
IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1nxdlYCeX
IoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0ZfxcBa39V0
wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2jqPMLxFN
e1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO4nLUXk0B
OSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7NkyMtQw
HQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
CDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEF
BQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUFk
ZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJKoZI
hvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo7EIMERoh
42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+394k+z3ZBy
WPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlxBhh7ETrN
543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7vODqzCM6
ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANPECTQdu9v
WPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72uYRBcunw
wH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9mB12D4ln
9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iAN2ZBXFiR
mjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQpx9/s81r
gzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
dGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBAhEArUDv6+74dq3c2eBL08L87zANBglghkgBZQMEAgEFAKCCAe0wGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwMzI3MDk0MzI2WjAvBgkqhkiG9w0B
CQQxIgQgeNI+n3QZdx+BG+azNw95k+jLJvaFBTN5bgZFIu7BvpAwgb4GCSsGAQQBgjcQBDGBsDCB
rTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCtQO/r7vh2rdzZ4EvT
wvzvMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUg
RW1haWwgQ0ECEQCtQO/r7vh2rdzZ4EvTwvzvMA0GCSqGSIb3DQEBAQUABIIBACMLQO8pw9VRAYuv
vGGrX7kYzXDUvxGGt+07zoO1+UUuFROvjpXouWSyUY22pf8/uXFSO7sh2ijCv9Qg+7ccFp3o8KSx
4Inqp5P1ToaDyxU9ONUzxDwLig2XjXJuiNCQd7F6Yqa4TQPUMWomMMTcDd7oBgZY7E/juX6jG35F
95ear/mev1kyVxbUx6NDIIcK0YJsoMoUm9DoMErCbLU6pTe+esYwd7Gt2azxRjiJag6qZRDLt1ss
Jd3bnwrYke4uEM3qAWwHQns6hLAZEdZla4yasqlsOifMWiKP6J/a165qFsaVBXUyt46bn3A+IHsz
A4ReRs/d798KOYz1yPjxGWcAAAAAAAA=


--=-t757H6yKqoFg9RlYqJ8W--

