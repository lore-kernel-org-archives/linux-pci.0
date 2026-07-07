Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6FF3FAE1F
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429471; cv=pass; b=B3qw+ph+PFI6z1sQe3jwPdMQzasrqpof/FuVQfGG15Yw5l8IzThYHjM+dCUc1mlxeZx1i+Uj8JTEOj20h72CvARGhFzU7zYN+2Cr58YGfcOprlMCGUpeT2SvMtpNxSyzZ5tOF/eDt46tPnBfc32EYLmXo0EKd/0ccImbqTWXwB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429471; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jacQAMXrDoHLK1nHZh2htTtAHYpwd6/vtn0MuKns95mRyX5F0NXHghSG6gBDkFJejXYkBFUMvYQuTkBD44YT0oIoHwA1hv+NZ1BCSJnGWt0bOaN6OVi9pturSbeQC2+ajWm8e91FHKKubucduM2kpCl94hFrYTSGseP5K56wpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNRNvkik; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNRNvkik"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso41401655e9.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 06:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429467; cv=none;
        d=google.com; s=arc-20260327;
        b=NLSP9YQ3ZkgQLf5zeujedKdi6njGgA+k5rVl4T/wA8tmuMjzf3zTu7NQ8ikoGcKhfW
         UcSR5wjCmQmqR8swkf+1OdtgvJ27+a6TtLkRgje260M1ufLZmHbT9uJE4v+puUp3vLdy
         TQUjywdoqNJPv2jeQkmSXaH/hcvkoVwG+eufr4A7w5yxe3wKXtEBCE73zw7shpWj+TVg
         +Uzli+ji3eBqp2twFHZP29WgGbc6KqmyhYOwNooJfQiKugI/Ks/wu3lDfH6GjXQjg01p
         ikVAZyvHBhntM/Q1zzlojZIr754o9YUhf+EIskQNL7JFmpqSjyjKm0oyscN+XQm2Cn3r
         U5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=10jiqzjZEHpsMXR9bkxjQWSkkwt6CtcPO6Tcuv9Xmbs=;
        b=duohGbvO0NE9WG9G+bM5iXIpa3DLi24CAhYqKkc/H1JiCDFpoHrkMhDCT5STuzGM2a
         CwiyAIKVy4OKzW+5CcWYgJUvWDCcX4DhCEshbBNdqyieWlG26QWuq7+nJkQz9capzh+h
         /bbYEoJ7bioBOFyd/Oxte8Ww/+smOvQxfsasjBEe671NgtIAdlplrFTEmWAD2MvbRl7E
         cjBWCEs0/QCj++Jti171F2Kt0oc3RLzryq0D6zqeHbtna54Wz+emX1HJ6l5MAiMTlRO/
         ngBh9g6R5NnbP46XmAbnoAuNuDHY7WLWm2R8voupRPxlKsFe0UmvAp3lhZKBsfFG9RwY
         k1lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429467; x=1784034267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=dNRNvkikjxahImuUI1Drg6CXhxVxac7dmERU9WjMnbsmX5eHK8WY83RbZ6d8ZHmaOR
         obViGb56A87vfGXlOGE5CbAAs1hrc3UXO2XdohufG2m67EjQNWl3aM6kcmBgGlnhpXb0
         55N4uSy4UxvHsBdSOFUwN8a7Xi9ecmoWElcH41X7rtSVSWXt9PKW5oQc0sCPCWon1GQI
         UHzzE9kkhxCI83tNWa1pH1IKsm+3VVHfnK74tgTXhcNzcUaQuCRi71myU8x3J7bukLTo
         7OpG78s998Dgqd4mCuL/HwAzs93Lz6Hpr1UIbUvthgrkhpJuQ4eNyiuBinQ+gNC9MzBE
         pURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429467; x=1784034267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=hFMfBPhTKAalqSLrXYq68Z6G5O+RFH+q/bznCFySglt8FP34krGsJwhRIznczWgQx2
         bC6+OqUPQ8sVwwiQpxWnqSrCXzOMrqqh1ymUtxAhcUZMmd9rJ0HPo4PQ2sdBjPk1yJPT
         +tS/+dSoHjmVfP2veKadCfXhZkDPo7IjXadbShy3rIHdn6ZxvSAJqSv9KBpbHqTKK4bk
         +bZJdRYi08BUIMCQeQau9YeQ3/MU7EIGAuBWPz1dHuTG27bjYq8tOvwU260RriakgSeK
         zjcTWhVeIlWC4UCAU1dADL2ZDqL9THaLB9qINlQXl6jSx7rtGyhq9Ey2vKNXOtSVvQWV
         EhVg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1RN8YvM8MuAcn7fiJQoN39TuZFTYgf63o40pj5srybjLM9yYnqOzYEkbGmlJCL2RkKCNfIunN76M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTj5yYkeC7aRD8hknL1YobIqiw28KW9nRPBgLLV+StamEAiuR
	yPNltLXOI3q6v/yCeMUVuWzcbNpWujzOudUA1p7mkZvmWyCQs8YrDHAYkrZpIr+E4Iv9qjGDDa+
	qOtpQX6v7ijnR19MB/OptRIhmfVtbtmj531VAhoub
X-Gm-Gg: AfdE7cld2oEeOgHcL4IM4yp7vWOavOlM8aLdCL0MPI1Qw9OrffP3Gm0zCOLN7Py0Hod
	ZFVcPHNMPzpqMQzdbuGYxgsCU19F+4OWdQi287ufMLhsbkzD0U8x1tsSygB6yfJb+ldiCjguRFx
	adyF2aI5pSeuFxRvIJyqbcqwFZgIkQBgNnrNiEUiKsHGnOLKp0UbuqUH8Mhw750DgctbnH+nAWB
	2vYWJVbku6k8WTU/3V2hLqyUmVYjJJNWFninv9/khVY/51D1A/TKyQzFlTaC1EBL4oTi2UuY/bD
	0Q7LM8cZwES61TKWEOVflduWgsU=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice
