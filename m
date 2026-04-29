Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304337EFE8
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503434; cv=pass; b=gdGaMFPeNAdTBWAgZVMm1qBD0dVH0/ADiRjzmOw8LoGjLuvOkelywVqwvp7+zKBB/Bo22P84S0WxWO4jAv7U4yu752vhQ6wTfi1Of/KYxQ5X9/zi9JaV/mywulaVXn/xzgHcT+fUvpw2Oh1c1gri5iIURs9vsV+Dr0yPhtVljAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503434; c=relaxed/simple;
	bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9yQ5BBmtTMgcLz1Mfms3q5GgaO2FsVY/CI6hK6/T3bryd4zVm3J7740L+gnJDKSl82j/o3GhJANunpzFxPjDVwNfEK7iochib4mrnZlF2g3iDXI76LqU+2qHK6erO5LOUw+wyP6KiLftxTUHo0N+aURglBgb5HoyxRsnAyb4/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqXQzpGj; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqXQzpGj"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso1294845e87.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 15:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777503431; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8o+AOQKOJYp8ASlb9jCljRA0DKzEtHjoiiZx5Vw7yhY6M1uVEKTMr2UWt2tl1W6u1
         sc2Xxn+KlbMJEPrUDzSa13Gm6RbGEGiE0KhdXOZmoOVn/+jo7ykJRgGSztfEgHUNGjh4
         F3M3s2w1Zu97v0x3H+VKtHxZ9KGZxrb/xwZLpfPAy5i5C6B6v2T/GmxLPLsJD/xMm12s
         3pm/KUDktVnNQKjpWcSZMWqxu6Yx7sjXulj+tSBS4WaMPkkOC6hboRqe5QIdnaK/2olm
         i/q3VCZTOUA0QAsgr0gdH/ye5K2KMPkSkQ3H6CSZ1k2rBo5lfXtTPc7nbBm8vJ6/VD2T
         MZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        fh=CQq89lpRs9gRTUuTitky1zSJuKudiYCKxoWL2uc18jI=;
        b=hauHbdbO+oRb1C3eH1YlgCFl4QAaTToDRdxfIFk9r0E/6H4avLCnJI83XEPMJl+iAQ
         nt0t6I8/rDeArzR9bMIFt4int/RDehEwaM/3oRAnScIp/bUDgXaZDP+Gbpig6TwB1R5n
         NuMSM7x7eyO6BW2/JLtTjhJnHorj0lF8wtmjAeXypsHaqOet+SoQlPQs2YDv6lhN57R8
         xVF1pfXgbC55P/ZS0rWTHiwStJ+jsAOJnTbhoky1301WXhYleLe1eMcVciNa8o+0cD2T
         zixhg3KoJaTWC9thne08ztq82PoGVEAvM5XBGFR+hKtWnLxTZ1bWi+UCEBXLvc5lBKT3
         wEZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777503431; x=1778108231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=LqXQzpGjCk7uwZQudFI4VaHkXWM6afq+wXD2IRjAwdrJsiKWFgCXoxBjAdNkUMS6dq
         UB0FgxjnDwDeQcsiYzKcPW4CkI7h81B/EaMIgfqRQjJG+vDjAeAi9l7jCQ2bw9O/H89a
         I7xaQFyqEacd2+o6xinaVsRE+PgQpiV+mVbkb/BjztXqQGVP0ul5WwZjlqKhrJ6WZKnz
         zsmSTS8pgW0GyTFBRlbh1jrUc2gFJHgI0LX8PQZznCZMM8CPikiriFKebX2sFV9lSMpZ
         wi3QDjyvginO1QlcILXdz7Zok6VU2i7dr0l35ZkVI2sJ41oRklukpWxUUXngJVgXvmGV
         CrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777503431; x=1778108231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=VXKrrZvy92JHJKk0QJBhWR1Fdyf6a4/vCJ0NWSb0Ok/PqEN5+5u8oYAtkL2Dv+QFoE
         AuIefIUyF33OWTh+zC+YeuM4GA3mHm2CFlIU39ESgI0ODq0xe7XBfgZGFp6siLq1Qboz
         AwBLCMfX5RM0icVnVi8m+tCOgPbOEAACfHmx22TkahcpicRDh/G3We0Ov9kMT6F7hgix
         jZIQkgO8Bt8mjurHjYOFZOqhOiaC+QzY1q0cDeRDnFVHJysyQrORdR1PbkHsFAKruSjE
         ciYjHsevqfQ5YrQsvPdLGM1qcCd+I05B0aIeGcBQT3juRQEYPWqUgxmc4DK9ObDkqFMv
         sz/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ROY5T9ovX0ANlYHq8y8PJZrHrvHFYpAu+jJeOkLUYF5gOg7h+gK0FSIWdtGoIP8+nawu3r8I0uZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOi3nCfkvyEvCwniMjyd3iOrOr+0gdo5rl0csYZnmq3iRREcbv
	Pe7oJEiWKWTCsM8qv8Q9JYAGiySPedmHZVlAumJnbsPJoTeDUByUjalrCeqnCyAaima1cJUjsx1
	gVH0OKEDUiMwIlt9p/WiWPquPBl9ngOrXhhZHFIag
X-Gm-Gg: AeBDievhxbpkeDklpX6rok9wQKtWJ9TjNU0jWisQ4bZRiXnIIgga40+hTRq8yg5yPa/
	KtX40l8mv4M5QON8t+1wZK6s62meRoOAM8bDs4LOq7PqDNz2bWrT5Ac0VajHXC9U4IhzGKrOx1c
	B7QIKP+ch/GuUNpUCCGoGGZM37Y67Ib3fimDnL9M6SPEyDr/0vtEQyRSsSPTA+pj0oZGhIaT4ar
	ORJrPswwLTlZYZxysG/p9IrjlaIz8Ky+C2zfOV+oAhP56NUYgRbUquG7n8qxjbz15qF5AXG9Ntf
	YAGX41gk9+tqcs725TatdmZAXal+bQ==
X-Received: by 2002:a05:6512:1148:b0:5a7:4912:1a50 with SMTP id
 2adb3069b0e04-5a852741d7amr22979e87.20.1777503430946; Wed, 29 Apr 2026
 15:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com> <ae_J2pRWFf5qjZXb@google.com>
 <ae_SHCjNGrEPurzH@google.com> <20260429152814.000005f7@linux.microsoft.com>
In-Reply-To: <20260429152814.000005f7@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Apr 2026 15:56:43 -0700
X-Gm-Features: AVHnY4Le9iheFK_YlZgcrAybDAS1kEhRs6kG_ymy3g2e8lI5OrgvcncvoFuHHPU
Message-ID: <CALzav=djG6T_NfwDD+aoobMfqdCkG0Xo8hHU2YkPc20uJdb-qw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:28=E2=80=AFPM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> Below looks correct to me, but I have another question. How do you
> stablize PCI BARs? PCI BDF stability does not guarantee BARs don't get
> moved, right?

That's right, this series does not guarantee that BARs do not get
moved or sized. For P2P use-cases, we do need BARs to remain
stable and avoid sizing during enumeration. We also need to
ensure bridge windows are preserved.

My plan is to send another series to ready the PCI core for P2P
use-cases, sometime after this one.
