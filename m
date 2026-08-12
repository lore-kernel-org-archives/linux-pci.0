Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEC385D99
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564570; cv=none; b=X9/g6y3KIVyhp77n+aIRt1v4YAOmenfvgl+u9ise2lAdCassmJgUE+CBxZBMwSSZ8o3CXerVgR6pSvnLNnBLsHfpXieCIoc/qwXiihPbBP1dHUxDKfQFzj80vGlNldcelGiJEf41FzSDvTw6MxynBGkgmlzSZBmUM8Pe/LVjiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564570; c=relaxed/simple;
	bh=qWAwXk6XLjTZEV49YgLVHYdlotoUwcqlQh9BZ+9HocA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OI+0LL60bNZATF42bMrzmR3Lspan9PM8DLUJBjBrxhphzi3wvK3dGnU+C1tLhKWe+KZPWBYh27DQCZ9cTjPs/JgC7k462UqG5PnaVG0UiW1rdFhn2rZsWL04gdXoYgFfYv+4R8/3TeA1SUbfIUIrl8/IdQ5Vm0VATP6mloWOALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbgFM+o5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbgFM+o5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627851F000E9;
	Wed, 12 Aug 2026 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564568;
	bh=qWAwXk6XLjTZEV49YgLVHYdlotoUwcqlQh9BZ+9HocA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbgFM+o5xvHPBP548NBcW4GOB/FAiOJuLfoywmC4boUWlgq3JejMoz+qfirv2IR45
	 tKYSj68iyTy/qHrB14TDECcIUrrFEbWFI1Sf6OQrY0HsyHIt3AGtaw4wdZlxpCfdJv
	 dK5KKc8F255opKGOf2opGXHgX/uKXBnmp81KWKmQApoq1EmtEnZw8oSbhoDP3LEFx0
	 NZ/dCqnLbUpj7uz5beKJOeTA4FB1OniZHYhWQRHjPVkjoJbwOamPmQqWMtSpBt9qSp
	 XRvrIVaygL5P3473DQhZVUR+Ix7mz23ZE7Uw5XkwRRgQiPOCqopKfN4cBZeC/z6CE0
	 pekML9ruYUbBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] rust: completion: add complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-4-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-4-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:56:07 +0000
Message-Id: <20260812195608.627851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion permanently
> done, which makes a single Completion unsuitable for signalling the same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>=20
> Add complete(), which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with wait_for_completion(), it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>=20
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D4

