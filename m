Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9D199385;
	Sat,  6 Jun 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705498; cv=none; b=DTcw5DueFPouBkgLXAsmC2zLhNlt05N3kcptey7I3RJYsWiieHfN3uwnUmtuXQzwLWj/i5/71mhYndQuGslk+rWL1/bOnFdtfCXFtt0jS8nzcFPEdF19X8JG41OIIaQa3ISfzcGcJgF9Yw6a6rJEUDYTeE6LxTpv3blBmw9ID9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705498; c=relaxed/simple;
	bh=85a+ZMOLVUDMgdb5VnDtIHQOh00au+drbiqXiadO2+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ieAVzsPGJCxnmXEwFwNZPbxuz7OyLiw/8IL63v5DlQunszzb1kYoymZfYKOS/NUkxNEzYdteriTElCHyTrlJgQ0ivbu0YLenog90j4BF+CavRmnMN/ZtnYLTSrcm0ivk37RS8mCzg0TwIKc+/pesEwbf8jpUitwVlx3E3L/Pgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWklmAKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWklmAKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5533A1F00893;
	Sat,  6 Jun 2026 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705496;
	bh=WiSEczeLurMKUEyGluvk+DuVbxIXyIC5eryA1lsi29o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWklmAKNs8BhWlRgi/ReAJ7Or8JpcCCqgxGJpFh604Cs1AGU0XOl6X2SDpfNlj+wS
	 Cg31hBRgFp0OW2IRCfkiZHE6FJm8yYQHMdp/LfHll/KO+F8X88YwhuEifRNII05D7z
	 yT1mvycc637BEy55sO4aghTqVH14MV0Mu9ePjrII5ZRkMUnCtwtJ8j8LPvgyH1zHgz
	 KJwaE4bxRqDQwW/DSnyIKOwUnI+wZFm0aYmhCSuMGZYm93gLo9nJdMAc7FJOhtY+J3
	 FRRRwTcwNikprRLUJUcISuvTzXcZBsCBtc4oq82O9UKnVm9sbibHARjwqijSdhuROs
	 eiNKaL+2+T9gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/23] dmaengine: sdxi: Attach descriptor ring state
 to contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-14-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-14-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:24:55 +0000
Message-Id: <20260606002456.5533A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Driver teardown frees descriptor ring state while threads may be w=
aiting, causing a use-after-free.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but hardware stalls =
lead to permanent D-state hangs in `sdxi_ring_reserve`.
--

commit 7d20c79380e3ebc097f2724f0a53221cb5571730
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Attach descriptor ring state to contexts

This commit allocates and attaches a sdxi_ring_state structure to each
sdxi_cxt upon context allocation. The ring state's lifetime is tied to
the context and is freed upon context release.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 2f9a29df5d9ce..907547ac450f2 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
[ ... ]
> @@ -63,6 +64,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  		dma_free_coherent(sdxi->dev, sq->ring_size,
>  				  sq->desc_ring, sq->ring_dma);
>  	kfree(cxt->sq);
> +	kfree(cxt->ring_state);

[Severity: High]
Does this free cause a use-after-free if threads are still waiting in
sdxi_ring_reserve()?

During teardown, contexts may be forcefully exited without stopping DMA
channels or ensuring active users have left. If sdxi_unregister() calls
sdxi_cxt_exit() -> sdxi_free_cxt(), the ring_state struct is freed.

Threads blocked in sdxi_ring_reserve() rely on the wait queue head and lock
inside this freed allocation:

drivers/dma/sdxi/ring.c:sdxi_ring_reserve() {
    wait_event(rs->wqh,
               (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
}

When a sleeping task is spuriously woken up, it could dereference the freed
rs pointer, leading to memory corruption.

[Severity: High]
This is a pre-existing issue, but can hardware stalls lead to permanent
D-state hangs here?

Looking at sdxi_ring_reserve(), the uninterruptible wait_event() lacks
a timeout and ignores signals:

drivers/dma/sdxi/ring.c:sdxi_ring_reserve() {
    wait_event(rs->wqh,
               (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
}

If the hardware encounters a fatal error and stops processing descriptors, =
it
will never increment the read index. Any process attempting to submit a com=
mand
will sleep indefinitely.

>  	kfree(cxt);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D14
