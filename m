Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC5286D70
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334863; cv=none; b=toE5SA0sVNJx6xnBK66EkBgzXsKwNkmZ5wiNYoFYMnO7ayVbMpquQBAwCzJMsvHwQLs9frEd1Pq2PgiStZNQje4sg9UU23HiWeLeBclZXoJn1qqST+HrEDayTu5m3mwmsbXR63sb4P2IuYhq44eJEArym9xHUWfVq+uC23nSdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334863; c=relaxed/simple;
	bh=iIsAxzTHIngj3SP2ZsKYeqI305rivPhuR9butdjDayA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGm9X7d1edB1A0fUiR5qchngYLGFQvzpSpzDM7RMw3ldVXNd2HSiQJFsnhCb8Lw88h76XGiOKJHpFuY82Qn1XgTfDQEjlpmJPB9dN1AhVqL++KzwoR7ZCgbBkUp+oXJY12gb5mQhIxZDOXLUhCsD3umwBPppZ50VvTgybAMMRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt+d5MU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt+d5MU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA431F0089C
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334861;
	bh=yJQSOKUJSE5fzp1ImzeqOtxzABhCvBEt85duieJj9jE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Lt+d5MU/uBHAfpBN3CUp8Bl25BMBpThpTel+2pLvW5r66adS0jDQopZaSsZFKoxip
	 4rqJqqFFhg36aU+SuXevrAVurmHuASiUcdeOcDFQ+GiEBxYhHL9mkxjM4GBgcBt9eL
	 yufA1qNF5k8bAU3URDuTIC4pBBOkFJFbtwjzYFqIgioyBAspDgZzQyZxA7ZyIKcetA
	 YZC4W0ra4abfh/eXATdvJsKDhx0PMrVzup6WjXAJQpyAAu33KHXsWEBSVLGhx8MBrX
	 jl30JCtizMZgiygSmrTY4cD0up09WavW5hfN/Mm5bMCvM5b2MMZoT2o7qOqVZXWKZL
	 VgxPthO9J8u/Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so1584152e87.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9k44kK1aOMcX0Gp20toL2OYQ6Qq1dQs+klw52+8wL68eovlhu7JqhtDE7iPF06BG0oE8UQxI8DrQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1OmBQ+leTWaA0xPst0A3LL1MV/OzpgEJvOyD/M2p87TduW7S
	O2w7QBpVfv61bTgu165RjYBWru+EvFevOTpIFBlUbjNkSuFBvHm2zAbLFIblWK2OOOo1jQ33HO8
	WWnK1hmDzzH03h05lZRtWcUiVhupcoBQ=
X-Received: by 2002:a05:6512:3b1e:b0:5a8:9bb6:230a with SMTP id
 2adb3069b0e04-5aa607ccac4mr3810344e87.18.1780334860369; Mon, 01 Jun 2026
 10:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526025118.38935-1-cp0613@linux.alibaba.com> <ahZFk-nWSQr18OHk@aschofie-mobl2.lan>
In-Reply-To: <ahZFk-nWSQr18OHk@aschofie-mobl2.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:27:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEgQTS+S7-Es3ycHyJOFuA48FgUxCS4yueEcxsigx=-g@mail.gmail.com>
X-Gm-Features: AVHnY4K_FEIxKSVWRAEk0iatTa67LmbxpAARvCcGAQUrMph4mfq1nPHq3M180Wk
Message-ID: <CAJZ5v0iEgQTS+S7-Es3ycHyJOFuA48FgUxCS4yueEcxsigx=-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI/PCI/CXL: Enforce _DEP ordering between ACPI0016
 and ACPI0017
To: Alison Schofield <alison.schofield@intel.com>, Chen Pei <cp0613@linux.alibaba.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, icheng@nvidia.com, 
	bhelgaas@google.com, guoren@kernel.org, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:15=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Tue, May 26, 2026 at 10:51:16AM +0800, Chen Pei wrote:
> > On platforms whose ACPI namespace exposes a CXL host bridge (ACPI0016)
> > with an ACPI0017 CXL root device declaring _DEP on the host bridge,
> > cxl_acpi can probe before acpi_pci_root has attached the PCI root.
> > acpi_pci_find_root() then returns NULL, decoder targets read as 0,
> > and no port/endpoint device shows up under /sys/bus/cxl/devices/.
> >
> > The root cause is twofold:
> >
> >   1. acpi_pci_root_add() never calls acpi_dev_clear_dependencies(),
> >      so _DEP suppliers downstream of a PCI root are never released.
> >
> >   2. ACPI0016 is not on acpi_honor_dep_ids[], so even when ACPI0017
> >      declares _DEP on it, acpi_dev_ready_for_enumeration() bypasses
> >      the dep_unmet check and lets cxl_acpi probe early.
> >
> > On x86 the bug is usually masked by link order (acpi_pci_root is
> > built in and probed before cxl_acpi). On architectures like RISC-V
> > that ordering is not guaranteed, so the standard ACPI _DEP mechanism
> > must actually work.
> >
> > This series fixes both sides and the two patches must be applied
> > together; applying only patch 2 would prevent cxl_acpi from ever
> > probing on ACPI0016 systems, because the supplier would never clear
> > the dependency.
> >
> >   Patch 1 makes acpi_pci_root_add() clear _DEP on the supplier once
> >           the PCI root bus has been added.
> >   Patch 2 adds ACPI0016 to acpi_honor_dep_ids[] so the dependency
> >           declared by ACPI0017 is enforced.
> >
> > The approach in this series follows the discussion of an earlier
> > posting:
> > https://lore.kernel.org/linux-cxl/20260514023238.49984-1-cp0613@linux.a=
libaba.com/
> >
> > Chen Pei (2):
> >   ACPI: PCI: clear _DEP dependencies after PCI root bridge attach
> >   ACPI: scan: honor _DEP for ACPI0016 PCI/CXL host bridge
>
> For the set:
>         Tested-by: Alison Schofield <alison.schofield@intel.com>
>         Reviewed-by: Alison Schofield <alison.schofield@intel.com>

And so applied as 7.2 material, thanks!
