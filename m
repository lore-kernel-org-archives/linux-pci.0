Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C3253958
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290052; cv=none; b=sKgxCL5eolFmPF6YFyeSSSryaRZOvsiZ9ZJpuGr9PPTSfQwVg0iUWLcfOHqUH6AvNTtw3nPwgI1F/cUxjEXtaQ0eNLR7f4zWE+jppsgDHoEVPDiIdi5Yqdb97CdKkdrlCinJFDlBiMbkTyVNGVcT19Q+n5GwaD+Ughi20ZGmrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290052; c=relaxed/simple;
	bh=jabuJ5JjJHDeSinsnqnOVUUoVXWNrCzxw+QWkzuTq60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbJTi9ivw0Eg96sW5+HeWt8TGEtwJ8lhwDJxIZBjlhvUjCbTjMCdY2SJpuh+JUFS5hUZR9jn0TlzpwvMiedWnLNG8o+8HnD2gJziqmHgGQWDh2Hxn+SszkovgJGVwbZR/J6aRMhe0lRwCikL3y4aQQOHTRnVw1jFxAeXG77nSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyXhIQY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyXhIQY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044E1F000E9;
	Sun,  5 Jul 2026 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290051;
	bh=vWZnHVmT2tctTX/PR3yRYAr68MgO+xWghKlEDQBLThg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyXhIQY3I8KmRyTGOTXz2exKsZ5nYFA9ZE0gyYRGwTJcqSdSzwpwX5rhbYp6g+5Fo
	 e3xTPYwDNShvjziuo16rHwdQfFxCpfcvVO5mgN78YBcRUh7BvaWzgv2+F2f8Y24Yz5
	 IB0kDlI5iHCEu7CVfBpzFduexUN5I5Wk8S2XQChiedN6t5ZCaKVZKbe8nZJEN/6aFy
	 mJGkYnLwhtcBasOMklffJTWk3vtTbFLX20f9KE++d2vAmqi1r5ZqS7te9nXYqyQEkD
	 460FpzIw0Bc7QoJn6l4laAeLBc9ETRK0csEIMYqG8OO6wK/z5C1l9zAMxEezp52rud
	 DCVofYeisd/Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] device core: Introduce "device evidence" over
 netlink
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-5-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-5-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:20:51 +0000
Message-Id: <20260705222051.6044E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature state advancement causes missing netlink attributes wh=
en a dump message is split across multiple skbs.
--

commit 011b819de43e88cfea717a04a2344bfd9d08116a
Author: Dan Williams <djbw@kernel.org>

device core: Introduce "device evidence" over netlink

This commit introduces a device-scoped ABI over netlink to retrieve device
security evidence objects, such as SPDM certificates and measurements. A
bus opts in via device_evidence_register() to resolve a device handle to
its evidence context and provide these objects to userspace.

> diff --git a/drivers/base/evidence.c b/drivers/base/evidence.c
> new file mode 100644
> index 0000000000000..8e019669db072
> --- /dev/null
> +++ b/drivers/base/evidence.c
[ ... ]
> +static int __device_evidence_read(struct sk_buff *skb,
> +				  struct netlink_callback *cb,
> +				  struct device_evidence *evidence)
> +{
[ ... ]
> +	if (ctx->offset =3D=3D DEVICE_EVIDENCE_OBJECT_START) {
> +		if (nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_TYPE,
> +				current_type(ctx)) ||
> +		    nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_GENERATION,
> +				ctx->generation) ||
> +		    nla_put_u32(skb, DEVICE_EVIDENCE_A_OBJECT_LENGTH,
> +				object_len))
> +			goto out_cancel;
> +
> +		ctx->offset =3D 0;
> +	}
> +
> +	available =3D skb_tailroom(skb);
> +	overhead =3D nla_total_size(0) + NLA_ALIGNTO;
> +	if (available <=3D overhead) {
> +		rc =3D -EMSGSIZE;
> +		goto out_cancel;
> +	}

[Severity: Medium]
If available <=3D overhead evaluates to true and the code takes the
goto out_cancel path, does ctx->offset incorrectly remain 0 while the
netlink message is canceled?

On the next invocation with a fresh skb, ctx->offset will not equal
DEVICE_EVIDENCE_OBJECT_START, which means the mandatory type, generation,
and length attributes will be skipped, leading to a malformed netlink reply.

Could ctx->offset be updated after the tailroom check or reverted in the
out_cancel error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D4
