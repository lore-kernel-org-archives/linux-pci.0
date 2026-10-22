Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673410;
	b=Os7ZyIpVhU0JUiATevXuC2/faN5AVQOTB4/ixzfU60/86W1YpG+Q/1QcLH62j9m7Mjxz
	 OoWHXVKFyvI58afSOxWGK4CNH8b+YozfAsEW1f/GCSeHGSaQ+7wyhDGMApV4z9U6ZYorj
	 1nEiEvhwx1rz2yfS3ORuy6zdU/Qmi5sSZdGBrkEexCvw2Sl0xWa3h2uUfSktUuTP8jfGO
	 7Wc41sTOsGrwykl1nPSfHJ5zpOU66TsO6xlYCbzhadwKHHO5vb22BoFv0brcOhLxG1acE
	 4VslpTX4E62+Q9QsMlh2KPaLSmFaCwnHc9NHgp0SM8KYL4n5nVM6t8YGrH1xQruRbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=opPc+eRANnsL3IgwnH1KHoUHY5QiZX1lM2OixXujM5s=;
	b=d/NauFuZK8JeuMML9TT/iDzuhqXrv8bGb4HwAn3feW3y9QRB8sYBm/S3GOmCZh85CWvk
	 JtSOzK85Lj+1KUzDCW1zp4i3xRRTcDCYbFggkfZBBdt6Y7nn5fgjcMGBaKeS0ysdHChyZ
	 pdobegt0rD31XctZ+uAUW015KY5nnDxybpgGTWTHQsRMXLH2IZGSQOr/25VaIkbQCSkT/
	 q9lQXKssmO5VaZqPtmoEaZjrxHDAj9NTX4RftpJRJvveh1Lae+9heFujC2DllUz/pGAlA
	 32mK7Z9FMyA893iN9LSkgnoONgwO/7O0ilGP9mf3EfuiTwd4x4uGV5cB9Y5OTlNSkZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DMsHHchj;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB85606A31D
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 12:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DMsHHchj
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c438ca31778so143386366b.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792673408; x=1793278208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=opPc+eRANnsL3IgwnH1KHoUHY5QiZX1lM2OixXujM5s=;
        b=DMsHHchjfhEFKBBrw4fIxgT97StwkOmkCi2mal4kRQNs2vkrkhAAcMsrSObSortg88
         pc71Jt1p1+m1Htltp305qagrdU2wgYkcUrb0sAl28ql2baldIwNJfgdBJyYeIifTZxTh
         fWQoq+jKwm9lnKYVo1BnPw4fUQoKd3IS0WZsZPG7Qtmeh6WZ6yfu37sNJGwt+55eYYwK
         YSQyB0ubmm5E+JIgBjyUJPBgZ2OEDqKo1MiyYdwr4DID/7LKS6WEdO27zAZdzU7zyFRl
         wMX3P6Wm18jN425VpWA+Wx2P2MIiQ+iTOESg6hDcC/sGRrj9QtBw2f1rJxN2oEzOIJiu
         1O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673408; x=1793278208;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opPc+eRANnsL3IgwnH1KHoUHY5QiZX1lM2OixXujM5s=;
        b=cKFCUe6YlyQ5C7INzXeih8Ackl3JrM/XxL4InNa1uvMjr18FY2xpsO04nFDuhB6nAS
         nAaJKx2jLd/B6P+WippIZZVn00sYBuecs+t33cYBlEMK/TzOGiQRrDhkgFdHIPVtlG/W
         ZoQTk1b7ebhGgDnRvaHg1EuVzwQYFjh6GrzGqiDE3xSEiiAuq/BCe5DB5bpVb+8IX1o8
         QeRrQR0wsEM1yXGN6fwLwzkZK8UZ/fBdF/9mSWWpbgIe0ad6nNvqMa1LvgF8dPSMH+gf
         VdiX7W0Ayl0OhvYFY5c7Ps1B77GlcMwr/88xhA29tz++LS9ziZ5cy1qizd1mRntT2CjD
         cfGA==
X-Forwarded-Encrypted: i=1; AKwUvBzOexp09z4b814eIZq3cS+NoYSn7GWFIumdCvFT+5lBrIM0DuTw4+iNyW99OzQu7apByGy/mYHYRUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYvxtXC6YApfL176YlF/eRxKSCJxF5z66qqMPBvpW06tUnYm1q
	iqnHIiHREMNFysAZCFp0M2spo0afccA48ED9+BxYHaYgqk7zJQ4HCyvYvcoZgNxUV6/uPgVm6s4
	B64plICHr6Jqh8dOpNg==
X-Received: from ejcty16.prod.google.com ([2002:a17:907:c710:b0:c29:490f:9a3d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9406:b0:c31:73b8:39b3 with SMTP id a640c23a62f3a-c4679796deemr525575766b.30.1792673407508;
 Thu, 22 Oct 2026 05:50:07 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:50:06 +0000
In-Reply-To: <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
Message-ID: <9huzik2t5281.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


I have gone through the discussion in reply to this thread between
@dmatlack and @pasha

I am not sure If I understood the discussion correctly.

userspace IOCTL for FLB compatiblity might not necessary as each FLBs are
registered with the file handler. So when new file handler introduced in th=
e
system, new flb handlers can be registered that is compatible with this
new file handler. I have tried to explain this below.

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.com=
> wrote:
>>
>> Currently luo_preserve_file() iterates over luo_file_handler_list and
>> picks the first registered handler whose .can_preserve() callback
>> returns true. When a subsystem introduces a new, backwards-incompatible
>> file handler alongside an existing one for the same file type, userspace
>> has no way to choose which handler preserves a file descriptor, nor can
>> the kernel keep the existing rollback-safe handler as the default while
>> allowing callers to opt into the new handler.
>
> That is not how it will work.
> If we are in the .can_preserve() call,
> it means the user has already decided which file handlers to use.

That is not true.

From the documentation of the luo_preserve_file(): 3rd point.

* This function orchestrates the first phase of preserving a file. It perfo=
rms
 * the following steps:
 *
 * 1. Validates that the @token is not already in use within the file_set.
 * 2. Ensures the file_set's memory for files serialization is allocated
 *    (allocates if needed).
=3D>* 3. Iterates through registered handlers, calling can_preserve() to fi=
nd one
 *    compatible with the given @fd.
 * 4. Calls the handler's .preserve() operation, which saves the file's sta=
te
 *    and returns an opaque private data handle.
 * 5. Adds the new instance to the file_set's internal list.
 *

luo_preserve_file():

	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
		if (fh->ops->can_preserve(fh, file)) {
			if (try_module_get(fh->ops->owner))
				err =3D 0;
			break;
		}
	}


the first handler whose can_preserve return true will be selected as the
FH;

later in code:

      	err =3D fh->ops->preserve(&args);

So can_preserve() is called on every handler for a fd and once it finds
the FH which reutrns true, it uses its preserve call to preserve the file.

> We
> need to do that before any preservation happens; otherwise, we could
> run into conflicts on FLBs i.e. FH of different version require
> different FLBs.

My change below will select the user passed handler directly if it is
valid otherwise it fallbacks to looping .can_preserve based selection.

****For flb****:

Registration of flb handlers happens with original
subsytem fd handler, for example, for iommu

 iommu_liveupdate_register_flb(&iommufd_ser_handler); ->liveupdate_register=
_flb(fh, flb);

This function takes the FH argument. So every FH has direct relation
with their flbs.

If new FH will be introduced within the system, it must register
compatible flbs handlers with it by liveupdate_register_flb.

Currently, FLB objects are preserved with the first dependent file's
preservation. and each flb handler in fh->flb_list (was associated
using each flb handler registration) will call its ops to preserve itself.

Same on retrieval side, handler name is preserved so the flb name is
also preserved. And they can just call their respects ops to retrieve
themselves.

What about If user try to preserve other dependent but same subsystem
files with different handler. Kernel must reject this. I have not
integrated this support. Which can also be added as part of this series.
Let me know if this sounds good, Then I will add that in the V3?

~Tarun

>
> Therefore, there should be a luoctl call (i.e via a new ioctl to set
> compatability) that provides the kernel with the specs file of the
> target kernel we are updating to, allowing the kernel to select the
> compatible file handlers. Since .can_preserve() is called when the
> user is already preserving files, the specification must have already
> been supplied, or the kernel should fall back to using the default
> (i.e., latest) file handlers.
>
>>
>> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
>> liveupdate_session_preserve_fd immediately after token, keeping
>> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
>> original 16-byte structure continue to work:
>> - When handler is empty (all-zero, or zero-filled when userspace
>>   passes the 16-byte structure), luo_preserve_file() selects the first
>>   registered handler whose .can_preserve() callback accepts the fd.
>> - When handler is non-empty, it must be null-terminated within
>>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
>>   luo_preserve_file() looks up the registered handler with that exact
>>   name (returning -ENOENT if unknown) and verifies that its
>>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
>>
>> The retrieve ioctl is unchanged because the handler is identified by the
>> name stored in the serialized payload from the source kernel.
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/uapi/linux/liveupdate.h  | 12 +++++++++---
>>  kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
>>  kernel/liveupdate/luo_internal.h |  3 ++-
>>  kernel/liveupdate/luo_session.c  |  7 ++++++-
>>  4 files changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveup=
date.h
>> index 509c6236720d..2413b19dabc1 100644
>> --- a/include/uapi/linux/liveupdate.h
>> +++ b/include/uapi/linux/liveupdate.h
>> @@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
>>
>>  /**
>>   * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_PRE=
SERVE_FD)
>> - * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
>> - * @fd:    Input; The user-space file descriptor to be preserved.
>> - * @token: Input; An opaque, unique token for preserved resource.
>> + * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
>> + * @fd:      Input; The user-space file descriptor to be preserved.
>> + * @token:   Input; An opaque, unique token for preserved resource.
>> + * @handler: Input; Optional null-terminated file handler name (max len=
gth
>> + *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) se=
lecting
>> + *           which registered handler preserves @fd. If empty (all-zero=
, or
>> + *           omitted when passing the 16-byte structure), the kernel se=
lects
>> + *           the first registered handler whose .can_preserve() accepts=
 @fd.
>>   *
>>   * Holds parameters for preserving a file descriptor.
>>   *
>> @@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
>>         __u32           size;
>>         __s32           fd;
>>         __aligned_u64   token;
>> +       char            handler[LIVEUPDATE_HNDL_NAME_LENGTH];
>>  };
>>
>>  #define LIVEUPDATE_SESSION_PRESERVE_FD                                 =
\
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index fb81239bedf3..be20e0f1e0aa 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
>> @@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set *f=
ile_set, u64 token)
>>   * @file_set: The file_set to which the preserved file will be added.
>>   * @token:    A unique, user-provided identifier for the file.
>>   * @fd:       The file descriptor to be preserved.
>> + * @handler:  Optional NUL-terminated handler name. If NULL or empty, t=
he first
>> + *            registered handler whose .can_preserve() accepts @fd is s=
elected.
>>   *
>>   * This function orchestrates the first phase of preserving a file. Upo=
n entry,
>>   * it takes a reference to the 'struct file' via fget(), effectively ma=
king LUO
>> @@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_set =
*file_set, u64 token)
>>   *         -EBUSY if the file descriptor is already preserved by anothe=
r session.
>>   *         -EBADF if the file descriptor is invalid.
>>   *         -ENOSPC if the file_set is full.
>> - *         -ENOENT if no compatible handler is found for the file type.
>> + *         -ENOENT if no matching handler is registered or accepts @fd.
>> + *         -EINVAL if the named handler cannot preserve @fd.
>>   *         -ENOMEM on memory allocation failure.
>>   *         Other erros might be returned by .preserve().
>>   */
>> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
>> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
>> +                     const char *handler)
>>  {
>>         struct liveupdate_file_op_args args =3D {0};
>>         struct liveupdate_file_handler *fh;
>> @@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_set=
, u64 token, int fd)
>>         err =3D -ENOENT;
>>         down_read(&luo_register_rwlock);
>>         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
>> +               if (handler && handler[0]) {
>> +                       if (strcmp(fh->name, handler))
>> +                               continue;
>> +                       if (!fh->ops->can_preserve(fh, file)) {
>> +                               err =3D -EINVAL;
>> +                               break;
>> +                       }
>> +                       if (try_module_get(fh->ops->owner))
>> +                               err =3D 0;
>> +                       break;
>> +               }
>> +
>>                 if (fh->ops->can_preserve(fh, file)) {
>>                         if (try_module_get(fh->ops->owner))
>>                                 err =3D 0;
>> @@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_set,=
 u64 token, int fd)
>>         }
>>         up_read(&luo_register_rwlock);
>>
>> -       /* err is still -ENOENT if no handler was found */
>>         if (err)
>>                 goto err_fput;
>>
>> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_in=
ternal.h
>> index dac6644bfb18..911ffedec9f3 100644
>> --- a/kernel/liveupdate/luo_internal.h
>> +++ b/kernel/liveupdate/luo_internal.h
>> @@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions_p=
a);
>>  int luo_session_serialize(void);
>>  int luo_session_deserialize(void);
>>
>> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)=
;
>> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd,
>> +                     const char *handler);
>>  void luo_file_unpreserve_files(struct luo_file_set *file_set);
>>  int luo_file_freeze(struct luo_file_set *file_set,
>>                     struct luo_file_set_ser *file_set_ser);
>> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_ses=
sion.c
>> index f48e9a4185f9..194ef45907c1 100644
>> --- a/kernel/liveupdate/luo_session.c
>> +++ b/kernel/liveupdate/luo_session.c
>> @@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_sessi=
on *session,
>>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
>>         int err;
>>
>> +       if (strnlen(argp->handler, sizeof(argp->handler)) =3D=3D
>> +           sizeof(argp->handler))
>> +               return -EINVAL;
>> +
>>         guard(mutex)(&session->mutex);
>> -       err =3D luo_preserve_file(&session->file_set, argp->token, argp-=
>fd);
>> +       err =3D luo_preserve_file(&session->file_set, argp->token, argp-=
>fd,
>> +                               argp->handler);
>>         if (err)
>>                 return err;
>>
>> --
>> 2.56.0.212.g129ede20d9-goog
>>
