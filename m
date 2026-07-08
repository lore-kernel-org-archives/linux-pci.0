Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892753F12C4
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524332; cv=pass; b=sp5HH7LEut/vEg0+bsjVm1qaKl6sTovD4e2ZaUM1kGeOxx/oyDLQ1tJvwdlgpjtpoVQXQoxtYYgfzPAGk1RrB3MOP18QOeCbBE8+sHaZfM7WbyLfwmxHuY4fcmdnjZotUzzjSm81GqSVTwYnraodyvGVjWy+RZ1qxbLZ6Zz39Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524332; c=relaxed/simple;
	bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwzwXFL+ETchwqYujIlrCXykRxNmb/sJ6pvnqFJ8PAlqi/yMjL2BUaF0hNBQP2i7Z6JcED4kMyw4cKZ3BikxXaG1cRgGZse8SwyMbMR77Sx0upAgHD0wGsFmVkWe2SNVkERgYDsIUJpBbQwA1/kMfp/8DeQ2HotvR+3Erl9Dx0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGPNCDP3; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGPNCDP3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c70270e6aso1216321fa.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 08:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524329; cv=none;
        d=google.com; s=arc-20260327;
        b=UmJWHwiP+vAGB6/zitbfhmIP+obWMAlDVWw3xBPgX4ZMYLfUlrejvIsm5T95NJ655W
         npnAqF0+T/DUAnDdR5s4yjNZgaMc3yKMO1XapzH67cs45+P/tTrevxcdjLHZHei/uEAL
         Fk1xwEyNp3paYck6hhNFbUu3AwyOWedH20gJD5JDAqMn1ROr53DXQA8CsECD7Gtsms1c
         KBBjMfHL8HJZCfjU8i9hirH0pRvwcWzKcwgGaEJdhOZDnyxm9Gcekcsu3G7P3u8+n8Gt
         v2mdq0Pdhso33ZCuNl7kvcpoEgh3EDaFPvoTx/H9ke4skV1sz0RIlWoIfyqDgmJHp7Ja
         AfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        fh=5vfc1o0rRx2R1thDuzbRoAvyD+VAcvEa4vG7ml8DeGw=;
        b=EwWVAY3VZk8YwjTbABxMIb9KpLbFy8PT1XIe30WxY6ZRSbuuhNAwosFtOyK7jtv942
         7ljROfWpFHmRK43+clCq5EASsddxkrT3+sbxm0wP/vjxJTcCIrXi1/NUaNvx8joYaVjB
         WaICIb+tOwXzf9LavZ7fuqiiieHKpEA/KO17VwByZD713kff7NPLfXBdhSvEKGI0uZ85
         116zjvYV28a8LfuG3CrsgriiZjcJSAUNtXAPF8TUGG45FTJ6kTjFngpxbROXIf7i2pJl
         BVui/1thls0jdncSakcDQ6useqj/ufIQK4xvN8XH35moI1ZtNIuLof0RDgK1WFzn2Ony
         8v/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524329; x=1784129129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        b=nGPNCDP3zX/JD7JIelS2PhEF+dnHsaiaOhut0qhiHFhIEdMQNv8rhdOteRKRyKDs+O
         MTuI00PiiCwOq2+M77Y9nUMWVSuOrAmNnLqqspkKUVeb7agC/GuayKrvlRzD0hurKyKP
         LQU5pDCGPN4HjoMMdqdCivY23Hb+OM7SBGpQiihaFw2Nqw9UssGn4fktsrrI1SzCGoeN
         ssHsz8WZnXSmo50VjEBo2+1ewIYnjbK4BVSh4LOGnxdKjcz1vBX1SwGcsn0dQQknRNZH
         Is/U1H7JjvTzL5BjnySPwPTbGeGZ/F8uIQcfWdHXZdP6kUJqCXhZE48cxU/07dfmohO0
         EyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524329; x=1784129129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        b=s8wIKKMnyDC8w9eBUKF+axE3TBAmREAneQCJgHzuMB4Z3zrgqDmqFKbh24IXr3JrEa
         U+wAt6CxnuJKwQvI0QYhD7k6iQaSATHdwYdOsNlxlGdYLq8rti4JSUUE2Kb3bW1LSWzO
         aXc+Wov727qyLqACjis4bQNXls8O6E57R3dcoUq4HlZfFmMRZqQFga0IalHpQsM9iIH3
         xhTlot7AV334IRM0JqYcP0BPIHp5ksiC3wlJRV2ENFFhj4wQiU8NsV1vDLSqA5c1l4q6
         GJN9i2Z2P4grglt1D06lHw8w2yLTI51LtBurCEfZ6ZavS7irKTwqVDUzqw8AbNWAIiYO
         Ep4w==
X-Forwarded-Encrypted: i=1; AHgh+RpXpOukl3HUALltvufyaWW5JjlCA+wupiZsNQCyQy8wLxdXnuwTFhyj4MEQbQo0oWxMsQg0Zqlp6uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuA84tnF0LpHtBA8+Z093fyuocwenVt+fpOjneH8wMqRHaTQ4
	HXsAmDuaX2tsl69N/rP+g89sWY6XuIMzXA5xNWK2gVdF47KJkabC3tL5nG0Gk5y8+0iCe0Q+QTP
	nAu1aOHg31kSPXksCy40aYtMpwgbDjQc=
X-Gm-Gg: AfdE7cmB1OgnIbwz09UGztyT4DAHqzmb8FzjOjA87NiqvgGCiXoo67D4R9Ya+2lLdT9
	8V9PPaOTcDmJ+/UhNefpj6ZuFYgYiykH+tu9UIe3eRaows9uGV0D++ZrTKxyDexoozFswPfev9M
	Vy2mih93xllkqE6EaIqX13Qi1ry3TASMqIhULGqAJk5VtB4SdWp4BjyFMwn7NbdugDE7xpwi2v1
	S7e/a+FsK/0kuX6IdOW4633SzMDHnwwzmLaYJdINK18cnKE1bildvAszjznbyKWMfvWex2Eq9zE
	wV+rpxPbCnU8REGcVPTvEqvrKpC1HnAf3dg0Og+Ki3ggb+nuneFer0UyU2dWg3NESdp0kym67DY
	EPCTLagtXRSc5
X-Received: by 2002:a05:6512:3987:b0:5ae:b9b3:9f96 with SMTP id
 2adb3069b0e04-5b0115c01f7mr445459e87.6.1783524328462; Wed, 08 Jul 2026
 08:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net> <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
In-Reply-To: <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 17:25:11 +0200
X-Gm-Features: AUfX_my_GxC4KLJmz5i_4DX9QExeJawd6XQyKpw76D3pBDNdQQvLPjQ9qPUqEYs
Message-ID: <CANiq72nyEK7cMphaawV73bN7VmAKG-UOE4SPDWDpAqoLs8zzKQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:37=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> You mean to avoid that cryptic =E2=80=9Crust_build_error=E2=80=9D when th=
e assertion fails?

My reading is that it avoids the assertion failure itself -- if the
compiler decided not to inline, then it would fail to build when it
should have succeeded.

i.e. it is not about improving the error message, but about avoiding
the error to begin with (not sure which one you meant of the two,
though).

Cheers,
Miguel
