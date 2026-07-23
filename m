Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4D3446DE;
	Thu, 23 Jul 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786081; cv=none; b=HTs87sm6eglZCR1nUEF94DsrbYMhBmsZDWHGetcuOeY+CHbnt3DIDGLFGDVCYHkvyl67JrboVCJrsFo2a6fEF0zKotmK08AJGdSisPKfwzvuX+V2sp1ZYg6bHywhF1lK5BFzQGN2Ila74HG7ARr09CZBk2CZiKil2K+JiM/CMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786081; c=relaxed/simple;
	bh=Y2pBtQ+9A3cBdRiSUQdalqgZYCDhiL/r6VVLM+gRBfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF9QC+8G/8tXpiODu6DF88vadW/g/mGjBogdyGaF0Ya2NG3piAkDSutau9uMn3JQl4dB4s4C4JOn3E+WeNJPJdEr8fVc8pKOSAu9YOkGTz5mh8O1Lxr41eKAWBF/mMD+nv4/UJ3RvW6T3TNBhzufKLRmqftCJuXEwK7Z3wAUKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PGctRurX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PGctRurX"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DD8540E014C;
	Thu, 23 Jul 2026 05:54:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IfZZW43a_hB5; Thu, 23 Jul 2026 05:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784786065; bh=aXME5abyiM2FcxO7X1xQmBbHpKRCAC/9uxeBwGv3xMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGctRurXJKTEW2YvBriW7lCS7WhfSyajw1bnCuPeviUMT+0x6NagYuptYbij+f3qO
	 UR7nNWjT60I55kQn8KVkEFT4CzS9rsz41VK0vb0OSHPlr1Q0IxxyzlU1dwnPjQ5WSq
	 TFCmrM6hToC17Tyx1eq330KOAW7qrYTrljZ21VFrACkyQj+3wPNHq61G3o06Q4CuHd
	 o0mu93GU04hrXUyF4Py56rx+pf903NOEPrzehmwHVXNQElwcT/L1NabQD4f2ffM5Ot
	 xkHZCBagPv0iQgFYA08v5AVxAubbJSAjb9HudxedE7xjnymAJ2fgTnaXh09qqdkIzy
	 FzVqHf7WtVm1/3pHyazyb4ucJT7tEbj7/5ing2oxJsy8evoc80J1h2KsOWShPwr5VU
	 CwkSU0UMyyk/Z5wtaDe36hPdbpv5MEgIYo9MVCRInwhRspbYqgohoyeCy9nAl5OGL4
	 gJ/bfUGhfZd5QjZZXgYnC+ZjoPQykUzpDqoldn99CrTGjEWIu1xs18IomT0tdKWQEF
	 +KPSt/qEenYZ2ebfhemLbU/wyn9/1x8mZ2/QXFo06RpJvuYNlBlSGJ/+rgQWWiPE7s
	 uLfT/7KPvIalk8nIK5sitbpSX25as+sElMn6NQWSp8lfHlXMJcIapikTjsrE3iEmEd
	 ASmQxBa98HokJ59dcKrjsVE8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF04D40E00DC;
	Thu, 23 Jul 2026 05:53:50 +0000 (UTC)
Date: Wed, 22 Jul 2026 22:53:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Message-ID: <20260723055347.GHamGsaxesLkMbSnfR@fat_crate.local>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>

On Wed, Jul 08, 2026 at 02:58:59PM +0100, Ahmed Tiba wrote:
> This is v7 of the GHES refactor series. Compared to v6, it addresses
> the Sashiko-reported issues including pre-existing ones and fixes
> the ACPI-disabled cper-x86 build break.
> 
> The DT firmware-first CPER provider is intended for the upstream zena-css
> platform. Validation so far has been on FVP.
> 
> Changes in v7:
> - Address Sashiko-reported issues for this series, including pre-existing ones.

And Sashiko flagged more:

https://sashiko.dev/#/patchset/20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef%40arm.com

I'd leave this to Rafael to decide but I would fix them all first before we go
and carve out things. Maybe we can share the effort and such. I see an EDAC
one which I wanna take a look when I get a chance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
