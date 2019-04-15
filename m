Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE81C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DD02087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJVlk5Ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfDOLwW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:52:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOLwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:52:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so20056585wmc.3;
        Mon, 15 Apr 2019 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6nUJ+AfbbOrYkgsMz3X9c73YS79FYCcl9NmCint8C8=;
        b=hJVlk5YeY8yag2nouGmrrrAEYT42HPgNIaisu+dwNLcQyWxKpbH2KTi/CjF6zQ4tIy
         UF+APgjWHndiygVMua7LBdEvHgaCQ946kprGCYobGkV7d2gh4WXL6+TjowH7cO5BSZtU
         xSECytVo6M6daoyM7xXRkXsOuYCEQXtDLQR2ma3eKh6xkg6RDHoGRch5y2nGiyBZ4MyC
         egtzExrtzQxSXov67rs/2gz8USgkE8EFHbvbEMLu/bOAVZyaLsKZgWrjIY7O0Bu3UxbS
         NHUm5sSrq1z4a7I0GjeejvwvIj9R62OnFVBrqUneR1cyQsMg4W2SFrGYoDJQo5nrYUgW
         yf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6nUJ+AfbbOrYkgsMz3X9c73YS79FYCcl9NmCint8C8=;
        b=Jmy/90ioWHEnJKKIoeCq0hsMvKKeFgrjavTOVdl3yu/iA0jYqNMYQxYflAeEqufLse
         oY5o1SJ/FhjG09/+4bFgiIG7NorUGI0rCeCs86Fce+ixiXdP27bWJjTHzbczu6QuajMU
         XLwTJvVfBOLdLKoYOnK0RNqkAiyRVDsXCzQYRDnTa9tgTX/uB24oq6tpMZ0qoRBSQq0u
         hcITEMPwNLHEop7osIpPio0ZSVnHxpc0qu79t7OpI/TNC2KYDqEYgX6LJ3fhhGlbYUbh
         DhNeQWs4nWjFRWNxUsAE/FD7PY23KXPuLmLAV6YWhI7M1H9geqsX9XuT3RhUEir96Zp7
         eD9w==
X-Gm-Message-State: APjAAAVYgKtUP69xBGnuy8s2bR8bIYWZO/3fCKZ2v43aYCXxu703WTQE
        GfvpMIfLUFqeG59pYmhBQ0w=
X-Google-Smtp-Source: APXvYqzs39ai2hnwXaBAsnRPQfnIGWD5rKNfZPU0AdqMUjNYDJ9qGV36vbrFoq4uI0b/x9Uk00gVlw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr20535420wme.78.1555329139819;
        Mon, 15 Apr 2019 04:52:19 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id z8sm50575895wrh.80.2019.04.15.04.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:52:19 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:52:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 14/30] PCI: tegra: Set target speed as Gen1 before link up
Message-ID: <20190415115218.GP29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-15-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8G1nIWD3RY794FAy"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-15-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8G1nIWD3RY794FAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:39PM +0530, Manikanta Maddireddy wrote:
> Some of the legacy PCIe endpoints doesn't enumerate if root port advertis=
es
> both Gen-1 and Gen-2 speeds. Hence, the strategy followed here is to
> initially advertise only Gen-1 and after link is up, retrain link to Gen-2
> speed.
>=20
> Following two cards display this behaviour,
>   - Fusion HDTV 5 Express card
>   - IOGear SIL - PCIE - SATA card
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 7dc728cc5f51..7e24eac12668 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -670,6 +670,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_p=
cie_port *port)
>  		value |=3D soc->update_fc_val;
>  		writel(value, port->base + RP_VEND_XP);
>  	}
> +
> +	/*
> +	 * PCIe link doesn't come up with few legacy PCIe endpoints
> +	 * if root port advertises both Gen-1 and Gen-2 speeds.
> +	 * Hence, the strategy followed here is to initially advertise
> +	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
> +	 */
> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS_2);
> +	value &=3D ~PCI_EXP_LNKSTA_CLS;
> +	value |=3D PCI_EXP_LNKSTA_CLS_2_5GB;
> +	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>  }
> =20
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)

This looks like it's related to the earlier patch that adds support for
retraining the link at Gen-2. As such, I think the two patches should be
moved closer together to make that more obvious.

Also, perhaps even the order needs to be changed. For example, if the
earlier patch enables advertisement of Gen-2, then there will be a
period of 10 or so patches where the above devices wouldn't work. So if
this fixes an error introduced by an earlier patch, it makes sense to
resort the patches so that we first fix the potential error and then
introduce the code that would cause the error to happen.

Thierry

--8G1nIWD3RY794FAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0cHEACgkQ3SOs138+
s6HhYQ//ZE33XGJb0W1SVhhQnJIuadqxGY05OGcBUtJJg9RkCAbwT6OldswqiWsX
MDvlKGra66ZQWw6WHMHKsy+oS2Bh6NMha9dG9/uaHMkUtPOev72Uaq2+nd3Ok3jw
Ae2tULQPbPCvyNr/wY3avHbGFOOy54KPIGgOvkfQYLTbSabt2/JUEM+CLM+4ZT2L
i5qGul+b34rFViaL59RdcxUdofCDn8iiKvnCYg/qjHoY91DilnUJpA/SmNkvsSEV
heRw0xcd03oCgHpE7VpLjtwJ2ujuehzf9igLujQTMrzb/kGQGQdivrFJd2InGPrA
mJdEq3IGufKeJ7QMPuIm/1z0zstPSPPYFqi//uENNXb6DX7fBuBjmziMqu8MUSV+
+Somyj1EDZbZYXy+eZCY99FuraUaCkQEsKunWTrIMheHj1vvms7VkOeZmW9mC0z4
O1aVPsdDcq1lWphnzqqF4UgZr3JcBMtAZ0bU8yFovKH3Y0Gy0OckV9d+DAr7fen5
S+N/n4WylinXloW5XO7ZzRbIrHzb6xt18Ntg7lSsPl3yKGKVPXJ3yKwn+Aj2oIYc
aiIJ5PQPg+SPZaro+Cp8vCMkMcvZkGUXqI5ISmH3YJJ9sJQIAE+FatP7i/OVE0Ub
3LzQsDxxxr3pO1VW7vBTpnJSR3N0QPQqRR7oyewz4MFRUDc6AIM=
=bOny
-----END PGP SIGNATURE-----

--8G1nIWD3RY794FAy--
