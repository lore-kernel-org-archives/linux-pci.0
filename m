Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FC3909A7;
	Fri, 22 May 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489009; cv=none; b=gsbkge+6j/UxSupWM3QoFMO1WaeflmL/wnMb4Le53FHALNzYTFUSscVHzk5vjohq7IB1cL9kmGWXqdGvdZREZCQ3eJaAzgxPNe9mEQ+8iQSdifujHZAPQSSR52NlozlIXWxYdjDF6lHyJV/40HS8FI6h/AAeQck6ofOKMCHnuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489009; c=relaxed/simple;
	bh=iDDGrI+e4lmnso2A59/aL6x4lrJJ6enbBU2/BGScIh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nId5/y5xW2Qhf/HFiVxPSBcwXuDGwoUOXZNXQqiaRF00ka6+iDsOaPGaZtLUdyxEnP5Gw0bDjTk79PxRK3vAUv2aAqeJB+UgI5l3iW/vakTuv/0BX1dFiqJCxg8547Pbq1xIqKd5Jo5rHLpobAQSm1S8mgHillQzWf1lJnmoqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amx4VqUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amx4VqUw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6C1321F000E9;
	Fri, 22 May 2026 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489007;
	bh=B/9Fhp6+B6XVKxfFhPfvyYEl7XjxV0+OL9YTJu5IVL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=amx4VqUwJ54RR0EVj+9g7zObcYqhkFBpZaEysZMG75DcmOPzLRsLdeD3b8TnvWh7l
	 DMh6f+Kur9UOoGwoTdxKjQBu5TjimLGs/PVsb6fexMr6Ag0MQqiZuO7WKNDlhjtrIT
	 YSsqZjwvBr43F+qsaCZ3v+Ucccnw9yNcZeM6jIdWnOLcuva/x0dRB0wvi2ovzX1c5M
	 kN4bv4gQtspYxGG9lL71+n1lmLFQEO6RPrQSrh+pEX5GDcUOnNNaopf32wvT99hMNA
	 C16baUPy+UxbCEQ586PfYQB5nmwhOI13C6KTMPV2FG8ZOEz9bKjarmdve9ppIyC6EQ
	 zFTRR274JAYbw==
Date: Fri, 22 May 2026 17:30:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <20260522223006.GA253892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518191220.636213-1-bhelgaas@google.com>

On Mon, May 18, 2026 at 02:12:17PM -0500, Bjorn Helgaas wrote:
> In pci_power_up(), wait for device to become ready after a soft reset
> (D3hot->D0uninitialized transition).  We already wait 10 ms, but even after
> that, the device is permitted to respond to config requests with Request
> Retry Status (RRS) completion status.  Use pci_dev_wait() to wait for
> successful completion.
> 
> Bjorn Helgaas (2):
>   PCI: Log device readiness timeouts as errors
>   PCI: Wait for device readiness after D3hot -> D0uninitialized
>     transition
> 
>  drivers/pci/pci.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> 
> Changes since v1:
>   - Log device readiness timeouts as errors, not warnings
>   - On timeout, set dev->current_state to D3cold and return -EIO
> 
> v1: https://lore.kernel.org/all/20260514153124.404060-1-bhelgaas@google.com/

I applied these to pci/reset for v7.2.
