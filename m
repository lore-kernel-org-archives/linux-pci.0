Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8C306D2A;
	Wed,  2 Sep 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375223; cv=none; b=M0Ucfjno4kX123eHvp571tle33flYPOKgdkCZSrfgMUQnV+NQBqjcBS89QXpjN+oX68r4Y5FkZmmeBfuiBY625ByqC2FbNb99vxTmyTMm02EETCWLSBXTGX1B5Uch7IUad81P3QQLNHz+UAlK3Wrl+0tYSNIUgALSWUddpmiyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375223; c=relaxed/simple;
	bh=aQ/e5iEi1Anvk7orns8m9DQiCpzgWQJgkqWEYMmEh5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVgokTlziTksyCRVV+y1WZkotbExZZoiqC++3bih0wqzhnV/k+ilzSi3QDNxl00hv9ive1RJWLe8FwAmvIxbMDU/udcYJQONX031V4+Wl+5I5FmA4lFa6RQ+B2IilsidKbtMVd3wVGTJa+QzYpevq5MAXoPBBr5NR4T8KKny+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id A3482148E;
	Wed, 02 Sep 2026 20:53:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5E99F60DBD6D; Wed,  2 Sep 2026 20:53:30 +0200 (CEST)
Date: Wed, 2 Sep 2026 20:53:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports
 on non-x86 platforms
Message-ID: <aphwqmtC_EMzLJun@wunner.de>
References: <20260811232245.GA805297@bhelgaas>
 <3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com>

On Wed, Sep 02, 2026 at 07:09:58PM +0200, Konrad Dybcio wrote:
> > On Wed, Jul 29, 2026 at 06:50:05PM +0200, Manivannan Sadhasivam wrote:
> >> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
> >> prevented native Hotplug capable Root Ports from entering D3 citing issues
> >> on old Intel SkyLake Xeon-SP platform.
> >>
> >> But there is no reason to restrict D3 for native Hotplug capable Root
> >> Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
> >> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> >> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> >> do the same for native Hotplug capable Root Ports as well.
> 
> This breaks system suspend entry (crashes the system) on Qualcomm SC8280XP
> CRD.. this SoC is known for fragile PCIe.
> 
> It doesn't repro on e.g. the Qualcomm Glymur CRD (2 gens newer), perhaps we
> need an explicit opt-out like
> 
> if (of_machine_is_compatible("qcom,sc8280xp"))
> 
> or some targetted fix inside the qcom driver

That's precisely the reason why x86 uses a BIOS cut-off date of 2015
in pci_bridge_d3_possible():  Root Ports on older SoCs were never
validated for D3hot and are known to cause crashes etc when low
power states are used.

Thanks,

Lukas
