Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36561 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992AbbKEWdP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 17:33:15 -0500
Received: by pacdm15 with SMTP id dm15so75783759pac.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2015 14:33:14 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 03/50] powerpc/pci: Cleanup on struct pci_controller_ops
In-Reply-To: <1446642770-4681-4-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1446642770-4681-4-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2015 09:32:57 +1100
Message-ID: <87si4khyau.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> Each PHB has one instance of "struct pci_controller_ops", which
> includes various callbacks called by PCI subsystem. In the definition
> of this struct, some callbacks have explicit names for its arguments,
> but the left don't have.
>
> This adds all explicit names of the arguments to the callbacks in
> "struct pci_controller_ops" so that the code looks consistent.

Thank you very much for doing this - I should have done it the first
time I created pci_controller_ops.

They all look good, with one nit-pick:

> -	void		(*shutdown)(struct pci_controller *);
> +	void		(*shutdown)(struct pci_controller *hose);

I think we're trying to move from hose to phb in new code.

Once that is fixed:
  Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

>  };
>=20=20
>  /*
> --=20
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWO9kZAAoJEPC3R3P2I92FE6cQAMmbZixxqSvwPMi5kqQ6m1hi
vtKZ2bmTagEPRlchN7TH2iNGQ1LhuA2mU1Jo1QZ1W2XpFU2l4I+rG94q7Va38YXW
3l8z2kl3jK/QU40vVx586i2+Yhad6t5z0hjooVT3JMVInDG6MZrP00jJfxKRpApI
/hr4pLtYlvh7JHrfAvtmucNRmjpV55MngXeivMnvhzx1fa8DGHzUrNdaVbq90w+M
10Q5W1VWNaAyK11qmkOE3TDJ1xEvz9nlRKPxhyuYdxmEu2eqhmHxPfrRFJRr+Yoj
3k6W6pE2JhtcRIfNsF6DWZuU4fQ8MwAGLPlZAmNQTx3a9y4IluL270JJNqD6afbd
FBMbA5fPHMH57D9aYSYHSTPgT0Be/1tImbOQ25AbVMEL2qJpg3mGsMP0ybROaUSK
dc7z5eFWfLnbsOORCZMixv+k71kyxCnT5sAI/Rs3Jce+MdYKVx1JqQkDCffRs6KB
yE2DiKDJZRBPjHE6889S51jz6d84HD7o9vDvoaFdWWx3IWZUbbzSx6XWuXoIPHtV
DVHaySvNIEhxdNjGhyzVPb6c+H2gi/raNjT2K7v8ZgkU6wUWPfuhBg1yTaI81IPK
QpzyUXbgTJ3JTlkrFy88fUnYr3l7UYIjonaidZ2xu6DfIzRT9PP4xnKbY00teG7z
fwRXCgfmXVXGyD5ZLd5T
=Pd7o
-----END PGP SIGNATURE-----
--=-=-=--
