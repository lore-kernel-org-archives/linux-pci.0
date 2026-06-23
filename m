Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084630595C;
	Tue, 23 Jun 2026 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186143; cv=none; b=tTyPa0570NuLP4aJYkzoDybH2ijcMxupUKIuVHPkflC8cCsMeBfBTpMlbOlVq3VvZpVabGPMIcDuW7AcY11V39EdAQpxHst5Mo5iipE9b+TC4A99RBYa4OgKS6OGuvLLygo4l8a12HYRMgInF1UqP2Q7OfoeZZ8UaIoqtEaMqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186143; c=relaxed/simple;
	bh=ts8BupGE3Hnu3P7u/FOi8JYPWqzCWe3gjxU8MBGqwO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eDeP6HO3iXBfH8C6AZHy6IKivg5wUwhsEJjeI+XK2KHd1pkFvrs8yUyEnuFoyHyg6RKZY7DoVzicU58BbQWs4pzjMQv8r4NV+dVvk8VsEBKKWqk/+u8mwYjeCVlBruD7xUPdvv1Y2cEAj4Y9x1sb24ZcYybRPO3GiwyXeurdK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGON+u7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGON+u7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF51F000E9;
	Tue, 23 Jun 2026 03:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186142;
	bh=RekW0KClx3QXKbw74Gr7X1BmTL8LNMeNbWvtfvwo0E8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IGON+u7F919KcN5D74wFRbXZq4kJAwsYqwWSTfC3USim8zop+4/Pc5MQfDsLdPJIV
	 tpyRX8hIN66eWuvIWTUehn+z3uBknwC+ak9jje9Kt6YRj2oURFC1qE3UlDwl07YR7v
	 6y7CE1Pg8PadINhSxzuQ/aFpwG54vQcc9FBS63hCRbBhrs7WqdjDHTYifrRCI68dXD
	 J+LZFWrigfyPV53fvACaZuAW1H3Efs2xP4D0ewpEqxPpZ3H3BPaZjhebVIedi0+kZE
	 /9zVoEuDSnJ2weO64nV3H3F6HG4BrqdDcIsANwgvlFPe7/o0RFQY7FXdLPznjrwdcz
	 nDrOOkI91L9kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/11] cxl: Cache decoder settings on PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623032453.3404772-3-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:42:21 +0000
Message-Id: <20260623034222.3AAF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Cached target list is truncated to 8 targets, breaking reset recov=
ery for 16-way interleaving.

Pre-existing issues:
- [High] HDM target list parsing uses an endian-unsafe union, reversing tar=
get IDs on big-endian architectures.
- [High] Stack out-of-bounds read occurs when processing decoders with more=
 than 8 interleave ways.
--

commit 1a9ec0491bde62ac73e5c79d561f966396fbb2b8
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache decoder settings on PCI devices

Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
enumerated, committed, or reset. PCI reset paths can use this snapshot to
restore HDM programming without walking CXL topology during reset recovery.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fa978c297546f..83cda63f76a5a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, s=
truct cxl_decoder *cxld,
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;
> +		cxld->targets =3D target_list.value;

[Severity: High]
Does this truncate the target list to 8 targets?

Since target_list.value is a u64, if a decoder is configured for 16-way
interleaving, it looks like the extended target list registers are ignored
and the upper 8 targets will be permanently lost during reset recovery.

>  		for (i =3D 0; i < cxld->interleave_ways; i++)
>  			cxld->target_map[i] =3D target_list.target_id[i];

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the target_list
union overlay reverse the target list on big-endian architectures?

The target_list union maps an 8-byte array over a u64, which accesses
the value in memory order.

[Severity: High]
This is also a pre-existing issue, but since target_id is strictly bounded
to 8 bytes in the union, does this loop perform a stack out-of-bounds read
into cxld->target_map if cxld->interleave_ways is greater than 8?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D2
