Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1FE555;
	Tue,  1 Sep 2026 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225591; cv=none; b=aKeUBU9qXdki7fltjO7ElucYZ97ONp8FIK3eNN7tcHav7VZc8vbmg9St/nYM+gadOYcA+n7JlHixAHGQZQ02+Xmf+hkOucBAMNsdzlRh3Wbtsabe/ZGzzbbc6zk9oK2N1h6uGVnbzgk4/PLKzXp6REDrCEV7gCH/14O1PiomIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225591; c=relaxed/simple;
	bh=yLv+FqE2ya0fof6/FcX7vG+S8Lo27/sxIRf6ina80nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9MPwbKKPHyAjCi/01uFpWmkUl1A2oy/+B6PAQY7WU32CQYdpVWFr3VziQzZsF/2gtMOlMWSZ8zaHQr0y3wfJnnt784mfJrAnuWQG8CZf422hFSfIyp4MAXyKUqfx4u257o2LAUbMo2flmzDq9PF6PI9Kac+1wii/Y91S8kQFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKiJ3gJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKiJ3gJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3552C1F00A3D;
	Tue,  1 Sep 2026 01:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225589;
	bh=KI5cPe/Gqayg6EDlqg5HZiaJbw7qDPC8rVSHl9oYmnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKiJ3gJmrxEEK7mgxUnmP118KbPUfeD7zU6Q1C7zMxX9axnVKRDO4cBMjeY7tksfQ
	 eIfy7QimtjnVKA8qex9ik9yBGL3QF1L3wdTvQOI/8yv8ReN7QUbx8WU9EZ8A9PFHu4
	 5irQg9RQpS39PS52S+MD52jd0vEkv+4am+qi7vJjxImqkPtDbwbZeAMbxZV0y3MZyi
	 cAIDT+Y0ZuqG4B3jEmOFigi7PmopBAOzHYlvyG8dyqDAt6UQ2CPJeJyA4n3hoeRjs8
	 zLxMOgsBGACLRAdLSTIdlHHkpo7mrtvEkGEeYuQRZ7L1HFEvknktd1skJefjFW97DF
	 3Kf7Q3uYHdxzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/21] rust: allow extracting the buffer from a
 CString
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-21-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-21-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:19:48 +0000
Message-Id: <20260901011949.3552C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `into_vec` method returns a `KVec<u8>` that includes the NUL=
 terminator, deviating from standard Rust `std::ffi::CString` conventions a=
nd failing to indicate this in its name, creating a high risk of subtle log=
ic errors.
--

commit c0d8b032f9c0888c9ca7f0f193ec4c7fb49a4747
Author: Alistair Francis <alistair@alistair23.me>

rust: allow extracting the buffer from a CString

This commit adds an into_vec() method to the kernel's CString type. It
allows callers to consume the CString and extract the underlying KVec
buffer.

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index a556788bcc5e9..3fd8a218547f4 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Res=
ult<Self, Error> {
>          // exist in the buffer.
>          Ok(Self { buf })
>      }
> +
> +    /// Return the internal buffer while consuming the original [`CStrin=
g`]
> +    #[inline]
> +    pub fn into_vec(self) -> KVec<u8> {
> +        self.buf
> +    }

[Severity: Medium]
Will this return a vector that includes the NUL terminator?

In standard Rust, std::ffi::CString::into_bytes() strips the NUL byte, and
there is a separate into_bytes_with_nul() method to retain it. Because this
method is named into_vec() and the documentation doesn't specify how the
NUL byte is handled, could callers unknowingly process an extra NUL byte
if they assume standard behavior?

Could this lead to a regression with incorrect payload lengths if the array
is passed to external subsystems expecting a standard string length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D20
