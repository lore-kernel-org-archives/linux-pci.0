Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63201ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6121470
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D6121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSVQs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbeJSVQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 17:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1EEB81F12;
        Fri, 19 Oct 2018 13:10:43 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-29.rdu2.redhat.com [10.10.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA15101F969;
        Fri, 19 Oct 2018 13:10:42 +0000 (UTC)
Message-ID: <b8393e70623ef7743fba74684218c1b744925801.camel@redhat.com>
Subject: Re: [PATCH v6 7/7] IB/hfi1,PCI: switch to __pci_function_locked()
 for reset request
From:   Doug Ledford <dledford@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 19 Oct 2018 09:10:40 -0400
In-Reply-To: <20181019021132.14743-7-okaya@kernel.org>
References: <20181019021132.14743-1-okaya@kernel.org>
         <20181019021132.14743-7-okaya@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-E5HDrwi+zXkbYOIvBMjv"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Oct 2018 13:10:44 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-E5HDrwi+zXkbYOIvBMjv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-10-19 at 02:11 +0000, Sinan Kaya wrote:
> Start using the new reset API rather than the workaround.
>=20
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Acked-by: Doug Ledford <dledford@redhat.com>

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-E5HDrwi+zXkbYOIvBMjv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlvJ19EACgkQuCajMw5X
L93/HA//X7euvVWdmMT3frlPX9krt4JZQpHY/T8jduTrQUIDkbT/P6O7fA5QK0wo
rgJBfSP3eH463PKIr/EXA62J2q26sTwWgGyOkcZG4q/3qpsi9DMjFuvVvF5XqnGK
wobwS6UjjfcuCRG2eBzpfprkmnrUhOoMmrxf6BDn5iTUCQOTTWOsj1B76EXUrF8H
TluAWJMLCkQ6JOWxUixrWjJaM6gKz97TqpFNXhvdgJ7faMvet/uqtBoAH0fFI+Cq
TQxBhWsg3Yz/EORDUOckTLn9JvlvcrG2QYsBCGZPQ7vQdkM1Ks1L9mbtDYKwv4+h
osaCIIrYMBlX5P1PXlI4CA+RH7EWq1avpQMRBMYIWYtmU4ubbei2rk8sDyVasOge
JWsqCtU/tR34DBUAFCGMTPlaJBVFwVekBLGGcstCQRhTu07JHOoHBarvr+fYTLso
HA1vp1tdkhQLCNsZQwJfBuVnC9lAqYeMyPRFqUVG0G46DNHmTaAMN4GgRPiKJtGy
3Ho2+gRpXcuKky9K/rUf5OkRx+BJ47i9Y5wVCOBgyCX0P882sAlpRRObdlOx7hUt
Go9jWW+f5v4NVj/dyregycmIj/s500UlkjkDwZK8XkghCeZ5qjTfVeLaL5jjwsWh
7dGC4kTnf8Co7yzhwRf5pmDQ6RwNq6PLsfhnbv5SQb/P2a6Iq2o=
=RTf0
-----END PGP SIGNATURE-----

--=-E5HDrwi+zXkbYOIvBMjv--

