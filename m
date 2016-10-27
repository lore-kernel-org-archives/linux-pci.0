Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH] Consider the CONFIG_PCIEASPM_* values within pcie_no_aspm
Date: Thu, 27 Oct 2016 09:00:44 +0000
Message-ID: <eb7f909fe4ee4d6a8695d62d9e7ac47c@FE-MBX1012.de.bosch.com>
References: <6cde8280b51c46be8c46b4665d5fbcba@FE-MBX1012.de.bosch.com>
In-Reply-To: <6cde8280b51c46be8c46b4665d5fbcba@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel=
.org]
> On Behalf Of Koehrer Mathias (ETAS/ESW5)
> Sent: Wednesday, October 19, 2016 4:37 PM
> To: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Bjorn
> Helgaas <helgaas@kernel.org>
> Subject: [PATCH] Consider the CONFIG_PCIEASPM_* values within
> pcie_no_aspm
>=20
> Consider the CONFIG_PCIEASPM_* values within pcie_no_aspm().
>=20
> In case that the ACPI FADT declares the system doesn't support PCIe ASPM,=
 the
> function pcie_no_aspm() will be called.
> However this sets the aspm_policy to POLICY_DEFAULT even if
> CONFIG_PCIEASPM_PERFORMANCE has been configured.
>=20
> Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
>=20
> ---
>  drivers/pci/pcie/aspm.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> Index: linux-4.8/drivers/pci/pcie/aspm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D
> --- linux-4.8.orig/drivers/pci/pcie/aspm.c
> +++ linux-4.8/drivers/pci/pcie/aspm.c
> @@ -79,10 +79,13 @@ static LIST_HEAD(link_list);
>=20
>  #ifdef CONFIG_PCIEASPM_PERFORMANCE
>  static int aspm_policy =3D POLICY_PERFORMANCE;
> +static int aspm_default_config_policy =3D POLICY_PERFORMANCE;
>  #elif defined CONFIG_PCIEASPM_POWERSAVE  static int aspm_policy =3D
> POLICY_POWERSAVE;
> +static int aspm_default_config_policy =3D POLICY_POWERSAFE;
>  #else
>  static int aspm_policy;
> +static int aspm_default_config_policy;
>  #endif
>=20
>  static const char *policy_str[] =3D {
> @@ -946,7 +949,7 @@ void pcie_no_aspm(void)
>  	 * (b) prevent userspace from changing policy
>  	 */
>  	if (!aspm_force) {
> -		aspm_policy =3D POLICY_DEFAULT;
> +		aspm_policy =3D aspm_default_config_policy;
>  		aspm_disabled =3D 1;
>  	}
>  }

Any comment on this patch?
Thanks for a short response.

Best regards

Mathias
