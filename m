Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA41404BE3
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764338; cv=none; b=UWm4XvrkjqqDsbzzj2q90HvTFq16G0VJzMslC+BVlA9SEtNpnEDuolQ45QsoladM8Ka4ERinZQFXWCj/BKtfLgcepovApIrvBuLNCuabVkJw9l2tHdGj63XV7ZslyXHRYz+wa4JTPhYstRKToYTykB8FpA3TIl3AgmKnFQMvDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764338; c=relaxed/simple;
	bh=qE4oks0Earms7tZVx5juVc3H1XkqwvxpvEExKABoGWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ed9pBVXUucZ+FhQ9TcbMScYpuQ+THxP5ZdNCWa/KDTkx2It45kZtUJ/lsF0GzigvFOgqiRmNOIRTaez/39A8B9HoJpd0rhdS6ah8xRZuOC0eDg0dXmTkFS1q0K4Fl8579WHzybIEXO56p0vateMAoXPpZC7s70HOyR/DqOegcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtA51Aed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtA51Aed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B21F000FF;
	Wed, 30 Sep 2026 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764336;
	bh=ix0ChN42gvwk1Vo/Yx2r6ajZm80Bqvev4wIzo7KjWug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtA51AedpeQtNPH4RnNu4mxijL3lLO8NKGyr7+BYVZjrWJcfZapPPS33MI8IKk6V2
	 43mYZUOXaTXJbD8KoTO09T9efFeKPv/Zk9OY9XtsC/XCILFNFIg8H5R7cPGTmLA5LO
	 FAAwOaFYB08ejRza17gJ1vnFvorT3ac2al3lb/j+K68HczmolzDMAhIYIOJ3oulj3G
	 43za7mNL7iJD7zrc0x1o8AcgnjvqDNoRgN2YGMaqmwilHdnRg4CyCfIPtct7Jw/9IB
	 qeXBt0gWEhnyreiZ8qRPmi3GOtBAh6h4SZ0jx6Vz2+miptqWk/gGO6KUEj7/TPD/QE
	 rV/gZy0nynT0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] rust: pci: add num_vf(), to return number of
 VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:32:15 +0000
Message-Id: <20260930103216.642B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] on num_vf() abstraction
--

commit c909cec9ddd3766a8c4ba947c0d935d2555ad9f2
Author: Peter Colberg <peter@colberg.org>

rust: pci: add num_vf(), to return number of VFs

This commit adds a num_vf method to the Device abstraction to query the
number of Virtual Functions enabled for a Physical Function.

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index a4a23a9ea77ae..4f611d5d0b89f 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
> @@ -28,6 +28,14 @@ pub fn is_virtfn(&self) -> bool {
>      }
>  }
> =20
> +impl Device<device::Core<'_>> {
> +    /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
> +    pub fn num_vf(&self) -> i32 {

[Severity: Low]
Does num_vf() need an #[inline] attribute? Small functions in abstraction=20
crates that merely forward to a C binding usually require the #[inline]=20
attribute to ensure optimal code generation, according to the Rust subsyste=
m=20
coding guidelines.

> +        // SAFETY: `self.as_raw()` is valid and this call runs in the PC=
I core callback context.
> +        unsafe { bindings::pci_num_vf(self.as_raw()) }
> +    }
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D5
