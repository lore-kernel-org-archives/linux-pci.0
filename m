Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18C241C8C;
	Sat,  5 Sep 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568137; cv=none; b=MNI8KFqTIgm/nU1SKUTPWRnWwo+dOf7SoiEzugrffeAxZkocqYnwPRzK+mUMrtj7v7CI+MHmKXAGTNZ5yT0r6LhKBtZXnJ9UKYqK1Xx+6+QZiIStTU6REWo8eo3N/NVdr27d23CEFR0qCsb26XKs0RYZ3aLBoAKpQgdqFGmeEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568137; c=relaxed/simple;
	bh=l0EOz1YKdtAZczCldw5S3WJVoef2G0CFr17CPYI6GAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bC/g3SZJ51vpd5MvAcz5xZ9Zal2QSl7bOFU2Hawlimtv0BezzQMNwVnKSsCbcqVOcp2UqjnFI2aioNL3XrXMzKdfA7dhZDc/Tqy48TcFMDmGfWJ0S+yMjQ5wh7sQ8hNU97yoWuCW5s6xeRFiS11e7z2HCqeWAoID9EbLtVt3SRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCtctULt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCtctULt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83BF1F00A3D;
	Sat,  5 Sep 2026 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788568136;
	bh=g4uYzI4lQALfDd/7PpefrgFsHwaVWxhzB7XRPZGMF0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCtctULt1uVBDylZlb3ApfeB6YiNZYe7fDMLFZQnz6+JGc6cvt5Ig3JBLPRuEyWcK
	 DcQ9059jD4IJxQKRRUV+aASn+xyHlznl+YbUzPOq4dmnOeVh58uYQMxAPxiylA1urA
	 zzbWemPY9macFjHAyBRAVEoGKOuyPpfakMr+cPtMTJ41jmihmvdbxM1JOvLCmsw51n
	 LFEDrLoFvRd+GGbAu+8cRF3KKZSpbyIp87t491zr/xxu6cb/BHKFVBu5If70/4tonu
	 QwpzIYjEoMmegbOOAiIOR13ZDNGuByDiO6zYQCANo7cPBkUxabIjeNO/8TqGHP/TiG
	 KJCN2OOv4xBMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Kconfig: fix typos in core makefiles/code and purge
 remaining ghosts (v4)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260905001631.108652-1-breno3011alves@gmail.com>
References: <20260905001631.108652-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:28:55 +0000
Message-Id: <20260905002855.C83BF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Exposing the previously inactive DVB_ULE_DEBUG code via CONFIG=
_DVB_ULE_DEBUG introduces race conditions on global state variables (ule_hi=
st, ule_where, ule_dump) leading to out-of-bounds memory reads and writes.
- [Low] Enabling CONFIG_DVB_ULE_DEBUG exposes the use of the undeclared ide=
ntifier `TS_SZ`, causing a compilation error.

Pre-existing issues:
- [Critical] Background workqueues are flushed before the network device is=
 unregistered, leading to a Use-After-Free if work is rescheduled.
- [High] Lockless access to priv->in_use and direct invocation of dvb_net_s=
top() in dvb_net_remove_if bypasses RTNL protection.
--

commit 868e166e76f967f1bdc9ce863be77c2238e93aa7
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

Kconfig: fix typos in core makefiles/code and purge remaining ghosts (v4)

Following precise automated feedback from Sashiko AI, the active lcd-panel-=
cgram
documentation has been completely retained to prevent UAPI/Sphinx tree-wide
translation breaks. This version properly stages and includes the intended
bugfixes, such as fixing MediaTek typos, adding missing CONFIG_ prefixes, a=
nd
purging verified ghost weight.

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..3b503695e3b64 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c
> @@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *io=
v, unsigned int cnt )
> =20
>  #define DVB_NET_MULTICAST_MAX 10
> =20
> -#ifdef DVB_ULE_DEBUG
> +#ifdef CONFIG_DVB_ULE_DEBUG
>  /*
>   * The code inside DVB_ULE_DEBUG keeps a history of the
>   * last 100 TS cells processed.

[Severity: Low]
Does enabling CONFIG_DVB_ULE_DEBUG expose the use of the undeclared identif=
ier
TS_SZ?

Building the kernel with CONFIG_DVB_ULE_DEBUG=3Dy enabled will fail immedia=
tely.
The newly exposed debug code declares a global array ule_hist using the TS_=
SZ
macro:

    static unsigned char ule_hist[100*TS_SZ] =3D { 0 };

but TS_SZ is not defined until later in the file.

[ ... ]
> @@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule=
_handle *h)
>  {
>  	/* We are about to process a new TS cell. */
> =20
> -#ifdef DVB_ULE_DEBUG
> +#ifdef CONFIG_DVB_ULE_DEBUG
>  	if (ule_where >=3D &ule_hist[100*TS_SZ])
>  		ule_where =3D ule_hist;
>  	memcpy(ule_where, h->ts, TS_SZ);

[Severity: Critical]
Does exposing the previously inactive debug code via CONFIG_DVB_ULE_DEBUG
introduce race conditions on global state variables like ule_hist and
ule_where?

If the code is fixed to compile, dvb_net_ule_new_ts_cell() will execute wit=
hout
any locks when network packets arrive. Could multiple concurrent threads
processing DVB TS cells bypass the unprotected bounds check:

    if (ule_where >=3D &ule_hist[100*TS_SZ])

and allow ule_where to be incremented far beyond the array bounds, leading =
to
arbitrary out-of-bounds memcpy() writes of incoming TS network data?

[ ... ]
> @@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_=
handle *h,
>  			h->ts_remain > 2 ?
>  				*(unsigned short *)h->from_where : 0);
> =20
> -	#ifdef DVB_ULE_DEBUG
> +	#ifdef CONFIG_DVB_ULE_DEBUG
>  		hexdump(iov[0].iov_base, iov[0].iov_len);
>  		hexdump(iov[1].iov_base, iov[1].iov_len);
>  		hexdump(iov[2].iov_base, iov[2].iov_len);

[Severity: Critical]
Could a concurrent reset of ule_where by another thread right before the
subsequent hexdump() calls:

    hexdump(ule_where - TS_SZ - TS_SZ, TS_SZ);
    hexdump(ule_where - TS_SZ, TS_SZ);

result in a negative offset and an out-of-bounds kernel memory read in
dvb_net_ule_check_crc()?

[Severity: High]
This is a pre-existing issue, but does lockless access to priv->in_use and
direct invocation of dvb_net_stop() bypass RTNL protection?

Looking at dvb_net_remove_if() in the same file:

    priv =3D netdev_priv(net);
    if (priv->in_use)
        return -EBUSY;

    dvb_net_stop(net);

A concurrent interface open via "ip link set dev up" holds rtnl_lock(), cal=
ls
dvb_net_open(), increments in_use, and starts the feeds. Because of the data
race, might dvb_net_remove_if() observe a stale in_use =3D=3D 0 and forcefu=
lly stop
the feeds concurrently, leading to double-free of feeds or kernel panic?

[Severity: Critical]
This is also a pre-existing issue, but are background workqueues flushed
before the network device is unregistered, leading to a Use-After-Free if w=
ork
is rescheduled?

Looking at dvb_net_remove_if() in the same file:

    flush_work(&priv->set_multicast_list_wq);
    flush_work(&priv->restart_net_feed_wq);
    pr_info("removed network interface %s\n", net->name);
    unregister_netdev(net);
    dvbnet->state[num]=3D0;
    dvbnet->device[num] =3D NULL;
    free_netdev(net);

Because unregister_netdev() hasn't been called yet, couldn't the network st=
ack
still trigger operations like ndo_set_rx_mode that will reschedule the
workqueues immediately after the flush, causing the pending work to execute
after free_netdev() and dereference freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905001631.1086=
52-1-breno3011alves@gmail.com?part=3D1
