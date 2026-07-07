Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7F42086D;
	Tue,  7 Jul 2026 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396634; cv=none; b=Fs06qCBB/QQWk0s0+9VrVS2kPpQPN1bSuyn5n5zCWoemEuC031AUjFImHVfJUlXM+RC23fCTfTiCgIqUtGVcEl1eIQYaqXoV/5QOMPXgeYmCui9qOx4BA6i84lfO/Po19m0UWPJOXa9YK0zmv0NKKaWGlR68++1RaaBMLCs4fEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396634; c=relaxed/simple;
	bh=hC4fSkAwmW8NGKucdpX00Hq1vRYq8ozpZASh471FWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZlxQDv/6Fmc3UVUfMBj1tFy2PMhupny/d6u3YG6NLlBI+RqgAiMHw2jnCKQLHhd/KNvR3yoqN4AOFP9gpSBcS3F2aO8QkARelIaNro1HP4US85qsczLHw3Kj75eHDO9OYdAqeolBWt5CYiYfh056+EVa0n/XoFOy0ARoTTXPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AmVnVBgB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AmVnVBgB"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3832240E016E;
	Tue,  7 Jul 2026 03:57:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PrjgAcrgi4Ly; Tue,  7 Jul 2026 03:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783396619; bh=I3+Ix25Mo7NhOayFsT1nISFbcSwSN7zrvYUGZxBEu6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmVnVBgB1zKDP/k8OneYj6cyeU27t+ogVT7hi6u14fXbEWSR5GyPSwYMbpTwoaaKZ
	 wTk7fUvlSX/hWoPzcafAFmQelINamPqWxn3+h0XZilHnDBF51UUjMYVBlHUQFxl5FG
	 D4BJCxSqnak37/cMy+2ROP7x3YOlYaax8tanwgarFIUPRRtmB0t1tfNsKjhBwruqCS
	 dXzgtYWTalnAfdGgRZrAOO7+zkbp0XcBEpiJzoaNXK37jPfQi/seC3MsodslnMyQ5P
	 ES8oLDppzM527BXsTisFkf3TVoCc4lTejWJFNu5dNS6sYSwPM5Wg7J5Jt5Y1RPtCMs
	 hoiru+ytDS9WMaZaqt9xPdgdlXhCRBghN04eNY9mqyT0U+ADIZPJIMnpSNTBe9Rmeu
	 JmCCZoAnf+W1kFug1g+5lthi495H2S0hReF2VkGlPhDK9PZzp+jTgR1UPVsdAMxgyL
	 Su3F4EIIdYxAXwzkIjqn0ypyQwpP54pThctNNlG1bvic6VMZBndcSLvO2qDrzXj3Yt
	 BWCszXHNlzBfuzlwdk4tonTaUpShLovTzZg37uT2RqhGVXtQ5Wl2feBXQsYPQi0ByB
	 44PoghqLcnsyRWaGZ/rj9kreGXL7J8rHdqMiFL7qdqTre4sqP69rgKW3zmKSepfgTg
	 JPJN2VyI2yRG38x84kmZ60sA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0382840E00DC;
	Tue,  7 Jul 2026 03:56:48 +0000 (UTC)
Date: Mon, 6 Jul 2026 20:56:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Message-ID: <20260707035645.GAakx4_XEpHpSFBYzn@fat_crate.local>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
 <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
 <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>

On Mon, Jul 06, 2026 at 12:47:39PM -0500, Mario Limonciello wrote:
> Boris or Bjron,
> 
> Can you pick this up for fixes?  Here is the lore link.
> 
> https://lore.kernel.org/linux-pci/20260623141505.1816786-1-mario.limonciello@amd.com/

Sashiko has a question and now that I read it, I wanna know too:

https://sashiko.dev/#/patchset/20260623141505.1816786-1-mario.limonciello%40amd.com

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
