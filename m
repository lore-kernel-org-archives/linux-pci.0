Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA93319617;
	Fri, 17 Oct 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698208; cv=none; b=fopfvwRcT/yyUjlLsIKcRkBz8RV7qZgDTuyyzcJOmGpCMaTNWRdvmiUQKOyVEGred3Q5v4V/JkvvWGzThzys2hPzKQIJF1T5gyee4tvxzzr/SEfKoW6pIuGDvXn9HQYnpPmfZzSIcK3Ntd4qkzPCyHtJsJJJXuKek/VMHHpFf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698208; c=relaxed/simple;
	bh=alNB6l5r2W+IhKSQqI1zuMysVjA6WKulqPXlUUPcAo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/7hU0C93Dhr51uqBJWbqzE1n8seh07ZzVdsC8CAlwQRLx7R2UFkQv5HwSTScI3wRQq2FGcVb1aPFeNg/zqIV+A85L5CE9GVj9D/Hy2f/g5/xuzVTfOoiYBiUrhKSxpVy+HC3gpzaJ8LtCLJZzFZMj2UgAJYSBnaOoluCyGPopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1v9i1y-00045a-00; Fri, 17 Oct 2025 12:49:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6B525C0256; Fri, 17 Oct 2025 12:49:46 +0200 (CEST)
Date: Fri, 17 Oct 2025 12:49:46 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <aPIfSvhqhc9wxzGi@alpha.franken.de>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
 <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>
 <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>
 <aO1sWdliSd03a2WC@alpha.franken.de>
 <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com>
 <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
 <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>

On Tue, Oct 14, 2025 at 03:41:42PM +0300, Ilpo Järvinen wrote:
> [...]
> It was "good enough" only because the arch specific 
> pcibios_enable_resources() was lacking the check for whether the resource 
> truly got assigned or not. The PIIX4 driver must worked just fine without 
> those IO resources which is what most drivers do despite using 
> pci(m)_enable_device() and not pci_enable_device_mem() (the latter 
> doesn't even seem to come with m variant).

will you send a v2 of the patch ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
