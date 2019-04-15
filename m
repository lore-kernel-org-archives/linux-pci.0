Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97885C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A9F2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyI5Ldpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfDOLcQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:32:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46958 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:32:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so21414182wrw.13;
        Mon, 15 Apr 2019 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYLUFoY+8kBEsDcGhegEr93btvThFeKYigIuUxscWeI=;
        b=QyI5LdppBnZd40dIM8CLiBJvnW9Lrg9faXeC4/gO0sONF5tiS8en1UY/KAk8GS7TBq
         na5QxJiqENE9ofKtQ7qNEZlU3dl+0x7VanGqcglbfoXswgu62jpEh1LD++D6ogSJECyS
         u81MqU36VXc+TDZwovLIr42Vce4PneSkS+F9bTyIj0wvpVkcXbSA6pCqB0FYOFcoWPwV
         SsGK+Bp1NPqwHvxnEuFdATmMe3PhJTVsWEK9S+RfyFZbPjSNfhHcre1KP6A2Cev/ibFQ
         22Vm6lvnWrjISJaKRFrxqQPixqiR5Qp/WAKpun3+zKfvVCySdZeKPKHO7bTLEI+dXJ6h
         lVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYLUFoY+8kBEsDcGhegEr93btvThFeKYigIuUxscWeI=;
        b=nFX785ymT7KcbTskITA6aQQBzZv78xzJzfY4hymIqggvayaf7jU72Erfkds+23vvvI
         zcYg9CpgQehdiKQ5Okl+PVyPea3PIiyjTMMZW0lIz9Y0mo9PsEiqGIMwxdaaVMWn1SEL
         em5nBm3WUFSZDCs14gHVpIO36H0G8eatjIkAbyYGliwMp649znXo1La11o4gyziwaSUB
         tDV9d0YyuHMXfG5oS9w7IC9M88OIozxkzZrZ2p78fApQXJmsfKybdMFQT5XPKvv9vFc1
         mvF8Q0s54zV6tHeESmhNbJmIO/2wZWagur++XFxnAs/I6e7iefqfuL9IWp9x7HI91Kzq
         9tKA==
X-Gm-Message-State: APjAAAX3kp541jZrjx69aBVFOpySS0hrYIWjsekX/WOWI0ZNdVRuCuhb
        5ss0HPDBQRujxxa3eOmkAOs=
X-Google-Smtp-Source: APXvYqyTEG/yxjPNgruRj92OAErYYE6yBqc1ALYH8JOqTPfys5aoMzwgfhN2tm0nS9PfXrRV/YhPdQ==
X-Received: by 2002:a5d:458f:: with SMTP id p15mr46262875wrq.188.1555327934581;
        Mon, 15 Apr 2019 04:32:14 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id x5sm40173776wru.12.2019.04.15.04.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:32:13 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:32:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 08/30] PCI: tegra: Disable AFI dynamic clock gating
Message-ID: <20190415113213.GI29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-9-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-9-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:33PM +0530, Manikanta Maddireddy wrote:
> Outstanding write counter in AFI is used to generate idle signal to
> dynamically gate the AFI clock. When there are 32 outstanding writes
> from AFI to memory, the outstanding write counter overflows and
> indicates that there are "0" outstanding write transactions.
>=20
> When memory controller is under heavy load, write completions to AFI
> gets delayed and AFI write counter overflows. This causes AFI clock gating
> even when there are outstanding transactions towards memory controller
> resutling in system hang.

s/resutling/resulting/

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0a7wACgkQ3SOs138+
s6H7Pw//YXsORx2wrc4XpQ66886+swzirPX74X+sHYCYJYt4Z2BfkvoZkYaPEfqv
rIjIv83dIiBOCuXh2ORfX7xH3u0sLiIHLvLmmyCMAWy8nJQNUrJ4VIPl9PApkpbr
mRjLiGlsFEVZn+zFEXOhSURWQitb/ucYU2m8MsFZZzZxQx1GJ+uzlXv3GBk27jOn
uJr18ef07rI4snfup9iCPWrzMU9QQKIHz/92zN05zNCo555XOiSLrghCsFNO8eqo
3oBoChvVvizKMfjmrVJjpFwuKGWy6NpMU5aIAmr674hHZCmodGGPsJTQqIPqKt3r
Vfi5xIFcPhmfl9VUYjD+M2rzPK+gI3xV+LnSgjbWzwj2SS7ANPhkzx5w4xu+oF/l
k2MpUuDkuIlqXmgo8JcGLZ6RLTi4yVnlJb+T0dD3ZjAvnOG4o6DICLiyOI8PnZcZ
E5WRkEhJs2hf5f919M3sCAomnIhneI+tqI8KpB0Rn5AU05FX3AwEhXFKbYvhZl+8
ectB/PrmCuChrNyTzC1+orJu+TOwoRPTbi/nzXmHbuQ6FFZlzo00A/0BPJvDhDqa
CgzMqSGCY6C8WM3kgvnYA/EyaTBnWeafscGDxG353cT/2rYcHrbWO2YtMum1tAuP
gWav1QW6XAU0b3BRZAZBRoz9UWXko1gSIrC6zArDsw1RVrMc6ME=
=mA7t
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
