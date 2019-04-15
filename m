Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FABC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD6F2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmvZX/DV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfDOLdI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:33:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:33:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so21441770wrq.8;
        Mon, 15 Apr 2019 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H72rWJvCCr8hFE+nYsAafJD2hX3zyyL0QxgD4PNIwxQ=;
        b=UmvZX/DVPuu35AulkV4JBC+qxPBi7DRHj94eWyhMnAbSt9Gl0CP09BMESV0wtd1Bne
         0Zn5McKJUUqrVB53o9HlGz70+gZEzDlYN1kpkD5gnjvuOkjMvIDTBCjOUvR+fctoQpC2
         8FgUrSOYF/ILjyDaI+no3iLOx3zEmVFbjBU62TCIl9piDEnn+qi1MFBoEW+A9fU+x5ta
         lIke+hrx2vUPsrXI3j/vo8pBuETghowcGuTRFgfe6EFF84Q9XnyDM4yDizxLqCHb/B14
         EO7Z+WhgM5F0PzQkzFgPEfJs/I70EXHHeFLj+l9j48tXKPR6ZsLyPMi9soV4AfsKX3R9
         75pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H72rWJvCCr8hFE+nYsAafJD2hX3zyyL0QxgD4PNIwxQ=;
        b=N/rCMjYzzVYlVDFnzQQ0WbKlMt0dyBsEoi3I51POXH3CA8XrTY7skgYBmWtSy6O9HJ
         HWtWNaEfDSmtdzKk/92zprM37fQPdOVsG3T1RKOvndz9Vf6fjMq/TPWBQmSEsDU3BNSp
         JLSSmfmC2o977qdST+tojyMB6CgHQbef3q5ir+D290s3ICPbno4vlhRdecowA/hm3G7R
         A0ZOzbdjxTi07O2RfkAzg96HGnFQ4RGzH3a5kTKQDglMv0s+wkxIeq2kmeEa/ylLxeMS
         ym6xQOBv2PBZa87aavo4c+jJEY5HOyIfy3X3r5gPLstO7PUv4Ho9b3Z7xdE+QiFPk/sr
         AnSQ==
X-Gm-Message-State: APjAAAVtPi+fqAX4EnIMG4mFcTnFbqJkBKkRRLUyYDmq6yoCIfYpSu73
        gVFKcX2yRZDSLLHXUmEV8bw=
X-Google-Smtp-Source: APXvYqxNB4MdQU3AHyfHbwl0bNCWr8pWSMDAmsugh7a90+jAlNqnPesINn9GCK+Tc4hCJtPHR7PH1Q==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr43877247wro.234.1555327986316;
        Mon, 15 Apr 2019 04:33:06 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id 84sm30572839wme.43.2019.04.15.04.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:33:05 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:33:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 09/30] PCI: tegra: Process pending DLL transactions
 before entering L1 or L2
Message-ID: <20190415113304.GJ29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-10-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-10-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:34PM +0530, Manikanta Maddireddy wrote:
> PM message are truncated while entering L1 or L2, which is resulting in
> receiver errors. Set the required bit to finish processing DLLP before
> link enter L1 or L2.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0a/AACgkQ3SOs138+
s6EZ1A/9H7FTiL5bNpYfqZl/Bkgx3P61HMKh5lIzrmjMbJgWv/REah55hktenUV/
FWzmWUh0cAqLbXtlbTX2crqRVfcURJvyyKYB3lOc+kEwm/558Ifex4DbWTedvBlF
n2ZAlcc+U5fYY1qB/1agxw9rByBfLuOBugmS3+2aU1PXhhFwQhXz3qrZA1rfz0oQ
mbHFjIlT4xtvbq02aALI7G6oSAGnMD5jKx99PhNo78f/2luTjbkg0mdUuzArbkCJ
lLw9HncnLluSsPbY8oiWr6ZwB0rBOsQ27B8DYC9Geitf04XBkOY/3S1XJfbUx0LP
VmbdFuGopMID9j+PA/8kBdacMrDpBJ7pmUjV5uMhhy5/y514pPm1OzVxri6TfA6/
cFyjaURjNysjm/0JfzWSgRlFAOUJkRH638vR2viK6ojcoEvysj2GEDtXhVYTPJ+T
kyTTlWK9S5vDvpp1jDdjlO/Zw/J53LThAXVUnBnzChhWVdIr36AVRI8h12IAffTM
2X7Kcz+yoLfYMj+S3j+IhuNEdeXn+i4QpP3KmR26HPOOIzrSfadhP5hEgSiq4X/Y
s/fkK0UiK90Rcgqm8cDONPR3KX+cqVyeH8HeC8SN1Hfpt2Ki+OXDiFoqWXgReLR4
y54i33/Ws/ZlfvLCZGhYNLguX6T0BL4I9w4kUB5Vxgp4vEEu9hs=
=H46F
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--
