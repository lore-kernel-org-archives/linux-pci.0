Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426912FE56E
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290394; cv=none; b=nAPlsSHHT1sUgd15rHWl3pBfbdha6UTZ54TXucaG0hYATEhalrkqVOu7NP+zTmuI3jI/mP8SnqVa2N4qpWRhxmp8dVKjUqSahm2ljfikF3erz6P1tQCvfq69jy2QLmQs0L0MpqZeA8Am8mhSr7cIV9hD7u3o7TSueprwUAKLgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290394; c=relaxed/simple;
	bh=deX7ZzVbrTZwObIIUQ1PC6h5R5oIOvkqagyKGHutJas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pr82PKDXlh3Z+xoXXd9YsRK+xj4cqC4cUsdA1Rm5vQ81YiEv34JxgVOGPq3v9dDPD6thUImY3ZgYeqt4gmTC4G7WhZxY3ylJq7MK6+V23C9KliAB5A2KVXbLwjnokwqG//XyHyWIdslBCsBkLY9jSQS6PIGmQNsRbl8lW+pGvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhmbHlQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhmbHlQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F320B1F000E9;
	Sun,  5 Jul 2026 22:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290393;
	bh=AYpykJWM3k+F8o+12cMIs3YEON0qd+Nxmb2Be3cw2Yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhmbHlQOeObvFI8NSQY6xMkH8B6knc6iFJebdmx+AZ65Hp+1tAhwS8U/UrgHL26xU
	 XGUj4JVyT5JKAf9rmurPdBxK2+vvGMU2uwrO94RUSbeOEvyIkVoSto/nksZ5Bl5uHk
	 7sCLrrRRFpbXqDftlahX057P32o6ItjFF6oL1AjZHA7MnMMCzQhe95MNfUghOejPSD
	 irozxZs986faJwrrf/L9hss135JsK7brkCSEjWEiwt/xxg4bo2z4ITKno45ZDHmCYl
	 RFsmzKa5pQ1Ra79dsbyOrJeygbm5rnpg2BV3HqGMvNARhWUMtYjjaBNO881bAFzkHH
	 2FNB41upqLlbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] device core: Add "device evidence" 'validate'
 command
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-6-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-6-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:26:32 +0000
Message-Id: <20260705222632.F320B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Holding the global `device_evidence_lock` across the provider's =
`evidence_read_begin()` callback blocks system-wide operations and causes g=
lobal lock contention.
--

commit e225a84deccb758c0117766e62b3f41123a9e5e3
Author: Dan Williams <djbw@kernel.org>

device core: Add "device evidence" 'validate' command

When DMA is to be enabled for a PCI TDISP device, the CC VM passes a digest
of the device evidence used to make the trust decision. This commit adds a
validate command to require the CC VM to ack and not invalidate the evidence
before the next DMA enable event.

> diff --git a/drivers/base/evidence.c b/drivers/base/evidence.c
> --- a/drivers/base/evidence.c
> +++ b/drivers/base/evidence.c

[ ... ]

> @@ -446,6 +446,48 @@ int device_evidence_nl_read_dumpit(struct sk_buff *s=
kb,
>  	return device_evidence_read(skb, cb);
>  }
> =20
> +int device_evidence_nl_validate_doit(struct sk_buff *skb,
> +				     struct genl_info *info)
> +{
> +	const struct device_evidence_ops *ops;
> +	struct device_evidence *evidence;
> +	struct device_evidence_ctx _ctx;
> +	u32 generation;
> +	int rc;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, DEVICE_EVIDENCE_A_OBJECT_GENERATION)) {
> +		NL_SET_ERR_MSG(info->extack, "missing evidence generation");
> +		return -EINVAL;
> +	}
> +	generation =3D nla_get_u32(info->attrs[DEVICE_EVIDENCE_A_OBJECT_GENERAT=
ION]);
> +
> +	ACQUIRE(mutex_intr, lock)(&device_evidence_lock);
> +	if ((rc =3D ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	struct device_evidence_ctx *ctx __free(put_ctx) =3D
> +		device_evidence_ctx_setup(info, &_ctx);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ops =3D ctx->subsys->ops;
> +	evidence =3D ops->evidence_read_begin(ctx->dev);

[Severity: Medium]
Will holding device_evidence_lock across the evidence_read_begin() callback
cause global lock contention and system-wide stalls?

If a slow hardware refresh operation starts on one device and acquires its
per-device evidence lock, and a concurrent validate command on that same
device blocks in evidence_read_begin() while holding the global
device_evidence_lock:

Device A (refresh):
  acquires evidence->lock for write
  (slow hardware communication)

Device A (validate):
  device_evidence_nl_validate_doit()
    acquires device_evidence_lock
    evidence_read_begin()
      blocks on evidence->lock

It seems this would cause any concurrent read or validate commands on unrel=
ated
devices (like Device B) to block on the global device_evidence_lock until
Device A's hardware operation completes.

Could the global lock scope be reduced here to prevent this stall?

> +	if (IS_ERR(evidence)) {
> +		NL_SET_ERR_MSG(info->extack, "failed to acquire evidence context");
> +		return PTR_ERR(evidence);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D5
