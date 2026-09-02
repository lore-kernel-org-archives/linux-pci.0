Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65102F6565;
	Wed,  2 Sep 2026 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317344; cv=none; b=FpFH30/qkIMtFnF2mJyxbiav4oIoeIkZ2q8hukVilq+Za6LAM/wPW/w3Q6OLOv6iXI9CCk3TLWCqjTHyQetj1AAiOZzmm2vOOynk0sMEEvVA8Qukvxr1vuMS6M9bpRnS62HKtJUgsxvtF0A+p1TZMRoeu0Qi5f1NlhSuMKFSOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317344; c=relaxed/simple;
	bh=CDAJzbYFopNuEjEPfB4EVEmiwJ+X3rMUurCQCJyw9jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oglSF99HjDp0iQtxE441FflXx6ijtgrKFGFAMgWUo9tIif44lzCvq3rlQAOhzH7bhZtL6sZffhCr1Si0uqzBlldfoaoTAYXFqGSyfT5/7VQ1AouoNN3vuZuqp1v2hCyTXjAkuF2DjvIaDkuf/Xy1J7OWCHIuYFFnZx+aH2oS5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WcQI6P17; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WcQI6P17"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 084FE40E027F;
	Wed,  2 Sep 2026 02:48:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7NmeUwCEEEgc; Wed,  2 Sep 2026 02:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788317328; bh=8FhQLUNASJhKidoY+QLjPNwf1uqxBH4I+mVz4+wIwkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcQI6P17kwI2Vjis9arQDZz/G1Camb4d2mbkT5zFvrQM08FAfptsDyIb9LXijboQQ
	 Hd19o/BuIg4IVY4fr1CvDQSjkzoG8GovSjbgTnVuxQ+hJOHyhW5V/xTlwkzT4LL6eF
	 WloHiqD+koeBQdgfA083JmlrxuCfP7AHqRMAz+/PsZgyFhVA9K4NfIntlEZiedjZwL
	 6UJxBZnkJ1aCjzIBJdbqZvyQlAh2Tlm3T7Ad5otlksk7iibN9NlVTGXgBeOgEMxw/e
	 f0WRgHoa2AQ5O8RNXI35ILgaBBGe1y6b/sCP5WsR6EgIP68QnG719Uleklqoaxkhq4
	 rnU1V9rwtZdWc5msq+dH31yOjRWAfyjAErTKpnP2lXC2Nrk2rQgJlR4FXQ7TIOuIqq
	 bGuNjdC88fMmIAcy6+/JnBNuqUlRTOeLpnwuZZMnHC5UdRX8MaoF3QnU+8Px13TYSy
	 nW3Q8K9YY0BBYbls9NA97v9LBPAOFnbjkbJn76hkAWzaddGXlRSx7URGULdPdEEi4m
	 LuSiq5xZvSmanCzXW4Bmxy9SZKyZUhfjB0XYLZyyNLZYOEZMR5+pp4xrp5V78vXhwH
	 FxEEJsEA4jdfZ4o6mfGSeTZcJmd9rF3/YoS0059YIzA4A3ji6CGYN3QPmpIoJIHVIR
	 1VuxgDtgRzpniDdaSWG4xfJE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F94F40E024B;
	Wed,  2 Sep 2026 02:48:36 +0000 (UTC)
Date: Tue, 1 Sep 2026 19:48:33 -0700
From: Borislav Petkov <bp@alien8.de>
To: Lin Wang <wanglin@open-hieco.net>
Cc: yazen.ghannam@amd.com, mario.limonciello@amd.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
Message-ID: <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901071700.3255382-5-wanglin@open-hieco.net>

On Tue, Sep 01, 2026 at 03:16:59PM +0800, Lin Wang wrote:
> @@ -252,6 +252,18 @@ static int __init amd_smn_init(void)
>  	if (!cpu_feature_enabled(X86_FEATURE_ZEN))

This driver should exit on Hygon right here.

Why doesn't it do that?

I know why - you set X86_FEATURE_ZEN.

Why?

What do you really need it for?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
