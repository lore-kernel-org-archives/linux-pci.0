Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E7BC10F00
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EF720857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfDBG2h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:28:37 -0400
Received: from sauhun.de ([88.99.104.3]:37334 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBG2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 02:28:37 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id 172032CF606;
        Tue,  2 Apr 2019 08:28:34 +0200 (CEST)
Date:   Tue, 2 Apr 2019 08:28:33 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
Message-ID: <20190402062833.GB998@kunai>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-6-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20190402013307.20912-6-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 03:33:07AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> The MSI message address in the RC address space can be 64 bit. The
> R-Car PCIe RC supports such a 64bit MSI message address as well.
> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> a reserved page for the MSI message address, and the return value
> of which can be a 64 bit physical address on 64 bit system.
>=20
> However, the driver only programs PCIEMSIALR register with the bottom
> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> SoCs, however may fail on new 64 bit R-Car SoCs.
>=20
> Since from a PCIe controller perspective, an inbound MSI is a memory
> write to a special address (in case of this controller, defined by
> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> cause memory corruption or other issues.
>=20
> There is however the possibility that if virt_to_phys(__get_free_pages())
> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> to 0x0 _and_ if the system had physical RAM at the address matching the
> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> physical address matching the value of PCIEMSIALR and a remote write to
> such a buffer by a PCIe card would trigger a spurious MSI.

Very good descripion!

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I double-checked with the datasheets previously.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjAREACgkQFA3kzBSg
KbbkPg//alydZyG1QPBATYVKTSW5uTpr63+7OpdNOEyDldk7hNwvR7kxRxbVhsoq
fFVYWdv5+ygW9QKYoKxj8AyiDyA5kuJRtLHCd4AJml/2JzZLymqQU87TDf6MHHZF
cQTY4yWzPmtDrCKTeo/sv+0RKPMURoJN1WRoIiNbT3q+MQylMMzlt8Emzom5ldIl
OgdqNZocpdcJs6ZMDUZUsrRtO6RDjZM+rgcepJ9o8firHv9GYi04zPZWmfiI1aAW
l7tqnaFrTD9IlmMvbY5DxOviYXW8AVsPivyHWdcxmqXnWNBUsOB4NIO0K2cP7DU0
WqhqOk7ef4ZcA353zORdG4QQ/uodpkP/DQISKaKpyddx3eqyTJ9gww9jtcnB1vkF
K/UbDzaq2fwG6d5U5YpsyPEM13h7qdmw10Wl4U+efSD0+4BB6EZfTk4SWXHvcRXa
TzWX/SRZvN/4OiBIdr23Ut6ezmbCcAKU41v68ar4fHgevT/D61DyM1L4twjbwThx
WcyOAxoU1z6ubpW6qXDSleTQOpyct20jVMF0HJXQX+Ed5J0GOyaQRwHRCSZq52Bu
eckHR2pr92h26ntscVbmYL6ELaDN44Vq8+ett+01cuBikSI6bnw+6yz6pA+LLR33
YGn8XC4c3Oyzeq7Sm/KSSS5dWl2qegh3UinHnM9M7ajifJCEpUI=
=N7SP
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
