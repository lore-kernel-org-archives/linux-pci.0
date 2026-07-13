Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A273D3338
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933076; cv=pass; b=P8JkTXZYThjBRK3g2bIdD0MH7dYHRVLdwbnTbSoNSMJSyGSfvt87NeZBwDWai5lW2eSFzr8b1+bg+r5xM9xwv1ykIWwnYB0rhb5NV83X8xZyibs+0jwdqk6jFpmdfoodU4DK2+2NoV3rW6sEdMMNq9xracNFTH4wjPuPskZl6kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933076; c=relaxed/simple;
	bh=zGXlgemVtM/fd1QacjWZsPwmu1tJ8IeGxyTqkvyGisI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5LtOBHXRYvQd69ZjVETYMgTpFQtIkVuhMyC6HR8IW6fTbghRm0rEt1Bl/mN0sPsHhNVOQP1UhSopC/QqRyEELu9WimL+Phb6OqbVCocYjsqEk2cOk9h6S4tmKmNvl7ID2zoDORBt14bajIbDm2ycFV2HyNxUV5nfs5F3Sv2zzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhZpWy9p; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhZpWy9p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475417f010dso1308082f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 01:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933071; cv=none;
        d=google.com; s=arc-20260327;
        b=ASpnZcm+UMfSQntAPdZkkzSsnwxPPwdDqvf3VRMFb52lFZaM6e3Q6/j6bRqRpFh+pc
         gfCkcbAWwe2Q0L9Krs8TOtKO3fmAfheRkzaRzHa7eqMXx519G7Nj1CRkx51LME5nwXFs
         vemqjRmPFtM8tCfvoCF772XIlwloEaXSFcpJHxjI/WoBV1TVAI6U4poR3n2rnpkb1Ltu
         qb9hk52+B3y/e9eTF5q2FUoRVZVR67mLjDSJMkMfw4lgiEPEtQl2Kc7T8rcH3xf/dAQn
         WztSOALD08XYh/nTRBWmVMCUmzwt7p9lN3y/kLQV78i7zgJYg5E9H+vHODHMnOrKfsk3
         Cfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        fh=48fzTTag2+rkT8VtT8EDSFjygnYH9IN1HJiFRXQQgmM=;
        b=iGzdOg4lx72okRGn/Pn10TaIrgFsIpdDoJTu3B6lM4qQKBHRN7p+u+kJTPxP1gM0zk
         6ik0PZ3qbxI82jzI4nSZwPInv5928LRPW9EaZ3O/CWDWeemNBdlKQ4jL3SecKwOYPf+5
         s3xuNe8UmitEWUdCgdq7sc3/Lw5YXfogqPQKS3ANNAWXOPiI2M6JpWyDqa8xV7ROcxTy
         D/qW3to+BF8Wn+F1B1cFGTq1MkCsAGYYYOukt3JoyQSzD8uoaI8zDhOiomnnmGhZsvYN
         vlY6zjoAmNs8U43+lUSDADU2C/I/b5GeQge/Mc58UX6ox5FDw288Z3NlwM0i9U5PyaBI
         zzmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783933071; x=1784537871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=bhZpWy9p92MsHXolXEEEzyqO6a8taUshJqNTLDakidqvhciCwPleXpZnFFjlWiYgu2
         PD4KtR4wi8mFviwOMoQsSLwoiUrgbFxzrfMzPSO3Sybm9n1+9I9aGIKm/8G9v52bT/Dy
         /ECgJDqbQXnj9gc2kOfy3eG3Oyas3PdEqt32qqoJCGj+tlRe2CTAPATVLVaT2ZBSLmFE
         6NLrPC6nlM9BaqCBTXA2N+qswyb64G3vtCx9kHyfA9GDzZl//f+Oby1N7yx4QVQbPtoh
         MUkxAek+4XmOD/fokqGCzy3ZmMRVg9nKjm32kMvJgFt/LiXZSc+ZvzDDjsD9s3OVP1/l
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933071; x=1784537871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=ri6kJFd1XIOFRlSCT6sLgonGvi1iIqakh7xCw/FjQ6mWTIgKeWsokQ7TszOsR+kEpj
         zK+F5lO53uVXOLa3quI6cVip2sLnlrBYXh/IDAyTtbDRcFupi4zbIdriqJW2Mk3SjkLd
         7G5QFRQZ7gQu0W/grdf2UwGnE7D8GUSn+jHP6trcwikv+una4G80yPWwDX0ICfAOxtTn
         29Y4EFPmnI5Yh3baimyFSDXUc1EHZ+oZEta8x+H5vhA20hCvlhP8R0+CW1YtLjvHlWHA
         Ar4BIEq3I9R0i0YmlSDJEW6bPJIUWi4AO4/0qP341cwhb7lvZgSLXSYB6EsGz4Hg3eXT
         3fxg==
X-Forwarded-Encrypted: i=1; AHgh+RrOUZCsi08XRpMCbsxBUsvs5lt8dfetJhWxQPs4cqygK+3ekugqoYOnzxq5W1CcIkDBMz0G5aECV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIA7BoHX1tqJ98Bms8h/SaqPncorc6wCfFjo30blLAmURqwmV
	pD3zeXgqGhJ/LJzWAnx0simQOryjGPoWffvCWsGqOYEiFQEpaC7tuM6jIir74RhPgQJYe/lxaJA
	XhF9nOggklOZoW9TpuuB45YfOclG10FBsMgjQWeHV
X-Gm-Gg: AfdE7ckEn9/lzoORZVvI1W8vVhToWGGI2dPdqjMGBsxOkmkZN+p47r1cawFgJD0DaYP
	BK6nXCh62bqy0eB1qztXFQh2YatduC/oUJkDbBbaKrYRpZAV4kkcLS4sufisjJhWM8HnlVi1eAu
	wLs0S751dd8YGSuLFPz60PsfyRfaN3YVw/ctGJj2CSScm2tvdiET3iMuK7ge6+84R/6mpALUMKL
	7hO7AZS4ZID0NHdPG+kSUZuwAkwthxnh6IJUq8qnAovSs6fGHsTTef9OpcCCJq30OwQ87UV+h1R
	QoE3epZjS1oEdLtwGsZc4+ngaSx0Czhhv6OHxb/SJqR0bnKAypD8eHfO+TLLhzwncw3rHg==
X-Received: by 2002:a5d:5850:0:b0:472:55a:ef9b with SMTP id
 ffacd0b85a97d-47f2dcac418mr8602513f8f.8.1783933070140; Mon, 13 Jul 2026
 01:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev> <alSe6PsvdrSYP_Z0@google.com>
 <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
In-Reply-To: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Jul 2026 10:57:37 +0200
X-Gm-Features: AUfX_mw1uUYgV4eMXkVflbUYoDKpPh-OOQHMx0yAVcG6yUMQsdEhmzk4SLg_fQ0
Message-ID: <CAH5fLggszOnUm7Rykt41V91de8h9YVaZt49wr52i3t5-QV84Xg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
>
> On 7/13/26 16:16, Alice Ryhl wrote:
> > On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> >> Module types now live in `rust/kernel/module.rs` alongside
> >> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> >> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> >> files are covered.
> >>
> >> Cc: Petr Pavlu <petr.pavlu@suse.com>
> >> Assisted-by: opencode:glm-5.2
> >> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7=
d21c5a1a1b8@suse.com
> >> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e035a3be797c4..74733de3e41ee 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17984,7 +17984,7 @@ F:   include/linux/module*.h
> >>   F: kernel/module/
> >>   F: lib/test_kmod.c
> >>   F: lib/tests/module/
> >> -F:  rust/kernel/module_param.rs
> >> +F:  rust/kernel/module*.rs
> >>   F: rust/macros/module.rs
> >>   F: scripts/module*
> >>   F: tools/testing/selftests/kmod/
> > Is there a reason why this is a separate commit from the commit that
> > introduces rust/kernel/module.rs file?
>
> Gary asked the same on v6; `git log` shows MAINTAINERS changes are
> conventionally
> standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate.
> Gary agreed [1].
>
> [1]:
> https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.=
net/

Ok, that's fine then.

Alice
