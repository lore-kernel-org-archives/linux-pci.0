Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B06475336;
	Thu,  1 Oct 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847307; cv=none; b=LrTMrW+n5wAN/rRfGD0vqPu2s42/tQWZFH/T4/ijveGSGWj3JmJ13ljp+wx5Ht+Lcjot/e2rJOSgUrzTcTlQXw6QhqeGkH/+Iulr1M+BZjNMM+ljm8o9dSnFxwq4O5rMmfaJuzfVXW8surAJaJfCvc99/I4kERZ9/OkZJy2OsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847307; c=relaxed/simple;
	bh=9d1lZ5DDhe66tV3SXVJSkm6XN9iKI+vfaWdpe/65o6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjIBRJNUZ4KyP/OjP+fhfooCvtxJwRhApVf6VQujuofy2vF3uvCUS400htLOXBND6yLsZD4YdynEKzrbUWaPx0Itk3w8XOCz8twfnSb7ekgk7Fqv+L8TWnJV9m+KyiyuprUb90GMnYP82W1vj711IAOVLGrfYBJc973QPMO0EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0jnhSsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0jnhSsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C741F000FF;
	Thu,  1 Oct 2026 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847305;
	bh=9d1lZ5DDhe66tV3SXVJSkm6XN9iKI+vfaWdpe/65o6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0jnhSsau2R1qILDeTeqHvkns9PDZcsrNJB53EIl45s1EX3aO4WfO4HOED2Ie1FlG
	 0rJfYTrOzQPBim0v1aee0DrW8/QYtHKtDUIUVtR+0Jkk71vn1nzNZpeBRJAYG3//gd
	 RLH+EZLACxMTZKW38w/kqf1Uq+dItlhldwTDLMYIEiCkDhfaAmZRnXQ+72KPprbk+6
	 z2PYmg8AEITWutiaMVV1bRKecJ2evKw4jliNgKTwxdyA9LfZoJeNiOCopDvQLul0pj
	 QlpwmDa41xmhJFkfyh2sM0q1yyZhv7Y2MTZlYai8Np2bie6P5j/5sYfYRnio8Xy46Q
	 M1o8Da1KBz0ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/16] cxl: Reject overflowing HDM decoder ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-9-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:35:05 +0000
Message-Id: <20261001093505.80C741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An HDM decoder with a nonzero size can report a base and size whose end
> address wraps the 64-bit address space. Reject that programming before
> publishing the decoder range, so enumeration and later reset handling
> cannot use the wrapped range.
>=20
> Use check_add_overflow() for nonzero ranges. Preserve the existing
> empty-range representation for zero-size decoders.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D8

