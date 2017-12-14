Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36619 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdLNO7r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 09:59:47 -0500
Date: Thu, 14 Dec 2017 15:59:43 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 0/3] Add ASPM-L1 Substates support for Tegra
Message-ID: <20171214145943.GC13733@ulmo>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
In-Reply-To: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2017 at 06:47:51PM +0530, Vidya Sagar wrote:
> Tegra chips T210 and T186 support ASPM-L1 Substates (i.e. L1.1 and L1.2)
> This patch series
> - applies fixups to reflect correct capability values for
>   T_cmrt (Common Mode Restore Time) and
>   T_pwr_on (Power On)
>   and adjusts counter values for 19.2 MHz of clk_m
> - applies fixup specific to T210 to avoid unnecessary wake ups from L1.2 =
state
> - enables advertisement of ASPM-L1 support in capability register
>=20
> NOTE:- This version of patch series drops a patch (that was present till =
V2 series)
> that introduces an API for host controller drivers to specify LTR_L1.2_TH=
RESHOLD
> value as more details and better understanding of spec is required to pro=
gram
> LTR_L1.2_THRESHOLD value.
> It also reorders patches to appropriately have software fixups and advert=
isement
> of capabilities
>=20
> PCIe - ASPM L1 Sub States spec
> https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_=
Substates_with_CLKREQ_31_May_2013_Rev10a.pdf
>=20
> Testing Done on T210 and T186
> - ASPM-L1:
>   Verified ASPM-L1 enablement by selecting PCIEASPM_POWERSAVE config
>   With the help of Tegra rootport's internal counter registers, confirmed
>   link entry in and out of ASPM-L1 state using USB3.0 add-on card, NVMe a=
nd NIC
>   cards
> - ASPM-L1 SubStates:
>   Verified ASPM-L1 Substates enablement by selecting PCIEASPM_POWER_SUPER=
SAVE config
>   Confirmed link's entry into L1SS using Westren Digital NVMe card (with =
Sandisk
>   Controller) using Tegra rootport's internal counter registers
>=20
> Vidya Sagar (3):
>   PCI: tegra: Apply sw fixups to support ASPM-L1 Sub-States
>   PCI: tegra: fixups to avoid unnecessary wakeup from ASPM-L1.2
>   PCI: tegra: Enable ASPM-L1 capability advertisement
>=20
>  drivers/pci/host/pci-tegra.c | 93 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 93 insertions(+)

Looks like these don't apply to an upstream kernel. Do you have any
other patches in your tree that would cause the context to be different?
I see a couple of fields in struct tegra_pcie_soc that aren't in the
driver upstream and I didn't find any patches on the list that add them.

Can you rebase this on top of a recent linux-next or -rc and resend?
Also, if the series depends on any other patches that have been sent to
the list but haven't been merged yet, please include a reference to the
patchwork or email thread for the dependencies.

Thanks,
Thierry

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloykdwACgkQ3SOs138+
s6ETTg//eHIjyBXaln/T6wA28Vjbvk/WmF8wyEz0w2lY4R3bQAActWaMzA7dMe6k
O4YIoXGZZcjdvMXGOSuunuEJ4ynYqjF6PNpcrmFUSkxfEHkvawbm0DuPIoY2wreW
dJSO4WxRKMfN1pj8wB2HEe2SQrDbVXb60sHBgjgsMEstOEDDBYojtDxO8ue1px0Q
AHEEUv918JDg1Ge+RArhaSh27w0D4bk+choLb6lZpz+c7rZjbql201nraE/mcWG8
vRwAS/TSI1HJN5CAE4JG0UXyNDmUjI91qUBsLxD+oygdKw9xZYM3H/++GY7oocht
hIkOu9EC4I2HALlMglBDS6lAo7CJ1HawISi+m/jD+s7T81gEz8QfuEp7T7WI1JaG
5Tr8CXwlpShcB9aAeD0B/DkM0W6EGR9HOQenGWSqMo4o+x50j2C3qljWrV7QTzfb
4fMofDoiowsnF9RtyJiuesFjLHKa9xukD08sibdeO/gEgasuhQw7oaHIalM8RBE5
4nXHdLzJdq+ZkKlq6xN7O+zqWuz7CfNMdu/CDgkB+WKjCwvWLLWaiBiDjXF8bgyf
V+zbDvlutj1qD0lDcVEiZvbBFgXYj2rxgs3dzpB97rsJ00kG+szMgbCdlOaayCpi
TlPmXbrB39r4KAWF7/tOTQmoPm8kPNLbvKbomFeAmusBpqGO5nk=
=ETQZ
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
