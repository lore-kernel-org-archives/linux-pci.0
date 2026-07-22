Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209E351C11;
	Wed, 22 Jul 2026 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753567; cv=none; b=DGm3HcrTGfDaFwJawRZVujWntWg/HozzvqohVCx6wH6P5HU5JA3e74Ma5hfdMUOaFPW+VeJWIr4bLw8E+kapra0UkagXgTmf5uEbYasZg5wc+/MfSfPb0PM8JNwPRIcjzjUz4Dfo4Xn474GBGrkZls1trQXiRGXto8G4XCFw3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753567; c=relaxed/simple;
	bh=hpv7BtvN2gC+gG9Dyi8J9RJuXaNb80lbxWiPzXZGJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R+MZgoEFT8F0RLUXutcKLOTAKAgQXLUrNCr8HH+e/qiMVwpIVI8JIEKlSjSuSJfTlD9I3Uwfaep8r4S/lwtknPWAdzIg7QWBxsRpOi9STkeydsGgWPo8cG4MjV5oRUDOlZC5BJoNtc01r3BKJEyYfBeII6W/pl40WjfyOcZhLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKt8jO36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKt8jO36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18CB1F000E9;
	Wed, 22 Jul 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753566;
	bh=YJZ5uElrIXPf+yuHlLwWqTY3ua/rmMMcZhDIWg3p6is=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZKt8jO368pM2n5aph5uQV0//dvc1i4I9oQRgPvqo/k/8JgVV4oE+hmiJFutl0zvbb
	 YmdpgyLIpY02G4nk3DPFj9cbZsi7+FM5fzYlsWjkKeKa0qasyLJjI6RrGiGFgwadO8
	 F3MQn57x9ZUvPYHrL7bFXTX7QQxtIFxVDI0GpdsOFX11XOVZClhKICdI3QdsJUPLGp
	 e3Fr5+sqMMXe41lou4xdvWIiXddhjAI6GsOGdlr5xvyZV+nce0IShPAkCLy/8Stg2+
	 +5SuIJ1SGqXxlt8GV/vb4sjiQlS9v90XnkMzjxjKTbHDcosmmCgf0cKRN+Dv05y0kY
	 9bEcEwz0U2BIQ==
Date: Wed, 22 Jul 2026 15:52:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Eric Auger <eauger@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Do not add hotplug reservation multiple times
Message-ID: <20260722205242.GA779880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720162416.5771-1-ilpo.jarvinen@linux.intel.com>

On Mon, Jul 20, 2026 at 07:24:15PM +0300, Ilpo Järvinen wrote:
> In nested topologies, hotplug reservations gets added multiple times
> into the bridge window higher up in the hierarchy. Adding reservation
> for intermediate level bridges does not seem very useful because the
> hotplug is going to add device at a leaf.
> 
> Accounting the hoptlug reservation multiple times results in larger
> than expected bridge window size that may lead to assignment failures
> as show in this log:
> 
> pci_bus 0000:0a: root bus resource [mem 0x10a00000-0x10c00fff window]
> pci 0000:0a:00.0: BAR 0 [mem 0x10c00000-0x10c00fff]
> pci 0000:0a:00.0:   bridge window [mem 0x10a00000-0x10bfffff]
> pci 0000:0b:00.0:   bridge window [mem 0x10a00000-0x10bfffff]
> pci 0000:0c:02.0:   bridge window [mem 0x10a00000-0x10bfffff]
> pci 0000:0c:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0d] add_size 200000 add_align 100000
> pci 0000:0c:02.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0d] add_size 200000 add_align 100000
> pci 0000:0b:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0c-0d] add_size 200000 add_align 100000
> pci 0000:0b:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0c-0d] add_size 200000 add_align 100000
> pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
> pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
> pci 0000:0a:00.0: bridge window [mem size 0x00400000]: can't assign; no space
> pci 0000:0a:00.0: bridge window [mem size 0x00400000]: failed to assign
> pci 0000:0a:00.0: bridge window [mem size 0x00400000 64bit pref]: can't assign; no space
> pci 0000:0a:00.0: bridge window [mem size 0x00400000 64bit pref]: failed to assign
> 
> The problem stems from calculate_memsize() that calculates size first
> and then adds childen size:
> 	size = max(0, 2M) + 2M
> 
> Alter the logic to first account for the children size before applying
> the hotplug reservation to not add hotplug reservation multiple times
> on different levels of a nested topology. As a result, the size
> calculation becomes:
> 	size = max(0 + 2M, 2M)
> 
> Reported-by: Eric Auger <eauger@redhat.com>
> Link: https://lore.kernel.org/linux-pci/f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v7.3, thanks!

> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c0a949f2c995..e8c94aa1d3c1 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1021,7 +1021,7 @@ static resource_size_t calculate_memsize(resource_size_t size,
>  					 resource_size_t children_add_size,
>  					 resource_size_t align)
>  {
> -	size = max(size, min_size) + children_add_size;
> +	size = max(size + children_add_size, min_size);
>  	return ALIGN(size, align);
>  }
>  
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.47.3
> 
