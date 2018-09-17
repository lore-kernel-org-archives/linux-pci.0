Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05740ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E382147A
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 21:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E382147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIRCbh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:31:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:48843 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeIRCbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 22:31:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 14:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="p7s'?scan'208";a="90898372"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 17 Sep 2018 14:00:57 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 17 Sep 2018 14:00:54 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.46]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.211]) with mapi id 14.03.0319.002;
 Mon, 17 Sep 2018 14:00:53 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "sbates@raithlin.com" <sbates@raithlin.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI hotplug Eq v2
Thread-Topic: [PATCH v2] PCI hotplug Eq v2
Thread-Index: AQHUQK9AMPUl01gFKEWGe98zyp8shaT1hREAgAAB8YA=
Date:   Mon, 17 Sep 2018 21:00:53 +0000
Message-ID: <1537218051.11525.4.camel@intel.com>
References: <1535667120-3002-1-git-send-email-jonathan.derrick@intel.com>
         <20180917205354.GB54859@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180917205354.GB54859@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.163]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-yWeO6dFHPaZ6ET0YVGSd"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917210053.fB3uAUyH-aokRWlHowieSR0n51z2txRW1As8thgJKLY@z>

--=-yWeO6dFHPaZ6ET0YVGSd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-09-17 at 15:53 -0500, Bjorn Helgaas wrote:
> On Thu, Aug 30, 2018 at 04:11:59PM -0600, Jon Derrick wrote:
> > Hi Bjorn,
> >=20
> > Sorry for the delay on this one and pushing it after RC1.
> > Feel free to queue it up for 4.20 if it looks fine.
> >=20
> > I've added comments to the git log and source explaining why
> > calculate_iosize was left unchanged. Basically I could not
> > synthesize a condition where it would have affected the topology.
>=20
> In other words, the only reason you didn't change the
> calculate_iosize() path was because you couldn't test it?
>=20
I did unsuccessfully try to synthesize it in hardware and qemu. The
firmwares didn't provide the neccessary topology to hit the flexible IO
provisioning conditions


> I appreciate your desire to avoid untested changes, but I think it's
> very important to preserve and even improve the symmetry between
> calculate_memsize() and calculate_iosize().  For example, it's not
> obvious why the order is different here:
>=20
>   calculate_iosize():
>     size =3D ALIGN(size + size1, align);
>     if (size < old_size)
>       size =3D old_size;
>=20
I agree this part didn't make that much sense to me, which was another
reason I left it as-is. Looking at it again, I think its a harmless
calculation that bounds IO size tightly, but could also be reordered as
below to provide for the additional IO (assuming this code ever runs).

>   calculate_memsize():
>     if (size < old_size)
>       size =3D old_size;
>     size =3D ALIGN(size + size1, align);
>=20
> So I don't want to diverge them further unless there's a real
> functional reason why we need to handle I/O port space differently
> than MMIO space.
>=20
> You've tested the MMIO path, and I'm willing to take the risk of
> doing the same thing in the I/O port path.
>=20
> Bjorn
Great! I'll follow-up with a patch as soon as I can

Jon

--=-yWeO6dFHPaZ6ET0YVGSd
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKeTCCBOsw
ggPToAMCAQICEFLpAsoR6ESdlGU4L6MaMLswDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xMzAzMTkwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMHkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2Fu
dGEgQ2xhcmExGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRl
cm5hbCBCYXNpYyBJc3N1aW5nIENBIDRBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
4LDMgJ3YSVX6A9sE+jjH3b+F3Xa86z3LLKu/6WvjIdvUbxnoz2qnvl9UKQI3sE1zURQxrfgvtP0b
Pgt1uDwAfLc6H5eqnyi+7FrPsTGCR4gwDmq1WkTQgNDNXUgb71e9/6sfq+WfCDpi8ScaglyLCRp7
ph/V60cbitBvnZFelKCDBh332S6KG3bAdnNGB/vk86bwDlY6omDs6/RsfNwzQVwo/M3oPrux6y6z
yIoRulfkVENbM0/9RrzQOlyK4W5Vk4EEsfW2jlCV4W83QKqRccAKIUxw2q/HoHVPbbETrrLmE6RR
Z/+eWlkGWl+mtx42HOgOmX0BRdTRo9vH7yeBowIDAQABo4IBdzCCAXMwHwYDVR0jBBgwFoAUrb2Y
ejS0Jvf6xCZU7wO94CTLVBowHQYDVR0OBBYEFB5pKrTcKP5HGE4hCz+8rBEv8Jj1MA4GA1UdDwEB
/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMDYGA1UdJQQvMC0GCCsGAQUFBwMEBgorBgEEAYI3
CgMEBgorBgEEAYI3CgMMBgkrBgEEAYI3FQUwFwYDVR0gBBAwDjAMBgoqhkiG+E0BBQFpMEkGA1Ud
HwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwudHJ1c3QtcHJvdmlkZXIuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AudHJ1
c3QtcHJvdmlkZXIuY29tMDUGA1UdHgQuMCygKjALgQlpbnRlbC5jb20wG6AZBgorBgEEAYI3FAID
oAsMCWludGVsLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAKcLNo/2So1Jnoi8G7W5Q6FSPq1fmyKW3
sSDf1amvyHkjEgd25n7MKRHGEmRxxoziPKpcmbfXYU+J0g560nCo5gPF78Wd7ZmzcmCcm1UFFfIx
fw6QA19bRpTC8bMMaSSEl8y39Pgwa+HENmoPZsM63DdZ6ziDnPqcSbcfYs8qd/m5d22rpXq5IGVU
tX6LX7R/hSSw/3sfATnBLgiJtilVyY7OGGmYKCAS2I04itvSS1WtecXTt9OZDyNbl7LtObBrgMLh
ZkpJW+pOR9f3h5VG2S5uKkA7Th9NC9EoScdwQCAIw+UWKbSQ0Isj2UFL7fHKvmqWKVTL98sRzvI3
seNC4DCCBYYwggRuoAMCAQICEzMAAKye+0C3syvSXOcAAAAArJ4wDQYJKoZIhvcNAQEFBQAweTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMR
SW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vpbmcg
Q0EgNEEwHhcNMTcxMDE5MTcyNzI3WhcNMTgxMDE0MTcyNzI3WjBHMRowGAYDVQQDExFEZXJyaWNr
LCBKb25hdGhhbjEpMCcGCSqGSIb3DQEJARYaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20wggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCz4TvOwEKxVEgGst/n3LricX9KG2YbHHvorBFb
ggk/Wm7ZV9v/w5I5+M7SFD1CVS+MD24tlcL0mjddPXklsjPNmFb7TCXhppQMWqxwlS44iokDpHEF
wx6DtwcIlfmvgPormri3U5V0gkRvnmiFSlQ2bUycWgxttAvR4sYjxLas7hE3jZJ1LJ9IxiD7VMNJ
QWXSxxnOGZVf1tUTqC5uNv9wSvr8N7ZRYldP4nJ9JUFO7bazyoplxGlgxIR3+7I9TgbrUOziQCja
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDkxNzIxMDA1MVowIwYJ
KoZIhvcNAQkEMRYEFJ7yUQXTdbxve9Bqx4u9m9kA4prsMA0GCSqGSIb3DQEBAQUABIIBADZzdw+p
LvTq7TRZJPHUF1iFV7lVxdXOHsusKhGUH7YnkxLn/kuj0sxhuE53ehbtUrmxbeIrGpTyJELWTb32
78KdZ9fuMgwIzzBP8hw8bWNmfez03jhfQ7zZlN/dyTJsACTlVN9ENLds4SchqqhLv5F/Unhuy5UQ
1sEMJRnKNR+8H3LWKxJzePxOK+vGfUTyYV+EwDGakllazJLHfJxYuz+9vYm+qOwgGbF9f9mCjBzl
FA1VaC/megcIAuOaEHhVaaUvPj30IGCZlZlX1D+snzZ3RbAJXbUyeSkuJGQJ6VXtwH+G+/MICYmP
23wQeb9FIYRBUglkvtGb8HAizs0ozHUAAAAAAAA=


--=-yWeO6dFHPaZ6ET0YVGSd--
