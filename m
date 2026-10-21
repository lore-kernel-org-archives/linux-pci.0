Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792604336;
	b=IdZC5EVi9J+GmkH+VUPQ5bRXUpjAW+sq0nwh6QCR7KVbZJgcHWeth1y5JppaVCZ9/W/h
	 P7Chsw8qQG9VBq0q8I1Pf2PsmcyMbMhJ2QbUZqCqJWwSP/vHQGXj4wJxja15foC0/Jexs
	 zLADk/SkBE7qOt+KEQeGO8KLX6m8dswZOVxTER9X9pAFlmEGwV6AZiEjrP62Z05dKr1wy
	 IMzVPMFclthFmlyZ3peWBFNtGcPWo5QqgPA9YH3/xYwkeWY9JmWVYc97PHINt3TNLejP1
	 sNyb3rPmF7LVxl/YCuaTEN2GL+IwUUH5i9BU25ygMJrBKY1qFrwDEwAVdyaQ4EspFtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
	b=E+HMiRbs3xyrOZWpAxGyC7so/c9nvlcpPSKXPTtKQ3dVCoeul5cqQ8M8yJDt1NGQG61/
	 IRfVus8gal4lO9+EUDOAftslaGuU+qWgEY0IbGO2kofKeXvSTDsJxHqR/Pn/EDyL2WJgJ
	 K4/KAk5OPVpyg+N2N9nXMf8iBcsqSDvSo50RVPm+3i+80O5p2me/dfDCBm4gqVYqKhM58
	 wfvSUJm5eUgS8l1LRWZbWjeVtoDFBqjbnxjCyrZ9m4pyqNS4OHkZgyGRq0LGU6wdyyFXE
	 U9dkMjNLV8/JcYhrXX/1jzARAYeTVi4mqWLlw6kcI9snjkosT/a5XjKPut26xIvh1Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="Z8zt/CD8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6D606A31E
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA6D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Z8zt/CD8
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so9079811fa.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604334; cv=none;
        d=google.com; s=arc-20260327;
        b=cDSLXEbUE6o4o5MRq0F1pfdQoTTXADj9BeolIlUkjRtrwCDSp099buiFgZctRf1pAW
         ztHqzfLecdmGdOQME/XniGm0WH+n7iEcy6ESKJfwXGqwXekyJ5jCgPTIq/Y+kYmjB5c3
         tWGjc01tDy8YUH5c5jB5DHIw02+XXpHPtqbanwOKeMASMFxZRDV5g4dIHa76UPl7Q0xO
         6GZtvvPBkvYzM/9e1Rg84+aFG1dHA1PVSMfqgPvbv4q2/lJyNIsgQ4dBXEqjsrnCzxFc
         hpq4j48XmOYebhqNlaAVEZbOxHRU7qBHy4UIA2eHXdFTpDESTfMkxj8kSgKai97630r+
         8C+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        fh=f6p8IDyhiUBstd1j4q37sel72WhE8NyrI8hN9qHY1zc=;
        b=OA4goxYqXyMwqH+JLko7QO8Uc7FCEOiwpbJrSStdK/Wcgz0jByf3jW6uzszZnTstOq
         HCiqoaKD01udxQMvpR1yzWkN0bUa8JtAXBT6psAvdoDQ7aPjZw3xkYZ0UY0HOqAy7jPc
         UQr2UqUf0eil16yt2jRgks04FjgbU8AyyOc+yKTfAKeMG799KIpudVcxXTvHytndmABT
         oa2BTXhNiT9sK65PQ7Mdj5GYr5aJqJfrs2/Nwo0G4vIideEItzU05TgBSA/tELWtYf1W
         Unjod2P/p3I0mCS4U+kVN2dgp/kPmNIrTarQdotu8m9RSkswzxZoAb41jKjGCr6dnZZ5
         KRKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792604334; x=1793209134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=Z8zt/CD8yXkF9Q3B+tyvIqqgdbaewlF50nbjRuiJdqbc3VV+N0b4a6EuxedwdXFZ12
         DZyhl9yzbmXnDhGtnX/NxBlQlwx3Qu8DgvK50O6Oe2UZNQY/zPyL9mvJAfwdeSSuRHlh
         kdNEmaTpal+mxW1DPfqJDhmJRfuUJdykdUVtV0eyhwHkXOBRBPTGKEoQ2ETHg7892rDs
         u72QIZikWh5X8YvIuCJi8vY5y8B1jsXTobW4ZNiEcJfVkLZOb9xj2M0zIS9dAVzwdems
         klM+T2Z8G3kfzK3HADiVbgSjxI73kDbkL4QANIESI9FpMgeWuAegPgAtPQbMULjtzu7M
         zdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604334; x=1793209134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csULT7PmXNkTg9HaShgHK/UOyRj2pqW39WBnWQcueFE=;
        b=k8xz9zFTeRY+gPuI7Zo6HKBXlm3vXZt5E2KxDVPIzrhCvd0Nwxr76+0xk1fVLWkkOI
         xDcnuunBBFU2bA+EObmlrmBBDQP40pGB7DH7gS15I2opUUBxUAGUDZRR145nNGDLdaSg
         vBLFG5S53+LV9FLwYwK4d0hWDE7DcaSP/sGftESpVZECXz/WuRfP5/Q4upbzsmIpXVq1
         ToRUV3LwjC4R2qYrsTniBByz+Jks4jXZuZlefGdu46oIWJZHXbDIgkk71tjh4b4QaP5W
         lZH6VS9qbplxa0S76e+e2Em/pDacT3EHwfA5b4eDyhYMXYvwjXySYRzOgPDUlSaoXSGs
         zGVw==
X-Forwarded-Encrypted: i=1; AKwUvByW0hmqXyjG2X+M7YDaosL4fWt8jUbFfq+N005otb3uJZxyAGUq3EJmphX5JTC/9jvwwaRwbiid4N8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPXnhQBw8LGRn1KL+Qg70vIQBsXBrrnQZwWWQrglnPMw2u32ac
	y3bsHjgoESsN5C2OF0kFpotbe7eBfSV4tBtC1yoB6ymAtZc/Bc91DHcrEs1Va6VtP7wLpwTktTJ
	uRsGUItduGaUWe6frkUspWAX+JkwUXkolLSBafKpYNw==
X-Gm-Gg: AYBFou03Lo3Fs2ot5v/xy1A3jBs4Ejdu+O3bI/bH8UeQCKrKhyafrQjcp0Wub6nG0vA
	w+MrOFkg/yGSi7kdUeiKPTh2wPcXsJFHqsZj0XHA719hbi61PjgSFGpcpocgg1PEDhhFnPoL8/L
	BttOEQnwHfp32JeM5zD8rBepgfikbauaZYLHRYHiyqmtAd4cShwMt78t+yKggg68ScIdP72mA8P
	nTaUMMm77qGCzd47lGL6vhsc48dIfWT0stqzajz6xOB2d7zz1aCEcVNk8qh1BDPPg0ahWFT+yvO
	glX9+MxYz7zC33C3AeX+JHy2H/x0RGIX8YfDTv4VcSWj+XvnEqwcWp2ihHwku3K6z60AtsWuwMy
	Kn8rTxaSEqvaOt6gd2d4sojN4K1fe67ygi0+yuBufevPNp9Rn7UWehQJDLEGr2RzPk0Y=
X-Received: by 2002:a05:651c:4210:b0:3ab:473f:4340 with SMTP id
 38308e7fff4ca-3ac44229527mr7899791fa.25.1792604334224; Wed, 21 Oct 2026
 10:38:54 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
In-Reply-To: <20261021152527.375070-5-tarunsahu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:38:17 -0400
X-Gm-Features: AclHuK9EmTvcDrSPqjt_gHIG_UhFcRBGzP6kEtdhbGsx9XevNkAWoOmg1utImw8
Message-ID: <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.com> =
wrote:
>
> Embed the fixed-size 128-byte struct luo_feature_hdr at the start of
> struct memfd_luo_ser and define enum memfd_luo_feature
> (MEMFD_LUO_FEAT_CORE and MEMFD_LUO_FEAT_MAX) for memfd preservation.
>
> All current struct memfd_luo_ser fields (pos, size, seals, flags,
> nr_folios, folios) and MEMFD_LUO_ALL_SEALS belong to
> MEMFD_LUO_FEAT_CORE (LUO_FEAT_REQUIRED in memfd_luo_features). Future
> changes add new entries to enum memfd_luo_feature before
> MEMFD_LUO_FEAT_MAX and append any new fields to the end of struct
> memfd_luo_ser so existing field offsets never shift.
>
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/memfd.h | 35 ++++++++++++++++++++++++++++++-----
>  mm/memfd_luo.c                | 14 ++++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.=
h
> index 371ffd108a79..f0b5235a408d 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -13,6 +13,7 @@
>
>  #include <linux/types.h>
>  #include <linux/kho/abi/kexec_handover.h>
> +#include <linux/kho/abi/luo.h>
>
>  /**
>   * DOC: memfd Live Update ABI
> @@ -21,11 +22,20 @@
>   * reboot using the LUO.
>   *
>   * The state is serialized into a packed structure `struct memfd_luo_ser=
`
> - * which is handed over to the next kernel via the KHO mechanism.
> + * which is handed over to the target kernel via the KHO mechanism.
>   *
> - * This interface is a contract. Any modification to the structure layou=
t
> - * constitutes a breaking change. Such changes require incrementing the
> - * version number in the MEMFD_LUO_FH_COMPATIBLE string.
> + * This interface is a contract. `struct memfd_luo_ser` starts with a fi=
xed
> + * 128-byte `struct luo_feature_hdr`. The relative order and offsets of
> + * fields must remain unchanged as features are added or retired: new fi=
elds
> + * are appended at the end of `struct memfd_luo_ser` under a new feature
> + * flag in `enum memfd_luo_feature` (before `MEMFD_LUO_FEAT_MAX`), and
> + * retired fields are kept in place so subsequent offsets never shift. I=
n
> + * the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are guaran=
teed
> + * present once `luo_feature_hdr_validate()` succeeds, whereas fields of=
 a
> + * `LUO_FEAT_OPTIONAL` feature should be accessed only after checking
> + * `luo_feature_is_active()`. All current fields (`pos`, `size`, `seals`=
,
> + * `flags`, `nr_folios`, `folios`) and `MEMFD_LUO_ALL_SEALS` belong to
> + * `MEMFD_LUO_FEAT_CORE` (`LUO_FEAT_REQUIRED` in `memfd_luo_features`).
>   */
>
>  /**
> @@ -58,7 +68,7 @@ struct memfd_luo_folio_ser {
>
>  /*
>   * The set of seals this version supports preserving. If support for any=
 new
> - * seals is needed, add it here and bump version.
> + * seals is needed, gate them behind a new feature flag.
>   */
>  #define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
>                              F_SEAL_SHRINK | \
> @@ -67,8 +77,22 @@ struct memfd_luo_folio_ser {
>                              F_SEAL_FUTURE_WRITE | \
>                              F_SEAL_EXEC)
>
> +/**
> + * enum memfd_luo_feature - Feature indices for &struct memfd_luo_ser.
> + * @MEMFD_LUO_FEAT_CORE: Core feature covering `pos`, `size`, `seals`, `=
flags`,
> + *                       `nr_folios`, `folios`, and %MEMFD_LUO_ALL_SEALS=
.
> + * @MEMFD_LUO_FEAT_MAX:  Number of defined &enum memfd_luo_feature featu=
res.
> + */
> +enum memfd_luo_feature {
> +       MEMFD_LUO_FEAT_CORE =3D 0,
> +       MEMFD_LUO_FEAT_MAX,
> +};
> +
> +static_assert((int)MEMFD_LUO_FEAT_MAX <=3D LUO_FEAT_MAX);
> +
>  /**
>   * struct memfd_luo_ser - Main serialization structure for a memfd.
> + * @features:  ABI feature and size header for memfd_luo_ser.
>   * @pos:       The file's current position (f_pos).
>   * @size:      The total size of the file in bytes (i_size).
>   * @seals:     The seals present on the memfd. The seals are uABI so it =
is safe
> @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
>   *             struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
> +       struct luo_feature_hdr features;

I have not looked into this yet, but I would prefer to use some kind
of macro constructor for serialized structs. That way, they will
automatically include the header, making it easier to search the code
for what is actually preserved versus what exists only in this kernel.

So, I think something like this:
/* Base serialization header: 4 bytes total size, 4 bytes flags */
struct luo_ser_hdr {
    __u32 total_size;
    __u32 flags;
};

#define LUO_SER_INIT_HDR(obj, _flags) do {           \
    (obj)->hdr.total_size =3D sizeof(*(obj));          \
    (obj)->hdr.flags =3D (_flags);                     \
} while (0)

#define DECLARE_LUO_SER(name, expected_size, members)       \
    struct name {                                           \
        struct luo_ser_hdr hdr;                             \
        members                                             \
    };                                                      \
    static_assert(sizeof(struct name) =3D=3D (expected_size),   \
                  "LUO struct " #name " size mismatch!")

Usage:
/*
 * Header:  8 bytes (hdr: 4 bytes total_size + 4 bytes flags)
 * Payload: 8 (pos) + 8 (size) + 4 (seals) + 4 (_pad) =3D 24 bytes
 * Total:   32 bytes
 */
DECLARE_LUO_SER(memfd_luo_ser, 32,
    __u64 pos;
    __u64 size;
    __u32 seals;
    __u32 _pad;
);

struct memfd_luo_ser *ser;
...
LUO_SER_INIT_HDR(ser, 0);

Thanks,
Pasha

>         u64 pos;
>         u64 size;
>         u32 seals;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 64f8b8cb75bd..ea1f4c8cd259 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -84,6 +84,10 @@
>
>  #include "internal.h"
>
> +static const u8 memfd_luo_features[MEMFD_LUO_FEAT_MAX] =3D {
> +       [MEMFD_LUO_FEAT_CORE] =3D LUO_FEAT_REQUIRED,
> +};
> +
>  static int memfd_luo_preserve_folios(struct file *file,
>                                      struct kho_vmalloc *kho_vmalloc,
>                                      struct memfd_luo_folio_ser **out_fol=
ios_ser,
> @@ -284,6 +288,8 @@ static int memfd_luo_preserve(struct liveupdate_file_=
op_args *args)
>                 goto err_free_ser;
>         }
>
> +       luo_feature_hdr_init(&ser->features, sizeof(*ser),
> +                            memfd_luo_features);
>         ser->pos =3D args->file->f_pos;
>         inode_size =3D i_size_read(inode);
>
> @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file=
_op_args *args)
>         if (!ser)
>                 return -EINVAL;
>
> +       err =3D luo_feature_hdr_validate(&ser->features, memfd_luo_featur=
es);
> +       if (err) {
> +               pr_err("memfd_luo_ser feature header validation failed (s=
ize=3D%llu, flags[0]=3D%#llx): %pe\n",
> +                      ser->features.size, ser->features.flags[0],
> +                      ERR_PTR(err));
> +               goto free_ser;
> +       }
> +
>         /* Make sure the file only has seals supported by this version. *=
/
>         if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>                 err =3D -EOPNOTSUPP;
> --
> 2.56.0.212.g129ede20d9-goog
>
