Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962787;
	b=jVNMBadmlkQ7pWa/S0IksqoJLjLEvIPaYyMi6hBiSTqDWHm70kVwO/Ni93RNWSgpNdQD
	 lng4Y1dIlexR933FRB30GeTlaOf6T526cHX6RGjXaCqtFbJNioGSwEehNhgA2rij58vDp
	 Lod9OC5NcCdsXvMwzEhnWsMHhG3QuGJBvpbqIT+5WTons0FkS7FwEp8eDYs1+9qe1PalX
	 vXvyd1B/9O92139QmtTmRslO5Y2RhUFJVpuH5DHY9NDNp/s4lW63xJQK2TaFWbsKIVJmf
	 upkgMc0s9XD7V7C5Z4xKp48R0iYK3id86S/pqZIgVl9gk2qSeZpR+aCVi7scC/hr1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962787;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=95SeBybFf2pXUkc5jYC6vrPZwmiK9L2JiETFgVW5e/w=;
	b=eovYPjqXF5cI+pGJ4ShmTCn+l1xeT4CcXWQs38OXCA1HZX7og6FbQ/zMZJzRUHcrBpIB
	 8HiO10axEvwfMSsZmclzPwPsqB2ZO6V/phygOLT/dOec9ZxopRGq8gfHyhuyIXOMcj23n
	 y1vo/In2WMtE43eErFkyb6ITw18TBGxqcGc1lOvO0fk3lz/Vt6WOe7WtcCP5jZJD5B42K
	 903wMZ2tJQAMRS0FP5rcqwKHoGpdQMOksO497BYKD2vvXcZfX1UVn0SF4YYLXe9yone+j
	 WCwNvIxMHfCjYC/WmogdHnSZhLpkrzIi6RZun246Pf/ClpypKtT0CHtCZt9dFqBQt2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="ZzCIS/xv";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994B606A31C;
	Wed, 18 Nov 2026 00:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7994B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZzCIS/xv
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C098D40E0218;
	Wed, 18 Nov 2026 00:46:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kSNdd773DXvc; Wed, 18 Nov 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794962779; bh=95SeBybFf2pXUkc5jYC6vrPZwmiK9L2JiETFgVW5e/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzCIS/xvgAKYSYAaxOitqOVDbAlC06a8u6TvTbgOxmhW86ubvXe0CcxpkGTWnn6mM
	 Xz1xUbKvEk4NFKAtprHAs8HDJrlO4XiZIankYoMCq43ZFjWsixwkL9Wh+eVkit07S0
	 V3X5zS8nFBDasxUbRx2dNlAYQ+6V2cwafusyzZUGnFoGXLtYR8VxIqOBXyMDfkooCL
	 29MVLGrjCeW6LI7HiiIVPbbVK1vLQqQSIe/akK/yJjVu7cWxucJT/6qgpRxoV8AQGr
	 DFXzuwUqTvYPL+0MSVzq1h34QLw31I5oEw2em/JSOxWJz4Cla9W2bEjisv6nOd3Dip
	 iwoe7TUXz9EraczODKqvmOfyAOaiKX2pDgFabIc3I2KeqXUpK4bmAjZxUvrwC+kxNp
	 koD7K1SN+t9LBdqwZK3jqRJW7W45eWnDfJ2/lUGQm7Ch1ybw7sxUizK6SMurhenVid
	 d+XoLrbeAooUU/NaSQ9U/ceerfrSHMKMaoEGNwOMIO0vHp7DzNE6HLZYXJJwOf9kdB
	 1cZUdz4Q6PP5rPyyMNaTSY+OJYiC+sK1aO/EYKf6uazlgpv04IW2Po3XGFdhO2nlwQ
	 1vRfHcZ1JXSLVDRgyR3jCCMvSX1mj3nRgYvPU/BgU0WNEB2KrUECJtnavvDVkG8d76
	 aXFILuq2pnNPW96sESyd2JwU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A18840E00C2;
	Wed, 18 Nov 2026 00:46:09 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:46:06 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Message-ID: <20261118004606.GGavz1TttiWqFI9saC@fat_crate.local>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
 <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
 <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>
 <20261117195455.GEavyxDycsQbYSctQr@fat_crate.local>
 <CH8PR11MB403433E7312691DB4FBC415F2FFC7B2@CH8PR11MB403433.namprd11.prod.outlook.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH8PR11MB403433E7312691DB4FBC415F2FFC7B2@CH8PR11MB403433.namprd11.prod.outlook.com>

On Tue, Nov 17, 2026 at 08:14:33PM +0000, Luck, Tony wrote:
> > This removes a bunch of lines in the MAINTAINERS file while having the
> > same result: unify orphaned EDAC drivers which are not going to receive
> > any more fixes due to lack of hardware, age of the hardware supported
> > and general lack of use.
> >
> > This is also adding drivers/edac/i82875p_edac.c to the lineup which is
> > a 32-bit only chipset for Pentium 4 from 2003 or so.
> >
> > The code is not going away - if there are users who are willing to test,
> > we can easily resurrect them.
> 
> I like the bundling of all the orphans together.
> 
> Acked-by: Tony Luck <tony.luck@intel.com>

Thanks, lemme push it out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
