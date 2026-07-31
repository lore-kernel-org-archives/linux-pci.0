Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EED361979
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537769; cv=pass; b=ArSOyvMdkCZbHOWeDtT0gDuJ0gGUU3if9QnxSkis9bi84pQgm7IkuNZEUaoDfYoQBWpTFuK61/3d9BbN8p8JO10U0C7ZNw3s8QqDYNAgW4MH2o0jvoSobmNHA79JSdt4agF7h9NXMlOXLIEyQDkJobRztlx6XIz2tKd1FwhX9yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537769; c=relaxed/simple;
	bh=cegOLujbI2LfUSz6SuewyzDp7MAuSuCLdFkmWG1zMrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqhhc+dSSNoI7cT6JPrPa1xrQUfoFcVzFW25i/7ncDJdTlWCT3S23wtsW0afV0dUfAAAuYEBIIj0fiDdZlBKAqwxDIzjuUpxfPpwU/5WSABfJRcnxYu1JklZ8pEcIc39T5aJeI6YPqEg1S2id9Lh5or987RoElut9AgCbh2ATXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYKgCDUF; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYKgCDUF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so12221431fa.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785537766; cv=none;
        d=google.com; s=arc-20260327;
        b=F2ooz8veT3tqq5c7uRb7JXCSv8fD10IT0rOpaoqdMD8NrSPnOrZZ9D5oqo3TRHLqiV
         /2AnCwDmGXA0bWkNI0M0JvRxEBHO94t1lGZCMYzgAZk7lIT+H8neaQbeifm1HVq1iwj5
         KeGZLsCUFeAvbtUsWKAw42kLzm+i7FAIUrR0UXqSoDPLqoxBNUzBopKue6xO3I7MR9Eo
         +PbryTvvqR+3DyKzSXD50TaoJ1tR48F5gq6vObYIkF/vC3jPhDgMAvE6gVFz99zR1Frz
         TsR/+R8SdB+1JTzCTvN41MrM3GvLEPRQQjLi/bfpKrX0uiwClekooW9kZFkFFEBLuwqB
         ODzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        fh=dkfQxOMZEPJBodZzngRI71nwrGhtW2+JgIU7vb7WAv0=;
        b=IshBK44i4iwmVj821c8YRLMRm5C1r2FD58mb1QI0hd6SHUkBWumYbyZQrLsc/EkX7P
         Z8Eah9XyF2/OnlLTz1CjWP+8BBd5dKOY7p4kfhvKYZ1vhraDILWL56IK8Cg7hJf2aLN5
         ANiQp3NlK9i/7JdCgt6XlVik3bQBqswpF0lkZ+jed28c1woaVp27O69+G9UWklz91oii
         4czo4PyVASAAincNHbKsH6G9Ar0zZ3fA1PCH5+GnzpkYRzyNTqfsYFgF331hU2Uf5xF8
         N8QJuDpve9iTpEc8BYPwf9Iu8yqoXQvyTYs421jM5IqY0YsJBkhmin0Q1+8T032OmqP/
         FJqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785537766; x=1786142566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        b=jYKgCDUFAMOyw1qqevqHuIRDDGR+aY4xZj503vXw1CDUcC7Kwogn1E0RSiLxLk6ftz
         OpIau/Qv+/IvAuKwY1yBV9OnMCpoJKJqDJZ5wxc9ewINZYcnfZIkkwiLEu+RZFx/g5JA
         PmYBSzBdq6vbwcmOW3gBQ+9qs+6mTedY2MpMYGGYX3ZndSYvibXVlJj4jC8N9PQMGhDH
         uI4oVOwFZh1n3GdhD65PkwT2HvZXCzKXNl87QQj6LXbxcp44HnUHKVl3/77aVouSQZUx
         XEfR4w4Mc6bOrVl63sM39UHRs+rx7J/rzm/e7PGeIY0JWTt5dxXtqoN4x9QpU2HfD4/I
         kDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537766; x=1786142566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwrtRUyNKFktqAHy/3WHzCYE4wzBTYRSuF4qoDAGW8c=;
        b=AB89Wa+1be2co8BhuEMc+O7mPENnX8mdb2MXWcJ8St0YDmlGPkOlBIIhwEfn+zv502
         uwFBFEoWDWASGH9RLSpatyS12LHVXoMh4QMBbbOpTlvzwKHoMK4tY5TArt4ojNyD5PYV
         sNykqe7pPul9WQNWSAzKKfH3Ev7HOvQFJEMTEZTbCp83B5F1pXpcAkSJn6A6iJsyUxb7
         +vJBcphf0Wk/vZks4pvQ0Kf7Fd9Izja6EuFUsV+6gQDBTJxewtYxDjfRTDDSQbBSZCzS
         uEpkGxWQ18k6qlG0N800v1v0STGlsNkKgTfgnhNuDd0aWIiCH8lQokOAN8wWRmnFyOqH
         BChQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHdlEkMPqTa4E3Vt6EtIxW9v/ADlkZgPxAhv6TOkNhOFPmdzYswjCIh3gXMVhcnRMqJIabGUMQ1+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4o0qePCIEuywEeMEBHjbkiSetvpBXN7VWA9dhBptjRlBx3Cn
	AqfF7RRn/bghNlItqj9qMH/q2ZyihwSxuEQHp3UrOM4y7BuWvgpEtQnawgbECW/jJZyjdolQnjB
	Iv2JwXiqzfHeBSzfZtsw1wklSamrimLY=
X-Gm-Gg: AR+sD12X6FYqYOhgVm2GX0ajCHplneChS43ZeEr3fdu+G/8KDSXJ6E8cVqXNrGA/r1g
	W1Cd/P4xLolfGIhjsNjnDJAc8efe7wku7GvX1RlHE+Fe3DNrKGYRHGSWZzcPxi9wIkresVqf5Ra
	5QW9pcwtz1NY/xFXKFmApRIucJTMHB2mRWwN2gjdaVc9KI/VRA7zIhKWlz9GpQ66USeT3bHrX15
	g0yXBm+Zv9z42esatmWkohWAzFkdvY6P6se8d7HjvbFyLjnJGuj4FGPuD1xbCuQzKf9tKuGDYv3
	qJ4LGDyCs4LzmWPHthtjYUxbhi6u358YpJLbwkbBiwlZOFj3HxMqNOPmBIzyvdig7nF+CsGo3Vh
	0/sdkMMY1gJN19kfdWWmMZuuPhKlstd35sBzCT2dMFAaLZlJ17Ua+
X-Received: by 2002:a05:651c:c8d:b0:39c:74ef:1a86 with SMTP id
 38308e7fff4ca-39f8640cf26mr2452871fa.33.1785537765380; Fri, 31 Jul 2026
 15:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas> <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
In-Reply-To: <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Fri, 31 Jul 2026 17:42:32 -0500
X-Gm-Features: AUfX_mzkvLUGzJCYHgtRvb9G-SIli9XZ_yCQ5x2jz8b5Ly_BQwxe_F38zuwne_c
Message-ID: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
To: Liz Fong-Jones <lizf@honeycomb.io>
Cc: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
	Jon Nettleton <jon.nettleton@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Liz Fong-Jones <lizf@honeycomb.io> wrote:
>>> This breaks amdgpu completely on the SolidRun HoneyComb LX2 (NXP
>>> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
>>> on the root bus of its segment (there is no root port device, so
>>> pdev->bus->self is NULL):

On Fri, Jul 31, 2026 at 12:15=E2=80=AFPM Liz Fong-Jones <lizf@honeycomb.io>=
 wrote:
>> Maybe this is a tangent, but I'm curious about this topology.  Is this
>> running as a virtualized guest?  At the hardware level, a PCIe
>> endpoint must have a Root Port somewhere, even if it isn't visible to
>> the OS (as is often the case in virtualized guests).
>
> Defer to Jon on what the actual hardware configuration is, but this is
> physical hardware, no virtualisation, running as the UEFI rather than U-B=
oot
> (devicetree) variant. See:
> https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a-com-hardware-user-m=
anual#block-diagram

I guess this must be the drivers/pci/controller/mobiveil/pcie-layerscape-ge=
n4.c
driver.  The commit log mentioned this:

>>>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]=
: releasing

so the GPU is on bus 01, which isn't a nice round bus number like root buse=
s
usually are.  The typical thing would be a root port on bus 00 with a secon=
dary
bus 01, and amdgpu being on that bus 01.  Can you share a dmesg log?  It
should include the lx2160a host bridge details and the PCIe topology below =
it.
