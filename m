Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A237AA75
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486392; cv=none; b=NoUKdatGdniN4PKie96ANysaGzG4maTlq93TZfexi4QDtGTg6G1Xax4nN8NvzzLN8yOsvEH7eQgY1K8nzxEQ8ffg4+gjqldOaLCUJaX7YGcUQCkopd/9hbYq4T0xt7gJb8RXFFj3hvMIR4JGb1hJndPDB7IDqlzB8DVE/08j648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486392; c=relaxed/simple;
	bh=XpkfcQWXKo8U5w986VkItPJuj6YTwiymiuWR2iEQmRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q1+2VItk/UomGnBgOdQ7NmZbhYyYkrVBZ8hDkpjkScWGD4Ts2YXoq3/xjhupgZ0U8bGzwi2EPjIxtMZQbdH1x60mVBlLLy7CFUcSMbjm9mdTEgvKDZc5vZHz6U1d9u6h2xFmlkaUCXseu8z9xwUM/X6LIHg6b0WofYji93UHRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDWpRwcS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDWpRwcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A111F00A3A;
	Fri, 26 Jun 2026 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486387;
	bh=nWdhka9vlxHskt8+WKq6JmVRC3RuOXuW2e3AQwKJTbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDWpRwcSSsnPL1I9mSjsGmZUrxnyEcNzjTiaJJR/QJz8kswphtz9J4FRolfT+tdIl
	 6oIMcv2x3DQIk0u8nW4LS+dH8lkZl/F319BQ2PigSyHuFnqFbS1Vg8tENU9f2Jsjre
	 LR/t7ENiZTYqAPcfWYjL9cvspKvgDN4pcWWNzWbmXQVU8dsLZadBz8shw+4GXDeR6A
	 HnK+aoHaqANJgzFFifSKFhZ/QSP8hyaliwe5OoM5W1WZJh/oYjovCikX1Uz4H5JkI2
	 QUAYGUMU/7uvYvvFgRMRd+FMSgzxHIhsJaJQTRNm4tQ14Wzt6KQ7nXq/4Lc4nE5Yvl
	 0SxWwJs+dAGkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:06:26 +0000
Message-Id: <20260626150627.30A111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data corruption in GSP command queue due to missing memory barrier=
 before updating the ring buffer write pointer.
--

commit abd2f0cd14180222d86d47f37c313be60a30d773
Author: Gary Guo <gary@garyguo.net>

gpu: nova-core: use I/O projection for cleaner encapsulation

This commit refactors the nova-core GSP driver to use the io_project!,
io_read!, and io_write! macros for memory-mapped I/O access. It replaces
the previous dma_read! and dma_write! usage to enforce better encapsulation
for PTE arrays and message queues.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs

[ ... ]

> @@ -438,12 +441,17 @@
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
This is a pre-existing issue, but is it possible that the memory barrier is
placed too late in this function?

In advance_cpu_write_ptr(), the fence(Ordering::SeqCst) is placed after
updating the ring buffer's write pointer via set_write_ptr(). Since the
payload is written to coherent memory using normal memory stores while the
write pointer uses a volatile store, weakly-ordered CPUs might reorder the
operations.

If the GSP firmware polls the write pointer before the payload writes are
globally visible, could it read uninitialized or stale data? Should the
fence be placed before the set_write_ptr() call to prevent this race?

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D17
