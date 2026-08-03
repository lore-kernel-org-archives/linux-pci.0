Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BD426D03;
	Mon,  3 Aug 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782424; cv=none; b=s6MQWRFMVkhYVsskaHfAiROExvkGN9rWps9CLxAeNnFOwBTc86ttgZEv7XVQD/Q2B0zHVlSbow8J0oavt8s6+NUscQQAoiK8A7XrrXXiZZTdkaltliq1Hoe2UNcDw5+HawuQrENfwZ4VJAjEn3tCgTEhz177tNnxHQNFfShMdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782424; c=relaxed/simple;
	bh=o1QAOOkJbiyCF2u1J4bgKYTZWs7PMH0vF3lSpYhnkVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZtZutRSiKbdFOSNRqcAary3G/sQ5GZ5W5Zfxh2Jf+HCq64UXtroIxfcDP8k70UppB/BDyvhonc0kPX96uofUMlPSnlR3Q3+jH1fWabg+ycTig4MCdlBuBVnSpTKM9Lj15na83iAPdK2wF5cXcK7WhOpJ4/vlWq4yBA0EsGi+9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbuckga4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbuckga4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9871F00A3A;
	Mon,  3 Aug 2026 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782422;
	bh=VpWkgxq0vDjUXS/IkYjuNTUKPFNKwX4SeT/nhDDVD7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rbuckga4IBdEwaQI4CGHVsrsAHfnP4B5qu4BgqdPw5S0LRjDxkb+XYDaYLuXYPv3q
	 SnasNKjqkWlgwdY+llre4JFzaijeaPnbWB4ROzyKwql4Auk1wzPBqJy7Xg0shkEsEf
	 D7/rQ5Yk+TbUDsyfQUtjoXgfUcKlI08wUHnAUlWGVfkP0jIqgyQKgUB0fh5fIxlnUd
	 EaJ+aVL9JLlVCKJaM0AIDEUXvUXRWgABOcKAsdkGty40hSzPkg9SUVlrXVpQChxAb2
	 Obh/gkvKn4VCv1i/E+wh1nIN/YqulpD0jlwOWmKXuUI8WtG6zhq089+9nE7m6wbPe/
	 XhEUZSRdmTIeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] NTB: ntb_transport: Use atomic MW translation
 groups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-11-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:40:21 +0000
Message-Id: <20260803184022.4C9871F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing work cancellation in probe error path leads to Use-After-F=
ree.
--

--- Patch [10]: [PATCH 10/11] NTB: ntb_transport: Use atomic MW translation=
 groups ---
commit 92a31c981341f2c994839699e7b4fa179c125291
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_transport: Use atomic MW translation groups

This commit modifies the ntb_transport driver to allocate and program MWs
in a translation group as one contiguous unit. It queries each group,
allocates its backing once, and uses group set and clear operations.

> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfaa..2c7728898890c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[ ... ]

> @@ -1291,6 +1366,22 @@ static int ntb_transport_probe(struct ntb_client *=
self, struct ntb_dev *ndev)
> =20
>  	max_mw_count_for_spads =3D (spad_count - MW0_SZ_HIGH) / 2;
>  	nt->mw_count =3D min(mw_count, max_mw_count_for_spads);
> +	if (nt->mw_count) {
> +		rc =3D ntb_mw_get_trans_group(ndev, PIDX, nt->mw_count - 1,
> +					    &group_first, &group_count);
> +		if (rc)
> +			goto err;
> +
> +		if (group_first < 0 || group_count <=3D 0 ||
> +		    (unsigned int)group_first >=3D nt->mw_count ||
> +		    (unsigned int)group_count !=3D
> +		    nt->mw_count - (unsigned int)group_first) {
> +			dev_err(&ndev->dev,
> +				"Scratchpad limit splits an MW translation group\n");
> +			rc =3D -EOPNOTSUPP;
> +			goto err;
> +		}
> +	}
> =20
>  	nt->msi_spad_offset =3D nt->mw_count * 2 + MW0_SZ_HIGH;
> =20

[Severity: High]
This is a pre-existing issue, but does the probe error path need to cancel
link_work?

Looking at ntb_transport_probe(), ntb_set_ctx() registers device callbacks:

    rc =3D ntb_set_ctx(ndev, nt, &ntb_transport_ops);
    if (rc)
        goto err2;

    INIT_LIST_HEAD(&nt->client_devs);
    rc =3D ntb_bus_init(nt);
    if (rc)
        goto err3;

If an interrupt fires immediately after ntb_set_ctx() registers the
callbacks, the link_event callback could queue nt->link_work on the system
workqueue.

If ntb_bus_init() subsequently fails, the error path jumps to err3 and
frees the context without explicitly canceling the work via
cancel_delayed_work_sync():

err3:
    ntb_clear_ctx(ndev);
err2:
    kfree(nt->qp_vec);
err1:
    while (i--) {
        mw =3D &nt->mw_vec[i];
        iounmap(mw->vbase);
    }
    kfree(nt->mw_vec);
err:
    kfree(nt);

Could this leave link_work queued on freed memory, leading to a
use-after-free when the work queue executes it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D10
