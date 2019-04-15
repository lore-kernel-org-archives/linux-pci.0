Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF886C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9FC20833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdzWuXC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfDOLmC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:42:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfDOLmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:42:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so8206867wmd.0;
        Mon, 15 Apr 2019 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVw+PVVCPMlP4Qj0t9ngTG19DDkmx/wgj02UVGGSXdo=;
        b=fdzWuXC4Ptg5V47rxmwuKi/7+m+kQ0AH+/pgOm7as6WAZEwDdyM0l+zKviceOsCL+8
         LBDPQJkXBAKSA8FMgmv/YLuuwmgkb0hv8dkZmzwZXNJFXIWM3YDYDipOvpy7uBpMxPRt
         1TVUG1FH7pRxGVFAQKhTCLFPyp/f6BWyvQwDWQVPH8ovAzO4aXxEXmz6AQ5njh/dMNG6
         w24y2T9o7ypysJd9Dp+LQW70kKQEj7KV3QhqLqRTSigde7rv6IGzKhy4Cxa3/GDfw869
         BHYKJcudAgFgGP2J9golFftkpC1/xGyQRfAp4L7a4qXg1TP6Cq9OXmjYchNDYciozGol
         atTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVw+PVVCPMlP4Qj0t9ngTG19DDkmx/wgj02UVGGSXdo=;
        b=AOnO3TRAmENLR+xS6/lzAETFFKxjuRAG3XmZ1rUDBZ+EzyO7BmOsXZrpbfHF9wvr3n
         tKdlKJFzsb4AOqTkf9pHFAiCQAXr73w/DZwCm0N+dlE6ACUVxQS2hIw0PoD4qqo9raL6
         ghedqLDYZChVBXmFjC8ZBfLXyVzQRx8fTpsmRxvS2TjALrHzHFXPh45eSZy1zJpf609i
         aGlKVsT2JXkt3u8dn8OOYTysQiQOObHt5h8tyieJYwP6CWQ+ezfx4mKWoLcQYERNZmGv
         LAlTAJkNIyEIAISzvcNmY1NPedy2nsroJ2t0k7PjhRNGePKrD0E5klGJbyPuQ+cCLVos
         OEMQ==
X-Gm-Message-State: APjAAAVvwQ6yPyhcy9+u6EQ1tW2qSLeOyllBkKVYbtXua5cui+m3HzRC
        dqRfBe/6AXKwOUfRnQ5SW9k=
X-Google-Smtp-Source: APXvYqwuhuZyaRfKCuBebZgB4eax3gDQBS3NECLpWKysiW0jdqvGn7qGqn/frH0Pub3Q8eO8om74vg==
X-Received: by 2002:a1c:c254:: with SMTP id s81mr20804006wmf.55.1555328520307;
        Mon, 15 Apr 2019 04:42:00 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id v184sm33476587wma.6.2019.04.15.04.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:41:59 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:41:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/30] PCI: tegra: Add SW fixup for RAW violations
Message-ID: <20190415114158.GM29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-13-mmaddireddy@nvidia.com>
 <20190411200121.GQ256045@google.com>
 <f0f02fbd-0217-9c6d-437f-e5212b67bc24@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Content-Disposition: inline
In-Reply-To: <f0f02fbd-0217-9c6d-437f-e5212b67bc24@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 11:29:35AM +0530, Manikanta Maddireddy wrote:
>=20
> On 12-Apr-19 1:31 AM, Bjorn Helgaas wrote:
> > On Thu, Apr 11, 2019 at 10:33:37PM +0530, Manikanta Maddireddy wrote:
> >> The logic which blocks read requests till AFI gets ACK for all outstan=
ding
> >> MC writes does not behave correctly when number of outstanding write
> >> becomes more than 32 in Tegra124 and 132.
> >>
> >> SW fixup to prevent this issue is to limit outstanding posted writes a=
nd
> >> tweak updateFC timer threshold.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> >> @@ -2381,6 +2408,7 @@ static const struct tegra_pcie_soc tegra20_pcie =
=3D {
> >>  	.program_uphy =3D true,
> >>  	.update_clamp_threshold =3D false,
> >>  	.program_deskew_time =3D false,
> >> +	.raw_violation_fixup =3D false,
> >>  	.ectl.enable =3D false,
> > It doesn't really matter either way, but you don't *have* to
> > initialize all these flags to "false" since that's the default for
> > uninitialized fields in static structs like these.  If you left them
> > out, the structs would only contain the "true" items, and it'd be
> > easier to see what's special about each SoC.
>=20
> SoC flags are explicitly set false if not supported, I am following
> same existing coding style in this driver. Maybe the intention here is
> to convey what is not supported by a particular SoC without going
> through soc struct definition.

Yes, this was originally done on purpose. I think it's good to follow
the existing convention, unless Bjorn feels strongly about it.

Thierry

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0bgYACgkQ3SOs138+
s6EuxA/8CElhyVIEEYlUr3ygK9jLIkAtJAYz4cO+zezAtUJy/lIReo+vtatEBQd5
3mZMJwBBZCGj9C5i9uliWYfpOwgznw9qEZ+l3wQo5usk9AaU8S9WJiziM4QlZNXM
Rs4lHZJjd1dT9xtE1Po5vftawZXBpk4OWCDIM4dRUqcYMBWD8EqymDrrX1KnUdF/
u8o//U3tOc+NnakhsAZLXg+Y9hzqUqXZv49/gUvvXHJ6pdIEa0LKRTqs2c9HdtGS
KgF/65ik6Fjc/KKUcLNNKM4tugqvg3i8cUupx5Snu9RRcGOIAJLPd6JGMdBXvWVU
e38ADSBAw3TEkolaexRIl40RZ84RU/SDpfYyWSNzrvWw0gjricz1nrX1QCeyMdno
qek07jTZc3CJo+ExmHWH55mRBy25JeuxHbcUv+vNKKOxu7fQVaxhkR+dQDDTDjiq
zgKgN73uGUmUmDiXKJ2hQOtpgfrjkkWHrpZ2lz0Wa0vL/7qGqTI9KOj4f3J72zSt
MXurG2ZZB0KJaQf39E5ngVLVeDgFgZB7KQeX5x8uD8Flyhdu2a/VTYe2AZR4FV1w
RQJRpb/rB7RDi7KJv+plN9O34gbdoLq6byyEWt6DVi8dHMybzPAFcuElSsTTuygt
ZMi90WZjkHUh4Q0Zdap/mvFFlvFyQOltov/9psEvAYdfkSDxPVs=
=fWHS
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--
