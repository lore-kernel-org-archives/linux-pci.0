Return-Path: <linux-kernel-owner@vger.kernel.org>
From: valdis.kletnieks@vt.edu
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Peter Wu <peter@lekensteyn.nl>,
        Qipeng Zha <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of conventional and hotplug bridges
In-Reply-To: <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1519082904_3347P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2018 18:28:24 -0500
Message-ID: <7778.1519082904@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--==_Exmh_1519082904_3347P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Feb 2018 17:14:06 -0600, Bjorn Helgaas said:

> Change "pcie_port_pm=force" to enable power management of conventional PCI
> bridges and hotplug bridges as well as PCIe ports.  As with the previous
> PCIe port-only behavior, this is not expected to work in all systems.

This part says the behavior changes - which is itself a Bad Idea unless you
have a deprecation cut-over across several releases.  The general rule is that
you're not allowed to break somebody's kernel without a lot of warning.
Remember that there's probably a lot of embedded systems that hardcode their
boot cmdline and changing the behavior can result in a failed boot - which can
be a royal bitch to debug if the embedded system doesn't have a console.....

In addition, it doesn't match the actual patch, which documents the boot
parameter as being removed, rather than the behavior changed:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1d1d53f85ddd..4660105ec851 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

> @@ -3143,10 +3147,6 @@
>  		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
>  			ports driver.
>
> -	pcie_port_pm=	[PCIE] PCIe port power management handling:
> -		off	Disable power management of all PCIe ports
> -		force	Forcibly enable power management of all PCIe ports
> -

And *that* doesn't match the rest of the patch, which never touches the handling
of that parameter, either changing it or removing it.

--==_Exmh_1519082904_3347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWotdmI0DS38y7CIcAQIFNgf/Voo1PhvVYqriKAKxYoK9fDPbW7e5I/CQ
RyGJmtTIvp+AZNCcZUv1OMQYitmPzUPDSDcYcwaDDRS/y06kV78U+lE+rpr1OuPA
k6DLH7LX3vM30nHY6Pt2uxeDWK7otdCByBZwrrFMo0IqJle/2sK/RcFfkr3B1+24
wo8QO3Gnq/u44KMaGaEUz3plZN2z0ZcKPf3Wffy6CTPSzwy38K55tbjqhylhpYJL
HQ5LYC6WP2LsAAQ8jJ3VeZGY9OoVZcz2c1JH9PxdIrFr3R5zcYmEQhGBPmya3yF9
J/jqc10cp0fx9YiexZxU+UdaaZpK3Yf5/rdoX7AWB2ZdhqnTEFpBIw==
=TDtU
-----END PGP SIGNATURE-----

--==_Exmh_1519082904_3347P--
