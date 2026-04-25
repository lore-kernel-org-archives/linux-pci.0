Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A62E541F
	for <linux-pci@vger.kernel.org>; Sat, 25 Apr 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156652; cv=none; b=PJK8HJrZ7O7gIgWhOzpsUSTuiV3QQx7CpRd4EhlsSu0Af6e6L06N1+Tb/UazqUyIAHhQD34pJ3QZW+qP6g6wtCZOozONX3/HBR2xW6rmyTddr1mdCxiOLSkzV8DmRTVJUOgo9YCorPt2VUbAGfGiWlFqvB/QF8m8qyxIkoLFU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156652; c=relaxed/simple;
	bh=CgAiApvk4BoYGVmy7dwADuNrJZGCcbEa44TRjk0V3dg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD1IaCMgB0x3BJQxySlU2wGZnug4s6v1YPhLZgVknOBiv+ITdHenr+MurP1JoTMOyf7pufHjJ4uCAbg1QkI06aU4IoB/ELQnuQZuVbESI7b1c4URCZLxq+28UMhLPHpu+v4apmAw92rhAW2Kvj8Dnp1RqBgNz88du9/uBnis/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=qSzO5bM2; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="qSzO5bM2"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id A41DB28049A; Sun, 26 Apr 2026 00:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1777156639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyPBpsqL9+OQlQ4v/lb2O2mCb3GW4NOrwJPdwip7sW4=;
	b=qSzO5bM2XIY53rEES5cmqUIu0aiEpaLPMmrEWKNNY/efYsmibTvb20vFnoiCrS2LPjxiSL
	vofOgLT8H8L/rSnDgJ+8Opxh39z/TnssO68r6Dfs1X3DXdlSOpPMniUANvlhIy5vrrHQS+
	5pyv9M7oUaUIfK8WG82iE54CHWYLSy8=
Date: Sun, 26 Apr 2026 00:37:19 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Guillem Jover <guillem@debian.org>,
	Bjarni Ingi Gislason <bjarniig@simnet.is>,
	linux-pci@vger.kernel.org
Subject: Re: Debian maintainer does not forward bug reports
Message-ID: <mj+md-20260425.223707.47829.nikam@ucw.cz>
References: <aee7asxxZ1qzg_EV@kassi.invalid.is>
 <mj+md-20260422.080349.87303.nikam@ucw.cz>
 <ae1A9ZuAJPHW0S3H@thunder.hadrons.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1A9ZuAJPHW0S3H@thunder.hadrons.org>

> > > #585146		lspci: query the database for specific vendor/device IDs
> > 
> > This could be useful. I will consider adding this feature.
> 
> Ah, great, let me know if you'd like a report filed upstream for
> tracking.

Yes please.

				Martin
