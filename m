Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CBAC282DA
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5B22075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVnWCJa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfDOOyH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:54:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50649 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDOOyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:54:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so21160626wmi.0;
        Mon, 15 Apr 2019 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ayVZXxmDfE7CKIQmWWZoQmCuxGLlioaha5h/hXjT9z0=;
        b=oVnWCJa9H2wGFtHjM4efVKWOflYxL8xJ01hRJc+0DQWIlkGzU8AbIisM5M+WdkT5Hm
         Z6STYoPNOeW9HMShkNJ58dW71csC+M9+oHb7Qu5yS2SiCsgvZFNF9BZXiMBnurBW++J1
         WxtVM6evym2OiRJkwlh9HHLqj/ccQqx7rWRah6jTIv/CwqBfx4hfyd/U0QBkLcb0SG4F
         nNyv5VDE4Vt2CL88BTAamuB5SBuCWqg1rZkgRLqgA3TuZC1CRYaieRH7g44TXiSySsjc
         jhqQDfy6bj6ZJM0HZlQCLQiMJJNQqv1tuMDO4me586A5WhnFAHlXGblrqptHK+SRG0IK
         p0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ayVZXxmDfE7CKIQmWWZoQmCuxGLlioaha5h/hXjT9z0=;
        b=brgsz88d7mln9C3Fegws9m3hTfQs9BYaPkCxLGZZuU/AK89Y1XO+xkgWGGNYek2G7b
         50tO9/obAiK7Y2sVHXTw5XNkPhJDPQ8lnuWeOgqam1EGLszZXpApxF9sbVKOvgfaRiQk
         0zQQx2GVBhTR6IUtHOTE2TR7OQ2ntwwXhFeWGBuXKLFIwLhcS/A9UMoxKOfz7F0dFD3u
         pNJ9ycDJHog1Z++LH1UdQqmNPMV4I2a6U1vHcZwql3u0TuhGcK7E2G5YOP0w2OIeUOzO
         o/Y1pNSRCE1T0iLojAZ5xTDY6IL54luRwZ7TgYncZlfvEJjwmBRTOLKaXssfKCFt5PtJ
         9ARw==
X-Gm-Message-State: APjAAAWLvSnaJzeIF17YD/7RvA1yaoLeGWxvEvgRpUe3H3/cfM3a8h+U
        JV7cyzXu8WvQXAt4vsVaIdw=
X-Google-Smtp-Source: APXvYqwa50kDHY1hgy7BL0arOAPNt2XIg8So3v6WgIr83tHXSi2YzHc1xlGmJ6vjWp9uEPY2DC7eVA==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr22995160wma.71.1555340044874;
        Mon, 15 Apr 2019 07:54:04 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id a4sm36765263wmf.45.2019.04.15.07.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:54:03 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:54:02 +0200
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
Subject: Re: [PATCH V2 07/16] dt-bindings: PCI: designware: Add binding for
 CDM register check
Message-ID: <20190415145402.GF29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-8-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtUqn8XWZYmnPFNh"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-8-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wtUqn8XWZYmnPFNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:34AM +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) registers check
> for any data corruption. CDM registers include standard PCIe configuration
> space registers, Port Logic registers and iATU and DMA registers.
> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Dat=
abook
> Version 4.90a
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/=
Documentation/devicetree/bindings/pci/designware-pcie.txt
> index c124f9bc11f3..728281b5bcd5 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -31,6 +31,10 @@ Optional properties:
>  - clock-names: Must include the following entries:
>  	- "pcie"
>  	- "pcie_bus"
> +- cdm-check: This is a boolean property and if present enables automatic
> +   checking of CDM (Configuration Dependent Module) registers for data
> +   corruption. CDM registers include configuration space registers and i=
ATU
> +   (internal Address Translation Unit) registers.

By comparison the commit message also lists "Port Logic" and "DMA"
registers as being part of the CDM registers. Shouldn't they be part of
the bindings document as well?

Perhaps it'd also be a good idea to rename this property to something
more imperative, like "enable-cdm" or similar.

Thierry

>  RC mode:
>  - num-viewport: number of view ports configured in hardware. If a platfo=
rm
>    does not specify it, the driver assumes 2.
> --=20
> 2.7.4
>=20

--wtUqn8XWZYmnPFNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0mwYACgkQ3SOs138+
s6FesxAApMVDuLHlIjYq7l6bKlBb4fa5bbXMIX7SnRy0GRIp585/YZ9j21gyDQhW
IrO2pEeVogNhiTndF/QjSJ4SA0nkPeirMr2gYXjiFwGWDXx3L2UXHlbULgY0jCQY
3mprsgNzpQvHQsr8nH+uqIOjXxW4xSQaaFZeVYwhK1FOqZY/VwBfBho1tCJynXNL
izZjuM1ijRBFzqcTmzjOTyk6v7wSPXokmQPFwxBe4sk9Q3JJqa8rMFH9tTv7XaVI
t9l2d0lsH6+zJGuolqj0zF42kyoWrdFp/H75pQ6oh5NxbZyarpbJM0labiC8Ja/K
6+AprGEEqtg/Eu6LxeuLHBIaYoEQ7POtYI1oAufrxaQAt2PWsXqHMpKoTvfW24Q8
iW+47ijSI2fJ3rygSW//MOXHR0Z+EjwUi1ZlluiO7tV35YNqUmBKGzNB13hlm6W7
IRt/o9xbYbR4G+MHHBfKNCMbej5bmXFOvu7RxAhRAR2Tx9Hbo1I7guFcIk42Uvc/
loRQHU5Xg3evxfsjj7Tz3ulKom5GQA6lo8gZgX7+60BZQSNnYBSpz1dY3DA/JIf6
Inawqfn8FV9Q+35F2pjaoFKyFtQEDvmrOcbA6PrPafgXnlunGbGK6dEYL6RaLA6C
TXWXOqbgoMuzqQXgObfEyWtEfJH7WkgJNlXK8yCyouItCvBWbco=
=EtML
-----END PGP SIGNATURE-----

--wtUqn8XWZYmnPFNh--
