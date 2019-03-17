Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111AFC10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376A217F4
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfCQJMb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:12:31 -0400
Received: from sauhun.de ([88.99.104.3]:52394 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfCQJMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 17 Mar 2019 05:12:31 -0400
Received: from localhost (ip-109-41-130-14.web.vodafone.de [109.41.130.14])
        by pokefinder.org (Postfix) with ESMTPSA id 3F3B62C27DA;
        Sun, 17 Mar 2019 10:12:29 +0100 (CET)
Date:   Sun, 17 Mar 2019 10:12:28 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
Message-ID: <20190317091228.GB2268@kunai>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190317000608.24881-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2019 at 01:06:07AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> The MSI address can be 64bit. Switch the data type used to hold the
> result of virt_to_phys() to phys_addr_t to reflect it's properties
> correctly and program the top 32bits of PA into PCIEMSIAUR.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Looks sane. Not being a PCI expert, I wonder: Were we just lucky to not
hit a 64-bit MSI address before? Is this tied to our 32-bit limitation?


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyOD3wACgkQFA3kzBSg
KbZZdQ/+JNE1/DZj3ApVMmrgAeeT/i9Sgne12kAGc31P7XF7cU6H36zSuhIJZnTB
ZdWLCf3MNE9RQ08cdtmDHMk36bUXY3GQ0KDezGpvgAC0typ4k+sFwsQRZrG1MS1W
499whdHBnuNuO5IqeRlH5aoNYqkbiCB0wbPTJ5wPHiZq8+R7CeBVZ8tJ6uj5IPJg
zr+MPd/bJERAom3tFKWf61J+UYWIPOLBdRnTw5c/zHH3L11tO08BNbS4DAuGVAcm
qLpYfb5dl6/z8kD369ROwi5kBlqxvPzwmA2nM1YiDBSdQN7ODdLCP7K/ACbmkW/P
iXwmtyrmBN3rBg7DZB5QNoVnZFxuvHA0mRyv3bShx6g2/kfLKqr9k8tiaDtmvaI1
OeKgYquvltmXyk1gbLXNPZRzgPOuQ8tGfk8EDXNwgN14bwH9BhdZ6p7I1oyvnXZt
U7SZ1fMgzOE8u8qKE/MVscrp2anaIxVFgbbf00r7liVnbwjXscr/7p/PwrN3nHK2
5v0WiSfwWhCZCIoICR/j+jjDaZOW1QpUMfsQJcdOBBOgrQxFK7V9u6sB7tzHW8xy
WHpDcdfUdXPPqQKTeB0A7PDS5eEjtNtKs+OW7Vtw72m+ouTONENr7e3JWgmLyJdu
4gcU+30yNLe0kSHAaEAcF8g8LHQFUI3xVCV1lMDoObnu4oaka7g=
=f6V8
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
