Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535AC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2532083C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 05:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2532083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeJAMSZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:18:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:63300 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbeJAMSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 08:18:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 22:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="asc'?scan'208";a="77701482"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga008.jf.intel.com with ESMTP; 30 Sep 2018 22:42:22 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: add support for Immediate Readiness
In-Reply-To: <20180928175718.GE18434@bhelgaas-glaptop.roam.corp.google.com>
References: <20180906141355.GC214747@bhelgaas-glaptop.roam.corp.google.com> <20180907061651.6156-1-felipe.balbi@linux.intel.com> <20180928175718.GE18434@bhelgaas-glaptop.roam.corp.google.com>
Date:   Mon, 01 Oct 2018 08:42:18 +0300
Message-ID: <87sh1q9q9x.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Sep 07, 2018 at 09:16:51AM +0300, Felipe Balbi wrote:
>> PCIe GEN4 defines, on section 7.5.1.1.4, a new bit on Status Register
>> which tells us that:
>>=20
>> "Immediate Readiness =E2=80=93 This optional bit, when Set, indicates the
>> Function is guaranteed to be ready to successfully complete valid
>> configuration accesses at any time following any reset that the host
>> is capable of issuing Configuration Requests to this Function.
>>=20
>> When this bit is Set, for accesses to this Function, software is
>> exempt from all requirements to delay configuration accesses following
>> any type of reset, including but not limited to the timing
>> requirements defined in Section 6.6.  How this guarantee is
>> established is beyond the scope of this document.
>>=20
>> It is permitted that system software/firmware provide mechanisms that
>> supersede the indication provided by this bit, however such
>> software/firmware mechanisms are outside the scope of this
>> specification."
>>=20
>> This means that all delays after a Conventional or Function Reset can
>> be skipped.
>>=20
>> This patch reads such bit and caches its value in a flag inside struct
>> pci_dev to be checked later if we should delay or can skip delays
>> after a reset. While at that, also move the explicit msleep(100) call
>> from pcie_flr() and pci_af_flr() to pci_dev_wait().
>>=20
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> Applied to pci/enumeration for v4.20, thanks!

Thank you

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluxs7oACgkQzL64meEa
mQYY+g/9EOFFOrsRnSgU5xavyGaDLqsQj25GT1A5vR23gaJsGz2OPFdsZWF44akX
JDCgNzHkkyAnKYnDWZmwnER3Znbrh0q8CVyc7RFqcvG1Ry4CqvR5grypwcU4HcAB
VYYPwJNQyZ3MmHROUXChzrjaNjNfkI7FgSLnuBl94O5oQI5Ro5+rhBqdKvqIrYSx
ftOYW3q/hBZMPXBM6EITs/LnnF6lcUIThGv7mY+Npc/HBVYLF4Aq1gxYhQdQTrve
ahLaTHXo/aOL3LilIISzch4f2dsyavB60lJNU8hqp3dBxVMQjMoKMejhfDbNvd0b
GA+O8a7MH8LAeEy9EfiY9DMdQ/b6SEeK43TTXp0KMa1CiXkWBSDogzpsoOMuQnzo
aQM64DEU5fTbyN4mb28K8S96eteft6Mt0apm9/v8HgqQv6V/7UEySceFgqqUiR14
R0PQy+c2Zsdsnn8a5sFyfgRsGsKxGSLpd2GzLXXPXJJTXQoYBjzWq2JibQS9J6z7
S3EpStGy0bTKqIbsdAMK7zl3Ph9BkICd10vejtQ6TDTd8G5YPgdOoMxdqkAbRam4
criSmOWUWlFKAU+btpNqkbyaecLdoR1jVe6Z4M7RhTaRaGFBpWw0UGOP+7S3KB5V
sOqF8/YhOKYNiDZFgmcuGpaBJVaQmjhncK53uAyGLBWC/iaoDvY=
=qUJ7
-----END PGP SIGNATURE-----
--=-=-=--
