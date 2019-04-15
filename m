Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE4C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330E920848
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfvToydv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfDOLVO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:21:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37494 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:21:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so19929138wmf.2;
        Mon, 15 Apr 2019 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mkCjvW3puWchcggeMGLmFDn9SG2ZXVl0+ee8SPGCsQ=;
        b=DfvToydvfWsFkePecjiV6jscR/iLwQgmR3MwlUXiHFDJ/WsAYzmOi5KEvUR7K2OXK3
         zHS4TOMd2anPeMm0GcqXCIu9Kp1V5IjemP8S5jWvgvsOj58T7V9Y5dqZgw4/8tXb0JbC
         YzrUrnzMWLAiLVowPRnOATLoST9TxA1xwL7trXEqOigJjkT9kvs5VyXHuBMQICSC8BFt
         HDi1/0EeCX4wH3736jn0IgZhbX4USttPGY+Mhf97L6teEV3UXi/2N7ywBuKmpS8cwSWu
         0tYFR07zt0bl/izDhOkX5MQtcCrJgYQ86NBPn/XM8TtoyHuYLpdPXkk+uyaxwCXg0xf/
         D4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mkCjvW3puWchcggeMGLmFDn9SG2ZXVl0+ee8SPGCsQ=;
        b=VBt2Nn5kVyTCEy4aG0QhJasCaB7a5nRyCnHAqBS+9RgMxw8em6s0pCixPhACCyfQS+
         dNYn7FOzpaYcFRYBUAXMxK/xCCuGCZj27mBEzZ9we478XkcrCuRS+t7HB+1IKYS7v3UY
         taH+Mba/QXyofYGcC66ggrqtwndy+t6HuIGzd4JE9pMceJniAkMeQVnLjAo3uu7AFLUA
         R1sqV6uSAAwT5imnijOvDONXvSYepe0YNKA+JuKd6y1xe5g80dOFWr58bVaNM7f9ORp1
         wcokuQHIOlylOpys7+FHyNHv4k5574QQqZsjKe7/3m1w8RXmvqhFuiPpRA/G2wTGEtsS
         v3GQ==
X-Gm-Message-State: APjAAAXpzOYWpswCNNB6QCsljezOf9RJwsGxd8XXF/97G6SYc7fmMpSC
        6O1KIcckGE2FnsiNSFcprPgR1vkO
X-Google-Smtp-Source: APXvYqxCvMCdhOZPNNAXUQvaUeJMWuO2E0reE24JGPh8jux7pCHoPRjMhbMIp3U/cyhNZ0IGHwMDhA==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr21905878wmi.1.1555327271110;
        Mon, 15 Apr 2019 04:21:11 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id n4sm51018955wrx.39.2019.04.15.04.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:21:10 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:21:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/30] PCI: tegra: Add PCIe Gen2 link speed support
Message-ID: <20190415112108.GE29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-5-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-5-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:29PM +0530, Manikanta Maddireddy wrote:
> Tegra124, 132, 210 and 186 support Gen2 link speed. After PCIe link is up
> in Gen1, set target link speed as Gen2 and retrain link. Link switches to
> Gen2 speed if Gen2 capable end point is connected, else link stays in Gen=
1.
>=20
> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
> PCIe LTSSM to come back from recovery before retraining the link.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 61 ++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index a61ce9d475b4..6ccda82735f8 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -191,6 +191,8 @@
>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
> =20
> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
> +
>  #define PADS_CTL_SEL		0x0000009c
> =20
>  #define PADS_CTL		0x000000a0
> @@ -2096,6 +2098,62 @@ static void tegra_pcie_apply_pad_settings(struct t=
egra_pcie *pcie)
>  		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>  }
> =20
> +#define LINK_RETRAIN_TIMEOUT 100000

This is oddly placed. I think this should go somewhere near the top of
the file. We already have PME_ACK_TIMEOUT there.

But to be honest, I wouldn't even bother with the #define. This is used
exactly twice and is much longer to type than the actual number.

> +
> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
> +{
> +	struct device *dev =3D pcie->dev;
> +	struct tegra_pcie_port *port, *tmp;
> +	ktime_t deadline;
> +	u32 val;

The driver uses u32 value for register values elsewhere. It'd be good to
stay consistent with that convention.

> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		/*
> +		 * Link Capabilities 2 register is hardwired to 0 in Tegra,
> +		 * so no need to read it before setting target speed.
> +		 */
> +		val =3D readl(port->base + RP_LINK_CONTROL_STATUS_2);
> +		val &=3D ~PCI_EXP_LNKSTA_CLS;
> +		val |=3D PCI_EXP_LNKSTA_CLS_5_0GB;
> +		writel(val, port->base + RP_LINK_CONTROL_STATUS_2);

The comment says there's no need to read the register, but then the code
goes on and reads it before modifying it.

That's the first thing that came to my mind. Then I realized that the
code doesn't actually do anything with the Link Capabilities 2 register
at all. So what's the deal here? Is it that the Link Capabilities 2
register being hardwired to 0 means that we can change the target speed?
Your comment needs to explain more clearly how it relates to the code.

> +
> +		/*
> +		 * Poll until link comes back from recovery to avoid race
> +		 * condition.
> +		 */
> +		deadline =3D ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> +		for (;;) {
> +			val =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if (!(val & PCI_EXP_LNKSTA_LT))
> +				break;
> +			if (ktime_after(ktime_get(), deadline))
> +				break;
> +			usleep_range(2000, 3000);
> +		}

This would be more compact when written as a while loop. Also I think
it's more readable to make the !(...) an explicit comparison. Finally,
use whitespace to improve readability. The above looks very cluttered
and, in my opinion, makes the code difficult to read. Something like
the below is much easier to read, in my opinion:

		while (ktime_before(ktime_get(), deadline)) {
			value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
			if ((value & PCI_EXP_LNKSTA_LT) =3D=3D 0)
				break;

			usleep_range(2000, 3000);
		}

> +		if (val & PCI_EXP_LNKSTA_LT)
> +			dev_err(dev, "PCIe port %u link is still in recovery\n",
> +				port->index);

Since you're continuing execution, perhaps make this dev_warn()?

> +
> +		/* Retrain the link */
> +		val =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> +		val |=3D PCI_EXP_LNKCTL_RL;
> +		writel(val, port->base + RP_LINK_CONTROL_STATUS);
> +
> +		deadline =3D ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
> +		for (;;) {
> +			val =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> +			if (!(val & PCI_EXP_LNKSTA_LT))
> +				break;
> +			if (ktime_after(ktime_get(), deadline))
> +				break;
> +			usleep_range(2000, 3000);
> +		}

Same comments as above.

> +		if (val & PCI_EXP_LNKSTA_LT)
> +			dev_err(dev, "link retrain of PCIe port %u failed\n",
> +				port->index);
> +	}

Most of the error messages in this file are of the form:

	"failed to ..."

Perhaps make this:

	"failed to retrain link of port %u\n"

for consistency?

Thierry

> +}
> +
>  static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  {
>  	struct device *dev =3D pcie->dev;
> @@ -2122,6 +2180,9 @@ static void tegra_pcie_enable_ports(struct tegra_pc=
ie *pcie)
>  		tegra_pcie_port_disable(port);
>  		tegra_pcie_port_free(port);
>  	}
> +
> +	if (pcie->soc->has_gen2)
> +		tegra_pcie_change_link_speed(pcie);
>  }
> =20
>  static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
> --=20
> 2.17.1
>=20

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0aSIACgkQ3SOs138+
s6Egyw/+L2JItfslNCOftAK/VjtYmQFRKowMg8fXfL+BTHvlWqE/0ZuW+gVeL7D8
IKMehZy0NFlP93q1N4xjZXaoXJ6FIfUriE/V3EUSWMe7Cw5opiEarQLIaZ/5miDz
jLt0nu45z8VAnxkmgkYcM6oCSTxposY6VShMc6M7mbZwcE3zyI7lyjQJZWtdwFr2
UZXbPCgrRA919FYCAAy2rwVD00NblYcWuQEdZ9azoow+MlRHKOdxiVsMO3PHZut4
0j6aF2BLqk2P2wOulE2z2/7IzT72ViduLOEp8OL3WhEN9yb/ca42JL0Ez/j2nSZw
I10s3K+X9QWY7Ol8s9OtZ+Kwo4VGS4j9Ev/AQM2qzCAnBq4Cc5CfXOIeQcu8z9KC
RK6vySfgdZfzsf1Nsz7mGbuxxAH0rOGQ2y7khudhFNYx3HAiKPyGfGxgJAr1Nmcm
4VkLRPhE6aWe7v9ItLoGw65YVqcs1IcUe/bGss2L/0t7wHgnb6rc1W8FSIuu0Gyb
9pHrJodXsOX0Xg3rHJHztJ2EUac7lyryzuMma2ljlOOvMVk/wG0WLvD1CtKvLZKr
Rk9NsONwJ94+DhERkgC8WwsbX/4ZFyIFhSt8uQPLYYFQ11fW76C9pK2lxFMebW/i
EWPKiyCBAfu0Dffy1MbNMrL8NcqTRVJ1ykh2TD10Ens6/WUy48g=
=WX7G
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
