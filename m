Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757E1C861D;
	Mon, 28 Sep 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559577; cv=none; b=SNbMqEZrhGGKdtZrutUErdhjZdb4YllIehUUFJ4QhtYJ7Vjfvw+ftKdoJtCrUY/xgPVuCndFRJh4BxXe5C0MHBaWIGglTYD62j73BWtp+WA/r30koOd8VdgR/blUMquc5UJTKf48qajgVc6eJzRRp0YdcBl9xVpQRcxp8DrelZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559577; c=relaxed/simple;
	bh=C+YzAwvt/F75DWE3bKvSg9UyD2hcPYPJkNEk2xKEWnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5I4m0Agwg1l1fBp5BnsZF95KePcB+IZQYyPfshZCtSPPbCDVVfWaDGfj5/WWGCG0PzwmDen3cfl6pEfOyY6I67ID0iOwbcbiQ1htgRACPQ04a17uwJfn16s+8Ln+tYxPTGTp++9freLePlo+qyyWp4MORygXQ/io+cy/lpCfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE4NVmk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE4NVmk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5521F000FF;
	Mon, 28 Sep 2026 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559575;
	bh=yt4LhSGyMt6Vmi4IkIPXOdnZbXqNTHVE2AUX0suHTXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gE4NVmk59ytDPN4h/YpKquZRbtmi7ZvmSt+5GQM+aaVgszL3wWMZx9d0aNpOqyfZV
	 JyfoE8+M/7AkMG06AIFLc1vJztQRuFexfPyH/g6YNiWA4i3/aIVQvx1r7CWMEUJbZg
	 hPj3H/25vGIc5o+lie/ehG8/QT3O5ulY0VhEZ6/4cKeSP2P/MQrguk+2SD1E2WBvoD
	 al+0kUhXZ2UoFbxgMWxlNrdReJIFxlCXxm+WPGBgTUxJO2wSMgUrv9kOxT8MOYUglC
	 KYKTu/xfUTEdM+lB+6eG7CIX9k27A2cU3HE5TV6xGcsFYm5oK0b6VLQ2UdhO6jDwFA
	 lm29WOouISZnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/22] lib: rspdm: Support SPDM get_version
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: gary@garyguo.net, linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-16-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:39:35 +0000
Message-Id: <20260928013935.7A5521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Duplicate documentation paragraph for SpdmState
--

commit 9b95322ccfb4a7875669dc07aadddb7266aa7fc7
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_version

This commit introduces support for the GET_VERSION SPDM command in the Rust
SPDM implementation. It implements version parsing and validates responses
during authentication.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index c894cf30bb870..3bbe55d965f7a 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -37,6 +41,11 @@
>  /// run one at a time and the locked `&mut SpdmState` is the only way to
>  /// reach the inner fields.
>  ///
> +/// Concurrent access is serialized by wrapping the whole struct in a
> +/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` cal=
lers
> +/// run one at a time and the locked `&mut SpdmState` is the only way to
> +/// reach the inner fields.
> +///

[Severity: Low]
Does this documentation paragraph need to be duplicated?

It looks like this newly added text is an exact duplicate of the preceding
paragraph explaining the concurrent access model of SpdmState.

>  /// `dev`: Responder device.  Used for error reporting and passed to @tr=
ansport.
>  /// `transport`: Transport function to perform one message exchange.
>  /// `transport_priv`: Transport private data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D15
