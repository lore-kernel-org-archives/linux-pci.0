Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E43DB625
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169855; cv=pass; b=gIoOAT7WokPgMomQ7AV6fWIxx9kj9oeKc8NnNflh1hiMaVqyMOrtQg/iilzqi4Z1c4/CkVcFEhPplindKxs2/BWyniAT0RBKcAB4H5xuEy7pMMHjD1jfrkT76RB+s4At4pBEgkSmUO17TvFBnGxMeF3qJndp/EZhTaVnI80MZdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169855; c=relaxed/simple;
	bh=RbuKONLY0/S+AJmxjQgwpW5xe4SNlSbwc6Tzv4DTTPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe+bB+GB6h+6b6Fi1BmxIR89jaOlN7DM3F8OF2hjlxS7PvJ9ovahT7CGpc5a7vqaRtr+Xl23rAwcnNWkPpmVT93ZUH5iZLCNbt4dYdH9NXiHsls4UGMSAF9U7lqMnrxjRNEHSkKCKhU80VH2uvO1s5HUiHvobyeiFfpcTi0p0T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU2Z1aF5; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU2Z1aF5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso542203a12.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 02:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788169849; cv=none;
        d=google.com; s=arc-20260327;
        b=n/UXp/YLoXSylDDalz/P2rmnU8RBjmNC3mFFeK8JoGROx1uEnbI+Pe8DD7k7gvnLeB
         sHKvd9FaT4N8g8fm1e3ttwXMbKqa+h5gYd9f0mxIXbx0yLUct+7u5NtvtJ66Hgc1qjYP
         8v7xz+13DGEKhEJnHrvcEgH8u8Obm/9bXAl7PwRQ2iJx9ms/FbYsUgP4FVNOvIWStmHu
         FQ/XfhLNwVsoQ+fe7sNo/KVm3VGXVKoHYx2u0hqWaJYPinKTvnPeVmGDCbKJVOt9HDmT
         bsoK24qu1Wa6FiEzSSwC4EWb5RW2gw6sP36U9c1fIUL00E6TS5zHivKffjIxvsfP+PtV
         bK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoMofcxx656wkcjtt08BKv2Pi44P6R9nDoS9NYe5W5M=;
        fh=XOKRUg0k/7d28vxEMbuRs+x/HIfU00r2k6CkCvZmmnk=;
        b=LBrLMrbNLR/OhLXhF9euuAjNoenno4xcQugTljrd/9x+ws77yIaHYYT8bMQbzuERIl
         +5Y7Tbo+jaX0Wm07JXXMDcd/IvF3mXSM8PzMYZWoew+2BwQbhwTy/mYlqobNVHlqBeEH
         V0KKcTC/yj9p8ax4tfmSMkOVbVwuPBXCcC00NrWCnxXZeSTftFsuLiWID1DT/tL0rCJh
         mNnRVyYxllVZ1OrYGrWFu+RbaTMSfUqeiQt89jz78ZMJk1+bz6Mz6ojSJX3lvAoHscY4
         zmnKdmfJc8Hklldj/GLZyktntHf4lBUtXl5wgAD5dYmma20TDIqFz55TgFqvVmKbQixL
         8w5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788169849; x=1788774649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoMofcxx656wkcjtt08BKv2Pi44P6R9nDoS9NYe5W5M=;
        b=NU2Z1aF5O2lfgwnc45eA/Drx5frvK5AQLzWrlmtFEvAvAyWjXiRVpHAeRZu/hWJiNy
         RMu+JqR13htB0X/e9aLNdMO9U1+8vwV24lZL9bx4At8zi2C3s3AGJ85ZuqQ4/9k3Y+Qb
         sXZRAWBX95JFFl46wQOkj1noKhBKomvfV5cpH3HIz4gUjS/n1YWI5J6Ww+UwgxT+8RFk
         lOB65F0iVVdf4e7YzbZIgnu5w4Ri9sYUUl8COaEfhpA9DEW/kZRE7KvGR8ve0gLNgA0+
         I/sw45EQZDZvV7bKHDvq7MRXzaLMj4GkK2SkvR6U0bk8B+obd0j0RFEwk99TvCRUsaE0
         pbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169849; x=1788774649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoMofcxx656wkcjtt08BKv2Pi44P6R9nDoS9NYe5W5M=;
        b=opQVbsKaw3NvtBATgTFAon+7Twe+Ybdd1nYwx86a3pnUsdllZ3M+1rO/Go+dfHhdxM
         RQ+pQPLORlwEEpg6925tvUdfLZuiOdbG0BsCblUsN18SxJLea7p6V/64oi3BPqeEWfKF
         FK3Y8I2YNJZCPnmG+wwniX/5cDF/CgS+jEqjs9aS/Y72fj5HDpXPl50yX6z2GX3fJYSk
         onAMaDGhJILDnHJ0o5ESbK/X/BRFXEAZ6sWf9u9596inHyqI5AHYi3a0NEs/ShcRUeMj
         OnPCDxNaeuiqY5OpgL5JJovCMU1EcFzKFSTZSevRfkf8nTy4sBWYCkEjS7o37gd5biqD
         U27A==
X-Forwarded-Encrypted: i=1; AKwUvBxd85dg6GDld1DaQPol6sxxIkYijTlbS3sqeNoanmyU4KVDMzm+B7WqkcvJLs3UG5BUcFadgmaJP7o=@vger.kernel.org
X-Gm-Message-State: AFuF++maCpt7c3wBTTya/9IycUTTizJgdCzPN+U5wtgSzK85Wnxhb53w
	a6EEySyAGCYJHevvll6bXAkXXKAzo3iTJLMEotzg5ErxsvR29lRchGBUFnTW+wub5r4a7ZkqHxt
	DJq5BZ0Oi+wqADoPqQekfrbGUpx2XYWE=
X-Gm-Gg: AYBFou03WTUjSwcER1JzsNu4HO3FWIhI2MrXVNQvNmkbJQo62BvtCkkH4tYiY/Pt+Pi
	+3o1kRjad2GA/TP1/QZUXJ8JPTbjXRDq8OcQlaytoDYz7YBk1B+uPaDc5loCVVwChk53Cc9JXzi
	NLX3GPN7zo1zmCdb4zXUiTpg0RojN0lnBStLCy+Z20Pn1bCXOvZiZ9iqV7LFYJOF9fMlr9g6pwO
	pphV37CcFoGybU/C8XhTbQ3Hq0aeynIISrSvMwGHMnjhnP1oYHbQZPvGRyVkZQJL1w4gG+Q8ORt
	ZLcKSFBSh83nhWI3ftnRGon6Nm8GiXULbL5/UZYIktMHmS75OBS0JDvs/lVh6yHdvJkt2hOkn6m
	mkT7Bl2NbVPHIHoolFqLbcu9A+O28JBBIdrJ9KbVGjK8GQSZwaHe2FD8/A1S2
X-Received: by 2002:a17:90b:4ad1:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-398bac28133mr11638970a91.4.1788169849364; Mon, 31 Aug 2026
 02:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
In-Reply-To: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 31 Aug 2026 11:50:34 +0200
X-Gm-Features: AcwNN1ViyddrDBit2qWlifkamMcobcRAYSEK9R5OBBJcArZIlXo8eUmjUf62r78
Message-ID: <CANiq72=8JgETrNHmoy0gHxPmfipUmVGq14EhjkU6JWYFE+7xhg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: pci: reject out-of-bounds IRQ vector indices
To: aiqubits@hotmail.com
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:17=E2=80=AFAM Sophon Z via B4 Relay
<devnull+aiqubits.hotmail.com@kernel.org> wrote:
>
> Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequ=
est in IrqVector")

The tag looks good, and there is no need for Cc: stable since this is
from yesterday's -rc1, so that is good.

Nit: we usually don't do newlines between tags.

> Signed-off-by: Sophon Z <aiqubits@hotmail.com>

Is this a known identity? Please see:

  https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin

> +        let index =3D u32::try_from(index).map_err(|_| EINVAL)?;

Do we need the `.map_err()`?

Thanks!

Cheers,
Miguel
