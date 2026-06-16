Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920693655F0
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614476; cv=pass; b=WJDjhZORjTgfLb+SFa9LzviK97bmPUUjgpawrYE6jA0ZbAdJk5j/P1bulB2T0D1lTcnABEd8T2Fb0xexQWFrp+daOCYAMGleSVRDTuW+WZ+WiDCPpaQ6M5hDVRzF35MHr0+SNi9UorBaP5iMdTL6iW2nsapi7uyfKRqWQ7PyXL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614476; c=relaxed/simple;
	bh=InmziWOUA6RgIhKs34TIvIzr4LKXlUkLbezJpZN7G08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOyuoLE9xHjcFLKmREno08+AMtcvSKafAVvfWXs53DHPXyNVSOrp1Vc01vUFcz7da7HvHvkNSQRtFbkGGR2Mwww746LuUOcW1IV5TLfw/Oo3gjmKXnfvRdrv+zCaJgTeOwkhB+n0j3fViGGk9lPRdtbo5c90np7EWwJq0mmaXzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdgBpkMb; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdgBpkMb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304d4e57d33so226209eec.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 05:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614475; cv=none;
        d=google.com; s=arc-20240605;
        b=cXKxG/qvfOiN/P8x27d1Tgf/dP1Gi4sG/YVmLyoYb4wKWGzfEDgtVntxY70QJ0Wb+q
         vnsLVmSOYu2dSaKWOpb3X7/kO9GaZYWufEWF7uKSgRiEckufoHrM0WA0uGUsPv5HAS+A
         U5njxrupf6gfWHTwvLhuHI3F/2cOyKMlEQcCMa82+hjW/Rhlx0DnowVXnCQsPOuFkBqk
         V3nKkT4LRUYErrpXW2txN3pQQBIb4PORkNY8BJoKnordAefBwbaqR9KFpX6SD2tptIUF
         lmupzndPV6vipAFln0c04bElN+xlUMjt9UG/7dXZImfx1k9vwYVXOJBgwQ/0hAQi2Ugl
         YDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBUWtL/iQ283W2M2w5jq5WrqgoMyf5cjP4re7CLhzjY=;
        fh=yTsYys23y/Ut5MXr7aySfty20yq/YZz1SUAg3aXwu8U=;
        b=ObDGjZPDosq3WrQk1Psb/ZiScsKqMDq5p/psMUDSF8P83St192dgIbtSN9lAHIVg/D
         dxgIIizQS9iwiPW+OXP4AhGCqEy5cYi7f+JzIa6WM6sjjMWyWZryCLLkht0VLVX8ofyl
         xjAsiTuNO02ZXo3BLP2vtWTNV5x0ZVjnjEk/kbUUE/ITtx1pyeVjbVvvOZt4oGNH/Pug
         mY0uejTJaU1lflETl1pKzEi28j93bsf8Z3i/RZcyt94+goiGhGUDm7Cg6LyNhAoLpjVu
         NZSS18AvgIfc78w7yXzl5nBOkQHy1AmmUarlgKgPSH6OoKUSo53oiYUtB9DxealTQ5Iq
         VndA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781614475; x=1782219275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBUWtL/iQ283W2M2w5jq5WrqgoMyf5cjP4re7CLhzjY=;
        b=WdgBpkMbxZ19IY0TDu6GO8l30958Zke5B2+joleZsKRJyT8HLb11yVtwJc52+lEKCQ
         eoAhVCSGFirVXGxZIiGIoyo7m9NXXg0dZBL3AW8wea8EUZZVLdLK7ercN0GiIEx1Hbhz
         Kafy0e8C+gL5taGYcE1Th9mAcXP7nSoB4q3M2SAnHvCG72axhjwhtdSqLUbbyzLcUodn
         Vw1piaYXjLdOCcWHfU5PG3P7ARyP5glz36lza4RUv4nC7JtSKm8W+WX4uAEtQ+JnyTvH
         RUgBKQ6KPUbRsvm65bKHABe2rpmSe72CkJNvAYbXg/GpMuCtF65XGaDQNkD7oLFc05FE
         toiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781614475; x=1782219275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBUWtL/iQ283W2M2w5jq5WrqgoMyf5cjP4re7CLhzjY=;
        b=NPBOItugG7ILSqliKStJH9GQJbS6FcLMD7PJ4YRoQMzFlrSnpzGSwmnOU55D7w9W13
         qP4F5lv5bZoiKNdWGUH9Cb1K8dP01BWjvhYhVFfn2/fTUGbItEJUa9dpUo5res1EnNQi
         BKp+y/ldV/PVy2qShtkATbdblAQ9b31cc5ZPAAQH17ZsNuerva+S3yhgopJK3y/xcP3M
         krKdKsqwa5h449UFYSMiGjYvviTvl5ioGkoqgVdvhNNPeWh4c0gRBAMdeliutWfLUBqV
         u0uBBf2DrKw9E9ZtEe90EY7rknSkY4werBFlQFQL8UPL+pAJecOTHN79NabFmhNGb5dd
         q4qg==
X-Forwarded-Encrypted: i=1; AFNElJ/KRndiHuZjX+AM7AVBQgk51WUo2PQ+JY2FejZdfSG788gWprnZ6/cpRaL8Xp8RlT8SygxNRtbOhMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZ7o6Vt8XL/wohVltbg5mX2tn/yrQhFi7pghNI8+o8w3a8PVK
	Cm6Xedux2/q6H1RkoCL/vlrSUGYVCMD6F71kPzvgHmfS7SeGb5g81NiS9tnyLJE+o9s07+s6HT3
	i1Q/ZDPlJTwbc33TfmkAsUMrX0yw6FeI=
X-Gm-Gg: Acq92OH/blcFY4AKJ1mEWltRVdpCSM+7Ey2lsmKvneU19XKm+1ov6YsTVj6n34zJdB4
	8v1RG57ZM1nxa+3sHENO0jrxe3FLZ87BmF74iBoelsDYAnjC1tKMEaT5+YIqyqq7+n4r4qTBR4E
	NU5j+9Ux+qtcf/ZjCiWJcRcWZi2+DgoyiN5WgggLNZy1cTRWBKaBlmywl361KpcKpBwYJD0p06+
	pYpop8g2rW5THPwsnw5wbPtiHXrY79PNGqYW88DoSZxOds5msbDnVk8/PcBlAcnvsowl2E0bqWb
	o0AU7jyyIe7xn7QerEXNkNctBBtA+EMnRndzVPy1zFpHPYMZkSoWirwHnNStFsGr0xqGNHGhAXC
	v9zlpG7/UIurTLnI6CV4QA0LL8KnU/7l9Og==
X-Received: by 2002:a05:693c:63c2:b0:30b:ab02:9e5d with SMTP id
 5a478bee46e88-30bab02bea3mr459608eec.6.1781614474738; Tue, 16 Jun 2026
 05:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
 <20260614-b4-rust-pci-edu-driver-v1-4-e3f2471b595c@mailbox.org> <af210580-4c41-404d-ab27-f8af634bec19@mail.infomaniak.com>
In-Reply-To: <af210580-4c41-404d-ab27-f8af634bec19@mail.infomaniak.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Jun 2026 14:54:21 +0200
X-Gm-Features: AVVi8CdDt7BroqN7LKaJMAbLNGNuWkXQvWEn4edY7w4TprAGX75TyBjazcadRjM
Message-ID: <CANiq72kMu_0fGtk9VKK1ViOGeqoYvNJ9wTPt5WL4D3jWSEo4ng@mail.gmail.com>
Subject: Re: [PATCH 4/4] rust: samples: add EDU PCI driver sample
To: Ewan Chorynski <ewan.chorynski@ik.me>
Cc: Maurice Hieronymus <mhi@mailbox.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

On Mon, Jun 15, 2026 at 12:12=E2=80=AFPM Ewan Chorynski <ewan.chorynski@ik.=
me> wrote:
>
> You can replace the if block with read_poll_timeout(...).inspect_err(|_| =
dev_err!(pdev, ...))?;

Hmm... I am not sure why the code explicitly mentions `ETIMEDOUT`
instead of forwarding it.

An explicit early return with `if let` would look fine, and I tend to
expect `inspect` for longer chains, but it is true that elsewhere I
see `read_poll_timeout` being used with `inspect_err`, so it looks
like people is fond of the approach.

On the other hand, I am also seeing:

    let _ =3D hal.write_sysmem_flush_page(bar, 0).inspect_err(|e| {
        dev_warn!(
            &self.device,
            "failed to unregister sysmem flush page: {:?}\n",
            e
        )
    });

So we may be overdoing it too.

Thanks for reviewing!

(By the way, if you can, please remember to trim your replies, so that
it is easier to read in e.g. lore.kernel.org etc. :)

Cheers,
Miguel
