Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6A3DDAED
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885933; cv=none; b=MJ6V9GcwDFej0J7WtFt/kLU3KXDfOl2oHSZ/d9KCQInbipAIvpiR2PvWZApfZJtY/33Qo5K1NtStBsKOfjgZ4cWC70HBc9UHFeUePEFoyx6pNAjMNdfy1pUWcM7FwUkKflHnJlig9wCZiPBO7B1O0Dezv9MHSJHPR4T1isn9CDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885933; c=relaxed/simple;
	bh=3GEZCZJw6g3WLomu4irAvto4kVz7tpQ2NLvVCTfwrH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HK8aX94YQzVuo4nu5Ruvnhny+GYTJL4wQiQKiQ6BdcGn3hVeYQQxoVEnQcGHugQwh2OCRUnpLeqDRNdRtOVCX/osEZ/sCfTKL7cLTztstxd7P3Nj0+5YmtLENAiEz39lH3vC6GYwHb8q17scHasrWaMq+PtTjJEzoAT+EzNBD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8eQCQYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8eQCQYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C41F000E9;
	Tue,  4 Aug 2026 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885932;
	bh=3GEZCZJw6g3WLomu4irAvto4kVz7tpQ2NLvVCTfwrH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8eQCQYcfGoiOHV7Aqn6mX20Irza/jkkAfvYZAj2UbXv+fcd78QVzOlVnYzflhdvk
	 RWM3vd+hMPD12VphYASCuE1D+4hW9L0jqBvlPgkPONqVmWV5qW0LdgCB+C+owBFYoX
	 R1d30m/SERZt9zBYcXaVTMR7RQpeFWXaJn5d6x39ozU8FZcTlEYePK137ZZTH09ogm
	 FKrtcY4zNXcoZEjUs4iBZyzV1JxJeVS0vhKVuq9QaBD5/GaOgnyfECguKK0OKx6zNg
	 0tOhfi6Sj3K0O/x8pYFev2ZbbCQdraKclf+ykFGteFdlVc0yPCu8yvE3OvS8WrOg/i
	 JnGPc9WBoraFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: pci: Mark Device refcount methods inline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Plant" <plant.ethan@gmail.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
References: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:25:31 +0000
Message-Id: <20260804232532.2C4C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Ethan Plant <plant.ethan@gmail.com>
>=20
> When building the kernel, the following Rust symbols are generated:
> $ nm vmlinux | grep ' _R' | rustfilt | grep -E 'pci::Device.*(inc_ref|dec=
_ref)'
> ... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::dec_=
ref
> ... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::inc_=
ref
>=20
> These Rust symbols are trivial wrappers around pci_dev_put() and
> pci_dev_get(), respectively. It doesn't make sense to go through a
> trivial wrapper for these functions, so mark them inline.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ethan Plant <plant.ethan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-inline-wra=
ppers-v1-1-16916db867e5@gmail.com?part=3D1

