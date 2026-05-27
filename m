Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA420342173;
	Wed, 27 May 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908236; cv=none; b=HDka7CwWd0IqBq7zwuQsDm5srk9nC7y75FGU9Bnlb8r6ar+ZHqx+sLz3Gk6pVmdJmjvLlwB37uCZpnMXmvekYnf9Xe2YeC+UzC2vfwwCJF6OzHm9HgXWFpmCHj+lWM+vdcYMISJAk9hIuI/+nQsrQm20j1UxYgsmu9FIlVB4kI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908236; c=relaxed/simple;
	bh=Yq3+ff6K7ntlWpuVzwdt6bIRXByd5Iu4wy0JEqf0m3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR10TfHBh94zYCqB8xgW28ewoJI225ToBZlXbbiwZt4EpdnJc06ilisM47FoGld/Vo2PLFdwzHF9EutORbbAwaPWIFyEgJk2p2qoYL1fTqSvTiDVTYUmuTgxeHO7IgzPg4ud3YbtDfJrm2lONDogAr8G9PFb8KokDpridJciYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cRIuiwiu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cRIuiwiu"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D681C40E00BA;
	Wed, 27 May 2026 18:57:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DoMDPxIJgBAD; Wed, 27 May 2026 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1779908222; bh=RoLeM58WreKcBsDy8+qfB+qdbMOVsnslLLw5jckrzjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRIuiwiuTvjpU/i5MTSrS9+kc8IRjiv/1ZhpW28zVcQI5tRIJ+vT7NLbQ1ZYbaqJ4
	 WKNPSrwBZ7jdPLCYO+SuFRde11NY0J53KXZ9S8+gAPRD6vI2qfQL8JVxrrJjFxQrDy
	 y/vhfQHu5kxqxtlIHGNZi3T/bpP2b8wn3zmdbgb8FigayUvdtvnu09gHTxN0XtOwUn
	 uyyLWuQc/04x2IK1iFzlMHpvv4QMmIT/aDdslGiawNRdoyFEdMOTsc9BizoLseyw7y
	 oSvzmPRXi4ykVPPoavUuZJwvI5OgRic03oSgZ1UIRiuGsp+5Ylzpkm74G9T3FvEzEH
	 gg3ergVXsyx9bSsGwaxlUDNP+EBb4gtE8ASLemwPZzLg7Y3eCu08iA5H8V3dw9Jqqd
	 jTWOXBP+R3o+p9G6J8J3NT1SpBS3SJEdWfb3szYAPHVTEPNDYr+duDEuSBVZ969BkP
	 ME/IZgfikUXIQ1V+7WYGZN4ID0QAE4Xltmw4vXLD07ttXap8Zh/LVg9IchBTjsRzZj
	 CcW85t159mCoM0gwlGJGYBpBZpeIJTyDloodDELSpPgR/J/iKsnaFxiVJMa2Rsei1J
	 Y/GeNtfIoE1kf6y/QX473avtRSXFDn8NoIAq+KfrxvXczE/KW2ISZJWTDWFxY8aFhE
	 EC9qDtqHSMwJBEh+vEmnh7KM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00:b8a3:f58e:8829:9ca6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 639CD40E01B3;
	Wed, 27 May 2026 18:56:57 +0000 (UTC)
Date: Wed, 27 May 2026 11:56:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Muralidhara M K <muralidhara.mk@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/amd_node: Add PCI Device ID for AMD 1Ah Family
 Models 80h-8Fh
Message-ID: <20260527185645.GCahc-ba9uHWSlvglE@fat_crate.local>
References: <20260527171731.2370179-1-muralidhara.mk@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527171731.2370179-1-muralidhara.mk@amd.com>

On Wed, May 27, 2026 at 10:47:31PM +0530, Muralidhara M K wrote:

> Subject: Re: [PATCH] x86/amd_node: Add PCI Device ID for AMD 1Ah Family Models 80h-8Fh

What is that prefix "x86/amd_node" supposed to mean?

amd_node uses PCI roots and doesn"t need those device IDs anymore...

/me is confused

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
