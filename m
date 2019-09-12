Return-Path: <SRS0=JEK6=XH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB16ECDE20
	for <linux-pci@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C172171F
	for <linux-pci@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568285633;
	bh=lYW/6z+3b+RUaKXVSh07U4b2ptr3sXYySVGiJGaSSZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GE0gbotx2wWBYyAYTxYOt/7GvvhRatJUHUjdQ0A9j+JsAJT3zbLKTCprzEo6MXcrD
	 DQ4cKypTR75seUZX6Q3Z5D3dEHeXFGd+Sgg1r2izMWzC9ndwFt+nxQ1MwLRoLxzguz
	 l7OFHFBX3MzgNEEnx8sDMFQEY4pnpdOwBwtD8PQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfILKxt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:53:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfILKxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 06:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D2D5xYaEKANX2x4ZJuWEVTNW1zYISnb/gu0LN4hJxKM=; b=WNqaA4u/faAGf9OS5qIbmq2Hs
        mWYdtL6fbchxGuAx43E34yD8Iuej5YZd3OfeAtXScPg4snnUaiz4NneKJONB/gxrQ6u2M6Ed0Bstq
        yQrjujqbf5juAAMGsRHZf6mDLO3xGHGkO1G0qO2n4xFS1KP75OW60V0gBrQZ2iCuWjvIM=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8MjM-0006Ya-Sb; Thu, 12 Sep 2019 10:53:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DD9C0D0046D; Thu, 12 Sep 2019 11:53:39 +0100 (BST)
Date:   Thu, 12 Sep 2019 11:53:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
Message-ID: <20190912105339.GK2036@sirena.org.uk>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
 <20190912094651.GH2036@sirena.org.uk>
 <CAP245DXBwwtcbjRQV_bCdYK5SZH9C9oxZJ2rFraJpbd5L0sHvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H6o9R95t2FPeZmf3"
Content-Disposition: inline
In-Reply-To: <CAP245DXBwwtcbjRQV_bCdYK5SZH9C9oxZJ2rFraJpbd5L0sHvw@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--H6o9R95t2FPeZmf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 03:33:20PM +0530, Amit Kucheria wrote:
> On Thu, Sep 12, 2019 at 3:17 PM Mark Brown <broonie@kernel.org> wrote:

> > > I was using initcall_debugging on a QCOM platform and ran across a bunch of
> > > driver initcalls that are enabled even if their SoC support is disabled.

> > What exactly is the problem you're trying to fix here?  For the
> > drivers I looked at these were bog standard register the driver
> > with the subsystem type initcalls on optional drivers so not
> > doing anything particularly disruptive or anything like that.

> I was trying to prune the defconfig only to drivers that make sense on
> the SoC. e.g. Why should I see a brcmstb_soc_device_early_init() call
> on a QCOM system when I've disabled ARCH_BRCMSTB?

So this is really just the standard make Kconfig easier to use by
filtering out noise thing.  It'd be clearer if you said that in
the changelog, and like the review comments have been saying you
need to leave in an || COMPILE_TEST in there otherwise it's
actively harmful.

> I came across this while trying to figure out how to make thermal and
> cpufreq frameworks initialise as early as possible.

AFAICT you'd also have been happy if you just built these drivers
modular?

--H6o9R95t2FPeZmf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16I7EACgkQJNaLcl1U
h9A5Xwf/Rv/6OyuOPX5W2hdLghPKgkdYoB2KbGacwvDTAd1oxRtRjMbzWEVEvqYO
j7Tj/JYrweUkTWM5SVxsDpiSAk7bx5eAGlLMxPDtK6NcM48bSaURXpoWhOQ4EWKo
ygzxV2PFMVmDf3yOmTcSXDpu+sAvb5eIF+gbsLCS98uc3uPZT8dO8Q3ZOI8R8TLJ
6AAdcecAKc+T156a8ted8iIlK9Ze2hTY1J1mfrIsXvpdAxcfmLaqB26ZfDSUN5AE
EUZFeWQboDrYzuSWYGjgqKMyzFhgigoYgnKI1hnepKs1tqoieoT9DZZ0AT2dcCGL
2STeoJiRo8YT6dVf8HnBzwNSizJdQg==
=8wH4
-----END PGP SIGNATURE-----

--H6o9R95t2FPeZmf3--
