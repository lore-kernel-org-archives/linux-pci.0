Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89313AAF65
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072553; cv=pass; b=XkzOlZloV8ahAlq4SjMDTqmPoZBxpr9KBLj8//IBWzZ2m2jBX62UZJvNEj7Qu6b1MSohfEIGYMDBUpw2PhHggOtU0WfvEbTm7kFJ7xWh+uDYgEd6IqXffrBH59v7fcJ4xCrFK7PwHBNEBijr4NZcIHse4zratPzvqfn0W3d49T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072553; c=relaxed/simple;
	bh=CT5neSn2K0bN9/PkbCJ3i+lCiVuxNjc3dREsIOEIXME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIpr+uXS6vEadY1+2nHG7uKt5qVG0aRRG6HrHx/0e5qeShZA3DHvtAiRLwptxlk6rxPFu8wV+RZdHzcWB86hFcJXa3Z3fpZrO7vEd4PWDKe0RdVZIW/IRKICKJssa1xGO6lh/iCrtrReQby2jmezts2KRw56tnOAUEwY0RcN8uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzNZv/T3; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzNZv/T3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b01cb18515so122594e87.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072550; cv=none;
        d=google.com; s=arc-20260327;
        b=g+dS1Y0V2vMsmp6bPh3t44WpilozMhBhUAiDe7CMnnb+xbtbBTrp0QVVDpFDNeNuTv
         LkGAS7lTjw9hHD8LO25dQmHIJfLeOJi4fJm7ll17YU44uTiCM/vZnKLmCbB6hZ3DWS6V
         /I33VpTy16fchYzhrYU4aA1DXVh2NZQQTysN65G4YViUvn7ZfpoXsaW5gsEmg2hT9vLF
         uo8u4WSzyYfOeA9Iv6dsHi1Fz0gT8CtgJxgfMuwF1lbaJZ5+IKGp5lv1Hobmb8LhVKCF
         ZL62geGa8mLCAAvCgHrDiADWwLGNgK9sxiWlTKy7rEEbMqvXKIf8vkUoDtYpU76bcTk8
         vTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        fh=npYDo/SwJ740rBKbWaDzW/xsVL/24E9AnoSyhWl38tw=;
        b=oTHiBoX1Ij9kYPeB4bhkgzxdM32pAQroOjMoTcH7E3HASgGnt1UCf+hkRPwdheJoXk
         i99/SbiOMm3ONJLJFcpcngDZKXkYGZ1ZZiv0Yp312EPTA0b4hUl+V1BiTTgO49UvF/ae
         THVtLuMu3FpFJkO9E2S6UIHEUAKe2wH2eNI3YOeqtcCIrUW6hlvtCDuBQw9/RHRK5xQ2
         viO3jDty8yvVYq2QY0rkfOWOHQmrse0/1ystW5cStJcL3h9eHvK7s5l+NBt4/yz1pxNW
         yOrrTdZlJuxv0UsFNalrvpKCWOz9Un4vPqE30c5U1lr5dl/n3JCeLc1ywusf/ODDuvfU
         Bp5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787072550; x=1787677350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        b=CzNZv/T3GML5P4agqAOGW7n3MQajSGnlLUs6x0tO+CvLjGfBFARXz+JSSVmVqAOmyP
         K4aWAsjUOKQu1W0L472UDKk90G0GCtdFkVQYvWjnwoB0n/gSovpZpoz/g4JRimMG6bC/
         R2jFCnSS5HOsG6l8Z2FLpbfzBsXJDofKXsiTFTANyppDSvRUMH6bobVl/6Fyq6dNdDaH
         0/13FGC2CLNvFQe++4YFw3DN2UTXvqOD9Q0vuYJcMBadUR3gjPLwcw4YgGEuNOMzP3HM
         DjnJaTA0Q0UwBckAsR1SxvAsiuwrL5eZ7OvTn0aqLlzvzKZx3F2J3cQnZzAnsvtKARe0
         93Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787072550; x=1787677350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjtdIb6WLQbnwc+hZbvzaCjPXgJQSb26VEMl+8tkzq0=;
        b=NCstrEJh0DoFf3/1qjDruBpn6tRPoo/FOeI8NNVIeYlPFpQ5M9P7G6y2zPPhuNv1kF
         5TC92Sb/kaO1dE9KCfKfpTTgIF/XcwPU3J7Hf3qIFQFIuJdUXzeLtkSPWQEwlDelOO2W
         GRVkdp2P5OfZyW1an9hxFFV7JdQET0ZIZtQDZ2qwR9FdqABvtD6xpg3s8sB4H62zeZPW
         dXuWxuL6G3PKsisszFeZVmcC4TXwYUVBnhXIoALTHVXNrCHFCqPZOvU73j63ev34TUT0
         NWu+lQxW9oJj29j00nMDR6dZTh/W5X0D+WYNpHSGsyG4uW2zu3E/H+gZxwvqDY6LJK9M
         Q5Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6nz1ifQDU1SjK6ggUcjI38nUJc2a9ne+bLuZUqJ3NpGMAOxabpIhYPnZgSVsrTEZDCPCk/Clrb4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwDrL8XOsewDBhf7mP9gi0c06ffovUs/YJBUlfhjyR7+ixBZi
	edZR0686v139E3N5N8gWcgMPNgQpenAClkaXjyYNKDq7QM8Tv5cu04D5dihilOnvhuZNwIC/YB4
	x6sZRzIfttGm/f7F1ZKQ0KyXfTwg9k6CpxU2kwbv5
X-Gm-Gg: AR+sD10nj/wfJqBf5/5j9NNyYG0QgxlzlLRnnfa5Wm1qIOREMKwQCOmpBGbR8MN/UjC
	2AMq/VJ7NcQ9Sxvp617ZfHgg18D1aQyWHT4dAh6rK8XgnYuQO8hvD2K5u49SQRKzbfDm/Soxatq
	8rx04J6uYpOYaCZ2/s9MKR9gAwuhei8kmUUrA09wtgIsA9fcTIUx0lZKQrwqDndPOgtEmyvMO+/
	nBouK3N5xrf54lSVEDpi8OSwiNVQBmxUkTSKlpIYZV5UnZgXL4kJfDia6N6guAXxgkZQEMdlU81
	F8l0AnneDiCaihlX5zXi/G77BVrgf08jQX0B052EDIHY
X-Received: by 2002:a05:6512:6686:20b0:5b4:3ddd:8996 with SMTP id
 2adb3069b0e04-5b470676e75mr1757831e87.15.1787072549336; Tue, 18 Aug 2026
 10:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 18 Aug 2026 10:01:58 -0700
X-Gm-Features: AcwNN1V4a25Yv0iJ76SrkHBknW5LsS7U4x19BfrVjGgcR0yRKfOyORXyqOEjm-s
Message-ID: <CALzav=ezKW25+1h=xQCRx0TQDtpADKpXQcKfz-3vbapz5-zwvQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] PCI: liveupdate: PCI core support for Live Update
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:10=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
...
> Merge Plan
> ----------
>
> I propose we merge this series through liveupdate.git for 2 reasons:
>
>  1. There are some LUO core changes around how FLBs are refcounted in
>     the next branch of liveupdate.git that this series depends on.
>
>  2. We had previously agreed that the files covered by the PCI LIVE
>     UPDATE maintainer entry would be merged through the liveupdate.git
>     tree (which is the majority of this series), so this would be
>     following that process.
>
> This plan still needs to be Acked by Bjorn Helgaas as there are some PCI
> core changes in this series.
...
> David Matlack (12):
>   PCI: liveupdate: Set up FLB handler for the PCI core
>   PCI: liveupdate: Track outgoing preserved PCI devices
>   PCI: liveupdate: Track incoming preserved PCI devices
>   PCI: liveupdate: Document driver binding responsibilities
>   PCI: liveupdate: Preserve bus numbers during Live Update
>   PCI: liveupdate: Auto-preserve upstream bridges across Live Update
>   PCI: Refactor matching logic for pci_dev_acs_ops
>   PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>   PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>   PCI: liveupdate: Freeze preservation status during shutdown
>   PCI: liveupdate: Do not disable bus mastering on preserved devices
>     during kexec
>   Documentation: PCI: Add documentation for Live Update

Hi Bjorn,

Pasha and I discussed this series and are hoping to merge it into the
liveupdate tree by the first week of September so that it has enough
time to soak in linux-next before 7.4. I was wondering if you think
that is a reasonable plan and if you have any lingering concerns.

Thanks,
--David
