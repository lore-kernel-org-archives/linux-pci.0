Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA733065D
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524060; cv=pass; b=pzHy1oeLoO/PvTWHyZsnPiF2mJ7vneEkwdZQrujAhs3sE3l8tXti6pU+XbtUHOSxkNS5wHTzdUQmXw/2GjV3aJVdmHZg5EOxGSPhWoo0OObJAjveTwZL1q5GM0rSdVFz2vh0k+ZELriV71swF/9gWWeTi31VlwCrikBLYprazDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524060; c=relaxed/simple;
	bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkvM4UmWm2Q7Wn4g5IxkfcPKCz3J8VOl16s/Mj3OVdjoYj2Xu3odjXZ1HK8oa6wPTG7IKyelH0FYFTsEClx1AKx59lFHh7AFLmwg1WQCMYI10FlshCUdmTIKerbzUvKtPciZx2Wm1fzi/y5RfDrytovOjBg1mrjvqHWGjXJlPA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnH3+ytX; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnH3+ytX"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307b668e1f5so252731eec.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 04:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524059; cv=none;
        d=google.com; s=arc-20240605;
        b=hiTXi0FQFcDIZocGwdSnX/uOGMLw6dXriSZVYerVKrMspzYLQy+zu6W/zqzfho/Qez
         uDB2lapHgY1+Rdv0ggvxHHGhevpHjFpxvI/eTGqlXAuON1OlUUlf6W4WqxRJxKnKFwhF
         WI8C5SwfAMnNtXZ3pHYvJPJ087+Rlhefe/FXYyfSrO/L9pLoNiMKrT/ptugX2ZTNSRac
         TlZK4zfIGLoP4Rnm8g2Cq6xZxysR+C8KFsVQvAY38T+IKadRsdrG51XGT4qEOWtcr2a5
         m+Msb/k0Bvff8OD6LVh2+eZgFbpgjUBR2syPGF+Cp6A2jB7GwMDhk3IK+IaZ+7Cj5hU0
         LN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
        fh=pGMVce7Cl+4i59+Rdmvc999cis01wZUz5LBEIiT1o20=;
        b=MwOU5dLmbSrkpShgj3QgnsC58+/jFcmc0Sm4TcQiueJjnCQFLm4GIXUmtbnvzwwdTg
         hI7uOezT7PufdVxgRJQFJ94U4QNQmI0onDhKu3V4Rpl6FXy/RVTM5oCQhwY5oxU6A2yn
         gWgelbOE6F2Ubzw1tc5SHBMeTMrYr/oz4HlaUfzwUDy4X4iE34xZpvTYct1xPYLnXQQ2
         HDXwjm1S+jm6fXerV1ayhU/v4FIjsMqRiRimBXsFxMYz70fuvLiSj8tgWbj5Nv8e/XqZ
         fQIOrN52JeE5NvDAMNmd1H3vpc+LNP4gvj/8Pz1WOlJ/C5UBUHfGBmBTnRgZqIHxCYcX
         zXQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524059; x=1782128859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
        b=WnH3+ytXSeSYqSrxvNpsIZ/MsgkcR1gIvW/BRLc5c49+DPgOFvymSxT0MRSc+JjFse
         Aq5FrsB+d8LWLvYmHyv7BsWdtppeQhZ5xTlXPQAWOGyDbcnzqr6Cb2aLMOx0If8D/IXL
         fDhcF+p3dMXOnF1K2eYPmmaJXgK+ncYIXaItUbNsjbByx41328MqfdivFBKi8P3bGHhX
         1wpBfvT/wv9mCVXiZncPEyP+XMmwRrY8GpHjUIFoZG/N/1Yn6V7Ccc8zTyVyBFRZ2+BL
         UOnS0k8Q4kiZ+ICwufWSisIFTTKVF1MmWUTbOVFd7KPyKiivthIjE/RKTTBiWG1lU9Tb
         Wt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524059; x=1782128859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
        b=bucTEeDKLt7y6QzjKbU8qlObvn2jiztU7YM0jmeUkOxhw9lGXeH/mC0KvGH5yvOBkW
         9aHBC3Y0dq6JHIzOfUeT7dMNuNKZBXeOJ2/X1EJLY+N5FDIYBUUzqJFvh8pDhybGszwG
         yDUcwGKmP5hEtHm3jknU2ghlZiln0Eq7xeAvIuAPXRtjQSu9sr87ZMuSEBIG9dxbPpjG
         DB4d9vAW+hfMS7yBmQydvv7jZmADkpPGR1/DCdSBckVy6fF9DbSnMxL54r2/rcQeYcgz
         PJ/U6/g+U0M4LkeYqztPoZRykTo6cxeWVE68lh0dmHiLLn58e5LA8oPHvEQfGarKXYEf
         2NyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aNngOCJciZ9I88VI73zDeNv1d4uuetUY2KyNfVXkTJ0V3WPW4Lf/Yn+DFR3j8Cs3FWi+rwfgUnm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEuVE7JHFjOxkOvmDNky/dUj6yuKwg+0sQYXWgW/DpLURuCf+
	iKUzHX5Lz8ysj7zrikY/+czDEcrhSz1O3tJF+PbhVx5PIsI0Xd+clm+OX/qdxyN5sKz4yeT23FE
	M7mm7LcayP8VeEbZVlUHKnb8HTymgW/Q=
X-Gm-Gg: Acq92OEOeCbkhXp72KHxgAWCTNkcz0ON6LhKKO43oal4dJwbLHQUIx4PWb6WP6q47Rm
	M0qtfkQdWaoxDE4DdR5l1dh6XeHtuDHAcUw01DIvRVKmUser6S1vWX+0ZiZ5mT6F/NePvC3h8KF
	QkuOynx1yoV0sFanwELIPcERK6L2ux201y3774SCFdd/THNvhmRqk3/WyYE+nbUv4tvsdnB5x04
	Lg79aYxPRJjGynCbph18h1sahyWV6yxRTmy3hIKKQVnI8DFUmL+B+SMtmmtsmiOFPQSuL/wbH+r
	9VwSB3DdyJd1t7xpYy+MV/tzS3FODRjZTvztO1/DkZQgM+aPKYPxK/3MksVERIPcWDm0DBzYqtl
	yBMCdCrThgs0q2sHrrRfTVM0=
X-Received: by 2002:a05:7300:ca1:b0:2ce:db5e:354b with SMTP id
 5a478bee46e88-30820093556mr3538872eec.6.1781524058794; Mon, 15 Jun 2026
 04:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net> <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
In-Reply-To: <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Jun 2026 13:47:26 +0200
X-Gm-Features: AVVi8CegjUXU8O3nUA4IWQxEABTAWlEoMDkVbcmMfj4RlduFup8ycaEWEgohXlQ
Message-ID: <CANiq72n4LzuHdu+D0BT0iew29rck1OydryyTw5j8JKhtW0prNA@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:03=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> s/should/must? I guess we are running into all sort of issues if we
> create regions which runtime size is smaller than the compile-time one,
> and this is an invariant of `Region` itself.
>
> Maybe this method should even be made `unsafe` for this reason? The
> caller will need to write a `SAFETY` comment before dereferencing the
> pointer, but IIUC this comment is bound to cover the pointer invariants,
> not necessarily those of `Region`. Making the method `unsafe` would
> force the user to cover them here.

Given e.g. `dangling()` is available as a safe function for any `T`,
this necessarily can be safe too.

In addition, in general, in Linux we have been trying to avoid
unnecessary `unsafe` tagging, i.e. we try to avoid using it for
"merely dangerous" operations.

Thus taking those two things into consideration, then this should be safe t=
oo.

However, I think you may be pointing at the safety vs. validity
invariant difference (terminology is still up in the air as of a
couple weeks ago, from a quick check) -- it is true that technically
dereferencing a pointer doesn't require library invariants to uphold
right away, but in most cases (especially so if it is not your own
type) one needs to be very careful when dereferencing pointers w.r.t.
the library invariants of the type too (because otherwise it is likely
you end up with an unsound module or just UB soon after).

Cheers,
Miguel
