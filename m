Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43276 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935116AbeBMNJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 08:09:03 -0500
Date: Tue, 13 Feb 2018 14:08:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V7  0/4] Add loadable kernel module and power management
 support
Message-ID: <20180213130858.GG6764@ulmo>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
In-Reply-To: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 10:54:07AM +0530, Manikanta Maddireddy wrote:
> This series of patches adds loadable kernel module and power management
> support to Tegra PCIe host controller driver. irq_set_msi_desc() and
> tegra_cpuidle_pcie_irqs_in_use() symbols will be taken care in next
> set of patches.
>=20
> These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
> are the verification details.
> 	- Multiple module insert & remove
> 	- PCIe device functionality after module insert
> 	- Free clock, resets, regulators, powergate, iomem and interrupt
> 	resources after module remove
> 	- PCIe device functionality after resume from RAM
>=20
> V2: PM QoS fix is dropped in V2 from this series because the fix is
> incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
> latency framework")'. Update commit message of few patches in V2.
>=20
> V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_u=
se()
> are dropped based on review comments. These symbols will be addressed in =
next
> series. Took care of few other review comments.
>=20
> V4: Dropped pci_find_host_bridge() export patch and added new patch to use
> bus->sysdata for private data.
>=20
> V5: Decouple from https://patchwork.ozlabs.org/patch/832053/ and rebase
> on top of linux-next
>=20
> V6: Rebased on lpieralisi/pci/tegra branch
>=20
> V7: Addressed comments on patch: 6 and 7 in V6
> Limiting this series to linux-tegra & linux-pci since patches for other=
=20
> subsystem are merged or dropped
>=20
> Manikanta Maddireddy (4):
>   PCI: tegra: Free resources on probe failure
>   PCI: tegra: Add loadable kernel module support
>   PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
>   PCI: tegra: Add power management support
>=20
>  drivers/pci/host/Kconfig     |   2 +-
>  drivers/pci/host/pci-tegra.c | 347 +++++++++++++++++++++++++++++++++----=
------
>  2 files changed, 272 insertions(+), 77 deletions(-)

With the exception of the failure when building as a module that I
mentioned on patch 3/4, I've successfully tested this on Tegra20
(TrimSlice), Tegra30 (Beaver) and Tegra186 (Jetson TX2):

Tested-by: Thierry Reding <treding@nvidia.com>

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqC42oACgkQ3SOs138+
s6H8hA/8CrlhFya4crtq2aXk7WbelAxMF1O3+hOtBJVPMQEc7qwp2TWjcjY+w2jp
JcGMxmy22r7UEQvWV9eCkW8Fak1z7TCTFfO2EKGitUyA2IUxVv5d8wqWF6bZDno/
CTKVTc4XEqUMGGtARnW8EgTogc4+ZVlwMoNS0frsPm6eD3PwIgNZTP7EbCaKf8Sr
2yntJntr/qWGBIpMZnMulgx2RxU0dgyywKTihuyjrj35aIxDVFHcAouqah9J9pp+
ytQpV2d09KO6PimB8GFa+NLl6p1fPmD8dyGxNwHt7X2eJ89pfLbeOB4xCtPf4p/c
O4Zk/raCvpniyGb0ozZTIShdH0q1MhzAd9aRHZepJ26gSv9Vi3SUEOuWx5VKeSuU
1E1ClBoHt1cyAichMOrKThyr3gVn/JR3BKlw8FsLhnGS47vYgmwlifz/+zAF9FxG
+vFeCEAXVJ9CklbVU2rvnXWxuzorZT2cUCrMaObZ5Y0ljOsm4hRqh1EvjF1z5WJJ
IM+zWifUifwtaUvv8RdHpVD53yE5wY/2oTn0GbEBVyW1r0C9anLB6Q8fETWiWcxW
rkw1wy6OITyWWxaMNoaPvspdRtUyTVktcNmgDlNYe54cbmjzSKEkua9OYjYgNyE/
670Z3Mg1vMFKl9nnIBjkKseGhbrl5tQ31kzTH2S9J2HoN3PcF04=
=UcNn
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
