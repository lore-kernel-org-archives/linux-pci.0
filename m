Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795576781;
	b=KW+v1I8UKo0ZnIkcMuUaV/adEupKYJaRDvF6fq53hdT5dc6fRNdzVNwfT5v0mB9S8ykF
	 IiwASU3A0ZnXJz5XmqvDpG1W/Xs4DJOPeVqF59zHDpoom7oRXJVR3y22gWr24C8to6W0t
	 g1mPEmR5fwkhlj2UdZi+HQojZ9P7gheb4aZbFUemcQ9u82F76GvblIrBJCeD0raXkHKOV
	 VNR1g5RuwcyDzODsIHrOWaUs8XTlTpN1cmS/Qn1/M85BWj78c08V6qe+RUN9vWLR35qxy
	 yMDlEOhvKKiX9EVk0eCED8cJyUyPUOEAF3+vlfRisTpjjU3CBTcCos1HhCeWBavV8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QA42/MGC/qfAtcbkUefOhbZmxkkSDqKdz1XMuKUF34U=;
	b=IN+PF6J6dEWAES8HuRn7jN5pou11nEa9g+HsR7ZbUXaxfCco+lwSdVHZuYRW9R45Aq7y
	 yGuGIE2BToWRdZ+brtEko7PX3Hl6L+jOKQzosSrFsz7fJ3UWQElKP26bbmBR6jU42pj1G
	 nGlbjxg6SGvRAFvYTEqVRmOxkxhujwoXxkl3cFa0hvfcI5tSsidICyubI8BrW6MdbogLH
	 xiU+cuP+ULEnw5NHZwZF9J18/ieOZrMJY1V4BDjDueeV/G9kkt0qEMgvWEaD+ISFEsZUa
	 S747f78I0udEcWHXFHPmpgYOA+gHEyR5j1zpEfGb6ZHMmfRF7JRJdfnJBpHMLhVPg7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=k2NnDf+M;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4lWxq8YI;
	arc=none smtp.remote-ip=103.168.172.136
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DF606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 03:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D8DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=k2NnDf+M;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4lWxq8YI
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 188D8138048E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:19:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Nov 2026 22:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795576778;
	 x=1795583978; bh=QA42/MGC/qfAtcbkUefOhbZmxkkSDqKdz1XMuKUF34U=; b=
	k2NnDf+MWKXvRdEQHMV4RgHxrHw/A8Qwr9xF2hsBw/NVWsLcJ7IZ1ROsU7yM3Dt6
	kpu+2Vx5Z0lwQBRk98q9FG6bcORrjZCYr2y0o5Z68epD+XwDkNh0wSwJe8cHlIee
	0GiiadLG4odJcrkGJwpQFcza7wkYgs+AED5NtqHH9tJx0absVL0UBMhJO7vOpJTt
	gWDCGVar24xhoNdfsQQp9FmJpN3zmqaVKTsJdgYzP8as+JOwQ69J9Gz9G4Cvznoq
	xYs4osa1m9SLH3KvR4jht7KZqKj7qfA0PpI+HRqhtmG//gQJEzQc+hdL/AOrsxE2
	Wl+VBOOylI8Q3L1iLY66KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795576778; x=
	1795583978; bh=QA42/MGC/qfAtcbkUefOhbZmxkkSDqKdz1XMuKUF34U=; b=4
	lWxq8YIMOYT6f2LCfxSOm9embOz2tc32jz2p0k0xEIMh+99rGSsPjij4HwISspeX
	4ieetjVEUQb4ZnOvlt67CvjYtPchNeUTgBumbJhtXetbS+WhwkMCPCm+eD9QSdh/
	VakZ6pNtZSz7a1DUgxOBnlu0+D2yLKM/l0UNbfBekQG1i7WbmWQuJNiVgHCxtjnJ
	6mfJdVTxq6LrTuviZqisUW5TIWg7VDAkTvEyheg8myslRDd7dOH1AFmuGhp9psrH
	ne7Gdl/dOhhK1jCeU6rOf0N/czXequFnKSN3mX+gtdTC24FRp4cSw+6YGPni2d+9
	M9/g1AjnYUgYZvptmFjXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795576778; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OYd4E2BaC2ZYdlaFOZtEXUbH06rpBGL37wisP6p1hh6594S
	s8lNPOQTBqe2wi7/ZQ0XkPETbURNm3Vbu9T0FbRnINee4Wt+AsbHYkfFqWQG0g4d
	qRfqWAINTA335OS2nnkFW2ZduEUas6vSfNyILgHCPpv78wOQ3E1m/NW1Bcvm7BMa
	oWvdjE7wb5d75gKaNEP6C8OoUhKzoR53LX/Z1Fg5DRrhIxPUzumi1TIdQJXpYbtB
	TOc1x1ZnAvVG+Q+ZrYid2k7dWZ9qu9GDdFvyh5i+6AZXg9ktEMGHcSk9LXlyZkEm
	I78p8NxH/YvLU9hGhv/QJfsYEsBDgOAujYIxt/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1K/A5LqZKn0D9oabFkZ5mF6MiE3iHa/yzET0b2D4bfE=:ZeJEyzysbLsHy2+BjO+KAXvIheHBIQhnqmM7ug6KOeI=;
X-ME-Sender: <xms:yVMGa84ADWUtVb_OhH_9Dd6djasiryq48ASfPte1yXi9Ka-ykEyXVg>
    <xme:yVMGazsD0UbjF-5qD0w7e1DSKwFemWOre9Ahb7wEubwaJmfyuPpdsIut-MUQXcOtq
    AcKTfXfr_J5WOZfk2oQTrSPsV2u9K0VbgOBbJDA5kjOjnd4fd5NTQ>
X-ME-Received: <xmr:yVMGa9h3uzksYtuA6ihhrPh7nes-j0BVLoXhnnC987IqRQlIM8IeZqBG8fvyFA>
X-ME-Proxy-Cause: dmFkZTF8lu5+zG7Jo2jGhdRZ5gRlMGh70lfhZJ+H7bdRUglZgDPpsO5yEspOOt7mwmT8Zc
    /Sf4UbW2L7ZAxHA7L3DWkyFKSrT0QiOVvOh9yR9bFRv1J7DcUAyX0jnRI1N2secWcmG5Xr
    /pdao9JuYuFnxa5WmmNSuZO3eThvNXhCD+ZcF5exeV6IFYAZARKE0G3XV0WDQh5uOnsDVg
    0aiWm8zbHcxwjF2/NoixTWWXPL4g986Xcz0KBY4WB5PmB1d7TL6e3nyXFJPsuti2TJY/hj
    y8GgKZdkjEyOaeaEqmWqLPVO7bP7YoEaHyQHwWrbXhveTeLLEba3LUMWoefFvxi6JETfII
    8vNlcKr+FFotPs/G9qBAldO5H9/DOAgcFuJoVsfUpnpWl8M73zn7E9Y5dPho199Pl9YH+0
    5I4g9optEHm4z2RllRflYtttx7WasRGbAoRVwcwP1GSmJd+6SbzPCwAY6cBJzLoiaM+kge
    iq/dtNUOj9Uh2mLE+CxEJEPz82CijrCDaPEdwHadiDc99syl57kfgomDeU+6lmlr4vBeDT
    U1QgLpWn46F7/VtGdaj+ReUcUXGdQ37BT50xSdIlW2q6py5hwA7CTOrkmjz4/klt1M4nBs
    znapuDWFdrsV3MRdo5mm60ZbOqpTOqjRxv369ZbrSEIEd3UZ+bHnd7kJq07A
X-ME-Proxy: <xmx:yVMGa5stP8B_NbLAFAG8YkV2_nmWHrMqXHUZngNmP3k_SXzqeMgCrg>
    <xmx:yVMGa_S8cXWwInax9qikeMPabLmB9M7wUEO7uPKcW6cnu8GqZvlmNA>
    <xmx:yVMGaw8xysKAfpAmZ4t-ZiIl4Nk8-ah1IuEWjEexpRJ_6PsJxqGV1Q>
    <xmx:yVMGa-XGnQAPDGcBfe7CzbMjvnDMymBtsnPFjEi22fsfNC1-9rSFFg>
    <xmx:ylMGa5u8NvhNAIxpYHDn4uVMfHOku5VhLwob3cPXSIOfTAF63MlNZzYG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:19:34 -0500 (EST)
Date: Tue, 24 Nov 2026 20:19:31 -0700
From: Alex Williamson <alex@shazbot.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, alex@shazbot.org
Subject: Re: [PATCH v3 9/9] vfio/nova-vgpu: add the Rust VFIO variant driver
Message-ID: <20261124201931.55c65263@shazbot.org>
In-Reply-To: <20261119215046.2892839-10-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
	<20261119215046.2892839-10-xinmengs@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 13:50:44 -0800
Simon Song <xinmengs@nvidia.com> wrote:

> From: Danilo Krummrich <dakr@kernel.org>
> 
> NVIDIA vGPU VFs need nova-core to manage their instances when assigned
> to userspace through VFIO.
> 
> Add a Rust VFIO PCI variant driver that uses the typed SR-IOV PF APIs
> to create an instance on first open and close it on last close. Expose
> the assigned device and subsystem IDs, enforce the assigned BAR1
> aperture, and reset the active vGPU instance on PCI reset.
> 
> Match NVIDIA devices through a VFIO override-only entry. Devices
> without an available Nova vGPU interface use ordinary PCI passthrough.
> 
> Register the VFIO device from probe and keep the Registration in the
> PCI driver data, so that unbind unregisters it. Extend the GPU build
> rules to make nova-core crate metadata available to the VFIO driver and
> export the Rust symbols it references.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  drivers/gpu/Makefile                    |  15 +-
>  drivers/vfio/pci/Kconfig                |   2 +
>  drivers/vfio/pci/Makefile               |   2 +
>  drivers/vfio/pci/nova-vgpu/Kconfig      |  20 ++
>  drivers/vfio/pci/nova-vgpu/Makefile     |   3 +
>  drivers/vfio/pci/nova-vgpu/nova_vgpu.rs | 375 ++++++++++++++++++++++++
>  6 files changed, 414 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/vfio/pci/nova-vgpu/Kconfig
>  create mode 100644 drivers/vfio/pci/nova-vgpu/Makefile
>  create mode 100644 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
> 
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index e372fc02139f..5fd610a172ad 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -19,8 +19,9 @@ nova-core-y := nova-core/nova_core.o nova-core/nova_core_exports.o
>  obj-$(CONFIG_DRM_NOVA) += nova-drm.o
>  nova-drm-y := drm/nova/nova.o
>  
> -# Export Rust symbols from nova-core only if nova-drm actually references them.
> -nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o)
> +# Export Rust symbols from nova-core only if dependent modules reference them.
> +nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o) \
> +	$(if $(CONFIG_NOVA_VGPU_VFIO_PCI),$(obj)/../vfio/pci/nova-vgpu/nova_vgpu.o)
>  
>  rust_needed_exports = \
>  	{ $(if $(strip $(2)),$(NM) -u $(2);,) echo "__DEFINED_RUST_SYMBOLS__"; \
> @@ -57,10 +58,18 @@ $(obj)/nova-core/nova_core_exports.o: private cmd_gensymtypes_c = \
>  		$(obj)/nova-core/nova_core.o
>  endif
>  
> -# Output nova-core's crate metadata for use by nova-drm at compile time.
> +# Output nova-core's crate metadata for its Rust consumers at compile time.
>  RUSTFLAGS_nova-core/nova_core.o += \
>  	--emit=metadata=$(objtree)/$(obj)/nova-core/libnova_core.rmeta
>  
>  # Allow nova-drm to import nova-core's types.
>  $(obj)/drm/nova/nova.o: $(obj)/nova-core/nova_core.o
>  RUSTFLAGS_drm/nova/nova.o := -L $(objtree)/$(obj)/nova-core --extern nova_core
> +
> +# Build the NVIDIA VFIO driver here so metadata and generated exports share
> +# the same dependency graph as nova-drm.
> +obj-$(CONFIG_NOVA_VGPU_VFIO_PCI) += nova-vgpu-vfio-pci.o
> +nova-vgpu-vfio-pci-y := ../vfio/pci/nova-vgpu/nova_vgpu.o
> +
> +$(obj)/../vfio/pci/nova-vgpu/nova_vgpu.o: $(obj)/nova-core/nova_core.o
> +RUSTFLAGS_../vfio/pci/nova-vgpu/nova_vgpu.o := -L $(objtree)/$(obj)/nova-core --extern nova_core
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185e..dd9b755262a4 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
>  
>  source "drivers/vfio/pci/xe/Kconfig"
>  
> +source "drivers/vfio/pci/nova-vgpu/Kconfig"
> +
>  endmenu
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 6138f1bf241d..1d9fb11eb3c2 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
>  obj-$(CONFIG_QAT_VFIO_PCI) += qat/
>  
>  obj-$(CONFIG_XE_VFIO_PCI) += xe/
> +
> +# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
> diff --git a/drivers/vfio/pci/nova-vgpu/Kconfig b/drivers/vfio/pci/nova-vgpu/Kconfig
> new file mode 100644
> index 000000000000..228f6ebc108c
> --- /dev/null
> +++ b/drivers/vfio/pci/nova-vgpu/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NOVA_VGPU_VFIO_PCI
> +	tristate "VFIO support for the NVIDIA vGPU"
> +	depends on NOVA_CORE && PCI_IOV && RUST
> +	select VFIO_PCI_CORE
> +	help
> +	  This option enables VFIO (Virtual Function I/O) support for
> +	  NVIDIA virtual GPUs (vGPU). It allows the assignment of a virtual
> +	  GPU instance to userspace applications via VFIO, typically used
> +	  with hypervisors such as KVM and device emulators like QEMU.
> +
> +	  Devices without an available Nova vGPU interface use ordinary PCI
> +	  passthrough. Both paths use the VFIO PCI core defaults; vfio-pci
> +	  module options do not apply.
> +
> +	  The NVIDIA vGPU allows a physical GPU to be partitioned into
> +	  multiple virtual GPUs, each of which can be passed to a virtual
> +	  machine as a PCI device using the standard VFIO infrastructure.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/pci/nova-vgpu/Makefile b/drivers/vfio/pci/nova-vgpu/Makefile
> new file mode 100644
> index 000000000000..0875c782602e
> --- /dev/null
> +++ b/drivers/vfio/pci/nova-vgpu/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
> +# nova_vgpu.o (rust-analyzer marker - DO NOT REMOVE).
> diff --git a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
> new file mode 100644
> index 000000000000..20553b7b4e2e
> --- /dev/null
> +++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +//! NVIDIA vGPU VFIO variant driver.
> +//!
> +//! Nova VFs own an instance between the first VFIO open and last close. Other
> +//! matching devices use ordinary PCI passthrough.
> +
> +use kernel::{
> +    bindings,
> +    device::{
> +        Bound,
> +        Core, //
> +    },
> +    io::resource::Flags,
> +    pci,
> +    prelude::*,
> +    sync::{
> +        CondVar,
> +        Mutex,
> +        MutexGuard, //
> +    },
> +    vfio::{
> +        self,
> +        pci::{
> +            GetRegionInfo,
> +            Ioctl,
> +            Mapping,
> +            Mmap,
> +            Open,
> +            Position,
> +            Read,
> +            Write, //
> +        }, //
> +    }, //
> +};
> +use nova_core::{
> +    NovaCoreVfApi,
> +    NovaCoreVfApiHandle,
> +    VgpuInstance, //
> +};
> +
> +struct NovaVgpuOps;
> +
> +struct VgpuRegistration<'a> {
> +    api: NovaCoreVfApiHandle<'a>,
> +    gfid: u32,
> +}
> +
> +#[derive(Default)]
> +struct InstanceState {
> +    active: bool,
> +    resetting: bool,
> +    reset_error: Option<Error>,
> +}
> +
> +#[pin_data]
> +struct NovaVgpuRegData<'a> {
> +    pdev: &'a pci::Device<Bound>,
> +    vgpu: Option<VgpuRegistration<'a>>,
> +    fb_bar: u32,
> +    #[pin]
> +    state: Mutex<InstanceState>,
> +    #[pin]
> +    reset_done: CondVar,
> +}
> +
> +impl NovaVgpuRegData<'_> {
> +    fn lock_instance(&self) -> MutexGuard<'_, InstanceState> {
> +        let mut state = self.state.lock();
> +        while state.resetting {
> +            self.reset_done.wait(&mut state);
> +        }
> +        state
> +    }
> +}
> +
> +struct NovaVgpuOpenData<'a, 'data> {
> +    registration: &'a NovaVgpuRegData<'data>,
> +    instance: Option<VgpuInstance<'data>>,
> +}
> +
> +impl<'a, 'data> NovaVgpuOpenData<'a, 'data> {
> +    fn new(
> +        dev: &vfio::pci::Device<NovaVgpuOps, Open>,
> +        rd: &'a NovaVgpuRegData<'data>,
> +    ) -> Result<Self> {
> +        let mut state = rd.lock_instance();
> +        let instance = match &rd.vgpu {
> +            Some(vgpu) => {
> +                // The firmware DBDF format has a 16-bit PCI segment field.
> +                let segment = u16::try_from(rd.pdev.domain_nr()).map_err(|_| EOVERFLOW)?;
> +                let dbdf = (u32::from(segment) << 16) | u32::from(rd.pdev.dev_id());
> +                let vm_pid = kernel::current!().tgid().try_into()?;
> +                let instance = vgpu.api.open(vgpu.gfid, dbdf, vm_pid)?;
> +                let info = instance.type_info();
> +                dev.set_device_id(info.pci_dev_id as u16);
> +                state.active = true;
> +                state.reset_error = None;
> +                Some(instance)
> +            }
> +            None => None,
> +        };
> +        Ok(Self {
> +            registration: rd,
> +            instance,
> +        })
> +    }
> +
> +    fn bar1_size(&self) -> Result<Option<u64>> {
> +        let Some(instance) = &self.instance else {
> +            return Ok(None);
> +        };
> +        let physical = self
> +            .registration
> +            .pdev
> +            .resource_len(self.registration.fb_bar)?;
> +        let size = instance
> +            .type_info()
> +            .bar1_length
> +            .checked_mul(1 << 20)
> +            .ok_or(EOVERFLOW)?;
> +        Ok(Some(if size == 0 {
> +            physical
> +        } else {
> +            size.min(physical)
> +        }))
> +    }

Does this provide a power-of-two size?

> +
> +    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
> +        if buf.is_empty() || position.region_index() != self.registration.fb_bar {
> +            return Ok(());
> +        }
> +        if let Some(size) = self.bar1_size()? {
> +            let offset = position.region_offset();
> +            if offset >= size {
> +                return Err(EINVAL);
> +            }
> +            if size - offset < buf.len() as u64 {
> +                buf.truncate((size - offset) as usize);
> +            }
> +        }
> +        Ok(())
> +    }
> +}
> +
> +impl Drop for NovaVgpuOpenData<'_, '_> {
> +    fn drop(&mut self) {
> +        let mut state = self.registration.lock_instance();
> +        state.active = false;
> +        drop(self.instance.take());
> +    }
> +}
> +
> +impl vfio::pci::Operations for NovaVgpuOps {
> +    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
> +    type RegistrationData<'a> = NovaVgpuRegData<'a>;
> +    type OpenData<'a, 'data: 'a> = NovaVgpuOpenData<'a, 'data>;
> +
> +    fn open_device<'a, 'data: 'a>(
> +        dev: &'a vfio::pci::Device<Self, Open>,
> +        rd: &'a NovaVgpuRegData<'data>,
> +    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a {
> +        NovaVgpuOpenData::new(dev, rd)
> +    }
> +
> +    fn ioctl<'data>(
> +        dev: &vfio::pci::Device<Self, Ioctl>,
> +        rd: &NovaVgpuRegData<'data>,
> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        cmd: u32,
> +        arg: usize,
> +    ) -> Result<isize> {
> +        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
> +        if reset {
> +            if let Some(error) = rd.state.lock().reset_error {
> +                return Err(error);
> +            }

Is a previous reset error effectively unrecoverable?

vGPUs are VFs, why are we intercepting hot-reset?  That's a different
class of reset that VFs don't support (unless we're running on s390).

> +        }
> +        let result = dev.core_ioctl(cmd, arg)?;
> +        if reset {
> +            if let Some(error) = rd.state.lock().reset_error {
> +                return Err(error);
> +            }
> +        }
> +        Ok(result)
> +    }
> +
> +    fn read<'data>(
> +        dev: &vfio::pci::Device<Self, Read>,
> +        _rd: &NovaVgpuRegData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        buf: &mut vfio::UserBuf,
> +        position: &mut Position<'_>,
> +    ) -> Result<isize> {
> +        if let Some(instance) = &open_data.instance {
> +            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
> +                let offset = position.region_offset();
> +                return position.with_temporary(|next| {
> +                    let count = dev.core_read(buf, next)?;
> +                    buf.write_overlapping(
> +                        offset,
> +                        count.try_into()?,
> +                        u64::from(bindings::PCI_SUBSYSTEM_ID),
> +                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
> +                    )?;
> +                    Ok(count)
> +                });
> +            }
> +        }
> +        open_data.limit_bar1(buf, position)?;
> +        dev.core_read(buf, position)
> +    }

Why do we virtualize the subsystem ID on read and the device ID on open?

> +
> +    fn write<'data>(
> +        dev: &vfio::pci::Device<Self, Write>,
> +        _rd: &NovaVgpuRegData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        buf: &mut vfio::UserBuf,
> +        position: &mut Position<'_>,
> +    ) -> Result<isize> {
> +        open_data.limit_bar1(buf, position)?;
> +        dev.core_write(buf, position)
> +    }
> +
> +    fn mmap<'data>(
> +        dev: &vfio::pci::Device<Self, Mmap>,
> +        rd: &NovaVgpuRegData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        mapping: &mut Mapping<'_>,
> +    ) -> Result {
> +        if mapping.region_index() == rd.fb_bar {
> +            if let Some(size) = open_data.bar1_size()? {
> +                if mapping.region_end()? > size {
> +                    return Err(EINVAL);
> +                }
> +            }
> +        }
> +        dev.core_mmap(mapping)
> +    }
> +
> +    fn get_region_info<'data>(
> +        dev: &vfio::pci::Device<Self, GetRegionInfo>,
> +        rd: &NovaVgpuRegData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        info: &mut bindings::vfio_region_info,
> +        caps: &mut vfio::InfoCap<'_>,
> +    ) -> Result {
> +        dev.core_get_region_info(info, caps)?;
> +        if info.index == rd.fb_bar && info.size != 0 {
> +            if let Some(size) = open_data.bar1_size()? {
> +                info.size = info.size.min(size);
> +            }
> +        }
> +        Ok(())
> +    }

BAR sizing in config space also needs to reflect the virtualized BAR
size.

> +
> +    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
> +        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
> +        // close release this mutex before entering the VFIO core.
> +        let mut state = rd.state.lock();
> +        state.resetting = true;
> +        if state.active {
> +            if let Some(vgpu) = &rd.vgpu {
> +                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
> +                    state.reset_error.get_or_insert(error);
> +                }
> +            }
> +        }
> +    }

This seems very wrong, why are we calling the PF driver reset in
reset_prepare()?  Isn't there still an FLR happening between prepare
and done?  Does it do anything?

> +
> +    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
> +        let mut state = rd.state.lock();
> +        let error = state.reset_error;
> +        state.resetting = false;
> +        rd.reset_done.notify_all();
> +        error.map_or(Ok(()), Err)
> +    }
> +}
> +
> +struct NovaVgpuDriver;
> +
> +kernel::pci_device_table!(
> +    PCI_TABLE,
> +    <NovaVgpuDriver as pci::Driver>::IdInfo,
> +    [(
> +        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
> +        (),
> +    ),]
> +);

Whoah, this would break a ton of users that are assigning NVIDIA devices
and depend on the module options supported by vfio-pci (that aren't
supported here).  This entry marks this driver as the preferred over
the vfio-pci driver for any NVIDIA vendor ID device.  We don't want
that blast radius.

This should list the specific VF device IDs we want to claim?

> +
> +#[pin_data]
> +struct NovaVgpuData<'bound> {
> +    reg: vfio::pci::Registration<'bound, NovaVgpuOps>,
> +}
> +
> +#[vtable]
> +impl pci::Driver for NovaVgpuDriver {
> +    type IdInfo = ();
> +    type Data<'bound> = NovaVgpuData<'bound>;
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> +    // SAFETY: VFIO hands the DMA ownership of the device to userspace. This driver never uses
> +    // the kernel DMA API for its devices, directly or through helpers.
> +    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =
> +        Some(unsafe { pci::DriverManagedDma::new() });
> +
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        try_pin_init!(NovaVgpuData {
> +            reg: {
> +                let vgpu = match NovaCoreVfApi::handle(pdev) {
> +                    Ok(api) => Some(VgpuRegistration {
> +                        api,
> +                        gfid: u32::from(pdev.vf_id()?) + 1,
> +                    }),
> +                    Err(_) => None,
> +                };
> +                let dev = if vgpu.is_some() {
> +                    vfio::pci::Device::<NovaVgpuOps>::new(pdev)?
> +                } else {
> +                    vfio::pci::Device::<NovaVgpuOps>::new_passthrough(pdev)?
> +                };

My LLM tells me that the new constructor installs ops that don't
support get_dmabuf_phys, therefore can't expose dma-buf to iommufd,
therefore cannot support P2P with iommufd.  But type1 uses a different
mechanism, so we would be able to map the vGPU BARs for P2P with the
legacy backend.  Is this true?  If so, why?  It needs to support
dma-buf.

> +                let fb_bar = if pdev.resource_flags(0)?.contains(Flags::IORESOURCE_MEM_64) {
> +                    2
> +                } else {
> +                    1
> +                };

Nit, why are we setting up nova-vgpu machinery even on a passthrough
device?

> +                // SAFETY: The registration is stored in `NovaVgpuData`, this driver's bus
> +                // device private data, which is never leaked.
> +                unsafe {
> +                    vfio::pci::Registration::new::<Self>(
> +                        pdev,
> +                        &dev,
> +                        try_pin_init!(NovaVgpuRegData {
> +                            pdev,
> +                            vgpu,
> +                            fb_bar,
> +                            state <- kernel::new_mutex!(InstanceState::default()),
> +                            reset_done <- kernel::new_condvar!(),
> +                        }),
> +                    )?
> +                }
> +            },
> +        })
> +    }
> +
> +    fn reset_prepare<'bound>(_pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
> +        data.reg.reset_prepare();
> +    }
> +
> +    fn reset_done<'bound>(pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
> +        if let Err(error) = data.reg.reset_done() {
> +            dev_err!(pdev, "VFIO device reset failed: {:?}\n", error);
> +            data.reg.error_detected();
> +        }
> +    }

I don't know what's happening here, why would a bad reset_done() return
trigger an error_detected()?  We don't have that idiom anywhere else.

> +
> +    fn error_detected<'bound>(
> +        _pdev: &pci::Device<Core<'_>>,
> +        data: Pin<&Self::Data<'bound>>,
> +        _state: pci::ChannelState,
> +    ) -> pci::ErsResult {
> +        data.reg.error_detected()
> +    }
> +}
> +
> +kernel::module_pci_driver! {
> +    type: NovaVgpuDriver,
> +    name: "nova-vgpu-vfio-pci",
> +    authors: ["NVIDIA"],

Please name an individual, with email.  Thanks,

Alex

> +    description: "NVIDIA vGPU VFIO variant driver",
> +    license: "GPL v2",
> +}

