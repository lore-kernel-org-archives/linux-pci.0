Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891333A70A
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203663; cv=none; b=duIpJPuYabYGlD6ACYCF4mycdd2dQPhBg2bOCpQsRs6hrKJOn12K2+HvlFt8EeImFk53mS0d3uF6xf+dQuY+L5mJPBUs+QFhi3hVCW6W6v7tuzrs3MeZ9vf9wPnJD1MWKY/vtUZXh5AFNdrRFFJvbMNG16ZssITXDGHJZHuJiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203663; c=relaxed/simple;
	bh=QZ4HrL2y4SJ0FS//d/mgphRfKKRjwhqlraoiu9er43U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSexrrLU+0Mlg8Hti9oy+zGIO4XxcWorkfRVf1Dt1UIG4B/mPTXNmDabKqV4LWPtUVZIY+3hyxFO9opkwIFJRhEbpnsM0Zeju0fZBaNNmuT97eWOWFGCKBz3i5c3dTLTawhVa6g9QVWSGcPWZdVTckBh7rQxTPr1u44WNWDqMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmgI7Diz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmgI7Diz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5741F000E9;
	Thu, 11 Jun 2026 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781203661;
	bh=yt3hAr9r/nMVlzHLtZScfH+YnGipZSiAbT6zcn9kuvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmgI7DizdJOb/0RnJMc+Yb5MmCk/CPsK4KH8K/6On+bvrYRjkNgHIJ4oBoowg5lpX
	 TMscu0HDD/q3c75VO+OdnZBtPyHD+IYqXd8nqZaA6RdyuT4zAQKkmzpg4+4ntMCa5T
	 AhLv9JBDgDLuUL54LcTh8Su5mz+QBOCD+yZeC2Q9yd2JM63/HUKhaGpsuHT4h5SDjg
	 HxZCYOh352D1/sjufTg70byVCz3BtmhXNiQOxHFDyUfsRvxzEiUODM4E9J5JwSYS4e
	 B4Hk1U0KSEP1pPZ/K8NBCkqgRJ15o+IKGgJaljtLVkBYzd2Omrzu8ADBe4bKWLvEnw
	 iX6YmD7HgczAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-17-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-17-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:47:40 +0000
Message-Id: <20260611184741.5A5741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The memory barrier in `advance_cpu_write_ptr` is incorrectly place=
d after the write pointer update, potentially allowing the GSP to read stal=
e command data.
--

commit 6cc25fbdd45cd6420a6e1ed539f7745066511455
Author: Gary Guo <gary@garyguo.net>
Use io_project! for PTE array and message queues to restore the proper enca=
psulation.

This commit migrates the nova-core GSP driver to use the io_project!,
io_read!, and io_write! macros for accessing the PTE array and message queu=
es.
The previous dma_read! and dma_write! macros are replaced to properly
encapsulate IO memory operations on primitives.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 070de0731e95..c34b48961496 100644
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
This is a pre-existing issue, but is the memory barrier placed incorrectly
here?=20

Because fence(Ordering::SeqCst) happens after MsgqTxHeader::set_write_ptr()
updates the write pointer, could the CPU reorder the preceding command data
writes with the write pointer update itself?

If the updated write pointer becomes visible to the GSP before the actual
command data is fully written to memory, it seems the GSP might read
uninitialized or stale commands.=20

Should the fence be moved to immediately before set_write_ptr() to prevent
this reordering, similar to how the read pointer is handled in
advance_cpu_read_ptr()?

>      }
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D17
