Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE7EC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4112183F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5WxUw2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfDOPdX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:33:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41359 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOPdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:33:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so22512314wrq.8;
        Mon, 15 Apr 2019 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ikbp+kg60r293DItj6mhQVG5OaXd0qRLYJTi3APN/QI=;
        b=S5WxUw2sFaMDX2RDNJeInMGl3nWuUbMoVnPDgVfMCcsGtluzkdygTHyRP7ZXhdyN1H
         cDIph7jXVVVlWhsVNiY3RFUKVlhbmneSiRSJok5odIVZ0e2D/jyqRF3CXFyFwobdQwUC
         Y6Moz4E6NFHu9fFzc7X8PYD4XuXcR6ozWf3GUh1Pny4iHFzYZ25CtGPbI3Q6lDkzh4Wl
         C2V2iizuWiNOIkBPHyoJVDymQrbbr4xHf3+/RwmVYo/p2ZqK6RibxwDsBwY4WsTy3Q+8
         Qq4gb6cvrX/WmXrvAopUeC/t29NM1sp1Y3yoW6dhT/3t8NA2qgTJ5vIbelj7KfSRI5w8
         cWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ikbp+kg60r293DItj6mhQVG5OaXd0qRLYJTi3APN/QI=;
        b=G6kDD1rne595DZpPce85hDiWDjNGtpxQvLrabe4Y+TzFQabIksnIEUcXRcxF1G1ukP
         TzbGTtzdQzQM1Kdg7yS2e0g2xqdY/AjF4IMNfHYW421j5k5RCQ2e9rj/kFJeqppYvB9w
         b13pig2+toWplAmZNTfcDk7lv0sySSa2Dj45R/KuBUrDMyqVlL/UnOFaAJzCwhYTTsvw
         TF7INktjJbTJfn0CrHZoHfrZuN+QvVo7Lke3xBvayqFz/Bdb+qnpWqpz1rK8MNW4Mg+b
         ctAOu5J6F2QMRCImipjJu2CLRtXdaL7vYQnPSVCj7PksCcT35scsY3YjdWZR2GCAJy35
         kn/g==
X-Gm-Message-State: APjAAAVqCjm1l5YmVZTGjXM52LVkXl6Hsrx1oFZBuA/UmkrgQSsS3I3e
        EXZRcTozgycXYmcAYJSqw0I=
X-Google-Smtp-Source: APXvYqy04szvi4LgjYbZCzVpGRdHbk6t3rHwRgFzKJ9NBC53CR5AA3PUTVn2fJXqsIJDzieznAydwQ==
X-Received: by 2002:a5d:6b02:: with SMTP id v2mr25932619wrw.84.1555342400957;
        Mon, 15 Apr 2019 08:33:20 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id z10sm14697322wmi.15.2019.04.15.08.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:33:20 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:33:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 14/16] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190415153319.GK29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-15-git-send-email-vidyas@nvidia.com>
 <20190415153148.GJ29254@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NrP+m7YXMSGlHqXH"
Content-Disposition: inline
In-Reply-To: <20190415153148.GJ29254@ulmo>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NrP+m7YXMSGlHqXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 05:31:48PM +0200, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:41AM +0530, Vidya Sagar wrote:
[...]
> > diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/=
pcie-p2u-tegra194.c
> > new file mode 100644
> > index 000000000000..d4df8bfa9979
> > --- /dev/null
> > +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
[...]
> > +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> > +MODULE_DESCRIPTION("NVIDIA Tegra PIPE_To_UPHY phy driver");
>=20
> The driver description is somewhat odd here. Perhaps something like:
>=20
> 	"NVIDIA Tegra PIPE to UPHY PHY driver"
>=20
> ?

Or perhaps just

	"NVIDIA Tegra PIPE2UPHY PHY driver"

which is what you already use in the commit subject.

Thierry

--NrP+m7YXMSGlHqXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0pD8ACgkQ3SOs138+
s6GGORAAo698Yjy8BynRD0sRJ0x8Z7blftz6y1Ui3Ho3DyCHkFW8XsKWWLluQehE
b4AiRWWB/skZ2JyYmPcQzZz45GlrSoBe042LQKy6GWkJo+k9nnQxrpQhzflWY8uk
NJlWSvUbhtgVEhRNKeHqeOQRuupssqMRdUr5Nplzn2I+oe1U0w6o28IW4TzbEe0e
kWbPPMZmDArmo5evjNZF2lnqIaXq2YLcOJLBJZ8GAzS3Utve6eXBpSITn2hqJfTC
MjEBZoHpR6cjFdOBtNW9wvnMSSgoR8TYCy8qhMolKyE7D1K3/m/8Y71KBNOpjtxC
O/iSl4JLVRtsQ5RwibiNAarNrblbX8XMseMb8SnYWeCe8YkXYWjURXSXetwCOph1
uNRYVHvU9k2ko6/3k79YjP9tRo6glwIN/psCM7mAdNpUPEqxlxpkseKB9qZQdNui
PXvp9I+GL6Tjl8hybQxZXamhaCsE73mgXsjmpbnp/27icvzfkrPrW/Ui85aWcesC
zUidFhIURvPy2drp9A33TAeRoTwrRVBIICepCAVOC2ptbXSfdcpfoB3mdQxYNVSR
u4lW/Dab/cuQhrJSRB4bvCKmaHDvkeIfr+smOeY+OFI+0x1vQZI3KxxCQsEPH7VL
hOob4+jJuyEmCYQQNaKHNCM2KMiPXWLYw4wKa3Eb/Kezkx1ewSE=
=TygX
-----END PGP SIGNATURE-----

--NrP+m7YXMSGlHqXH--
