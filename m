Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9E3A5E65
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279127; cv=none; b=BuvcMKjvfcuT7IO/Nhrj9+OiS3umONgGucY4vRXk01FvmTQumDAajryE9LB996WHKWylEL1Qz7hV7uVdmkp6oJSHWfRcXJz3A/XmydHPTM/s9JiT/bhedlK9+NoeNHRpFLKPGfXh2rn1KwlwMpkxyL56yrWpBw7/VKNX/SYsxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279127; c=relaxed/simple;
	bh=54MGIL2fP6UxJUsR96DHwoJUSyyvPIssH0h1bbbnPIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq5QSXEvBPW2qS8tYSbUQGO3JwcVvt9YVU4nyZyUKqWyWjjNPKn6s9HgAU2bjMtggZfxtl6Eu3f51fIW0PdZ5vPtetZ8lvHikj75wYf1f8JW3w9n/u9W3gU4eRRwB9mKbmmb+lsjpFGfRu8Sf+a6noEhoIzJfJrDBd2Vzl3j4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goHt6IVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goHt6IVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554991F000E9;
	Fri, 12 Jun 2026 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279126;
	bh=10y/PqVdybTQA7CAuBtXpVaH4R+E+jCeVQ/pdF/7o0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=goHt6IVHRHlVrwe5gOVhPf2UTbwd2JwwOj4suce0zCHN/HOA2pJa43vICK8h4trTz
	 F90nGxRMMYSTYQ/oIEWx5hkMkyufSuI4pFkujlQki+CMHPauy57rYapv7IHh54fJLu
	 jYGGln8PD06hU8z4Rvdp6b9PEF2oiNIFfCJuBgs8iimJBDaWyva0LJtpZdmFgxDVra
	 B2Is0zHwGjnqFJUJSPSihurWDbJZCa3lALbNfWj8c7T74zYLdF1VajKrORRxtqJJJy
	 v+I4IZ+lrzjo3RdZsQNkwXWDwnPriMijVsyXm1zsybLMIKf7e2qn+1w7bDOTVy398n
	 N4GIph4V98GvQ==
Date: Sat, 13 Jun 2026 00:45:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260612154259.GA1436258@rocinante>
References: <20260611150543.511422-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611150543.511422-1-kwilczynski@kernel.org>

Hello,

Related fix:

  https://lore.kernel.org/linux-fsdevel/20260612153031.536525-1-kwilczynski@kernel.org/

Found while working on this patch.

Thank you,

	Krzysztof
