Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93F70830
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979052; cv=none; b=lXRY1I5LSg4dgYmdBfrT2Nocus9h7f1k7ulX/hhfCkiKrCCIJxMSHsGqxLMkk/9o1i6wJ6a7E1Aw8noq1tjSLofFRhVxvdXDa0cDcttB2vkdVQbjQXRqtrbg1oDHtJ63pOsBOQb9vTbKsbKVDqx2s9GsoWPBmMtdVrOONMQLy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979052; c=relaxed/simple;
	bh=xjLGZtNRXyrMgvECd+wfmTybTmFTbeJdKC9lYetOFgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfWCUi6DVmwcidzka9rC1P7jbIF81VIaP+G5y4OH6782AYXKysrNKNgYTXfZFFELE+vCBZASQGQHV/nmm66qFT2QLEN5ZC7hFJTWNJf/Tc6HgbFeX7K+P3mp7+vh9UoHWb9jWAc1aaiKmUjC+Z5C+R/4164lU0PbrYYs2XjtbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtW8ZD4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtW8ZD4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C78C19425;
	Sun, 17 May 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778979052;
	bh=xjLGZtNRXyrMgvECd+wfmTybTmFTbeJdKC9lYetOFgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HtW8ZD4X9GXrlcwrz6FAFIpmh/0ZZO+0vMGBcEGKVLTCY9oWLrzTAIPtVJ2GTLCQr
	 wiwzNGhzzK45aBZhVQzV/mEqm3Kx3ezR82XOkxNiDm9EZVeCnNcwqcvTXyDicEmICS
	 AGmH698YW7HhavDILfmiMZIangGM68lP6drGTF/KvM0vDXfL4lrlxh8lv3yDGnQK1n
	 iDR/BmJ+tx3yyTO6GoOLh78kZNxUP3GpCkwErc+KFCHP+2yoGhc9At7CjEQb/it73B
	 LvpL62N7dMJpkM+UK1E6Wp+MsOia4QxvVs9sLqSJ1kofxJxRpHP+Hm6AK4pSU+B89r
	 oMpvTFAUmngAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v3 25/27] gpu: nova-core: unregister sysmem flush
 page from Drop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-26-dakr@kernel.org>
References: <20260517000149.3226762-26-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:50:51 +0000
Message-Id: <20260517005051.E0C78C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware Teardown Order Inversion due to Rust struct drop order
- [High] PCIe Posted Write Race leading to potential DMA Use-After-Free
--

commit 1e4442de0219b840e2a05e974e6828767c51d68c
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: unregister sysmem flush page from Drop

This commit automatically unregisters the sysmem flush page by
implementing the Drop trait for SysmemFlush and storing a bound
reference. This removes the need for manual unregister calls and the
Gpu unbind method.

Link: https://lore.kernel.org/all/20260409-fix-systemflush-v1-1-a1d6c968f17=
c@nvidia.com/

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index bdd5eed760e17..a707fbfe3ced4 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs

[ ... ]

> @@ -70,19 +69,18 @@ pub(crate) fn register(
>          Ok(Self {
>              chipset,
>              device: dev.into(),
> +            bar,
>              page,
>          })
>      }
> +}
> =20
> -    /// Unregister the managed sysmem flush page.
> -    ///
> -    /// In order to gracefully tear down the GPU, users must make sure t=
o call this method before
> -    /// dropping the object.
> -    pub(crate) fn unregister(&self, bar: &Bar0) {
> +impl Drop for SysmemFlush<'_> {
> +    fn drop(&mut self) {
>          let hal =3D hal::fb_hal(self.chipset);
> =20
> -        if hal.read_sysmem_flush_page(bar) =3D=3D self.page.dma_handle()=
 {
> -            let _ =3D hal.write_sysmem_flush_page(bar, 0).inspect_err(|e=
| {
> +        if hal.read_sysmem_flush_page(self.bar) =3D=3D self.page.dma_han=
dle() {
> +            let _ =3D hal.write_sysmem_flush_page(self.bar, 0).inspect_e=
rr(|e| {

Could this lead to a race condition with the PCIe bus?

PCIe MMIO writes are posted, so the write to 0 might be buffered in the
PCIe root complex and not immediately reach the GPU. Because the Drop
implementation finishes right after the write, the page field will drop and
free the underlying DMA memory.

Is it possible the GPU could attempt to write to the freed sysmem flush page
before the MMIO write actually reaches the hardware? Would adding a register
read-back here help flush the posted write before the memory gets freed?

>                  dev_warn!(
>                      &self.device,
>                      "failed to unregister sysmem flush page: {:?}\n",

[ ... ]

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 03295fa6fb321..c17d068b35eb4 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -228,7 +228,7 @@ pub(crate) struct Gpu<'bound> {
>      bar: &'bound Bar0,
>      /// System memory page required for flushing all pending GPU-side me=
mory writes done through
>      /// PCIE into system memory, via sysmembar (A GPU-initiated HW memor=
y-barrier operation).
> -    sysmem_flush: SysmemFlush,
> +    sysmem_flush: SysmemFlush<'bound>,
>      /// GSP falcon instance, used for GSP boot up and cleanup.
>      gsp_falcon: Falcon<GspFalcon>,
>      /// SEC2 falcon instance, used for GSP boot up and cleanup.

With the explicit unbind call removed, the code now relies entirely on Rust=
's
drop semantics for cleanup.

Since Rust drops struct fields in declaration order (top-to-bottom),
sysmem_flush will be dropped before gsp_falcon, sec2_falcon, and gsp.

If any of these subsequent components perform hardware teardown or memory
flushes in their Drop implementations, could they attempt to use the sysmem
flush page after it has been unregistered and freed?

Does sysmem_flush need to be placed at the end of the Gpu struct to ensure
correct first-in-last-out teardown ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D25
