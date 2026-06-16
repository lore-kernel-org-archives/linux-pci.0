Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DB46AF3C;
	Tue, 16 Jun 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631659; cv=none; b=RxHBbxtrZx6QvXj0rX3+j8T2seIGLBX4H9V3CYESnrwQZu2IVew/eUaQzEm8d3SrCum8QKC4IZXawmoI3F8dF4g83Ycv6P4O4a2n5N3StnuMKjeKLlqoXkAvMUK6mJ+rfMV+y8Q5mrLCZKjL1R13a+vcnI7WaRBjXjWE/Jv7q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631659; c=relaxed/simple;
	bh=Tpohtpxv9OHbO2WPK3TOnUm7e7476omwD08g4hId1Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW6e9FJ9q6Q40lWeSv8hUM8mOTVHUzgKRRKMvqe/BlAxnzGYc/m0hcKsc/Ds2zQ5+aeJuClcj7U2GJ5I+L/QUegzWeR2p4E9EA7wR+VALuc3nWBbQrF179dMZKItZcpAKdnmTDWh/BHSGvknxoen58V7UkJw24W2m8VmC4fjnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDmdCmdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDmdCmdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5795B1F00A3A;
	Tue, 16 Jun 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631658;
	bh=ccS/ln5QcVxJYWX2Zp4+48P7XLW+G+pWSQ75wMzkNZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BDmdCmdAn/RjBLnELIa9yA/HPZNChARTcHrVzh6oqFfY7JI1gXx4y4pYIm+aiSzKB
	 KaFglKfxfmsPdKYGanIc8jd7fy2FOyi/cEc/zLoo//8l+vG/cgHbDspOPe8due1HZ8
	 3Jw+pk/BPRNY0X9F7AKAHLhdBB1Qi0NE4vwLJP2rgTpqMHWq3cDO9MhZC0itIeqdiX
	 LKl21//RRFagrfw4Tx890RH/cbkV+iJYsigBdBeoMdsoGmxobLfOMwIZ7eUiRdzjJE
	 cQr7llCLM9d1Vwc9BDFcH7/dIUuEcZ1Cwb99y55kWvdYmnVnsFKjDJShlQ6Fddr/14
	 Lf1GPpHa62YWw==
Date: Tue, 16 Jun 2026 18:40:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder
 registers
Message-ID: <20260616184049.42cdc02d@jic23-huawei>
In-Reply-To: <20260609105836.3702787-6-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7@epcas5p1.samsung.com>
	<20260609105836.3702787-6-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 16:28:33 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> Plumb the 'uio_capable' flag to CXL HDM decoder capability and
> control register interfaces. The UIO bit in the capability register
> is now set for CXL Type3 devices and ports when UIO support is
> advertised via 'x-uio-svc' property.
> 
> Per CXL 4.0 specification Section 8.2.4.20.7, the decoder control
> UIO bit is validated against the advertised capability during
> HDM decoder commit operations.
> 
> Additionally, replace hardcoded HDM decoder control write masks
> with spec-aligned 'WRMASK' definitions.
I think we should be modifying that depending on whether it is uio_capable
rather than saying it is 'writeable' but 'not writetable' if not UIO capable.

A few other comments inline.

> 
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> ---
>  hw/cxl/cxl-component-utils.c        | 29 +++++++++++++++++++++++------
>  hw/mem/cxl_type3.c                  |  9 ++++++++-
>  hw/pci-bridge/cxl_downstream.c      |  2 +-
>  hw/pci-bridge/cxl_root_port.c       |  2 +-
>  hw/pci-bridge/cxl_upstream.c        |  3 ++-
>  hw/pci-bridge/pci_expander_bridge.c |  3 ++-
>  include/hw/cxl/cxl_component.h      |  2 +-
>  include/hw/cxl/cxl_device.h         |  2 ++
>  8 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 31bbedb502..9a5b382272 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -13,6 +13,19 @@
>  #include "hw/pci/pci.h"
>  #include "hw/cxl/cxl.h"
>  
> +/* CXL 4.0 specification 8.4.2.20.7 */
> +#define CXL_HDM_DECODER_CTRL_WRMASK (    \
> +    (0xfu << 0)   | /* IG */             \
> +    (0xfu << 4)   | /* IW */             \
> +    BIT(8)        | /* LOCK_ON_COMMIT */ \
> +    BIT(9)        | /* COMMIT */         \
> +    BIT(12)       | /* TYPE */           \
> +    BIT(13)       | /* BI */             \
> +    BIT(14)       | /* UIO */            \
> +    (0xfu << 16)  | /* UIG */            \
> +    (0xfu << 20)  | /* UIW */            \
> +    (0xfu << 24))   /* ISP */
Given the FIELD() macro defines appropriate masks, can we build this as
	R_CXL_HDM_DECODER_0_CTRL_IG_MASK |
	R_CXL_HDM_DECODER_0_CTRL_IW_MASK |
etc
That will make it both self documenting and ensure it aligns with the field
defines.  If we get a bug at least it will only be in one place :)

> +
>  /* CXL r3.1 Section 8.2.4.20.1 CXL HDM Decoder Capability Register */
>  int cxl_decoder_count_enc(int count)
>  {
> @@ -305,7 +318,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>  }
>  
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> -                            enum reg_type type, bool bi)
> +                            enum reg_type type, bool bi, bool uio)
>  {
>      int decoder_count = CXL_HDM_DECODER_COUNT;
>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> @@ -325,9 +338,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
>      }
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> -                     UIO_DECODER_COUNT, 0);
> +                     UIO_DECODER_COUNT,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
> +                     decoder_count : 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       SUPPORTED_COHERENCY_MODEL,
> @@ -341,7 +357,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>          write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] = 0xffffffff;
>          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
>          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
> -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
> +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =
> +                                             CXL_HDM_DECODER_CTRL_WRMASK;
I think file at least mostly aligns these long line wraps as
        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =
            CXL_HDM_DECODER_CTRL_WRMASK;

Given i think this needs to be dependent on whether the device is uio_capable
maybe just bring the mask defines suggested above down here, and modify the
UIO bit to fit whether it should be writeable.


>          if (type == CXL2_DEVICE ||
>              type == CXL2_TYPE3_DEVICE ||
>              type == CXL2_LOGICAL_DEVICE) {
> @@ -391,7 +408,7 @@ static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
>  void cxl_component_register_init_common(uint32_t *reg_state,
>                                          uint32_t *write_msk,
>                                          enum reg_type type,
> -                                        bool bi)
> +                                        bool bi, bool uio)
>  {
>      int caps = 0;
>  
> @@ -431,7 +448,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>      case CXL2_LOGICAL_DEVICE:
>          /* + HDM */
>          init_cap_reg(HDM, 5, 1);
> -        hdm_init_common(reg_state, write_msk, type, bi);
> +        hdm_init_common(reg_state, write_msk, type, bi, uio);
>          /* fallthrough */
>      case CXL2_DOWNSTREAM_PORT:
>      case CXL2_DEVICE:
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b7ad437cbc..4cdadc3e10 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -590,6 +590,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>      /* TODO: Sanity checks that the decoder is possible */
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> +    if (ct3d->uio_capable) {
> +        ct3d->uio_enabled = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, UIO);
> +    } else {
> +        ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, UIO, 0);

If it's not supported, shouldn't the write mask stop it being written?  I think
that would be cleaner than overriding any write to 0 here.


> +    }

