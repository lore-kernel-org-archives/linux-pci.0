Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD43C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC43217F5
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP5qtAda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfC1Mdb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:33:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40256 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfC1Mda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 08:33:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3833461wmi.5;
        Thu, 28 Mar 2019 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XiYPhLiSc0sheI22/HhTGA2hVZ2lmebipfMRfdSOBqQ=;
        b=hP5qtAdahXEdI0kQQO0tTbre0Xb1LPl8rjtCT6zGq6PoS//AdV6AXzwefksU87+ruQ
         Ygt0BDGm92OSZfd3vpqg28qjc6+805Bxqb4Xw/JJuahWmcDN5n50hNs8JUhZKs1Qlwm7
         quNxslIKjr40YHQc6i3pzstalrp8aJH/SjcqsE1aTFQYZZR13peDs1WPcJO2e/fomeYJ
         veD2TdQQPdIACQ9NHznw10NQeGpQk6xh9wQCayUdBlttTX5+Wmt7AISoox2bEJ9dF063
         ZLOh9vHBMT5a22SwS5YPTfI0vc3R+WPXdCC5+w5Eng+f7XGK5ntLuTAL2TLI9KpvOMgQ
         E7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XiYPhLiSc0sheI22/HhTGA2hVZ2lmebipfMRfdSOBqQ=;
        b=r2i12V55QOKpNzqLSvbnkVAWMyEI1n7nNapH9zdGGYE3hU0BA1WwZf3J4eaIUbEq7G
         F+3uxwW80+2Mt330WBtkSzyETXla1uaE/sPi6r95eUONmD6gkuRoBhwHn+GxGXgr+YQH
         k9jA1vC7ZzG40p0Nw+/GcmcfLLoUYT8snU83190XG3Y0TIjAv2AglYocIPCw55/YyMCX
         INcdbQVETyIqHwTic6zOu9LY+fKQAeGBBO5pGo3zjFTkzfeqIfmqkjTJudWDrl1F354d
         K2hMxGtUTAA2XWbmbMNOVti8kxyOC1FyHQz8TJ/W17baK3SPL01o7pmpC+MO1aP8Dhr7
         t6GA==
X-Gm-Message-State: APjAAAWRqCjlaw5YvRPCNyRtkqYpv5rmdYs2jBgJnm0NncelaWd562gS
        90Sehv8ztGkUuB+dwZTgbhU=
X-Google-Smtp-Source: APXvYqySs766CdICmGDrag2cnWKsQdbDmc8IDhuhDedRS1VrdjFDq7QqySZ6OGASlCMgi+RUKOTbZw==
X-Received: by 2002:a1c:44:: with SMTP id 65mr20384947wma.127.1553776408446;
        Thu, 28 Mar 2019 05:33:28 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id q4sm11678041wrx.25.2019.03.28.05.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 05:33:27 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:33:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH 03/10] PCI: dwc: Move config space capability search API
Message-ID: <20190328123320.GA5518@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-4-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1553613207-3988-4-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 08:43:20PM +0530, Vidya Sagar wrote:
> move PCIe config space capability search API to common designware file
> as this can be used by both host and ep mode codes.
> It also adds extended capability search APIs.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 37 +------------
>  drivers/pci/controller/dwc/pcie-designware.c    | 73 +++++++++++++++++++=
++++++
>  drivers/pci/controller/dwc/pcie-designware.h    |  3 +
>  3 files changed, 78 insertions(+), 35 deletions(-)

Just out of curiosity: is there any reason why this driver needs to
reimplement this? Couldn't this be made to work using the standard
pci_find_next_capability() function?

Other than that it might be a good idea to split this into two patches,
one that moves the existing functionality to the common code and another
that adds the extra functionality.

Thierry

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlycvwQACgkQ3SOs138+
s6FSHRAAiqfW9pZdlTMf93D0kyVYmJif0pMQT9zO40TPg/fOvnaoMv0VQaSweuGk
GuZEgZFflhDhQlpu+p9FC58xyabumnSxpuo9Zqlo9VMoClzkmOmNMng4kYFSGcmG
zKyzoVCOlwgp1yuDeZYJsXfpCcH+IFcnnYGp0+WO4HGqMcGM1VfYhNJs98TFJHaj
QrUdDrlw54VTiZzZKlqHDAEPtT9QW/u1jHhjPGESPkkW7gJiK3k718eEhNATx1DJ
cE+fMzbhitGvPB2sNJFWqFRIw43ff8qnsdKqKVTK6Fcx+13wSRz3GPtiGqbu3lwe
hkz6mo0GT/VKXRlkes8y6n93sUqlndeJAg2WJKhBahgqJVitl9aVzWt/8qzr+FDG
a4Anyw8h88Mc1MYdBhNE3Fedsm/q324bqCpmcmemLPZmy4tVCeMAu8XuagZq3txg
HZGzugRI2Avuvq4iJ9hqc6EAPOOja48OUVzQNO7H6ht2qLKeGVeEq9hGuqI0/dYW
H7djABdlbJTk4qL0Y1aEzc2y66mDkYrAniRbtH7wBcoVJ8kcNT7l+k99hkSDQUxQ
HZA4HbWEEaOhP7vHs9JWgwtLpgIDAy7gMRJ4drabe02YlSgm5+RAO7SqlIxD9Trh
t0QXl1CjjHzbqF1coa8XLFirUWskW9p9Y3H86pkuULFyCbjMllI=
=OOta
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
