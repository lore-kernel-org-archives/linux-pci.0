Return-Path: <SRS0=TeuG=ZK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF1C432C0
	for <linux-pci@archiver.kernel.org>; Mon, 18 Nov 2019 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47733222B9
	for <linux-pci@archiver.kernel.org>; Mon, 18 Nov 2019 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574102340;
	bh=JLpriv5n1pA0d39J8iHuRWjED4eDVxKUbQZ/J5Hyzng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WeXMB13pqybfvM2MmN7OPLjjLQ2Sjrtne4+fc4xKz2kZriy4mvbIlEaHyslwDFK4
	 DFWLiruXo3ZvFwb1h2D2FysRE+mt12qzESTF0RmwV3TuO7kTDwUSKIrN/ht9kmV6Xw
	 xhebdliYpCH3dvLs5/R6fezQYLMIro6fbMyn5h0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRSi7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:38:59 -0500
Received: from foss.arm.com ([217.140.110.172]:38552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfKRSi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 13:38:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32621FB;
        Mon, 18 Nov 2019 10:38:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112A33F703;
        Mon, 18 Nov 2019 10:38:57 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:38:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, shawn.lin@rock-chips.com,
        andrew.murray@arm.com, heiko@sntech.de, lgirdwood@gmail.com,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
Message-ID: <20191118183856.GB43585@sirena.org.uk>
References: <20191118115930.GC9761@sirena.org.uk>
 <20191118142428.GA27459@google.com>
 <20191118181538.GA2261@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20191118181538.GA2261@e121166-lin.cambridge.arm.com>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2019 at 06:15:38PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 18, 2019 at 08:24:28AM -0600, Bjorn Helgaas wrote:

> > I don't know anything about the regulator API, but the fact that NULL
> > can be a valid regulator is itself a little surprising :)

regulator_get() has always been documented as returning a valid
regulator or an ERR_PTR().

> if (rockchip->vpcie3v3 == NULL) is true the driver would currently
> panic the kernel AFAICS.

We don't currently use this, it's just something we could do.

> Also, by making NULL a valid regulator, it means that regulators
> (ie pointers) with default values are valid whether we call
> devm_regulator_get* or not. I understand this patch can be dropped
> but that per-se does not make this driver code any more robust AFAICS.

That's one reason we've not done this.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3S5T8ACgkQJNaLcl1U
h9DFqQf/cTutH2x122zo7UHe+cKZ/hNpf/F5YBX4bqzxzmvQEZ47zT6xkwjxPxHr
vFjJW5qbKE/jVgtWX0e2B3ly0K1ekarqJLQ3y19TAO7bkJ16jIMp31fh6IK0HfWC
upzwAVBEH+dEpBNlaa1RFVvaDJBlL/MGEi+VhNqOae/Pi4HrgOhmCgCenG+ux+Wp
Bgk5JvIKqef7lkKvMETRkIVgsn6YA0uVHqQtnjx53Gz3V8KlAjWF5MEQ2vlIUHPt
VQ/a+ApxM2cBGsmcipwo2i516dDPOyS3WJCujf2AnVJtNjU6FX3kH7+C0TTL1Rhp
Nqk5/0Fy9gm8n8qwXsas38Ysz5XYEw==
=vY9F
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
