Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35820 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936228AbcJGRWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 13:22:14 -0400
Date: Fri, 7 Oct 2016 19:22:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: tegra: Swap order of pads_writel() reg/val
 arguments
Message-ID: <20161007172211.GB10399@ulmo.ba.sec>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007162632.23718.27618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
In-Reply-To: <20161007162632.23718.27618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 11:26:32AM -0500, Bjorn Helgaas wrote:
> Swap order of pads_writel() arguments to match the "dev, pos, val"
> order used by pci_write_config_word() and other drivers.  No functional
> change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-tegra.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX99nDAAoJEN0jrNd/PrOhiY0QAIFm/i9I39C5zj2oADxmjZ6A
+SEdEh+9y+T53pnw0mQTIqlx8WjAx49oWKRnPojM6Z9Enbv30Rs05z1pzlr3lbMy
YhBmE61CIXFPPA1+8mqaSKBx9237UEsN+fThKMqWNSg4BUHKBbYIFEv3YixJwiNW
ZBhuJxn1JiH2Ng2lCHDK2YUx3DyBNCq4OAxv8L+Go4m5fzI7/Q4SnfUrEdvVJp+e
xeOYwYbGJ/Zh81q8tJ9MBGc1r6R7cRDmmLduYuY/LnQLGGmQlJ5M0h7lOpB1Hege
zTePwZyWDSR1gd8k3QXfeFjVYkqwJQnmCn9QNwSoGCqe7QocC/bgnGUIqvyNdO6E
J8dqBLMDT7AMqgYltL9iVQr6OXCxFNCMNGzrnmwewGpegk1BZYkZNXXCpz6YF4oR
TZWxQR5PjCVCOXXaO/mYVB8ET+skw+mFCj2/RNn6xnnKVzZfbcUE80GuJacVQSbp
rwduaMdgmGzIUz+HtIOzn2PV4SJUZGUgkyQ4SKG5Rn96pX//zwLxggVGF4fyVFbi
ZMV5IyiTF5nIdgckLLIypV+ZIfJ68UcW4Cv7q1Q+3XmJX9s0/fVm6qqHjcXKJ+az
VhRXPVP05yG9zifRh21e7iyVEjPKabFXViUenLhYSa2RKzr3xWkwlZLSNqVncXMZ
0htqs1hfwbtI5bYlxsjs
=C7hp
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
