Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B206ECE564
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34222214DA
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrkhjAkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34222214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeIRUUh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:20:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeIRUUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 16:20:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so2824608wmb.4;
        Tue, 18 Sep 2018 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9MSBn6zthiPKedGRFvLQNbBiyueZmH4r8CLVv4/wodA=;
        b=mrkhjAkN0+MHkhmvSjCsUKOGYRVOP7dVymflD8NCVhtlPotakbDNGRYTulrxUXD92O
         fGpCkDIExi15PFVxDcfzNDXDaNj5V4mDizqdCRdEk0/LfbAR1qclAMOlNuXRQt8kgl/d
         c1y6NlLpuIv09yp49RZ0Sf/WrXNkC78W5QEIon4Cmsrxq63sbYQ6/Htv9Qtz/cau4pZs
         58ufmW2f0GIy+AOJH4m6yX7SxG7MNt9nVTk3CQOqegw26i9fpwf9yHcFswoPf0Facu2C
         5Rh3s3HorLAfXmC5E6Sts8LlFp2JUoxA9fxCidQx3qlEPJx6zGerfCHBDmM/UuIOezJ7
         lhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MSBn6zthiPKedGRFvLQNbBiyueZmH4r8CLVv4/wodA=;
        b=Oqj4w1+ndNn/PwLKP/A65hm0kSODt31aT3pZf4RHUk+xW2UDq5d4kwe8jhTQ645uel
         tkIMC/6jTzemjMfq56FrxL1GdorYXEbMzkokFdCJZt6mYFOM4tY/8nVr+s2/PHOeNaLB
         DzZo+WKfc46pc7SaCaHrYQt2uxPcHKt9wNjuWbJDbSJMSgTkY5FnpndfEPzxYEqnAx91
         fNrbrAXQIhMu3Wxc1GL102/QW7HaobebL7dxALjyyNQ7ILDuFNzXNGZR4LDrnjHglNy4
         jzHgZhwWQnNvbE6i59eUfhGm9xtiqn+OleRS4v7UvoIZ594F0dKkrrfpF2Lk0nO6La3n
         9fqQ==
X-Gm-Message-State: APzg51A440pSf4JPwg6enU9k8yDYrxDoqts92xHosxRqFMIl/esHxMqT
        T1/A2VNyw5Q3UGqpZRDYfII=
X-Google-Smtp-Source: ANB0Vdb/Nzo5nOTRkARg9iiclNfolTwJSm1F112SwV6BBx/V53MaNJ7eoVsu06rUlqa1tqACBBBItA==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr10366492wme.111.1537282059392;
        Tue, 18 Sep 2018 07:47:39 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id w3-v6sm19915450wrn.16.2018.09.18.07.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:47:38 -0700 (PDT)
Date:   Tue, 18 Sep 2018 16:47:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix ptr_ret.cocci warnings
Message-ID: <20180918144737.GA30386@ulmo>
References: <201807120738.oIXXb65q%fengguang.wu@intel.com>
 <20180711233041.GA39597@lkp-sbx04>
 <20180918141838.GA32243@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180918141838.GA32243@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918144737.sP7g6oaxUFxoNMgZYsnEbc0twdZGRj37mZ9em7MZRmE@z>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 03:18:38PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jul 12, 2018 at 07:30:41AM +0800, kbuild test robot wrote:
> > From: kbuild test robot <fengguang.wu@intel.com>
> >=20
> > drivers/pci/controller/pci-tegra.c:1132:1-3: WARNING: PTR_ERR_OR_ZERO c=
an be used
> >=20
> >=20
> >  Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> >=20
> > Generated by: scripts/coccinelle/api/ptr_ret.cocci
> >=20
> > Fixes: 6e0832fa432e ("PCI: Collect all native drivers under drivers/pci=
/controller/")
> > CC: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> > ---
> >=20
> >  pci-tegra.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> Thierry,
>=20
> are you OK with this change ? I will remove the Fixes: tag since
> this does not fix anything AFAICS.

This has been proposed several times in the past and each time Bjorn and
I have agreed that we'd rather not merge that change. I think the
original is clearer and allows the code to be more easily extended.

I don't know if there's a way to "whitelist" certain drivers or sub-
systems where these kinds of changes are known not to be desired. Or
perhaps there's some way to trick coccinelle into not recognizing this
particular instance.

Then again, it seems wrong to have to work around over-ambitious
semantic patches...

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluhEAYACgkQ3SOs138+
s6HSCA/8D3HAVyXRzXB8VImac6wJpL026qaKKkszs5W6STpjFG609Puz9iptCx4d
7SZXc/48zKgs6KQBW+08IT2QBHY/WWUiZiSu0dq2Q/ldd/uJWd7SN9nb98+EKPOy
Ckbx6h2l2ZSfqd+l0ViXvNDIcAlR6z/Lu4GOyzeJq+XWL8HSg2xJ1Ht4bfVfK9+0
RQ0Sxb+M1/ilVcQLd1nfrK/0iPRP132UpASx8NVNlC97l/wrUezUbN942FeMyp7D
a9j8v4vVmVobQJH0Wko/Uo5bhg1SdFkx3pwnJj2Toj+LhmZklcplHLs5QcjyGljw
WkFKeWDy2P6WGvKgt8fCPXpK8CxpV+WrZ8/vmFr3Df+F0iqlEQu4yQPXPTb88quq
0FyUZK1DAPm/VCJWgY7jz19TzNta8kRINbLTXKnNcDKsh4AA3ldoAcmfd57CiC8w
WkJcPyqbjc+Zxu33lxV2gAL1o18cj58OvYJUbW2jds97Yi0reW1cdA1EYEuO8ZQG
V2ii1kXvFnpcnAnPIjmUjLG/7FqKF0z5Z5hIPvSsWAr4pLszRsZ2Cj/TaxY/Bnib
KtwFs+5m1x2VYjwzqe+0dvWENxke1cRyhu2brm2jhzdRkhrpkxwjBQBEG0sB6367
4pw5tq2uWQv7/03eyFnpfKp0rzRgY+qbOHWz1FYrVPWFkcm0ods=
=Lanw
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
