Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E353DDB0A;
	Wed,  2 Sep 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362060; cv=none; b=QUKW2G0vBSlEgbtRAM+8e3CTCoCSrDkWzxjSXnOHSvQmQZDlR6DRpyXLqFe5C9hK7LAKfiVxLtQlCqykPWImeWRExmdLrNVzT5YhMvX83HkVl5QZZs1PLqeU+tVjYmWclQETdWxuPv/bUMY5robO/X1VFmWuw/T35nlMBue3KWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362060; c=relaxed/simple;
	bh=mZD4+9zNMilKUrKEQmGK4V8mTRae7XvHliv57yrDxUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8YkNKjv0OCTnNc5EKRIFP4T3QfS6J7WwdW4yzu4Tx8bJseDkSddVuuweKhUJ+Nepn3y5i+iiUX37kOajy55tExjtW4CLfcT6U2MaNoyEUkaR7PCl6pb1WS41IoxvDEThnI4BnN4YQBkEjEP956C+HYAN9C4iKEaNdfayJ8MO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hjEqhnF3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hjEqhnF3"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 81BC540E02C2;
	Wed,  2 Sep 2026 15:14:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AYVx6gYArKhO; Wed,  2 Sep 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788362036; bh=0/7TFecHgxfgCO5pVrEG5Te+we3BLLQUU8o9mjQMmaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjEqhnF3HecIstgHusjlIqnW0ry/eCmQcwtmDLIrWH7YP0JR6sCXSBFwT0vaLG3Z+
	 mEScjGSCg1YCIqamq0mA8UVaxaQRQHe5KWPyYkNAPkSrtCb6spjSgnTxNn4hgHK1EY
	 UDY7G07q+KVHLpXD7iTqIX912lAonnhkwXGL99560+nw4B24Po1zbC7LNJNeWEWXQc
	 NKOBT8PxWLrvbWFS3cz4YsRye7IsqHuCiow9JhY5/10uOZr8hyu59oAIeMqKub/DJa
	 tRB2dAn7rnBL7Kpq/K9LgFIN02Q5FhAwR49lvVucU+0CdIhMW3vsIsHodm5h37cEo0
	 V/1vh9orBNm1oL50CHi1vAdLTfX1gSe+Ks2SDQpGqMxMrY9ji1g4ZwnlcXLd/aazFt
	 prLx8uhHsxSNN27oNCwpdFL8QE25n83lP6Y6p0Ezp+/p7h9oWJ4Al8I0jJiSc32C6G
	 T49YF63h4RbeXe4D8C6BDGCNdHBde8xiZJz0jV/5AmM9H8nF2b7LQb2t03j2I0V3H2
	 322iSYHGkywRBYRD8pXriJDdADwpPYsKQhaDGev9c355kJgpXQWZXm13lYm9zOh0M5
	 IfPQBCfPOcyW4T8oZ04SAU70DiQlj4qBi7cmgy7mZTnL/S5yjNzWZWm+NDXc0U1QKU
	 f7FYxVDVvi6iRitC1JAwEWN0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FD6640E024B;
	Wed,  2 Sep 2026 15:13:44 +0000 (UTC)
Date: Wed, 2 Sep 2026 08:13:40 -0700
From: Borislav Petkov <bp@alien8.de>
To: Lin Wang <wanglin@open-hieco.net>
Cc: yazen.ghannam@amd.com, mario.limonciello@amd.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
Message-ID: <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
 <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
 <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>

On Wed, Sep 02, 2026 at 02:22:13PM +0800, Lin Wang wrote:
> Please let me know how you would prefer this to be handled.

Well, X86_FEATURE_ZEN isn't Hygon apparently. Otherwise, we wouldn't be having
this conversation. And we wouldn't need ugly workarounds like that.

Which means, you cannot set it on Hygon. Instead, you should check vendor or
define your own X86_FEATURE_HYGON if you think it would be useful to denote
common set of features between all Hygon cores.

Reusing an AMD-specific flag but then having different hardware which needs
hacks and workarounds to the code is not what you do. Hygon is a different
vendor and it should be treated as such - not piggyback on AMD code.

Unless you wanna piggyback. But then you have to extract it properly and make
it generic so that it can be shared. I have been asking all people submitting
Hygon code to do that and you are starting to do it but then you need to stick
to it and do only that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
