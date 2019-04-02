Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CEC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB712084B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtP1HU07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfDBOUg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:20:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 10:20:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so16874910wrn.11;
        Tue, 02 Apr 2019 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpI16h+PlFg1hU2/fJYFvYepCCzxfoRKL7JIq6ujNJU=;
        b=QtP1HU079fPxHCjwWi5CTo2DP8u6vEpUEC0XS70CBGJhUgVfDp1pzgin8Z3ig7CgBp
         33aox3LCa1bWLktwbFmuQMWdYSGJeXQ2UdTvd9rHNS03I9idAgqV7IAUT/+JgkpBCudv
         auLqobfZ6J3NrC2DGuzhZyv4yfhsafd2TAuwad0aru6bOQVKVAuzwZNhr3aO9o+W4TEz
         Bjf6a3vEDh8/ket8jkJiIqWPCh8q3kXqLNOfOY/lvlapHmE417gP6mugpFPPRDblin0O
         5sOL8gRxiFeieKQDOJwbUt4rgbr1cymLAfwXRbreaJ6LMHWgYhQG5G12hwHq3UL4uKQa
         iNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpI16h+PlFg1hU2/fJYFvYepCCzxfoRKL7JIq6ujNJU=;
        b=Yywv7UU7+keaqcU1odtb3gnCgf2XtTAbzxVTviU68fzitrgWAF6fbSMvJpARuZjiaD
         EM38Qw73TFP3n0CfPEqUIIMl+wZMI6f2tBH+nvuc9OQQwfi+9tgcdx7YMc1sY//HfliS
         O5rek9p6vgr6YO+FD20/FX/sK+GIscUzC66JXyPLfe+drOgq1Lr0yUYg2Q4+OWzjwoXS
         FsYpCKaz8Nko5ASOSrtvWI747xX5+bvSlJUtmhVJbD/Vyt0cXB7U8zVzwwC/naorVe6H
         yGKDyKj+NCfKcekJD8alIExJB/qlJbRJplIQJtWwBLgSLO1lmS27upw9qaRLUpZuVNwm
         B5hg==
X-Gm-Message-State: APjAAAVjGklotFfKYOTXbQECIA2AdyxTco6uXe6LS1PtNvLveA0xOYDo
        OO10px6NUT/1kl+ZP5ZChXc=
X-Google-Smtp-Source: APXvYqzG51o0bcOitf2R7Na+As0TF/NGsnHW3fWX9diQWQO1Gsq/6hEA4rmsLtz0uXcKlP2j4k8OcA==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr45510414wro.234.1554214833528;
        Tue, 02 Apr 2019 07:20:33 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id c189sm17272143wme.32.2019.04.02.07.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:20:32 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:20:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, bhelgaas@google.com,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        tiwai@suse.de, spujar@nvidia.com, skomatineni@nvidia.com,
        liviu.dudau@arm.com, krzk@kernel.org, heiko@sntech.de,
        horms+renesas@verge.net.au, olof@lixom.net,
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
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
Message-ID: <20190402142031.GC8017@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <5ca06149.1c69fb81.720fd.79e1@mx.google.com>
 <5ef50168-2476-1088-7156-8a4488d7a2e1@nvidia.com>
 <20190401143138.GA4874@ulmo>
 <67f9b726-c075-0291-7777-8f10ecc9e29d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <67f9b726-c075-0291-7777-8f10ecc9e29d@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 02:46:27PM +0530, Vidya Sagar wrote:
> On 4/1/2019 8:01 PM, Thierry Reding wrote:
> > On Mon, Apr 01, 2019 at 04:48:42PM +0530, Vidya Sagar wrote:
> > > On 3/31/2019 12:12 PM, Rob Herring wrote:
> > > > On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
[...]
> > > > > +Optional properties:
> > > > > +- nvidia,max-speed: limits controllers max speed to this value.
> > > > > +    1 - Gen-1 (2.5 GT/s)
> > > > > +    2 - Gen-2 (5 GT/s)
> > > > > +    3 - Gen-3 (8 GT/s)
> > > > > +    4 - Gen-4 (16 GT/s)
> > > > > +- nvidia,init-speed: limits controllers init speed to this value.
> > > > > +    1 - Gen-1 (2. 5 GT/s)
> > > > > +    2 - Gen-2 (5 GT/s)
> > > > > +    3 - Gen-3 (8 GT/s)
> > > > > +    4 - Gen-4 (16 GT/s)
> > > >=20
> > > > Don't we have standard speed properties?
> > > Not that I'm aware of. If you come across any, please do let me know =
and
> > > I'll change these.
> >=20
> > See Documentation/devicetree/bindings/pci/pci.txt, max-link-speed.
> > There's a standard of_pci_get_max_link_speed() property that reads it
> > from device tree.
> Thanks for the pointer. I'll switch to this in the next patch.
>=20
> >=20
> > > > Why do we need 2 values?
> > > max-speed configures the controller to advertise the speed mentioned =
through
> > > this flag, whereas, init-speed gets the link up at this speed and sof=
tware
> > > can further take the link speed to a different speed by retraining th=
e link.
> > > This is to give flexibility to developers depending on the platform.
> >=20
> > This seems to me like overcomplicating things. Couldn't we do something
> > like start in the slowest mode by default and then upgrade if endpoints
> > support higher speeds?
> >=20
> > I'm assuming that the maximum speed is already fixed by the IP hardware
> > instantiation, so why would we want to limit it additionally? Similarly,
> > what's the use-case for setting the initial link speed to something
> > other than the lowest speed?
> You are right that maximum speed supported by hardware is fixed and throu=
gh
> max-link-speed DT option, flexibility is given to limit it to the desired=
 speed
> for a controller on a given platform. As mentioned in the documentation f=
or max-link-speed,
> this is a strategy to avoid unnecessary operation for unsupported link sp=
eed.
> There is no real use-case as such even for setting the initial link speed=
, but it is
> there to give flexibility (for any debugging) to get the link up at a cer=
tain speed
> and then take it to a higher speed at a later point of time. Please note =
that, hardware
> as such already has the capability to take the link to maximum speed agre=
ed by both
> upstream and downstream ports. 'nvidia,init-speed' is only to give more f=
lexibility
> while debugging. I'm OK to remove it if this is not adding much value her=
e.

If this is primarily used for debugging or troubleshooting, maybe making
it a module parameter is a better choice?

I can see how max-link-speed might be good in certain situations where a
board layout may mandate that a link speed slower than the one supported
by the hardware is used, but I can't imagine a case where the initial
link speed would have to be limited based on the hardware designe.

Rob, do you know of any other cases where something like this is being
used?

> > > > > +- nvidia,disable-aspm-states : controls advertisement of ASPM st=
ates
> > > > > +    bit-0 to '1' : disables advertisement of ASPM-L0s
> > > > > +    bit-1 to '1' : disables advertisement of ASPM-L1. This also =
disables
> > > > > +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> > > > > +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> > > > > +    bit-3 to '1' : disables advertisement of ASPM-L1.2
> > > >=20
> > > > Seems like these too should be common.
> > > This flag controls the advertisement of different ASPM states by root=
 port.
> > > Again, I'm not aware of any common method for this.
> >=20
> > rockchip-pcie-host.txt documents an "aspm-no-l0s" property that prevents
> > the root complex from advertising L0s. Sounds like maybe following a
> > similar scheme would be best for consistency. I think we'll also want
> > these to be non-NVIDIA specific, so drop the "nvidia," prefix and maybe
> > document them in pci.txt so that they can be more broadly used.
> Since we have ASPM-L0s, L1, L1.1 and L1.2 states, I prefer to have just o=
ne entry
> with different bit positions indicating which particular state should not=
 be
> advertised by root port. Do you see any particular advantage to have 4 di=
fferent options?
> If having one options is fine, I'll remove "nvidia," and document it in p=
ci.txt.

I don't care strongly either way. It's really up to Rob to decide.

Thierry

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjb68ACgkQ3SOs138+
s6FD5w/+Ph9LQU8GQsXjPzIJIldfOH1kjDq6hK38fLuzrABjWSsrRFvEIA9bHgJq
Nsd7KXtwEaqoL22mL9NfByIWWiWlnGBeAMdHJ/XXZOwAUp/O9+VVs3W9DEynSffr
Y75gYnUoI4u0OmQKGHRyKItqY/X6ZgiOfUEZikk6FEgFqMB+POTnWIFVtFj7sal+
B6BRmyX7JG6/7uj+5fR4D8s86QFLkhGbLLvH4pCk/4j+BoMtgxWkfnm4UwIohI3M
JUJ498e50Wkv4b22K6EfgRWm3UTIlEqYvi5UA2dc2WPX0YftobDjnOzxM+xTmaG6
jTqMI54S01tmj+pZ1MYb4v+rWfcnZzBYdFU1kYww6YD9iUtZRfZ0xlEx4x5/4yRK
Yc7jXQIdcPe0Cim7i4Gynu+LgnIm15rwXX0o3MzvYze2GdQ1KRu3enOvJI0OqavQ
wiF2X2835v6dvgFMlYM6RQRG2prakluLnop4EeWe/kZR0Dq/F1wcNR6mSht/7QjN
lmbOTOPhc3FCpjV7iZp3ljEeRllOB7Ri4C6s+Byzy7Vix4wDlatEc7fHqDqVMlYz
rnGvFY5WvmuBX5nzyYzy27R/u2VBKwzYO1aTid7FSAVO39cFV8BScHZSxIncnwSH
q49nsxqe58i6IIFB2rI3iT+an+TBypraHkp7inpQdULp2Jcnj3U=
=BIli
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
