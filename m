Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603DC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA43218D3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 16:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJoSmb3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbeLTQoY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:44:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36291 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbeLTQoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Dec 2018 11:44:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so2311071edb.3;
        Thu, 20 Dec 2018 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=udwoJwfUZVTLOwxGcRxzcnzXp8PPvnNNCGmi043csVg=;
        b=HJoSmb3vcdm8FnOqXzD5As8Ne0duxHPcU4yIIOc0yBVofpYdVxljnobXkMn8ChB0zS
         cNQVNC4JF11xjZYPHGO/7zekySsbnBp138BgWmvuKQp7g4gWachAzJSNypfWpOuMKwKV
         Cc64+5HRyXMh9y3boPG4Sey+5u3w4HlSDgCJxBmwantyScvrl5o9Zykwty2Hfe87aILC
         27HQhzd43QUn7+xlBaKCqxFm08QotKMR2wt0tGxLoFhjBTC8jK2Tt9QUxRBJ8zuTl78X
         LiFI69xvkD5PZyv0IbFkz9yTnY2GO7C3SOpgDpHhEud8fKkwwZg8EIo6yQgA/n+cHNew
         gFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udwoJwfUZVTLOwxGcRxzcnzXp8PPvnNNCGmi043csVg=;
        b=PBzPoh26u0UkvMo67aIY8uqAtr01OEdH2i+v6IB93aOzy3Wxtgvdy5hs6M+tsnPfFN
         PPQqUVYUGWUvGGCEXe2YYkbzI36/MdyctxyvadKQzLpR3EdG1P9X6i8IMWdZ2do5/v4x
         5vc5xXDPIzk9xDMDBu5PGHeAixhPE5rqy9GLJ+x68kV3gtFsLd08zBRI5pqEthLIgA4L
         3k9TsC2YRxrXWH3bmbm43ldf44G+4utoDuOmT3IFJFvERyLJPtHsZR7nj81mfkBAYkwe
         Ej0uTAOD+t9q4GES/Ina/IHPpdy6jcIBXdmO0Y+1hhHNucwawVXPke7ET92YtYsA1Sqf
         +chQ==
X-Gm-Message-State: AA+aEWY/cNSCzBEKghUzzjUBPLjKj5CpoGFfPhDZnchWP4IH0S+jWTt4
        AVffHKa17ddRS1KjqbWPqjg=
X-Google-Smtp-Source: AFSGD/XbntL90LehgIKfTmGzsmFEOHRlGbpugiPq8LsCYuUKRD/7OWkTSOl16XaGwWplJSPJ06Mc1Q==
X-Received: by 2002:a17:906:198b:: with SMTP id g11-v6mr20146763ejd.166.1545324261086;
        Thu, 20 Dec 2018 08:44:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j4sm2371867edh.69.2018.12.20.08.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:44:20 -0800 (PST)
Date:   Thu, 20 Dec 2018 17:44:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181220164418.GA18777@ulmo>
References: <20181207190720.18517-1-hch@lst.de>
 <20181207190720.18517-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20181207190720.18517-16-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 11:07:20AM -0800, Christoph Hellwig wrote:
[...]
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 0b18cfbdde95..fc84c81029d9 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
[...]
> @@ -397,9 +404,9 @@ int dma_supported(struct device *dev, u64 mask)
>  {
>  	const struct dma_map_ops *ops =3D get_dma_ops(dev);
> =20
> -	if (!ops)
> -		return 0;
> -	if (!ops->dma_supported)
> +	if (dma_is_direct(ops))
> +		return dma_direct_supported(dev, mask);
> +	if (ops->dma_supported)
>  		return 1;
>  	return ops->dma_supported(dev, mask);
>  }

Hi Christoph,

This hunk causes a crash on boot for me. It looks like a ! got lost in
the rework here. The following patch fixes the crash for me and restores
the logic of the op->dma_supported check.

Feel free to squash this patch into the above if you prefer that.

Thierry

--- >8 ---
=46rom c502b29ab01fa857e81c78cd574d4d22d7d20e09 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Thu, 20 Dec 2018 17:35:47 +0100
Subject: [PATCH] dma-mapping: Fix inverted logic in dma_supported()

The cleanup in commit 356da6d0cde3 ("dma-mapping: bypass indirect calls
for dma-direct") accidentally inverted the logic in the check for the
presence of a ->dma_supported() callback. Switch this back to the way it
was to prevent a crash on boot.

Fixes: 356da6d0cde3 ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fc84c81029d9..d7c34d2d1ba5 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -406,7 +406,7 @@ int dma_supported(struct device *dev, u64 mask)
=20
 	if (dma_is_direct(ops))
 		return dma_direct_supported(dev, mask);
-	if (ops->dma_supported)
+	if (!ops->dma_supported)
 		return 1;
 	return ops->dma_supported(dev, mask);
 }
--=20
2.19.1

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwbxuAACgkQ3SOs138+
s6FOFBAAvk7KvF523TFilLtTgdqzgtbG0su3+Q9/rfoojbuGfvhM5uVjTT8i/Brp
4yx6kTZg7EbcIyiPhY4YN6MKtxFIQO4xRuCAnsiEG2XzwLKct0bmqf39UOMjRCiL
QgdUBn7wdWKH4gMLwHs9jupvvw6AWkDUF+d7s9/idZIy5+KGXeCYq6qgcRFhitXd
fOF4iBMnK49WcDhwRCBYieTE99Mb01ILjFOtdBFjnB4xnf3GyWs5uriDDwGdrurI
ASrZABnhANLKYYInPA61xDqpudGlydOTa+7BtIvDMVr1CGcRYpZ0ERknioCdQQQE
XoO6taGR2vfwIOm+frEvuIVNOBEUO7NNRFHfMaVWU3oEjQ5NNhzcp3t+EyxL+jTT
0zxaX2H3b9w703yxWo8/fvEwdyuBGbTYA7cmtCgoTo8QHRt2BhxBaE1X/n5wLDYW
Giu06kdfZQAks6U+YAogHzy7imPUpDYIZuH2Tko3Sw710nIF1et6j2zPrQmYO2nu
1i/orBSibV/5P1Y9DRVNztY56l9oDv7cOVmFeJWXtQXBz8OdYjyHIKI6KhDi1sQK
W/nqPzW9uvCC4KeTWDGaw90BChgtWyKy6rEhPdk1QpQnMQYerr+a0y4Za905TqlU
mgI8M4YFd34Cr424HZuguZ6NtgUACys5BnYqjMLUTfl/LK3lcW8=
=t2Tu
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
