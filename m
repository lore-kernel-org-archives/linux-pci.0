Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92F39184A
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133730; cv=none; b=iYo/O1x2may88AHM7/gExQez7iRrrRCFtbAOL3EXeLGv/fsuI+8HnUiTQFUKvRAQeFDxNjXSDPahO02PHFGMcLp03DMki1At3kiSXvcmiG/UVCMotalcCmBMCPEd3dNIEJfEui0W8jlFTauPMMtcTj9juJhVVnuugBRA3r5yBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133730; c=relaxed/simple;
	bh=WuhOyip+SDzo5zZOpCcKMe2prt0wCvm19FIdHuBOb70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG3CalmGWqu8mNz396+PKASiyTTg3sAys7oTdXLE+0uTbhsUUAI+zlJw1OJfWWeNrf1RHYUORmFTO1XGNvvx+FyOvtIHSkjnuHDmJU8uXZ3GjqW7Jb6p3N6gGAG74DLQuo/SYaERGqR4dBhlUPPgTE8uIwlQOfdzE4/GLhD7/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdJL4u4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdJL4u4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D5CC4AF0D
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133730;
	bh=WuhOyip+SDzo5zZOpCcKMe2prt0wCvm19FIdHuBOb70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YdJL4u4nmVBnhzNAyUyeKYZEYTKKZRGm7fRylohOm0s91c//5wD2LfwscMwiA9tlf
	 x+XeKstUH5fWwreNofi9+YoYS4rH9KzaDF08GS+dSthRLObSkTLMx2Rme1krMbUt2T
	 1armXw2OLIvnXjviTG1moE2gSjeCCA62sgZ1GKcgY8MPKEn2Dj4M1tQ7D7Gr3LYt0P
	 hKH+ed6y5Qz7lQQJIz9eLf/VzYOJz/jMHa+Df0/pjdcs1KYq5nfPJpyNE4UaEvKo9T
	 n6ii2WGXFZxJ/9QBZbyJQYNxk+1eTK6nGPbD7RgqB2fWKTaYfaDVVw3mZXzLqGCDq2
	 RpVFPGNW9Z6xw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38be5e86918so36909101fa.3
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:48:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwfgtM5o7Av1vKRZkDNpZz5qAi0seayHHUg4/JbrlboIJhccLMv
	RfTp9Q98fC/9IGTYxkF8VjO5NLKh1re3XgLdM5fkZ9jrEIwdHkUGau3nwCQeGBt5E1f4c0x2Bbz
	LSaHFXyVSrAlgz0I+raifK9UcuEAwCQ8=
X-Received: by 2002:a05:6512:39c2:b0:5a8:ee4c:8ae2 with SMTP id
 2adb3069b0e04-5aa0e73a2d6mr4558381e87.30.1779133728288; Mon, 18 May 2026
 12:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518191220.636213-1-bhelgaas@google.com>
In-Reply-To: <20260518191220.636213-1-bhelgaas@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 May 2026 21:48:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j32rXM3i4SxVc6m7BXvxJxN24jC6mRj6ujCsbphYSS6w@mail.gmail.com>
X-Gm-Features: AVHnY4Jhj7miEAQgrQt8844FphiLw2VPe0awPU4ZgeZnuoxo2B9DhiWE054-ZLk
Message-ID: <CAJZ5v0j32rXM3i4SxVc6m7BXvxJxN24jC6mRj6ujCsbphYSS6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Wait for device readiness after D3hot ->
 D0uninitialized transition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>, 
	Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>, 
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:12=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> In pci_power_up(), wait for device to become ready after a soft reset
> (D3hot->D0uninitialized transition).  We already wait 10 ms, but even aft=
er
> that, the device is permitted to respond to config requests with Request
> Retry Status (RRS) completion status.  Use pci_dev_wait() to wait for
> successful completion.
>
> Bjorn Helgaas (2):
>   PCI: Log device readiness timeouts as errors
>   PCI: Wait for device readiness after D3hot -> D0uninitialized
>     transition
>
>  drivers/pci/pci.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
>
> Changes since v1:
>   - Log device readiness timeouts as errors, not warnings
>   - On timeout, set dev->current_state to D3cold and return -EIO
>
> v1: https://lore.kernel.org/all/20260514153124.404060-1-bhelgaas@google.c=
om/

For the series:

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
