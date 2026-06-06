Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E237199385;
	Sat,  6 Jun 2026 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705303; cv=none; b=YM2rmKMLLnfFaEbteDepuYE1zg5yc8o1wZItS060PkoI6CNZahNqFuEoG+lsVrKliURcpPzBd1giKWVyzR2ukXUXEbpV5OczImfJmAuzN+fOurdFt5p9+YALWLM/agB8FQRHVujZhs7qdGTbqSmnY/c+O3sGBCd1kauaHFfSajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705303; c=relaxed/simple;
	bh=2xShmGbyxAa3UCWXsFMlMNxhk3+102YvjQi3o5v9Uis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8GT5E2jEnMLYRGg06RapWa4giaoq/VbAQh6fbXrd2iE1zaJXAmCVbQMYFIL+ieWREtQR5s7Qnh0lFCeFY2M4l7ST73i0HhStbAH+2qqW+rQquqksD7PkrXtvw4SjeIeLS8jZKbkfDpHiVPG9VNwadkwDE/7G6TmHJKTmVB2t0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyL/4bNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyL/4bNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388891F00893;
	Sat,  6 Jun 2026 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705302;
	bh=Bizv/m0QmIr+1azM1zbDWU9IX6nZH89yhXf3JjghzoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DyL/4bNOtLMScpULhzkA8LAkNXD7nIBDzer3kF4ZXFkX0MQWRy5kq6NBM76S4CdY+
	 m/g1lgwcVI02FIKKifNnL/77HLGlLctDLaTaHTBtJv1Y7VMQGwDTDgLaPIdsllbs7M
	 EyYOEQMbCtyrSloVYhQp1uqalTJO6On8a/WN/YaiEogfNxpKNt2q8tl6x9sdEA7wWN
	 BLHvhyXbu7Mz4qT4v46ZkBv+Z+Iai1vjDrxaL3nVh1ZViZ3sJfaF/fJmm1zHCCdpjz
	 wBnU27ICnJSKpDIHNF8auB05vD/oOIujRD8DLocnvA1xIhvgFfoMjuffAKbV1VDmIO
	 xUqAltB2lwDWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/23] dmaengine: sdxi: Add completion status block
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-17-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-17-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:21:41 +0000
Message-Id: <20260606002142.388891F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Misplaced dma_rmb() and missing READ_ONCE()/endian conversion in s=
dxi_completion_signaled() allow stale DMA data reads.
- [High] Race condition in sdxi_completion_poll() can cause false timeouts =
if the thread is preempted.
- [High] Freeing the completion block after a timeout without aborting the =
hardware allows the device to write to freed DMA memory.
--

commit 7e5654d9158f4ac258b9deab508138cef7d4089d
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add completion status block API

Introduce an API for managing completion status blocks. These are
DMA-coherent buffers that may be optionally attached to SDXI
descriptors to signal completion.

> diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
> new file mode 100644
> index 0000000000000..7ffd034b129b8
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.c
[ ... ]
> +int sdxi_completion_poll(const struct sdxi_completion *sc)
> +{
> +	unsigned long deadline =3D jiffies + msecs_to_jiffies(1000);
> +
> +	while (le64_to_cpu(READ_ONCE(sc->cst_blk->signal)) !=3D 0) {
> +		if (time_after(jiffies, deadline))
> +			return -ETIMEDOUT;

[Severity: High]
Could this return a false timeout if the thread is preempted?

If the executing thread checks that the signal is not 0, gets preempted,
and then resumes after the deadline, time_after() will evaluate to true
and the function will return -ETIMEDOUT. Would it be safer to do a final
check of the hardware signal after detecting a timeout to ensure the
device didn't complete the operation during the preemption window?

[Severity: High]
When this loop times out and returns -ETIMEDOUT, the caller's cleanup
guard will free the completion block. Because the hardware operation is
never explicitly aborted, could the device eventually finish the stalled
descriptor and write to the freed DMA address?

This might corrupt memory if the DMA buffer has already been reallocated
from the pool for another descriptor or structure.

> +		cpu_relax();
> +	}
> +
> +	return sdxi_completion_errored(sc) ? -EIO : 0;
> +}
> +
> +bool sdxi_completion_signaled(const struct sdxi_completion *sc)
> +{
> +	dma_rmb();
> +	return (sc->cst_blk->signal =3D=3D 0);

[Severity: High]
Should the read memory barrier be placed after the signal is successfully
verified as 0?

Executing dma_rmb() before checking the signal allows the CPU to
speculatively fetch payload memory before the DMA engine has finished
writing it.

Also, does reading sc->cst_blk->signal require READ_ONCE() and
le64_to_cpu() to prevent compiler optimization and endianness issues,
similar to how it is read in sdxi_completion_poll()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D17
