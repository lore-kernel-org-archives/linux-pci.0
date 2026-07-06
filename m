Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C743E8326
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343436; cv=none; b=tdpprYWCZzanzpfuxPC4zeb29HRokbw3nDabXHhjkeVJG+G+J6yMH5fCEblz5EIDCIRKeAYM2eN6a09OkPGaQ5CgFNw1DJd3cEbhzHySOYnddZwz8qz8AEYwlT/hcFwC82cCkqqmAeq+yJVFol+CuvvZOepWifpXcbUX6YGziiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343436; c=relaxed/simple;
	bh=L9P9VmFUCYYKzWGNUCoW2Ad6arjfF9eZeV9sH0/guf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3AF0CcvyPDf3DyesHZNcHwzqvR9H6YLDzBhHRO/Tj6p8fehzgzZevBEsgxmEsjYtOfhhn7azZZ+MZroOW1XeX25S2jSWApGTZjDZm/KV8Pf9fDX7xmuruO+S98F/DFHA56jvP9mfbq1BBUJDgxG4RwHKaL/355n3sFGpK1aE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMoRup3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMoRup3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175F51F000E9;
	Mon,  6 Jul 2026 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343434;
	bh=ZiL3sRyR05DrFAzCUBWTWf1OQLCDLTViJmJOMURuh/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMoRup3xLKnjwClZtz6qL3qOiGrW4zowH4wfI1qnBbv5Ft/k/PFPAxQRHYHGxc1dz
	 v7JoUgsZO8hnmIB6r1RA7p2ETk44ozpS83syVsntfpVPbG2V6fRUl452jCAcis2wLc
	 syhPInbp/SGglPhKzmyT4OT828ki8V7R3hGqqvYzUM5lZTlrv6pmyk9sYCKv0mrS2l
	 Ue3gy8skzTxWsosXPAeBjKp4t7PcI4VXiBkL21O4eH4X05gJaZqYh+GG6orZtk79sq
	 LuUeNbBE7u8R39Hu3AYOy6gwCSufVqcifw+tZLHVtGonW2AEUrqwU7TImuaVTX3Spm
	 sf96vfTX1XHjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/20] rust: dma: drop `dma_read!` and `dma_write!`
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260706-io_projection-v6-18-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-18-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:10:33 +0000
Message-Id: <20260706131034.175F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The memory barrier intended to order command data writes before th=
e doorbell ring is placed after the doorbell is updated, failing to prevent=
 the hardware from reading stale command data.
- [High] Missing read memory barrier after reading the GSP write pointer do=
orbell, which can cause the CPU to read stale message queue data due to spe=
culative execution or memory reordering.
--

commit 4f52030a2d0bed4fa2789f818006faedda8d1221
Author: Gary Guo <gary@garyguo.net>

rust: dma: drop dma_read! and dma_write! API

This patch removes the dma_read and dma_write APIs. It states that primitive
read and write use cases are now covered by the io_read and io_write macros,
and non-primitive cases should use CoherentBox or as_ref/as_mut to ensure
lack of concurrent access.

[ ... ]

> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -317,7 +317,7 @@
>      fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PA=
GE_SIZE]]) {
>          let tx =3D self.gsp_write_ptr();
>          let rx =3D self.cpu_read_ptr();
> =20
>          // Pointer to the first entry of the GSP message queue.
>          let data =3D ptr::project!(self.0.as_ptr(), .gspq.msgq.data[buil=
d: 0]);
> =20
>          let (tail_end, wrap_end) =3D if rx <=3D tx {

[Severity: High]
This isn't a bug introduced by this patch, but is a read memory barrier nee=
ded
after reading the GSP write pointer doorbell?

When polling the GSP write pointer via self.gsp_write_ptr(), there is no
intervening Acquire memory barrier (such as fence(Ordering::Acquire) or
dma_rmb()) before the buffer is accessed via slice creation.

On weakly-ordered memory models like ARM64, could the CPU speculatively pre=
fetch
the message data before the doorbell read completes or is validated, causin=
g the
driver to read stale message queue data?

>              // Read area is non-wrapping and stops right before tx.
>              (tx, 0)

[ ... ]

> @@ -448,7 +448,7 @@
>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
>          let tx =3D io_project!(self.0, .cpuq.tx);
>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count=
) % MSGQ_NUM_PAGES;
>          MsgqTxHeader::set_write_ptr(tx, wptr);
> =20
>          // Ensure all command data is visible before triggering the GSP =
read.
>          fence(Ordering::SeqCst);

[Severity: High]
This is a pre-existing issue, but is the memory barrier placed correctly he=
re?

The fence is placed after the volatile write to the doorbell
(MsgqTxHeader::set_write_ptr). Without a barrier before the doorbell write,
couldn't the CPU or compiler reorder the doorbell volatile write to become
globally visible before the preceding command data writes?

If so, could the GSP observe the updated doorbell and process the command b=
efore
the payload is actually flushed to memory, leading to the hardware reading =
stale
command data?

>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D18
