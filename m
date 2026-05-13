Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5623A984;
	Wed, 13 May 2026 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648824; cv=none; b=rFTFflUMJsLo9d/XEj/R+mgRA8Qgkp+0QAOuA9GvUQ2pyU24hrTHh5+vtXzpXKaxfqiAvkwJCPcgggUJkKwfCUYcLldb2Bkhy8YqlWpRQ4GixvIDTP7c1HZa+r6egzFdiAL8B26JyrYddTYaWeNnxom9OT/HN946RF8V5GafDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648824; c=relaxed/simple;
	bh=Od8jQ7HppMWceeFf2Wz1PMSY1Oj7ZTXnse5bp6MWPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITKqWJGNF/73JnfP1JeIh/Sk37MgFNzb2IHUy4rmqdf0ROoHMwZRsnqULFRe54ExhiLvyC4n2T9mgkdgokGvd8CLYzaNw9IA9Qpol3N5pva2YzIwdlqVYGPcLVxLXpDajsnP/UDjfaQxhRb73yDTRSwnlOPsUN3SNqd2Em7JncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgC2fiWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgC2fiWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED8BC2BCB7;
	Wed, 13 May 2026 05:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648823;
	bh=Od8jQ7HppMWceeFf2Wz1PMSY1Oj7ZTXnse5bp6MWPgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgC2fiWGaFx565UsEzgDHXGiXp50zB4X9zvT4iVLodn9o3flW8VoJCS5NzC2/yFA6
	 oWE70/AMSAku740cdOvj9f/u062UzaTOGRBlIgXyoiK1bY1bFrheirLIgD5YsZisNX
	 C3bSbnVJs+pPmnz597WZ+nr8s1tBkQfoK6EHL7IAt2OBF9VjAHqDzcRdqUA/TC/Kib
	 F3McmMmHC1fpiLmsscdzzVS7XrEssw0ck0XRWC7lnWnIhvbyuyJik9lLM1rSgy0AII
	 Go4TOwfPdVr8QNj2mvysSkMzPhwLFwYoBubi/o4AnLNOVwaDEVB2r8GIXZpsvCdcvB
	 /t+X9tN6chHEg==
Date: Wed, 13 May 2026 14:07:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ravi Kumar Bandi <ravib@amazon.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap
 handler
Message-ID: <20260513043934.GA4124219@rocinante>
References: <20260512094621.GB1539393@rocinante>
 <20260513040401.16035-1-ravib@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513040401.16035-1-ravib@amazon.com>

Hello,

> Thank you, but as you suggested above, I will update the patch to use
> pci_dev_is_disconnected() instead.

There also exists pci_device_is_present() which would attempt an actual
read of a vendor/device IDs, so if this succeeds, then you have a more
solid assurance that the device should be working.  However, this adds
latency, and there might be side-effects, potentially...

I wonder, if for you, you could forfeit setting any flags on a resource,
which drivers don't customarily do, such that we would only rely on
checking pci_dev_is_disconnected() on our side, so to speak.

We won't be setting any precedent here, as the helpers such as
pci_read_config_byte(), perform this check internally already.

Bjorn and Ilpo might have different take on this, though.

Thank you!

	Krzysztof
