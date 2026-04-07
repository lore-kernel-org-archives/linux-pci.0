Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B3372EF5;
	Tue,  7 Apr 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591294; cv=none; b=PnqxieCBEM8tzbeAK9ygFP+S/HhdpXKjjbsGN9XDGpEyOTHkpYez8OvfYiln7Nl67xOb4JEE7Dkr29BCEBH7coZa+XygYLyuNcwAe3oum3TXRzWxs6ht5zKg3+4cLeSLxuyjenohSr/EVk1MlNkKIg8jPn+5EU7nApbvMfHsZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591294; c=relaxed/simple;
	bh=bqTMhfo/awTZ5i51GTS7bLuXXoGvgvNDnvhfdzNNwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rmJYwcINaXsfelGePhSDh+v4YmM1I7ku63p0OyHeZgvLOnfIpwhGFe5y/jvya4i0wlpoMvIYphy07YrQExZwROgG7PuojsOTuoxfvz1gxu5SUNo4Bvqz8Xf2VIXQrRzfSIPh5ZaQhQM5fY1Jq1rPfQZwKAVhhfbmppcuhqJmEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7x/jeR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7x/jeR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF51C2BC9E;
	Tue,  7 Apr 2026 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591294;
	bh=bqTMhfo/awTZ5i51GTS7bLuXXoGvgvNDnvhfdzNNwu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O7x/jeR5J5MLAT4mzBXyKcebP+NLbPW0xQDXSrL+VdxvNBJrjXFbpFehnbergnonC
	 23U1M3cI6ilDt1R13lq8Rtpe5G/Y7o6FMcMZmiJAqdk2UoKTLDlKgSP5JFw3nV7dTF
	 HsScmaa0KgxgtLo/9t2np1bIvGNrXz84/FFd7fl3MV7cU032RZjyXLJLseLzwRqsAH
	 P25pI1kjf0GOgNlFhY09LupQOMJN8jZKTwSm+GENLr3h+4NKZIMqYNIciqH+02ypaB
	 KDyngCO0S9UcIjFsW8La9ZLl9YezxUv2UkNSSU489hpW8ZogwXsAZa3+OmP1/fH6oW
	 YGNWICE/jltXQ==
Date: Tue, 7 Apr 2026 14:48:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH 0/2] PCI: Remove no_pci_devices
Message-ID: <20260407194812.GA250485@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>

[+cc Maciej]

On Fri, Apr 03, 2026 at 12:15:34AM +0200, Heiner Kallweit wrote:
> Remove the last user of no_pci_devices(), and then the function itself.
> 
> Heiner Kallweit (2):
>   input: pc110pad: change PCI check to get rid of orphaned
>     no_pci_devices
>   PCI: Remove no_pci_devices

Applied Dmitry's patch to remove pc110pad and your patch to remove
no_pci_devices() to pci/enumeration for v7.1, thanks!

>  drivers/input/mouse/pc110pad.c |  2 +-
>  drivers/pci/probe.c            | 17 -----------------
>  include/linux/pci.h            |  3 ---
>  3 files changed, 1 insertion(+), 21 deletions(-)
> 
> -- 
> 2.53.0
> 
