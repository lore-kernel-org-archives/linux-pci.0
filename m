Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AC3EC2CD;
	Tue, 28 Apr 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382563; cv=none; b=OECDccrOvLgWkIEMbhHih1V3eCL/NBKEeNVDYg74tbBjHsMV6hFeXKnvq53jgx7WHVndmVKLL66v2XKZU5hqqLa4niUaq+6e9tUg73jMTW48rFDkKXhlt2EEjqx1bxZvQF4pusncpE5b3o3Xbg1b++thPOIbT8nu8RA1kX08AjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382563; c=relaxed/simple;
	bh=M1huU9amtIwVkVET6Mnt5+JELOvaJpGXaOgvuKFhvMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNnq5NKlPlqabtTNIsWfIiH5MqGxiL0fVTx78FymSYOSgbmwzsp3D1NQQ0e/TarByyNvS1OuHDojnJn0US6EHvtqTwH8XXU/tYLqfyXu5Byk0d/Q6gW7m9aTTlCcAwdAnnkTo473Ko965L4dCYWDTkaaQREbQryZtC7CoEKqvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiiW3wML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiiW3wML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093CC2BCAF;
	Tue, 28 Apr 2026 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382562;
	bh=M1huU9amtIwVkVET6Mnt5+JELOvaJpGXaOgvuKFhvMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OiiW3wMLHpl4S5Wz4DZtog1aQWzIYgBsMSYspKvyKB8CIWD91tcGzzeyTNYgfv7wf
	 mEgvRbMt7A+3wgGvh/nT/1R/D6EEjoq2kBU10hxHwg2jU0AK03H4vC/HJMrQsFJVEL
	 BSjhkvwvmNJjhI701K9k06IuP+iBAwShkzlAk8sLRQQRsP1s71TghxfnVEGXtWeuE6
	 hZHcu+uD0LgWthhMv08g/dEyRIFqd6HpV6j0FmpAHpdig823kFoWsMvT1nstacs4jc
	 fBNE8/dPdy20V+za2VdbCqfOE9Dq9a6MKUNCSs99wR0pziJSuU6jIL89Df4j8mVInb
	 luRTpuL2qYUpA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue
 <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 08/11] rust: io: add `read_val` and `write_val`
 function on I/O view
In-Reply-To: <20260421-io_projection-v2-8-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-8-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 14:53:39 +0200
Message-ID: <87o6j3p7os.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> When a view is narrowed to just a primitive, these functions provide a way
> to access them using the `IoCapable` trait. This is used to provide
> `io_read!` and `io_write!` macros, which are generalized version of current
> `dma_read!` and `dma_write!` macro (that works on `Coherent` only, but not
> subview of them, or other I/O backends).
>
> For DMA coherent objects, `IoCapable` is only implemented for atomically
> accessible primitives; this is because `read_volatile`/`write_volatile` can
> behave undesirably for aggregates; LLVM may turn them to multiple
> instructions to access parts and assemble, or could combine them to a
> single instruction.
>
> The ability to read/write aggregates (when atomicity is of no concern),
> could be implemented with copying primitives (e.g. memcpy_{from,to}io) in
> the future.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



