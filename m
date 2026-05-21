Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6237206F;
	Thu, 21 May 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374856; cv=none; b=JaL3IMqfjNr+O55C5GUfYYsD8S9N5jxlLuGoYSA7Yq9y506bRvPL82es725SXclfgKi4KMnd6YZoPCzTUKP9sgF3YwJhvyKLDbKrptD+041taRmWzU8/k1CFnLU7x7sMJAL6Mut08O62sF1iNrd1+SE1v5Zg/90R0HkYsPVrFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374856; c=relaxed/simple;
	bh=34vM8oC08HMw+E4/NG6bZv1CxZSArT+5viOXRQ6TiDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwBJWguVBthGRg9uYqs7oes/tYd+Ad7RpoMzscmNdk1qRR3j7yg6qYGbvSr5N5kqjzmdayY/Qgb65gg06KmT2KlgIejAuPrMFtyDTvTtOyYnYb12psXGF1/A2PtJG4pBt+o1V7gItlpjkE/leIQ6Q5e77FC28kboGRjD5RLcgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zc9Y2EKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zc9Y2EKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE69D1F000E9;
	Thu, 21 May 2026 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779374855;
	bh=gVaOyRE5SdvShW4Noo+xeu/A7h7G8HtSGPx8etBkX5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zc9Y2EKE6Helr38u2v9PnCCoGJaGhBxPLIr/lzyyt/VgW3GZ+YkVvF4am9hfWZp45
	 3EnKnJNkmumsFoSOcbQd3oxj4i35n3jrzNMLtA5jEKljl4HyFEjuwZhuOLFdOp2Wel
	 uQySJhO8rQObXQqBR38SuTyAlC5QQVT5W0BKA+jk=
Date: Thu, 21 May 2026 16:47:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jihong Min <hurryman2212@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	Yaroslav Isakov <yaroslav.isakov@gmail.com>,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Message-ID: <2026052131-dad-glory-59b3@gregkh>
References: <20260519000732.2334711-1-hurryman2212@gmail.com>
 <20260519000732.2334711-2-hurryman2212@gmail.com>
 <06236462-6c4f-413d-8324-537fb8f743d9@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06236462-6c4f-413d-8324-537fb8f743d9@roeck-us.net>

On Wed, May 20, 2026 at 07:18:49AM -0700, Guenter Roeck wrote:
> On Tue, May 19, 2026 at 09:07:31AM +0900, Jihong Min wrote:
> > AMD Promontory 21 (PROM21) xHCI PCI functions use the common xhci-pci
> > core for USB operation, but also expose controller-specific sensor data.
> > Add a small PROM21 PCI glue driver for AMD 1022:43fc and 1022:43fd
> > controllers.
> > 
> > The glue delegates USB host operation to the common xhci-pci core and
> > publishes a "hwmon" auxiliary device with parent-provided MMIO data.
> > Auxiliary device creation failure is logged but does not fail the xHCI
> > probe.
> > 
> > Make the PROM21 glue a hidden Kconfig tristate driven by the user-visible
> > SENSORS_PROM21_XHCI option. If sensor support is disabled, generic
> > xhci-pci binds PROM21 controllers normally. If sensor support is enabled,
> > the glue follows USB_XHCI_PCI.
> > 
> > This keeps the auxiliary device available for a modular sensor driver while
> > avoiding a built-in xhci-pci core handing PROM21 controllers to a glue
> > driver that is only available as a module during initramfs.
> > 
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> The two patches should be applied together. For now I will assume that
> they will both be applied through a usb tree since this patch touches
> common usb code.

Sounds good, I'll go take it now, thanks.

greg k-h
