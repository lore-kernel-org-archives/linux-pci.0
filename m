Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721F3EBF29
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195826; cv=none; b=DEt+VRPbvwqVqAMqw4tLNTDWyE5zYTMlivnvqymHUby7PKnN6esJbvbPphZgjGdbeM9uTdxLY3rXTwP5Gv8uCUVWg3ffCv2e46aiEa8dWNtBLnU2qZx6m0zYzr3mT59swOneDb4mRc+XaQ/C8LH1I/ofMd5qirr0l6Etnc9K0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195826; c=relaxed/simple;
	bh=mNV2qABb6j0tq4GAx5D+hClmWpJtg9XLRiYnkwu+I/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv3D7OgrPL1pQ9dxcQq3OKcx90uckoPYgxL2mbs7mq723Uv9513hMmYjmKBIuqjQeyUFVILsH4JpXHsWbexE7On5C5JvszRKMKZp34EjY+dsPEF/QGeQLV+AEhDVWEZSA6yLes7NdPxgO7MrXCQGUgZZ/zNyyuC1juYcV568+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5vkftOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5vkftOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477BAC19425
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769195826;
	bh=mNV2qABb6j0tq4GAx5D+hClmWpJtg9XLRiYnkwu+I/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P5vkftOj/R0zJUjxeHzLzhV6N9y96dmwCTC+/tVn/yhEQiq8rZ1fAbq6zZx6l8ksj
	 c55zYcsOWNPHN+xAXF0B1zDmkD+Pjp/VyWjefL7moWa+NgcAZB4CK6ZxowPfPagVRF
	 mERTHRrtTkL0v5/PP06zJDpMM9FdUH1MvCrGCC3gfE4NLvknv/wJDpXdvfavgkqId+
	 1NPNgaDfSFtQrJXi4NJrYuhLbQdQ7YZIQgwkhREIBMMkkndjJyyRpvNpwj2kODQkfB
	 x0MKLDdVh/h63cZP4ur/4S7fL2d30lU0mlG7gGRcN2bwF5A2zdzaxXMU31Eaj8b7QY
	 DEJo7OkgxcTyQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662beac5d02so1419821eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 11:17:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+853Rce5uOymSpHyL+oZGmG/Nz4hgkyJcyGJ4mhnuLgxgC9qX3nJLUnrZhjYs0QVxTwmQ4AdIe14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUABJ7jEjafoOK3zMMpm+nztap7XY6EDllr1dp0yikE6nk076
	H6+feYNSGi0Fck/CR50xa6NY0QTvKsQ5f3ae3qxM+y2DDdV3Mkxnq08443RJ8ZxMCElMiN6FSDv
	SkgurvG4S827g1JVzV+VQCyR3/Y8dfiY=
X-Received: by 2002:a05:6820:f06:b0:659:9a49:8fdd with SMTP id
 006d021491bc7-662caad7d80mr1675999eaf.10.1769195825317; Fri, 23 Jan 2026
 11:17:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>
 <20260121231520.GA1221379@bhelgaas> <aXHYuwPiC1KAceZm@smile.fi.intel.com>
In-Reply-To: <aXHYuwPiC1KAceZm@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 20:16:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2QO9BmCvzpJ0dBjs6gtnvj6m6pCr3fhQNADgkpmK+6g@mail.gmail.com>
X-Gm-Features: AZwV_QhWooXHMXW3DyGLOV99PRnxQji8lLi4H9PQg4dJMEDLI6-oLfq-P0xitp8
Message-ID: <CAJZ5v0h2QO9BmCvzpJ0dBjs6gtnvj6m6pCr3fhQNADgkpmK+6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 21, 2026 at 05:15:20PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 21, 2026 at 09:50:49AM +0100, Andy Shevchenko wrote:
> > > Now we have a helper so there's no need to open-code.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thank you!

Applied, thanks!

> > Looks like most drivers/acpi commits capitalize the subject line,
> > e.g., s/simplify/Simplify/
>
> Unless Rafael wants this to be done I would leave it for now as is,

I don't think it matters that much ...

> but I will try to remember this for the future contributions, thanks!

... but consistency will be appreciated.  Thanks!
