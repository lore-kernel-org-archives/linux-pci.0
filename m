Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792603079;
	b=j36QNr83fx7EwljvH1bnon+fl7mkFxcxoHHhHrLJitZpRR9SGcDuJZ3P7Mr56MEGbE57
	 DyJnMyLX/5KUqLPLK+4fXDuLmIAdHbBUEChEiFU/EnP7fTQF1FTRAsbxWMO3JEwAhtrjN
	 Bsh6KXpUmrqwp4pP+OdT5aEABTTgdFKsF3rYe6nQ/4J65x3dANyl2d7yxwngdUrCloOI6
	 Gz1mX+nRx+AgUEkZT4Df1/vIeTUwsv9oeFDm4jK8fp88kCAL8XJ1bLIKXV1AgWysHpi+3
	 5F03h+mgdoRkW+3yoD2X4CIUFMmHvXQu6E02Y2qymLVFWddAKenyqbep4xTK0s8qDvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
	b=OkxNCpgf7X0wzaoJ9rUu1td3F7oTs/FgRMBvPdTbErcR78DTBxYlJUAVwZrFgfcku7To
	 bzwVPHXEWI/io1vMAdjNLK+tI1ZBWOEW9bBCJL0D6Gy7mg4xDWhW4+t9E0C0YfgfvNRQ5
	 hYfWxf/HaykHzmfzuMAErv6MnCseBBWm5nJjLM5Y7lSp3izStKfq54j/dneAPGzggZ7u9
	 AfHnX2Blkn7PSXomkVpTZGVU9/+MxyaUVCShMfDYpaGLnkv4RWEX5bc0LqTfXe0rNXijj
	 HsGBSmsexGt4MUC9Lu8ZRwTU5OQckvNk+dTXn7jJAN5WkTrr7JZ4LOjhUxuLL+KQptw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RnntubLz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33B606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C33B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RnntubLz
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3fd91337baso138588066b.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792603077; cv=none;
        d=google.com; s=arc-20260327;
        b=M+Zqyj0+oBj45N+PdH4YH5rBuKacja4AsjLoSIJOuho1cF7n3SBCN2pTXLExJOJSok
         iOeP6HLomAUMiRkxk3nHEDFq/bpVDeacsBnhZpkIzaPotlO5v6XiSCf6H/gVPRTEAXUH
         /TmzVkA4P9KgYJgJcO7FdwIbfYic9YmvP2UbWhnrahxFnkdj7LHQBvqNMhxBYaWwztjV
         SINZq96NMKriUZOxTXw/Ys77kIA2VSicEvUi8GmgRQGfimhfxiBgP3H0Tz7NLrFhz36S
         9/I4Mrvve6NYQN9sBpt4W85cJEYWpfIBYKrk1uucIskwxPUZN5juBLOOvtt3F+5pkIg0
         RkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        fh=EGh5uFXeSw96HsDPl7XHOmeU6o4zjENhAiP4he1C3ws=;
        b=X0zDqBRosjjUu3tfBVI+JIKSByDururZewYGUDEbA7er+V+YTzzVJ72Xv7jDspyOXE
         NrJt2QpRQu8Dz1hzWXEWkVT/nVjhz5Dn/cYoXmJpgj5lA92OUg25d78h9tI+3NTpwZNJ
         3t2bJ8V2iA0uaJ13E4oynsky5LDG0pIyRCtrfcEpj4MpYMhDVNcSvN38tzUV8v4LFyx6
         RBEaKYm4oM4OrSGkRpI3K9nv9kq+yRdZTLif0S3fMrMOLx7LIEdP4nwbB7SX5/0Znu7i
         mxma7hpeGBgE5UGxezSeZg7f3CwENiOgqAkUA1XYqysd0u2YAD+ZgbPnPJO2UlLs+u4X
         RRfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792603077; x=1793207877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        b=RnntubLzmvRqDzQZtAvafVhQR/S5BCx0gkEM89FBs/AgnkkFXqnXGhgLMbtmtcyUvj
         v0iaUF3cv5a7ZAq4M9cK+YK5wayhvCYAM1/emDA5E6s25q5GDYwmvz06Sbn680TfDl3M
         g3MI4M78GywKo1QeouQsAMZp5BmkmuUIHOcL7gx3C03ux/5EBVZAwQ1OoAcdHDgs81Rs
         lSsuvWXc/zJnf64HVhkBOX/qvJYyFs5V4CiF/umf7XKgwo6PRPk1+H9AwmuxuNDo2WQ3
         mVV2Fcyy773ICTh77VRKvqKyoLtSRyUrnJVvP3b9tbHENh28QCRfyvYzS92keqNk6SM7
         se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603077; x=1793207877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elbAOUhGKDzUinaTQ0302ZCYZ7inGoSdWd2JTt/hv+g=;
        b=X39+CCKM4xLvNHF7mD7JpXZc9MqEZObYAj81Gqsq1GwRFmFGe8jzUE55Kjqs9rIjmi
         AXqG2HbTTBt2ADzALGDyZGwf58oLP4UfK6RbrwzlI6T21CYaDKVyW2/7lwQH0h4huBk3
         9Y12VxsUdhFfyMwniuaO0hWW/vpx6SAguae800EBPvL/Uz0NYxGGTHSbslzVX75ql7A6
         D4Oz7UaY0N1g/YopRLxQQdzHtMCl6SXJ5sbYnsbhxdRFh0pVDACmZf5BXxxOs7PGkwgR
         qhHAA0hqL5nOCiY+2lwp0hmiNVTmauZ8YgKyQLD4Pd3APN+nGHxMNrIGMIX05pzoRFtx
         YUlg==
X-Forwarded-Encrypted: i=1; AKwUvBxGO4FrpaI7slT9fuL8mIAlYKP+6roRdEKdZOG5j6FhmTqm7xvBm0DGCKm3n/W6rSQECuTmnfm0ocY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkHTOjLF14hQA43zepRY55zBa5WEKd5PGp3AVAn+28tqYEeZwK
	MgWRAWeJ5QXRu7fj6xh9BGmF0iCvNDGsz1N1ER1PCYPh+vRMse/WnAXaFPjU+ytpnev2Hr4VF6X
	Q5oy128NIGNQjiy3ciKTBWgs4Smjy1N1o2xAG4vTxRg==
X-Gm-Gg: AYBFou2NxndPTl6NyA693fRIb5oHt3bER6DSZNy1w+h4/Khswyj/mQLDbkrKvsPvtil
	FRCejQIb3ez/C4ENfj4yXW9hbQGXNmCCEUW7N/202QpJ8HMDGeoLt0jgL/9nWpvUv/lo791ngiH
	57cWZued3xz78ldigDQ73uCYUwT8la5iTwMRT7ucvToT7fTwOCcfHqk+ySa5IP6ellymKDeE+vK
	br6IUis+MHAq9VnYGN3M5wPNCz7rMB5r1IqGKXyu0hJlRZ6H/lhfbVLhkKXHLeKihxSPnNvRwAn
	WJBXfTGT9N6fK4CJy+3Ct/kpqadT1MSpXkfgKO8E0i8P0ERcy8U4m2XMjZiorYouvIcChTG1bZo
	VybeK7zNEoUcqZJvDsJSAJUCZWmaQZebLn1aWuFMvCgISht5WyImYNCKO3g7+wcs+i/g=
X-Received: by 2002:a17:906:f597:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c4678f7c6cemr225893866b.0.1792603076743; Wed, 21 Oct 2026
 10:17:56 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-3-tarunsahu@google.com>
In-Reply-To: <20261021152527.375070-3-tarunsahu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:17:19 -0400
X-Gm-Features: AclHuK-IkiswuL9j-om2-Yvi6ZhWxvxntziJi6QKVuLB1ELR4YcI0vWO7hzjpeA
Message-ID: <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
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
> Currently luo_preserve_file() iterates over luo_file_handler_list and
> picks the first registered handler whose .can_preserve() callback
> returns true. When a subsystem introduces a new, backwards-incompatible
> file handler alongside an existing one for the same file type, userspace
> has no way to choose which handler preserves a file descriptor, nor can
> the kernel keep the existing rollback-safe handler as the default while
> allowing callers to opt into the new handler.

That is not how it will work. If we are in the .can_preserve() call,
it means the user has already decided which file handlers to use. We
need to do that before any preservation happens; otherwise, we could
run into conflicts on FLBs i.e. FH of different version require
different FLBs.

Therefore, there should be a luoctl call (i.e via a new ioctl to set
compatability) that provides the kernel with the specs file of the
target kernel we are updating to, allowing the kernel to select the
compatible file handlers. Since .can_preserve() is called when the
user is already preserving files, the specification must have already
been supplied, or the kernel should fall back to using the default
(i.e., latest) file handlers.

>
> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
> liveupdate_session_preserve_fd immediately after token, keeping
> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
> original 16-byte structure continue to work:
> - When handler is empty (all-zero, or zero-filled when userspace
>   passes the 16-byte structure), luo_preserve_file() selects the first
>   registered handler whose .can_preserve() callback accepts the fd.
> - When handler is non-empty, it must be null-terminated within
>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
>   luo_preserve_file() looks up the registered handler with that exact
>   name (returning -ENOENT if unknown) and verifies that its
>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
>
> The retrieve ioctl is unchanged because the handler is identified by the
> name stored in the serialized payload from the source kernel.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/uapi/linux/liveupdate.h  | 12 +++++++++---
>  kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
>  kernel/liveupdate/luo_internal.h |  3 ++-
>  kernel/liveupdate/luo_session.c  |  7 ++++++-
>  4 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupd=
ate.h
> index 509c6236720d..2413b19dabc1 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
>
>  /**
>   * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRES=
ERVE_FD)
> - * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
> - * @fd:    Input; The user-space file descriptor to be preserved.
> - * @token: Input; An opaque, unique token for preserved resource.
> + * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
> + * @fd:      Input; The user-space file descriptor to be preserved.
> + * @token:   Input; An opaque, unique token for preserved resource.
> + * @handler: Input; Optional null-terminated file handler name (max leng=
th
> + *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) sel=
ecting
> + *           which registered handler preserves @fd. If empty (all-zero,=
 or
> + *           omitted when passing the 16-byte structure), the kernel sel=
ects
> + *           the first registered handler whose .can_preserve() accepts =
@fd.
>   *
>   * Holds parameters for preserving a file descriptor.
>   *
> @@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
>         __u32           size;
>         __s32           fd;
>         __aligned_u64   token;
> +       char            handler[LIVEUPDATE_HNDL_NAME_LENGTH];
>  };
>
>  #define LIVEUPDATE_SESSION_PRESERVE_FD                                 \
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index fb81239bedf3..be20e0f1e0aa 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *fi=
le_set, u64 token)
>   * @file_set: The file_set to which the preserved file will be added.
>   * @token:    A unique, user-provided identifier for the file.
>   * @fd:       The file descriptor to be preserved.
> + * @handler:  Optional NUL-terminated handler name. If NULL or empty, th=
e first
> + *            registered handler whose .can_preserve() accepts @fd is se=
lected.
>   *
>   * This function orchestrates the first phase of preserving a file. Upon=
 entry,
>   * it takes a reference to the 'struct file' via fget(), effectively mak=
ing LUO
> @@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set *=
file_set, u64 token)
>   *         -EBUSY if the file descriptor is already preserved by another=
 session.
>   *         -EBADF if the file descriptor is invalid.
>   *         -ENOSPC if the file_set is full.
> - *         -ENOENT if no compatible handler is found for the file type.
> + *         -ENOENT if no matching handler is registered or accepts @fd.
> + *         -EINVAL if the named handler cannot preserve @fd.
>   *         -ENOMEM on memory allocation failure.
>   *         Other erros might be returned by .preserve().
>   */
> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
> +                     const char *handler)
>  {
>         struct liveupdate_file_op_args args =3D {0};
>         struct liveupdate_file_handler *fh;
> @@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set,=
 u64 token, int fd)
>         err =3D -ENOENT;
>         down_read(&luo_register_rwlock);
>         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
> +               if (handler && handler[0]) {
> +                       if (strcmp(fh->name, handler))
> +                               continue;
> +                       if (!fh->ops->can_preserve(fh, file)) {
> +                               err =3D -EINVAL;
> +                               break;
> +                       }
> +                       if (try_module_get(fh->ops->owner))
> +                               err =3D 0;
> +                       break;
> +               }
> +
>                 if (fh->ops->can_preserve(fh, file)) {
>                         if (try_module_get(fh->ops->owner))
>                                 err =3D 0;
> @@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set, =
u64 token, int fd)
>         }
>         up_read(&luo_register_rwlock);
>
> -       /* err is still -ENOENT if no handler was found */
>         if (err)
>                 goto err_fput;
>
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_int=
ernal.h
> index dac6644bfb18..911ffedec9f3 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_pa=
);
>  int luo_session_serialize(void);
>  int luo_session_deserialize(void);
>
> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
> +                     const char *handler);
>  void luo_file_unpreserve_files(struct luo_file_set *file_set);
>  int luo_file_freeze(struct luo_file_set *file_set,
>                     struct luo_file_set_ser *file_set_ser);
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_sess=
ion.c
> index f48e9a4185f9..194ef45907c1 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_sessio=
n *session,
>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
>         int err;
>
> +       if (strnlen(argp->handler, sizeof(argp->handler)) =3D=3D
> +           sizeof(argp->handler))
> +               return -EINVAL;
> +
>         guard(mutex)(&session->mutex);
> -       err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd);
> +       err =3D luo_preserve_file(&session->file_set, argp->token, argp->=
fd,
> +                               argp->handler);
>         if (err)
>                 return err;
>
> --
> 2.56.0.212.g129ede20d9-goog
>
