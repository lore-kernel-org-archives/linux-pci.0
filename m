Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A473932E6;
	Tue,  4 Aug 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863464; cv=none; b=I1Xe4Nml+LLMPiHqABM4ZKkx8/zrAShzNz2phZQBL3DBUyll0+sHn/BISLogGSEy4hYeP2VOAH4KUPVQxzhsrqc8f/yHz9rKGTJEp0++KSFO0SzAFOfLVXYRe2mGN9rK0i9ftP+6z9Ay/uzd4Sr1ee0gXXK3hCF5vq47AiHMtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863464; c=relaxed/simple;
	bh=35eyXciPR9j8/MBduG/c/JnLYoZ+utXxlxeVdSkYFDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VopBuZkzx7fbZDrtovggpr7jnCdIGcsIXjeb8hcPjyQtEhoxUhYT2pF+e3CzAKEaKhewvxw+K9SvTBaPz6l6MLdgPQEtpU5MnLIF/mKEV1+IMHbNBDOO/UUT/jCqFSKfoXwgcUsEtuh0S0ZI8kFFQ1T5CuomW5qvOcSw0hxPw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFrfCeCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFrfCeCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEF71F000E9;
	Tue,  4 Aug 2026 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863451;
	bh=1LVVNbLVWwC5CIGGgYIPTH1Rm2DNCYV2WCjmIvLSONY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MFrfCeCOk9v5LXwZOXNM982o04Adm4HI5V0VodP5c58khb8zMRsvti5IMpfuDVpe0
	 V8ZitU5uYRVkg8A4e+eoZAAzi2GyBFsoVRyWProin2S2qCCT+2XRh3PuLEJO/V85xj
	 LjGjQEAcvw3duswB/XtdYyOdUc5/+NKOd3JwKc17lLG9+twRiyW/bCzuD4Ns0SIky4
	 QsmT92AYNQ1ZSo90DWZXEqzm0j/K0g5xVsHOt+z/2qRwRgNcJxNRDEqJwoU/lxHBDy
	 T1Wcr0pKbjaKBEEk3GB7jPk40Un3R+rDPleGgUJgAd1DwQptpiiLfoj04A1j83HZ58
	 K6H8+gcRj4hHA==
Date: Tue, 4 Aug 2026 12:10:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Warner <rick@microway.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rhoughton@microway.com,
	ssingh@microway.com
Subject: Re: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on
 adjacent x4 endpoints
Message-ID: <20260804171049.GA1844931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575ad8f9-5cf6-4365-8c0c-ce34b5b42323@microway.com>

On Tue, Aug 04, 2026 at 09:55:23AM -0400, Rick Warner wrote:
> Hi All,
> 
> Here's an updated version of the fix.

Can you resend this as a v2 of the patch (not a reply to the original
post), with its own commit log, please?  Be sure to cc Lukas and
anybody else who shows interest in it.
