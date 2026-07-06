Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1B381B1C
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343383; cv=none; b=fKM3ZsZToWL3pzDi4B5KQy0Eu+7ueYMOVa+prRbVKeEV4jPF7Rn+0udoG1+aianRiuPnBQ2mJTsV6DYT9bTjjl+6uQJ1BDmcqLpkUuKJrUyV69jXowDMFW9XsDNFkRZU0sEDtNziw66QQ3SDi+nXcJzn3CZ35WelGsQJm2SHJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343383; c=relaxed/simple;
	bh=5uYgrVTzyiAvpSUsidCWa7D92A7tREcxWUY9dgYKrw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F048svLBkq2CJ7JyrErfjFkWpW6f0Z2Oh9RYN6GZutrZdk7AYB9Sfz5gk6JgekhNOtV02EB1Olc5OjlmljHQW3zSi+jTq40I26+3H/z8249BPXMdVzMF2GReP6tBSQar2PY+9IQD/gYD1Xv+g0v7trUVehRokQTL0JNxAwkWvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag68XJGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag68XJGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2F11F00A3A;
	Mon,  6 Jul 2026 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343382;
	bh=qhBXz5dJ8J33VxtVL+B77S+FOyeSsvTuCKfkzGt7t48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ag68XJGMkV4VYqQbqc6QJpiPvzIQ31+NsuJEsS/vSYNAbqbfKokcgeuY70uFi+/aK
	 SEbSYcNiVfnNjX3VQeQyC98zUNdQlMgkveVzRbFIRTQYoGU8haB23LJtvBz4x7EsdA
	 8Cb+tcwCG4kPDlJGk8mNKfmptScnkYp8bpQTjL5oCypQnWcnVvc9lKboc/oyzWk0cb
	 1EkIVDcqbHeqgzxp3Ne4GL3wcn53ueCz5q1WR2k31I+URlPbprVV50ojCHoY4OxFBL
	 evAkPanS83aNsBTTQADCjru5zOQVs1gihhm4/krbr+NGcpmZlwgnmB7CdA3Wy0QiOV
	 DXyf5eGr4aklA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/20] rust: io: add copying methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:09:41 +0000
Message-Id: <20260706130941.EA2F11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Exposing `copy_read` and `copy_write` for arbitrary generic types =
(`T: FromBytes`/`IntoBytes`) on `MmioBackend` maps to stream accessors (`me=
mcpy_{from,to}io`), which bypasses CPU-to-device byte-swapping. This confla=
tes stream and register I/O semantics, creating a severe footgun for MMIO r=
egister structs on big-endian architectures.

Pre-existing issues:
- [High] The use of `fence(Ordering::SeqCst)` emits a CPU-domain memory bar=
rier, which is insufficient for synchronizing memory between the CPU and th=
e device (GSP) when updating command queues.
--

commit b39304c44ce9723636b250bacb9f2e99203d514d
Author: Gary Guo <gary@garyguo.net>

rust: io: add copying methods

This commit introduces copy_read and copy_write methods to the Io trait
to allow reading and writing structures and slices. It implements the
IoCopyable trait for I/O backends, mapping the MMIO operations to
memcpy_fromio and memcpy_toio.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c423125870b75..9df4e982c5d8a 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -442,6 +524,121 @@ fn write_val(self, value: Self::Target)
>          Self::Backend::io_write(self.as_view(), value)
>      }
> =20
> +    /// Copy-read from I/O memory.
> +    ///
> +    /// This is equivalent to reading from the I/O memory with byte-wise=
 copy, although the actual
> +    /// implementation might be more efficient. There is no atomicity gu=
arantee. Note that for some
> +    /// backends (e.g. `Mmio`), this can read different value compared t=
o [`read_val`] as
> +    /// byte-swapping is not performed.
> +    ///
> +    /// [`read_val`]: Io::read_val
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
> +    /// // let mmio: Mmio<'_, [u8; 6]>;
> +    /// let val: [u8; 6] =3D mmio.copy_read();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_read(self) -> Self::Target
> +    where
> +        Self::Backend: IoCopyable,
> +        Self::Target: Sized + FromBytes,
> +    {
> +        Self::Backend::copy_read(self.as_view())
> +    }

[Severity: High]
Does exposing this generic copy_read() for any FromBytes target conflate=20
stream and register I/O semantics?

When used with a struct representing MMIO control registers, this method
eventually maps to stream accessors like memcpy_fromio() in MmioBackend,
which bypasses CPU-to-device byte-swapping.

Could this lead to data corruption on big-endian systems, where drivers mig=
ht
expect the byteswapped register layout but receive unswapped data instead?
Would it be safer to restrict bulk stream copying strictly to [u8] targets
via copy_from_slice and copy_to_slice?

[ ... ]

While reviewing these I/O accessor changes, I also noticed an issue in
the GPU driver code introduced earlier in the series.

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_read_ptr() {
    ...
    // Ensure read pointer is properly ordered.
    fence(Ordering::SeqCst);
    ...
}

drivers/gpu/nova-core/gsp/cmdq.rs:advance_cpu_write_ptr() {
    ...
    // Ensure all command data is visible before triggering the GSP read.
    fence(Ordering::SeqCst);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is this CPU-domain memory
barrier sufficient for synchronizing memory between the CPU and the device
when updating command queues?

Rust's atomic fences map to CPU-domain memory barriers (e.g., dmb ish on
ARM64), which only guarantee ordering within the inner-shareable domain
between CPUs.

To properly order memory accesses visible to a device in the outer-shareable
domain, a device DMA barrier like dma_wmb() or dma_rmb() is strictly
required.

Can using a CPU fence here lead to data corruption or lost commands on weak=
ly
ordered architectures, since the GSP could read stale command payloads befo=
re
the CPU writes are visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D19
