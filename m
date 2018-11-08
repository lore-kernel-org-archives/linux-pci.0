Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EDECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8C20825
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KtvEPJ9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A8C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeKIAKX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:10:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 19:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ugg2Q9dGtiOE81lMh3L9KC3ByUPlHS6Y+GmRK4+1PsI=; b=KtvEPJ9ReHcQUVtlLm9zJ+aoW
        /tlMTDVGBC/I57UR/XRbuBUjpJ6Q4y1Whe7SubWxf327WX0vyAWtITUvGyOVh0xHvp9AOQP4uDSid
        iGNODEh2t0hDYOa5PcCXiv7z7NWoHfB6sRETDUaZHHNOJXLpGJg/2u+CA2xJ6cV1EwV3k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKlOC-0008Tq-AT; Thu, 08 Nov 2018 14:34:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E3CF71124D9E; Thu,  8 Nov 2018 14:34:31 +0000 (GMT)
Date:   Thu, 8 Nov 2018 14:34:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
Message-ID: <20181108143431.GG6675@sirena.org.uk>
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 09:58:56PM +0200, Andy Shevchenko wrote:
> Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mark Brown <broonie@kernel.org>

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkSXcACgkQJNaLcl1U
h9DvYAf/YIYorONs2ctGtIKujJqvfUD1ejpWmV/M3n5Vmi6T0+IiClgvWFio5LI5
KXjuJNpQkumjCKhvxdrC9uqX1EDa0XKWyoy5HcBYErt5IAYpKfSqWXRF3XFhRq5n
mQfCpS5Tlzhry5sf7fdarR38mcIffXBBqgk3tYJJD0dDhXGTvjgaNc5au23zhPIa
YZJp8NaK5G20X4K2R3DcvjsLZ41TvrjAmwY6eNEW5uDFRcne74jbASHxJURNY9kC
2CeSE7+rvMMFvXSsTWyQCDatEP/ktHr5Q02FHSjw4hl5t/FZI/E+xIEuWYhD5J81
lU0Cd7FsvNcczVAyvnPuoRqwf363Qw==
=L/6h
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
