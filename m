Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830C3CB8E6
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343243; cv=none; b=dWc+pq5ZsGYP/MIfFIoVBwpi2plg/HxeIGLq1oOqawe8bkNBr9S01YQs+8Cw4Txp73+6EXka36JoVX3QjYAkskFzIdqbmUdypEZaz99VKeBpNH70/Byk04JxxgYcd4kTeFTPZzBu0hxRYuj7U/ddy4WLui5sB8x3iU8vPP7zDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343243; c=relaxed/simple;
	bh=y3IPMqu/K8gDhMpUYuGbanalWyCko+XF0hlwCLaBACk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xgj+g0daXdWkkeursd9l7g5HQIx9ugUrfRppxE0aOgfUL87ttJzGoNRKi2veEqhn1a3TujQvWnbYoET3EayG/TKNgsUhgN2d6O+GSlLoNAY7frFlT8tiPVFsBldDgdJVO+phdYKGL1H/jZnQvPo0ativTLZgh5ghgSR8r61mSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRu5wm4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRu5wm4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9F11F00A3A;
	Mon,  6 Jul 2026 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343241;
	bh=/5gX+7WV1J0jIuXNz4HBAwXbYCmWbobXBpWvUfivXt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRu5wm4G+cxAwbiQgSNuSJFxw8Ns7C+OVML5hBcxxBBhNJxudHFoZr2G0niq2aW5C
	 /kqR73es2N0F378LaUZOGYWcF8tOUOSYV6wOfCd9fGOpnjTNZ1UG0G/e8GTaM2fEQ5
	 9aGMiwSwpj0Myz8DpPqdC73wIQCtAtT7cc0c0tpjYPxuYlAjByGkE53fwVeCWRAVl0
	 Nf8dFQIPs6ym8AeHq23orX90bwfmFX5KHx9YLGax0pKog9ZrCty4ye8PEPadkWXUd3
	 bHC/ju806LbfdBbg/gaIjNqvpSVIHJ7wWU+lw5SP30uxaV6dSHPZKXN6/WUgP6p5Ny
	 FtV3dzmPsorxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260706-io_projection-v6-17-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-17-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:07:21 +0000
Message-Id: <20260706130721.9F9F11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing acquire and release memory barriers in the lock-free ring =
buffer implementation between the CPU and GSP firmware.
--

commit 0033519811b496066fb6090d793690e7fd6d3d45
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: use I/O projection for cleaner encapsulation

This commit refactors PTE arrays and message queues to use io_project!.
It replaces primitive dma_read! and dma_write! usage with io_read!
and io_write! to restore proper encapsulation.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 070de0731e950..c34b489614962 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -438,12 +441,17 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32)=
 {
>      //
>      // - The returned value is within `0..MSGQ_NUM_PAGES`.
>      fn cpu_write_ptr(&self) -> u32 {
> -        super::fw::gsp_mem::cpu_write_ptr(&self.0)
> +        MsgqTxHeader::write_ptr(io_project!(self.0, .cpuq.tx)) % MSGQ_NU=
M_PAGES
>      }
> =20
>      // Informs the GSP that it can process `elem_count` new pages from t=
he command queue.
>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
> -        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
> +        let tx =3D io_project!(self.0, .cpuq.tx);
> +        let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count=
) % MSGQ_NUM_PAGES;
> +        MsgqTxHeader::set_write_ptr(tx, wptr);
> +
> +        // Ensure all command data is visible before triggering the GSP =
read.
> +        fence(Ordering::SeqCst);

[Severity: High]
This is a pre-existing issue, but does placing the fence after the write
pointer update fail to order the preceding command payload writes?

In advance_cpu_write_ptr() in drivers/gpu/nova-core/gsp/cmdq.rs, the driver
updates the TX pointer via io_write!() (inside set_write_ptr) and then issu=
es
a fence(Ordering::SeqCst).

Since io_write!() compiles to a plain write_volatile without an implicit
barrier, placing the fence after the pointer update could allow the
firmware to observe the updated write pointer before the command payload
is fully visible. This could lead to garbage command processing on
architectures with weak memory ordering.

Should this fence be placed before the set_write_ptr() call instead?

Additionally, looking at the wider lock-free ring buffer implementation, do
wait_for_msg() and allocate_command() lack acquire memory barriers?

If wait_for_msg() polls the GSP write pointer via read_volatile and proceeds
to read the payload without an acquire barrier, the CPU might speculatively
read the message payload before the pointer read completes.

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D17
