Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DB46C4D2;
	Tue, 28 Jul 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266480; cv=none; b=ljDajiAvJomaiDW3IS/QmpGdv03ogOIeYcOy9/d45nUG7sAusKaUWKbz2a9m5rv4H7Fw68frPn7mvIlXe569PMTIrfZOP+RfrFezuhTI4aBaoX3Q861V6SP6GivdTYk3DreMhLcYZDM8sDcwnupdElkJFLILA6Jo9eSKmbRDdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266480; c=relaxed/simple;
	bh=B7iiikjW3RZQKq3luZMA9Hki0kb0lG99YXABnPOZ1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXw8fC2BiTaziX839O1piPSGQ6S/LWOwk9krDNsoELgioKMAQZuYL0LvWBfx9dAEaaRMrS5UN0PrlO2IGvun0Hv5kTMMgs7IDFHby4gMRWy0+gUJuCf+ZTa/57SnOk9x8kRn4OKMrebyhTvrrZhH3W1eUItYqfgo7xvpFaZklFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUKsuKFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUKsuKFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2112F1F000E9;
	Tue, 28 Jul 2026 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785266477;
	bh=hfXSw4Cezo9CUJzD5rmxcTYpcs2wvM40Rw23eThWLlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eUKsuKFTMZw1c5IHwNDNl9ulQLMx+nGUmgIeMA2g6/NatpzorEKpLFNVbwbcz8dLn
	 STaD/PdAVudqs3lxeM3KiZTE5qBPxOG2IJcZC4G+5MR8Xf4so6siRuDtljfoFBUsbK
	 i0KyqfklcKgRt84w0MpwXqMdMjGMkHoAKAv86f5Dh8ux5blq6MZj8ZA5wXuQ1b8TJs
	 /Sw6RGlwlPASkaETNGLMztvbXL5MCumYxTndp7yhF9HVc5gZBgVFp3l01mYFzoq8D7
	 p3C/vq55TP/fy8MvJp8jTL2WysqQvej1kHuJUfpS8zaXvFKYWx7OHzT8/z8atmFzxX
	 klC3Rr0N4MbxQ==
Date: Tue, 28 Jul 2026 21:21:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v2 4/6] i2c: acpi: Convert to use
 acpi_dev_is_video_device() helper
Message-ID: <amkBGerBIwhNNSrj@zenone.zhora.eu>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714185915.865396-5-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Jul 14, 2026 at 08:53:43PM +0200, Andy Shevchenko wrote:
> Replace open coded variant of acpi_dev_is_video_device() helper.
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
