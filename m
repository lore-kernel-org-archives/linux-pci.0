Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5BAC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8FF2147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a73x6uHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfDOPmF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:42:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfDOPmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:42:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so22551683wrq.8;
        Mon, 15 Apr 2019 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pU9/kt7Abut8uedbV/OtxPT9sP3yv9PmPoE7vHej01M=;
        b=a73x6uHeW9K+kko3+Yfdo66Js1JCZXfv2Z75Mhp+rgexonXz+Oqhw8QZpF/CnGyIqW
         qhP5Mj6qwJr/LefTlUStfpOH/2U03k8voo3RlLr0Y4GBqeewh4/2hduyLn0u66DxePXY
         oqyAa1hWBubR6NouetMK95ew9wiX55f2JFBmExzXYS15GVps4EC2MJMgWXRDvdzpD9oN
         dKBE5cVirH1GP34L5Bu7q9hB7lkQxAjo4/Xzn5vXLSA6OwF3YUxa4jlwBFjJcjkQGkct
         mQs7U5YDZNUQuqQutf4DgkDZ56BRw5PPUHhH49Ev2evWsl4jjMpQOae2FLHpAfqQdd1p
         U80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pU9/kt7Abut8uedbV/OtxPT9sP3yv9PmPoE7vHej01M=;
        b=accj0x2hHIRfP4x/kkwFLpNCmq8oyaR7Zk3RMnSNrCbtcyvqEgRUZ7kpVKKOLm/zCi
         ZhnLZ6jk8kqbUPkL/+GOdPeCKwrIH4ngdqdiWA16JElvZU/910lj8QiPqDfVNmQzXxu+
         Uzc2weIEyebK9DwLmnzcoNK4Mcx9dFum3+Z1r9aGAknyX/72v83ieHoxUBbJ7lVttwft
         UxkdRJdrAnIA072Dpel/IfWOdtQhG/n0LcP8tMq/F5HBYAfG7mBSyi+tUVJWfgf08bCP
         GaDNA1ROutVD0RTmE+4Zfh4rf9EsoiXKnN9iuvbuex2xMz1cEa11bY9idgll4gD015Ue
         YDvQ==
X-Gm-Message-State: APjAAAVRCz+B894V2cHOGw1makqxilvXsJrrx9ajmuo4I6ykUeoDr8mx
        I7Gl1wlc9RBedR+M4rEHihcNLR6V
X-Google-Smtp-Source: APXvYqx+pe+UmLlORHe1/ww465JvcLsZ0/dLXd/PlNsAXs+ka6LpsTejvMP3EbKoDIXqFwh8f6w0GA==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr27537301wrp.172.1555342923590;
        Mon, 15 Apr 2019 08:42:03 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id w16sm71637795wrt.84.2019.04.15.08.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:42:02 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:42:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 21/30] PCI: tegra: Add "pci" type check before parsing
 child device tree node
Message-ID: <20190415154201.GN29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-22-mmaddireddy@nvidia.com>
 <20190415133715.GV29254@ulmo>
 <059fd53c-8a53-be56-a5bc-393f37aae168@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2CW6+cughRlDaKZr"
Content-Disposition: inline
In-Reply-To: <059fd53c-8a53-be56-a5bc-393f37aae168@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2CW6+cughRlDaKZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 09:00:58PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 15-Apr-19 7:07 PM, Thierry Reding wrote:
> > On Thu, Apr 11, 2019 at 10:33:46PM +0530, Manikanta Maddireddy wrote:
> >> Each root port is added as a child device tree node of PCIe controller
> >> node. These child nodes are parsed using open firmware PCI bus accessor
> >> functions. If the child node is not of "pci" type then device tree
> >> parsing fails. Add "pci" type check before parsing child device tree n=
ode.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >>  drivers/pci/controller/pci-tegra.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> > Erm... what is the use-case that you're trying to support? Why would we
> > ever have children nodes that are not of type "pci"?
> >
> > Thierry
> In downstream kernel we have "prod-settings" node as one of the child nod=
es.
> Even though we are not supporting this in upstream kernel, I believe this
> check is good to have.

We don't have prod-settings upstream and for good reason. There's no
need to add this check in upstream. We can carry the change downstream
until we've moved away from prod-settings downstream as well.

Thierry

--2CW6+cughRlDaKZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0pkkACgkQ3SOs138+
s6Hk6BAAuuLmSi3da795/1SMFfCMinG4+Xv2R3ifsnGGXF9deM9FABvAmRlwxQ4o
uXQ3ZgmW5TVPqydtUc4/bDmTl79P2Q2tthMzCmGw8PtWf3mPCeaeHwYGwGgq6b/7
ujii/QFJB3KnVFiB91lfog5oaKSfTH5igeSyzhofSWAyfoj+XXAsXZ2KlFpslKCu
g5daw4687XvnolPgpt/YtPemta+rEJaBl0ZonQpRxQnp3mJcbu1DumLbJB92vi0k
UrhzD2G5s/lZ78w1NuZaEwR6iz9Y8lilZ95lK5BZZJL9DsJVta0wI75lWfqi5JbD
yc8aI4FfrJ6V/zxi3MVhITDytLWyelmJcbFxZOs3qbGmdu0LczBmDtgik8sVGDkt
r0oyetd6kmp/JeWkf30A9zWm/pfR09JFOhG935lanjt5OSjNgWVX/7mDgCHLIG6q
GjZA90KrDUmMr7R6ewCd62wFOh7ftHlLq+B3CWGCE2h9CohPn21bD8kue8OR1zXf
E+v3ml38bdn3BkIZLWGysJLapOSNjGMXxjXXzGylTDyAN7E/Af+IE/pXvUt341+H
hv5733jebhTb0EPszwwWZC3sG6TdDkmxYtDVvCBEwNNK+qD53s9oFsUT4hQ04ehN
wBUmzXgJWnVL+RqFaSTmVPQIBQKac+vm89f4G/2XeO1vKFSNNQY=
=Hexk
-----END PGP SIGNATURE-----

--2CW6+cughRlDaKZr--
