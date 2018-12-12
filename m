Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D3C67839
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 00:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0FA20851
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SYYS8Vfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0FA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLLAhy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:37:54 -0500
Received: from ozlabs.org ([203.11.71.1]:41943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLAhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 19:37:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 43DyZk6qyjz9s47; Wed, 12 Dec 2018 11:37:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1544575070;
        bh=vUiGKvYaVVCrNhOnq8YxGEvqhpKSI/AAuTcLp+f9B0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYYS8Vfs1DWy6xQreHsDTPuB/A9JCjiqKZ+03SHMNfMqgqCKHP7Ufiy/WdgteWINN
         GjxhtQhl3ajiH+k4pU86AwFa0wV32Imtr6++ohLfE66CUfKGiK3DUVLxHQHUnHT72R
         i5D3zVp8wNYV99NNnbrM2a0YSwswZx0UOalSG0No=
Date:   Wed, 12 Dec 2018 11:22:34 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     davem@davemloft.net, saeedm@mellanox.com, ogerlitz@mellanox.com,
        tariqt@mellanox.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20181212002234.GC2719@umbus.fritz.box>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181211140143.GD99796@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20181211140143.GD99796@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:01:43AM -0600, Bjorn Helgaas wrote:
> Hi David,
>=20
> I see you're still working on this, but if you do end up going this
> direction eventually, would you mind splitting this into two patches:
> 1) rename the quirk to make it more generic (but not changing any
> behavior), and 2) add the ConnectX devices to the quirk.  That way
> the ConnectX change is smaller and more easily
> understood/reverted/etc.

Sure.  Would it make sense to send (1) as an independent cleanup,
while I'm still working out exactly what (if anything) we need for
(2)?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQVMoACgkQbDjKyiDZ
s5L+cw/+KM764cq7FAR/lTsfb87oC6lgM+U63FC2WIKnaxcJodoYFkg4eYhjc7B9
OfAliLU6kk4A/cowrU/TZRHtvW3LcaZU4qTlQBKuPoFq6ApOmCv8ftr4jbdcXD/U
2R/RS4QgRInfPg1g3de5DuveWiVI8gIzfcOKPh53yAkcdbsi937ZMFICwSYfln9X
hmONBWM0BfrVvx8AFxhyc2lczWNzXHpFTTBqcV+lZnGUlB51K/+WQOIx6BNVssQs
UfiJqHQixhdJA9pzkMEykEiS5A9hdOLJ4XyYO6jt1S9ZdB4dp1ckPrej8zgXt2l1
HRG11NfawSntxutiu4CLM4Ra0aykkRw6ws2n2joV0Tb7+jZMGTeCzJSACdIbZM48
RLKIS+b5PjAziH/QzZ4rSau6vRsaB7NY80fMPuvmM4/P3o5NrqmJm6trUX6LWOFZ
FnUjMvXlFmO/5E7pmclcUxqvG6n5alBbMg+vJRo5ljZbp2MeFAVR/BWnXA5iTARQ
JmjIIbUMQhie1ykQuWiZ0rqpCB/rEXDWfWDSyPvdYdXyNK2R/ZLi58G/PU/DQi3D
By4mlrRHhZCcRoxXK7RznAj/bR9nKI/NsGm+8eaqaTf5foVQ7jW+PQpz+Jiy3nrg
O/MBa8cWSsV9VH9xCbGAFHTjC6WtICnGk9xscxqcWlwnMWIr3sk=
=7iRq
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
