Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C46146A66
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977507; cv=none; b=Q1sflAnETE6o4vljcT86lPXCwm5Qb2RYF2JI8iBZS81W/IzarI/smX2C5bu4wvoVVTyv/L28i0u9Sauv4hjqYhzZM5Fa4i6ITVNEB1jQ+jK0UBslXju8Wlbo5pp4JlJtF3aw24KA4hzu22POAYpmTB9GyXsi+EAOiwyRuqe150k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977507; c=relaxed/simple;
	bh=Z7oRJusDb4SAWPXN9ImrHaxBcOVO1u7Ys0TIko+P0sA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X/vc0WPW1YLrzaYfAsUB/n7b5IVBv+2EFut/8QiCpcD5AvRoW7JfO4h56vWNkYHsqoYSL5Qn10mHuYZzfIJORywxbxnXwWMYXk+h51WZ5lKsWOT46tfBQrIUvCjxYeaS1Mtu8y2U+LLb+08nYO/tWYJCBXyxpKqhwpdTwT9lVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojru06+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojru06+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F965C19425;
	Sun, 17 May 2026 00:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977507;
	bh=Z7oRJusDb4SAWPXN9ImrHaxBcOVO1u7Ys0TIko+P0sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ojru06+G8gBWm8mU1WXhLL77iTGY+j//3sjxUP53KSfE7h0d89Npr6F9/3cfLNCxA
	 PR0Ou+FWeZJRpIm9lIK6vu3hRyHWTJKLGDyu3SZoElNeNj7yRuWsBq3IhElmGqeGYt
	 EBeia7bib83jSrWpDPO4SnVHkTiKB87xUc4C+wXWmb0bBSxi5JlfYq/9fA46hq0e/q
	 E2SWA7+TpTwLsCXTwhb1mlPDmhrEYC3tGRB2EuqZ3AS4zAcL8nQBn0uroVChnoVVYD
	 TlTVYCDP+2o9TFMdmg3RiWubvJAs3MqFJIJ+8z9S+rBykpYzYuToRc/Evg55UuVd7Z
	 WpcfVuU9y7nVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/27] rust: device: implement Sync for Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-10-dakr@kernel.org>
References: <20260517000149.3226762-10-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:25:06 +0000
Message-Id: <20260517002507.6F965C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Device<Bound> implements Sync but omits Send, leading to inconsiste=
nt thread-safety traits.
--

commit e675b37d10f2f352ac9ef52da2da8c8f4d217a5b
Author: Danilo Krummrich <dakr@kernel.org>

rust: device: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> so that types
holding a reference to it can be Send.

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 5df8fa108a522..c4486f4b8c403 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -467,6 +467,10 @@ unsafe impl Send for Device {}
>  // synchronization in `struct device`.
>  unsafe impl Sync for Device {}
> =20
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct device` is=
 the same; `Bound` is a
> +// zero-sized type-state marker that does not affect thread safety.
> +unsafe impl Sync for Device<Bound> {}

Should Device<Bound> also implement Send?

Since Device<Normal> explicitly implements both Send and Sync, and the safe=
ty
comment notes that the Bound marker does not affect thread safety, omitting
Send leaves Device<Bound> as !Send.

While &Device<Bound> is Send because the type is Sync, any user structure
tracking device state at compile time with PhantomData<Device<Bound>> would
unexpectedly become !Send.

Would it be appropriate to add an unsafe impl Send for Device<Bound> {} here
to maintain consistency with Device<Normal>?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D9
