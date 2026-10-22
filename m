Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792676583;
	b=liRiHdzKr04CkxUK56pXY0D0fgreRBuZ3e7+UqbziSZjWYVGKsHvdmwK1WBVGMuxyOfN
	 thZ0Pqi+7Q6fKHfT04AcgOBJSTHBh4TDgvlChz+vCm6JrTduRPuaPiRQdBez7hmQ5IgjG
	 /8A0p/z7Kz4aUHfk4rLzpt5OFpt8iIfMAPmqpzrSO48ryCxi0knpkJOsXVVpESPitI9PD
	 xprecqQnsDxcDxz7NqQNaIqeiKl2zSdeQYQBdwoUMtd69vnZvB6UlwG4+ldtRE9DF1U27
	 KuwgEHK41Ki7IAzJ3mRisTLhe6T2CceMuLZQViYfJOw9cTGGEcerz6qC/2G3AdFBY8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
	b=tMXJq+9nDdH21q2+Y1KtaOhAEHlE14zeGoL6bVJe+WEmmYM3hwD1aGcuqAzdhXY4w0jv
	 UTWa8MMHn3vZEEnLvfRFvDfaEqXOID5KPnHYgo1LhMSReXWtGSgla8VyTb3zGoOs1iiir
	 7yCdhHCzhDPb6EIumK7/W9ywhlnYq8hzjZ3V4KJuOUacw2LUPnFMMs44Hv+jkvASpJLfI
	 0RO/AjB/whbdXlumsozKK+iqD33DFceEq1IlMSfY+16JQEIaWd5SxZseNwfCm/68dCTD6
	 dqV8A7S+7qcJSGBfst5jNTw2bLIaM6W/n9Kss39Z0sy9DLJ+ZXLC8slF13pOXe5QzTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=W1Ud43OR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92860A263A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B92860A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=W1Ud43OR
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so2473367a12.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 06:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792676581; cv=none;
        d=google.com; s=arc-20260327;
        b=kK+odDKBDTHn5p4BPwpx/Wd8L9GxKnGPmxPUI+2r4DrQ9vmGwZz5q4rppZjaslXiw+
         hTObcM7oSHgTlZJeotAnFASPE09bnORv2B7a8Eu66jaeCiSidDjn0b9BEmJ3lyZZ72jN
         92NBmnDWsILQL3RNQGZ7b1F/oAI7kecyFzoOxFV+O7j+0J3ZoONC3yKXUvrZrGckbUCK
         HZKR3hR9pV7JhMG8VoLpQWG+PbWjSBHzwGC71+qqNPH4Bqfe5j7RaILioeEK56CbtfQv
         JjKBEfAVr4VupbXT8n7vnlHokhLFgdLmnAmlq4cQ5YQjDonFtr3jPiMjCQCf3T/YWfnn
         KZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        fh=c0Ojz73OWuQnmUyDVvD6pMNY25a1srkU2aGGRS/yT6k=;
        b=SqKdc5La9CE4SRDBC/2qxysuBmnERtslLYhxUBHhafgt538gMDjMXJcCoHKAJz8DTR
         1FzxiRjRQsbiZRNzRHQ33QJKRBBXnUyPG2m1pn3Kh1EPfrPcxH/2eOddySlVHu/vT6hS
         diYKXkE+okMIiyPTXz8n0yWIVZB83gzmycTnd02nbpL1ytvjSURkSTxx1u001U4sbgae
         BFkZijq15AUO/Dq9/8hpiI1w+Ers9DNMhFvaMiWVxksZDMeLhispjV5AvQgR4oiTxxi/
         6jDlcVPLKXaK9oVe5CMDc1JiqnjAiFnzh8vLaGuAb+LXxGo+tb70FPHyFLJZeqMJFuFJ
         xuHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792676581; x=1793281381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        b=W1Ud43ORzgSFMDywx4yvDHgCuuF+9zibORRfmsLvoGg8BFOpG4Lbjv6C87RTAZOJtf
         QkMOCWMIoew6FIFD0Ynxigr5YmQF64OsEYl3GNvsCkhU1FIwRi3Ku0YfJ09ZBIpsA/a8
         CC9bLa3cPKSPHM89GoFI46a62fUtGeCfdtyVM+5ooCJQvMiYwNMW1Xk/0RMHO5uhn/2t
         Bo56RpK3wG6iAMnifAt07fZPmqe3nnQzD8DRosuZG+SomyXv3BALLv5B9/tV/SJdvMMP
         FYdLZ24HLrVHFCtMG+t2A2oPAAP8Lr7/W1/TLYZXea3u69Vuz9EUmrNwNkAefXZIWVmj
         HiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676581; x=1793281381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gizFMxgAiNeNcK9yHAVbAAuSg3KjclB/mQKEXDByXnY=;
        b=Tgsk0lz/GllXlm4JiocVayiDJn4C5JVlWVc/eH42AKeu8ykCNd6m6w2qInkDVG0QoV
         76LtH3kHEjBF6DKkVQOang5Xeqy/DRxSqsVubPi9VunLYr6pxPykhmd8QdYNkLSHk0mR
         lSg4bqrLAgapXVpZxm8P1WhbR8mbidI+ghzfbBwoOeA77fp224Y9N/iZaF4ELootfGNF
         lHk7jLSRHfbwtdqxWtBbVCa9DTGdkCIpd6SVFONa+oIE1LQxLrsyYBGp6HwhCYc050QO
         Bsw76Xn1bTSFyQtJ2Kbfm9+YWGYTIX4Px3CnR+2l9Wi08aBg41Kfmz34PsCJqcvlyAJ4
         x57w==
X-Forwarded-Encrypted: i=1; AKwUvByR+dCLahTj9numCthApnPJMTLkG+Oe4z1EdQ8IKNuuns6TJF1JFwVzRXieELXpPlwYWHjst4tfaIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmgfdUnxi8cEivIGKNTcNZrG9EF/Y2Ti/0IfQLbquCXHtd/Uoz
	u1pL+ThC++zE8h5Imex0wtOBq43lzRFGWyZgLVkEpV+HlYLEC/GjFVpIHGjqO5iKBJDDhLEccL9
	/ld+naJ8lUzAYu2icHEMcJ+Y+hIYHO7UWkiEApkhEnA==
X-Gm-Gg: AYBFou0fFGxBBtStvWibhk43RkO8hjzyJsWSp9q48m6tC4jm8+oRy7IZuBQyB5VYzFH
	kGiBYTAlysIiu21naSaMrlhJMyYKTZHEjCLMkyc2ikULp+EH4WxjjiWZoo9L+WQJDOZ6HhZ7TgA
	j7rF8aCg9ae+SqZf11+LKGtdBkyALxCbLZzTDgm1gvkG1acCZ09A8J6+FwF4XnL85SqQ5rUQVYz
	juV1MrU07ylTdYFLBAcYSnZrLLeQPwJQzXAStXyTNELFAsx/ZmVnCnxQ1N0LKmnFarEF2z+z/nJ
	3wd2PUjAWG27jQTLgMC/X/wGEH5Uax3njgLExgcMRe6IkwdIsVLPmQPE9EcdaeDCVqP+BASafvv
	xPm6MBMQzTuxysplESvgnRsVAyHCkjc3A7PCFPXsPdhjOTGQKz6F5K0hbmE7XQ85BchNy
X-Received: by 2002:a05:6402:51cb:b0:6b1:ba86:5f55 with SMTP id
 4fb4d7f45d1cf-6b408eda746mr4955017a12.35.1792676580475; Thu, 22 Oct 2026
 06:43:00 -0700 (PDT)
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
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com> <9huzik2t5281.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzik2t5281.fsf@tarunix.c.googlers.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 09:42:22 -0400
X-Gm-Features: AclHuK8k5bT2ZKs2HYGA795ETIkO2JydSGkbGrRRu0cT3FC7RgYcT81JMzNVsA4
Message-ID: <CA+CK2bA2zqQJryBqpoNG7RQqnUnQT1+d8G5xwrjx0Dqo58woHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
To: tarunsahu@google.com
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

On Thu, Oct 22, 2026 at 8:50=E2=80=AFAM <tarunsahu@google.com> wrote:
>
>
> I have gone through the discussion in reply to this thread between
> @dmatlack and @pasha
>
> I am not sure If I understood the discussion correctly.
>
> userspace IOCTL for FLB compatiblity might not necessary as each FLBs are
> registered with the file handler. So when new file handler introduced in =
the
> system, new flb handlers can be registered that is compatible with this
> new file handler. I have tried to explain this below.
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> Currently luo_preserve_file() iterates over luo_file_handler_list and
> >> picks the first registered handler whose .can_preserve() callback
> >> returns true. When a subsystem introduces a new, backwards-incompatibl=
e
> >> file handler alongside an existing one for the same file type, userspa=
ce
> >> has no way to choose which handler preserves a file descriptor, nor ca=
n
> >> the kernel keep the existing rollback-safe handler as the default whil=
e
> >> allowing callers to opt into the new handler.
> >
> > That is not how it will work.
> > If we are in the .can_preserve() call,
> > it means the user has already decided which file handlers to use.
>
> That is not true.

Please re-read what I wrote: I said that is not how it *will* work.
Currently, we only have one FH per supported FD type, and that is how
it will remain when we supply the target kernel specs. before the live
update begins.

>
> From the documentation of the luo_preserve_file(): 3rd point.
>
> * This function orchestrates the first phase of preserving a file. It per=
forms
>  * the following steps:
>  *
>  * 1. Validates that the @token is not already in use within the file_set=
.
>  * 2. Ensures the file_set's memory for files serialization is allocated
>  *    (allocates if needed).
> =3D>* 3. Iterates through registered handlers, calling can_preserve() to =
find one
>  *    compatible with the given @fd.
>  * 4. Calls the handler's .preserve() operation, which saves the file's s=
tate
>  *    and returns an opaque private data handle.
>  * 5. Adds the new instance to the file_set's internal list.
>  *
>
> luo_preserve_file():
>
>         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
>                 if (fh->ops->can_preserve(fh, file)) {
>                         if (try_module_get(fh->ops->owner))
>                                 err =3D 0;
>                         break;
>                 }
>         }
>
>
> the first handler whose can_preserve return true will be selected as the
> FH;
>
> later in code:
>
>         err =3D fh->ops->preserve(&args);
>
> So can_preserve() is called on every handler for a fd and once it finds
> the FH which reutrns true, it uses its preserve call to preserve the file=
.

And as I explained later in that e-mail, the set of FHs will be
decided ahead of time:

"Therefore, there should be a luoctl call (i.e via a new ioctl to set
compatability) that provides the kernel with the specs file of the
target kernel we are updating to, allowing the kernel to select the
compatible file handlers. Since .can_preserve() is called when the
user is already preserving files, the specification must have already
been supplied, or the kernel should fall back to using the default
(i.e., latest) file handlers."

The user/admin will configure the active set of FHs *before* the first
FD is preserved. By the time we search for a compatible FH via
.can_preserve(), that choice has already been made, and there will be
ONLY one active FH per supported FD type.

>
> > We
> > need to do that before any preservation happens; otherwise, we could
> > run into conflicts on FLBs i.e. FH of different version require
> > different FLBs.
>
> My change below will select the user passed handler directly if it is
> valid otherwise it fallbacks to looping .can_preserve based selection.
>
> ****For flb****:
>
> Registration of flb handlers happens with original
> subsytem fd handler, for example, for iommu
>
>  iommu_liveupdate_register_flb(&iommufd_ser_handler); ->liveupdate_regist=
er_flb(fh, flb);
>
> This function takes the FH argument. So every FH has direct relation
> with their flbs.
>
> If new FH will be introduced within the system, it must register
> compatible flbs handlers with it by liveupdate_register_flb.
>
> Currently, FLB objects are preserved with the first dependent file's
> preservation. and each flb handler in fh->flb_list (was associated
> using each flb handler registration) will call its ops to preserve itself=
.
>
> Same on retrieval side, handler name is preserved so the flb name is
> also preserved. And they can just call their respects ops to retrieve
> themselves.
>
> What about If user try to preserve other dependent but same subsystem
> files with different handler. Kernel must reject this. I have not
> integrated this support. Which can also be added as part of this series.
> Let me know if this sounds good, Then I will add that in the V3?

No, do not go this route. Rejecting mismatched handlers on subsequent
FDs still leaves handler selection as a per-FD decision, meaning the
first session/process to preserve an FD dictates the FH and FLB
version for the entire subsystem. Individual processes preserving FDs
should not need to know which handler version the target kernel
supports. Version compatibility is a global orchestration policy and
should be configured once up front before any FDs are preserved.

Pasha

>
> ~Tarun
>
> >
> > Therefore, there should be a luoctl call (i.e via a new ioctl to set
> > compatability) that provides the kernel with the specs file of the
> > target kernel we are updating to, allowing the kernel to select the
> > compatible file handlers. Since .can_preserve() is called when the
> > user is already preserving files, the specification must have already
> > been supplied, or the kernel should fall back to using the default
> > (i.e., latest) file handlers.
> >
> >>
> >> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
> >> liveupdate_session_preserve_fd immediately after token, keeping
> >> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
> >> original 16-byte structure continue to work:
> >> - When handler is empty (all-zero, or zero-filled when userspace
> >>   passes the 16-byte structure), luo_preserve_file() selects the first
> >>   registered handler whose .can_preserve() callback accepts the fd.
> >> - When handler is non-empty, it must be null-terminated within
> >>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
> >>   luo_preserve_file() looks up the registered handler with that exact
> >>   name (returning -ENOENT if unknown) and verifies that its
> >>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
> >>
> >> The retrieve ioctl is unchanged because the handler is identified by t=
he
> >> name stored in the serialized payload from the source kernel.
> >>
> >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> >> ---
> >>  include/uapi/linux/liveupdate.h  | 12 +++++++++---
> >>  kernel/liveupdate/luo_file.c     | 21 ++++++++++++++++++---
> >>  kernel/liveupdate/luo_internal.h |  3 ++-
> >>  kernel/liveupdate/luo_session.c  |  7 ++++++-
> >>  4 files changed, 35 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/live=
update.h
> >> index 509c6236720d..2413b19dabc1 100644
> >> --- a/include/uapi/linux/liveupdate.h
> >> +++ b/include/uapi/linux/liveupdate.h
> >> @@ -126,9 +126,14 @@ struct liveupdate_ioctl_retrieve_session {
> >>
> >>  /**
> >>   * struct liveupdate_session_preserve_fd - ioctl(LIVEUPDATE_SESSION_P=
RESERVE_FD)
> >> - * @size:  Input; sizeof(struct liveupdate_session_preserve_fd)
> >> - * @fd:    Input; The user-space file descriptor to be preserved.
> >> - * @token: Input; An opaque, unique token for preserved resource.
> >> + * @size:    Input; sizeof(struct liveupdate_session_preserve_fd)
> >> + * @fd:      Input; The user-space file descriptor to be preserved.
> >> + * @token:   Input; An opaque, unique token for preserved resource.
> >> + * @handler: Input; Optional null-terminated file handler name (max l=
ength
> >> + *           %LIVEUPDATE_HNDL_NAME_LENGTH including null terminator) =
selecting
> >> + *           which registered handler preserves @fd. If empty (all-ze=
ro, or
> >> + *           omitted when passing the 16-byte structure), the kernel =
selects
> >> + *           the first registered handler whose .can_preserve() accep=
ts @fd.
> >>   *
> >>   * Holds parameters for preserving a file descriptor.
> >>   *
> >> @@ -152,6 +157,7 @@ struct liveupdate_session_preserve_fd {
> >>         __u32           size;
> >>         __s32           fd;
> >>         __aligned_u64   token;
> >> +       char            handler[LIVEUPDATE_HNDL_NAME_LENGTH];
> >>  };
> >>
> >>  #define LIVEUPDATE_SESSION_PRESERVE_FD                               =
  \
> >> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file=
.c
> >> index fb81239bedf3..be20e0f1e0aa 100644
> >> --- a/kernel/liveupdate/luo_file.c
> >> +++ b/kernel/liveupdate/luo_file.c
> >> @@ -207,6 +207,8 @@ static bool luo_token_is_used(struct luo_file_set =
*file_set, u64 token)
> >>   * @file_set: The file_set to which the preserved file will be added.
> >>   * @token:    A unique, user-provided identifier for the file.
> >>   * @fd:       The file descriptor to be preserved.
> >> + * @handler:  Optional NUL-terminated handler name. If NULL or empty,=
 the first
> >> + *            registered handler whose .can_preserve() accepts @fd is=
 selected.
> >>   *
> >>   * This function orchestrates the first phase of preserving a file. U=
pon entry,
> >>   * it takes a reference to the 'struct file' via fget(), effectively =
making LUO
> >> @@ -238,11 +240,13 @@ static bool luo_token_is_used(struct luo_file_se=
t *file_set, u64 token)
> >>   *         -EBUSY if the file descriptor is already preserved by anot=
her session.
> >>   *         -EBADF if the file descriptor is invalid.
> >>   *         -ENOSPC if the file_set is full.
> >> - *         -ENOENT if no compatible handler is found for the file typ=
e.
> >> + *         -ENOENT if no matching handler is registered or accepts @f=
d.
> >> + *         -EINVAL if the named handler cannot preserve @fd.
> >>   *         -ENOMEM on memory allocation failure.
> >>   *         Other erros might be returned by .preserve().
> >>   */
> >> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d)
> >> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d,
> >> +                     const char *handler)
> >>  {
> >>         struct liveupdate_file_op_args args =3D {0};
> >>         struct liveupdate_file_handler *fh;
> >> @@ -266,6 +270,18 @@ int luo_preserve_file(struct luo_file_set *file_s=
et, u64 token, int fd)
> >>         err =3D -ENOENT;
> >>         down_read(&luo_register_rwlock);
> >>         list_private_for_each_entry(fh, &luo_file_handler_list, list) =
{
> >> +               if (handler && handler[0]) {
> >> +                       if (strcmp(fh->name, handler))
> >> +                               continue;
> >> +                       if (!fh->ops->can_preserve(fh, file)) {
> >> +                               err =3D -EINVAL;
> >> +                               break;
> >> +                       }
> >> +                       if (try_module_get(fh->ops->owner))
> >> +                               err =3D 0;
> >> +                       break;
> >> +               }
> >> +
> >>                 if (fh->ops->can_preserve(fh, file)) {
> >>                         if (try_module_get(fh->ops->owner))
> >>                                 err =3D 0;
> >> @@ -274,7 +290,6 @@ int luo_preserve_file(struct luo_file_set *file_se=
t, u64 token, int fd)
> >>         }
> >>         up_read(&luo_register_rwlock);
> >>
> >> -       /* err is still -ENOENT if no handler was found */
> >>         if (err)
> >>                 goto err_fput;
> >>
> >> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_=
internal.h
> >> index dac6644bfb18..911ffedec9f3 100644
> >> --- a/kernel/liveupdate/luo_internal.h
> >> +++ b/kernel/liveupdate/luo_internal.h
> >> @@ -101,7 +101,8 @@ int __init luo_session_setup_incoming(u64 sessions=
_pa);
> >>  int luo_session_serialize(void);
> >>  int luo_session_deserialize(void);
> >>
> >> -int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d);
> >> +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int f=
d,
> >> +                     const char *handler);
> >>  void luo_file_unpreserve_files(struct luo_file_set *file_set);
> >>  int luo_file_freeze(struct luo_file_set *file_set,
> >>                     struct luo_file_set_ser *file_set_ser);
> >> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_s=
ession.c
> >> index f48e9a4185f9..194ef45907c1 100644
> >> --- a/kernel/liveupdate/luo_session.c
> >> +++ b/kernel/liveupdate/luo_session.c
> >> @@ -266,8 +266,13 @@ static int luo_session_preserve_fd(struct luo_ses=
sion *session,
> >>         struct liveupdate_session_preserve_fd *argp =3D ucmd->cmd;
> >>         int err;
> >>
> >> +       if (strnlen(argp->handler, sizeof(argp->handler)) =3D=3D
> >> +           sizeof(argp->handler))
> >> +               return -EINVAL;
> >> +
> >>         guard(mutex)(&session->mutex);
> >> -       err =3D luo_preserve_file(&session->file_set, argp->token, arg=
p->fd);
> >> +       err =3D luo_preserve_file(&session->file_set, argp->token, arg=
p->fd,
> >> +                               argp->handler);
> >>         if (err)
> >>                 return err;
> >>
> >> --
> >> 2.56.0.212.g129ede20d9-goog
> >>
