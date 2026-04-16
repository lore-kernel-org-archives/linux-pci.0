Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C372FE58C
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310238; cv=pass; b=ndJGd4vAMZ3sJqCtR+eo7MUVcWGZPqzBSE2SQy4W9Pt9yT3PgSf3LMbJWD7lQmz8UZvg5r/D6KIIp5+UOpeuAUQ/Mn71hvHHkeDDFtBTGRPBclDO3/es89z2TEmWKoxCtc3+bf7TywVIXU/yS9WU2VdwhTZ4XHS+nJABqlkt4OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310238; c=relaxed/simple;
	bh=iTtON7C1saxGO1WpU3i+FepkxQvrPytkI30BQs9EQlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrIYJICVRHgd7fxmBp7Ey+4reufHDWvZt8PQ64cYKaRFoUG86Nve/4Ns3+opJtyUB5DbXtweHBLezfLb4lvp+BK/pgx8d0BI+pgMT+9l7JqvpnCCzRPb9LplOxbAKLdypHozwhumUA09nwZk6u2SVYYBABnwHnarUmb2yuMesTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1VlrlmC; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1VlrlmC"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6749188eec.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 20:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776310235; cv=none;
        d=google.com; s=arc-20240605;
        b=bmJCMKzXVieYYX5+m3P1oFePgrAhM3mwFdH3pwAUM2Lk4tkO3jJNnZ6QUpp/55n6oa
         YHaGDN2WcbpW45iHMKAc/SKdKAZsugTPADmd341vwr7wPukkpeNIZedZpU/VqYIIhhvR
         8nxgx7YsS78REo/1G8LgF7B7iDiGrj7AfqtLuMBhCOmC4h2HFzY/sGiVX9zg5l4Ryuzb
         VSLOsoV5FlWE7oXH9YxYKZQUemXMVDxJ7lsEw3WV0Ug/lKPhPAB+JcKpDAbK4JSbUvTC
         p+lEC3IQQnm3+9lu7xsfkFPVf7GCkd1+MF+18fE4/QaLTTDUCFcvNossDQeYPoTLizvV
         B8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        fh=Ls6w/r2ZLQVNinslVprJgt0FpnxsMhrcL3GNwEQ2pB4=;
        b=ZCf69YFnBlkfQdMyylLFslexPOsN9LgzLQ+TDSGz8yIX89Kygs/mtWA2VF5O8/0guM
         YXxsfRLYARQgkW8MccifIfc20O5O3ChceZs64uRiWBVa2blVvJdmkpgmb80Zb++NkXBH
         Cn9jcLCDeoDddV8gsIlgByJxbl6URakvlE2+JOo72X9ZV8X5qenAfqXp/QFT9h07Fd1G
         TPcqIjk3oMRmJsC2Y8NWI49pG0S4kz++n78r2xFI80vuoW8PtuWCWpEuamXvVKveONhe
         BlfX0BfTU/dpJy0Ku1hum0Fhs7zuR/Jkb46Ld5+9F+wVVjiCvPVRRfXjt5Z+975BCIqk
         vO9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776310235; x=1776915035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        b=q1VlrlmCFrtVHE5hetzAOsBCWcGxb/CFhXHSSopeF/IlxAPo0DUBJ/C6gbvOrvJiYw
         cdceN5UReXjnL6InkeQtNyS50HI4ppuCooMyssWxnvX0g9UmryDd+Gyqq4X316cT7Xq8
         c+2Cn4IvuJrzVNY6pRkBZr9cXPscrF3I20+ssiCoyF2uvtU1JjnxT8DNPMsmMUpjIST+
         xqx4fbZU7R/wLJ6v9EW0ctWCZWKaKhltfVFfVB7WZZ3aKoJ3qHrPRHkCMZ7kDt5+SRYR
         7IUSa6kyHZCFaqwvvSrtCw9WaQryviOrSLkTsnzqesOFhS1yQ04NIG2hhbuwYPWvcjiQ
         pw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776310235; x=1776915035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        b=O5WolKh7C56NEdFcwCIewkBsO2SyYlP6ComFf3JreZxlOsxHuHkPoGFZAFOlsnRAL8
         E9y9v3mQAfhX7Sw2GbFfqVZbOlVqc7ph3xbqZDWILuAx/sz0oK+l8B4mYZcovyeUPxsn
         eDoHW8C4s8lO9eqb8F31OwsMnaALtMv4OVs0DDTe5O1S9eKw8g0hvjINLgRSiK43mJuh
         DImJ3npooWOCHybJLyXULAB4kp1uGavzBGwmXlI1hqZlT+MxaSJMlQDw0PIzgb4lJXiJ
         ZS2QF0x4fwgqanSrKmNJ4zxAfPTnwfqxeL1tJ50bfQB7QDyjjpyDv/tIUSV+e1e0ZdyH
         dc2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6gi0MWmovS0m9oLNXlhB14afrhRb3NLIDOZ8XyEfaGBLu/ZaF9N9NjswKCYedS35TRXI8OVpNYlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QQwX0uPeeR/7r+Qn3SX3ZRBd0YiowaPABkMnLq4P6lLC4j7m
	+awwNfgIL+4l3EQsS8RnSprKDq7iISX25DX1zgGIz0tFGUoTRhaNa99NTd1GlGmyRmJp6vrrHuD
	zdTI1HLH+jRUZYMx90HA88X8sVPLPf54=
X-Gm-Gg: AeBDievUSSUCKqv0WxoqX9WQBLeTbVdyPY+xSE5ej3V9TCwimQFbvWRURN2kwBc+pgE
	z1y29bqaw7RVZN6+zzacneGlChNGNUMmmLKLkkVtYWFDi/+YMLqpcfd1mi4FxFvMMornOazG1Fn
	CS6IZYaQUs+wsVuMI2dw9jrdv7oE7mnOc+32xm1ZUJWF52UQkJpXgYwqrCW9ZAMV48xUXbZBrY2
	nV+ov28vL5uHa4m4eDxfbs1aknyRFywG5eCSrZ5wObybKP1uP1879L/5Vj8fr6A1Z2foMwWt4Pe
	Mi7L/TY=
X-Received: by 2002:a05:7300:e2cc:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-2d5898a59fdmr13887470eec.27.1776310234537; Wed, 15 Apr 2026
 20:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com> <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 16 Apr 2026 11:30:18 +0800
X-Gm-Features: AQROBzAshGAwo61mQxzSw05B4fc-T0M_3Sz-I4zsvryqbMNOOaLRwnMtQN-AzBI
Message-ID: <CAMvTesDbCYPLowZ=RS4ZOwbY_hNixhop6t1ADjDQjJ8kWjwe3A@mail.gmail.com>
Subject: Re: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, easwar.hariharan@linux.microsoft.com, 
	jacob.pan@linux.microsoft.com, nunodasneves@linux.microsoft.com, 
	mrathor@linux.microsoft.com, mhklinux@outlook.com, peterz@infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:13=E2=80=AFPM Yu Zhang <zhangyu1@linux.microsoft.c=
om> wrote:
>
> From: Wei Liu <wei.liu@kernel.org>
>
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush(which in its handler may flush
>   the device TLB as well). Page-selective IOTLB flushes will be offered
>   by new hypercalls in future patches.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |   8 +++
>  include/hyperv/hvhdk_mini.h | 123 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
>
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 77abddfc750e..e5b302bbfe14 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -478,10 +478,16 @@ union hv_vp_assist_msr_contents {  /* HV_REGISTER_V=
P_ASSIST_PAGE */
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID                       0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE      0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST       0x00b0
> +#define HVCALL_CREATE_DEVICE_DOMAIN                    0x00b1
> +#define HVCALL_ATTACH_DEVICE_DOMAIN                    0x00b2
>  #define HVCALL_SIGNAL_EVENT_DIRECT                     0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT                     0x00c1
>  #define HVCALL_DISPATCH_VP                             0x00c2
> +#define HVCALL_DETACH_DEVICE_DOMAIN                    0x00c4
> +#define HVCALL_DELETE_DEVICE_DOMAIN                    0x00c5
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES             0x00c9
> +#define HVCALL_CONFIGURE_DEVICE_DOMAIN                 0x00ce
> +#define HVCALL_FLUSH_DEVICE_DOMAIN                     0x00d0
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS     0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS     0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY  0x00db
> @@ -492,6 +498,8 @@ union hv_vp_assist_msr_contents {    /* HV_REGISTER_V=
P_ASSIST_PAGE */
>  #define HVCALL_GET_VP_CPUID_VALUES                     0x00f4
>  #define HVCALL_MMIO_READ                               0x0106
>  #define HVCALL_MMIO_WRITE                              0x0107
> +#define HVCALL_GET_IOMMU_CAPABILITIES                  0x0125
> +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY             0x0127
>
>  /* HV_HYPERCALL_INPUT */
>  #define HV_HYPERCALL_RESULT_MASK       GENMASK_ULL(15, 0)
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..ba6b91746b13 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -400,4 +400,127 @@ union hv_device_id {              /* HV_DEVICE_ID *=
/
>         } acpi;
>  } __packed;
>
> +/* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S1       1 /* Stage 1 domain */
> +
> +/* ID for default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +       u64 as_uint64;
> +       struct {
> +               u32 type: 4;
> +               u32 reserved: 28;
> +               u32 id;
> +       } __packed;
> +};
> +
> +struct hv_input_device_domain {
> +       u64 partition_id;
> +       union hv_input_vtl owner_vtl;
> +       u8 padding[7];
> +       union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +       u32 as_uint32;
> +       struct {
> +               u32 forward_progress_required: 1;
> +               u32 inherit_owning_vtl: 1;
> +               u32 reserved: 30;
> +       } __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;
> +
> +struct hv_input_delete_device_domain {
> +       struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +       u64 partition_id;
> +       union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +       struct {
> +               /*
> +                * Enable translations. If not enabled, all transaction b=
ypass
> +                * S1 translations.
> +                */
> +               u64 translation_enabled: 1;
> +               u64 blocked: 1;
> +               /*
> +                * First stage address translation paging mode:
> +                * 0: 4-level paging (default)
> +                * 1: 5-level paging
> +                */
> +               u64 first_stage_paging_mode: 1;
> +               u64 reserved: 61;
> +       } flags;
> +
> +       /* Address of translation table */
> +       u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +       u64 partition_id;
> +       u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +       u32 size;
> +       u16 reserved;
> +       u8  max_iova_width;
> +       u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> +#define HV_IOMMU_CAP_PRI (1ULL << 6)
> +
> +       u64 iommu_cap;
> +       u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +       HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU =3D 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +       u64 partition_id;
> +       u64 logical_device_id;
> +       enum hv_logical_device_property_code code;
> +       u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)
> +       u64 device_iommu;
> +       u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       u32 flags;
> +       u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.49.0
>
>

No code uses these definitions in this patch and it's better to merge
with Patch 5?
--=20
Thanks
Tianyu Lan
