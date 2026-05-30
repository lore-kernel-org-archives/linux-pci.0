Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC372C21DF;
	Sat, 30 May 2026 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101962; cv=none; b=YQu0aKPKquBh3cQmCiJmliCyJC5um0SoN1jUN2ax3e73ohczd24VEcI3mY8q+I7GXLaispxX5JmwBnKVfGAZCgZ2h55GRPpFpfPKJ5iUwqooV7dlIoqwkBHGqg/NGL22d4iISy9PMhU682tJcTUlXHWemOqfkwGhURzjjEyZNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101962; c=relaxed/simple;
	bh=XSAaevof0A1IrsWm0oSPu44vwy3uuZCWBU5X6SUmHeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BdaXQxM8XIU3OMg45zUSMAvXMM3tdv6niVMJDR+rCqh8siS5uTBS4H3GPes+t9r5yOa2gzz7GOeLkKSMzQTwprHKDzLAAqeCNg6RCNcZtTGq3l43MQuUyWqrDuL9snl0fK0pISg/w0tGCrSXWtOBQ29JsCMj+jGUR7BDmJn4E/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvDSuhws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvDSuhws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6711F00898;
	Sat, 30 May 2026 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101959;
	bh=cv1VYnryK4GWIJhm8EDWBXQRtGNV8wFHFsC9t8z0AIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvDSuhwsG1P0v6c4JHEK0ueaHDHQivbEr9ZpYiBltOhrxYOw2xIsRVsc2QwB+nm3p
	 1baZH9hPnOANhWLW4EHwOsJgq+c0FCz4P5IdqZlJ9RXnIyXuBF4yojj5WLt66vdCEj
	 pH3K9iLzU8UQlC8SLxfEymcK6YzU5/x1E369V4YTuqPDAvKIi1O1YdrR61aJlRVFy3
	 3V8BaIu1Xdl+bilfOrUuDaHMcLa+b70ByrvC9eNsUyj7GSSfOTKsLlhpdnScSMPcmb
	 P0mTfVCXi7aQ/CBXzqrgimUSl9PBqLP4fHLWqaNyOTufxTqQ3xFHfbc1KF9FYFxntg
	 Sn4ypglEVIfvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] moduleparam: Rename .get field to .get_str
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-media@vger.kernel.org
In-Reply-To: <20260521133326.2465264-5-kees@kernel.org>
References: <20260521133326.2465264-5-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:59 +0000
Message-Id: <20260530004559.6D6711F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The commit message claims that all `kernel_param_ops` initializers =
in the tree now use the `DEFINE_KERNEL_PARAM_OPS` macro, but several files =
(e.g., `arch/xtensa/platforms/iss/simdisk.c`, `drivers/video/fbdev/uvesafb.=
c`, `drivers/mtd/ubi/block.c`, `drivers/target/target_core_user.c`) still u=
se direct struct initialization.
- [Low] Renaming the `.get` field to `.get_str` in `struct kernel_param_ops=
` breaks the kernel build when Rust is enabled (`CONFIG_RUST=3Dy`).
--

commit 1952ed67c747da9c1d8185a27ee2651d4cdb0689
Author: Kees Cook <kees@kernel.org>

moduleparam: Rename .get field to .get_str

This commit renames the .get callback in struct kernel_param_ops to
.get_str. It frees up the .get name for a future commit that will re-add
it as a seq_buf-based callback.

>     Now that every kernel_param_ops initializer in the tree goes through
>     DEFINE_KERNEL_PARAM_OPS, no source file outside kernel/params.c and

[Severity: Low]
This isn't a bug, but is this description entirely accurate?=20

Several files like arch/xtensa/platforms/iss/simdisk.c,
drivers/video/fbdev/uvesafb.c, and drivers/mtd/ubi/block.c still use direct
struct initialization because they only define .set.

>     include/linux/moduleparam.h references the .get field by name. Take
>     advantage of that to rename the field to .get_str.

[ ... ]

> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 26bf45b36d023..f5f4148e25049 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -63,7 +63,7 @@ struct kernel_param_ops {
>  	/* Returns 0, or -errno.  arg is in kp->arg. */
>  	int (*set)(const char *val, const struct kernel_param *kp);
>  	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
> -	int (*get)(char *buffer, const struct kernel_param *kp);
> +	int (*get_str)(char *buffer, const struct kernel_param *kp);

[Severity: Low]
Does this break the kernel build when CONFIG_RUST=3Dy?

In rust/kernel/module_param.rs, the make_param_ops! macro explicitly
initializes the generated C struct with get: None. When bindgen reflects
the renamed field, compilation will fail because the get field no longer
exists and the new get_str field is uninitialized.

Even though this is resolved later in the series by removing the get_str
field entirely, does this intermediate breakage cause issues for git bisect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521133315.work=
.845-kees@kernel.org?part=3D5
