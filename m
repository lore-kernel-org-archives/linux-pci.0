Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4D357D00;
	Mon,  6 Jul 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353955; cv=none; b=QLYx4CCg4nQXjgUp9d63UAxX/knsbNTKX2+97WB9F0Z+nxF1oi5yANibh28oCDboomhEXPUdNA0AH5cZ2Lpg55Qki6vRcfFnE94Nz9p7d4sUKEsk1wo28oIeQIy5+3N8gDLwzOUl3qvtEtnZujCV0No5UCnoqtWij3FvSzmaFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353955; c=relaxed/simple;
	bh=3TnSPoRxI0MOSZC+Y9FUSaoEE9WVyo5LqH6T+aZQa/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYrMvRWZdDIxigk4xqzot1ENfBZgDTodukwM8QN1cHihu8HP2Yhy6DJ8agglPaBqSMph7poh393YgN+FM+UXMvugGsaPdTGwgqWvezubxf9JYMD0Uu0aIbsYACzPemUUUXzCKJfOu19VPD0x3od6KfyWMp2ptqMDOTOogaBmGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlaN3zqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlaN3zqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98DA1F00A3E;
	Mon,  6 Jul 2026 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783353953;
	bh=eVPJKAYA4FOtP5keAiYh33guSNJ6m6XsvZpSAFgLv0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MlaN3zqPyuiXHNiIIuCgOedDavdjo4l+inBjC/S2AvUaVIDeSnY7p/910Rc/v2ygT
	 tqwUFuA8ttrOTPl4ExJA68sUF2sg9OL0vsPw40Z9jkJ9Hf0EkleA3xIJlNpSdlmpUB
	 PQfu1jMeMkP5rCHg5xEB5UPr7pq2j6hiL1jGCAWvH/F9ULc/rp2waYUDFFtimJfCIb
	 WrwnzjNhKi3SJB0P0Y5iZGmp4bmiCNPGT9oY6h8joqJZ+nOPqRq+Y3zhl8dcZj+Tbq
	 lObDYf8BwLe0DKjrKbrxTN03R0cZtTbHMQy7p4IPvQDxe8N4Xt+UOLFwaOW1mbhs4/
	 Mcv6CL9SCc8EA==
Date: Tue, 7 Jul 2026 01:05:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs
Message-ID: <20260706155911.GA2885536@rocinante>
References: <20260705152458.291832-1-lgs201920130244@gmail.com>
 <21033e817082413fc343ad155a0c8c5458e5e254.camel@linux.ibm.com>
 <20260706143653.GB17215@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706143653.GB17215@p1gen4-pw042f0m>

Hello,

> > This seems to be a complete duplicate of Ionut Nechita's patch[0] from
> > April. The comments are close enough, but not identical, that I don't
> > think this can really have been created independently.
> 
> Yep, +1.
> This is not helpful. We still want the original patchset included (I sent a
> ping a few minutes ago), but then in its complete form with the proper
> authors.

Older patches (include reviews and conversations about the problem) for reference:

  - https://lore.kernel.org/linux-pci/20240610220304.3162895-2-kbusch@meta.com/
  - https://lore.kernel.org/linux-pci/20240612181625.3604512-1-kbusch@meta.com/
  - https://lore.kernel.org/linux-pci/20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com/
  - https://lore.kernel.org/linux-pci/20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com/
  - https://lore.kernel.org/linux-pci/20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com/
  - https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/20260326083534.23602-1-ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/cover.1776755661.git.ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/cover.1776756380.git.ionut.nechita@windriver.com/
  - https://lore.kernel.org/linux-pci/cover.1776839248.git.ionut.nechita@windriver.com/

This patch is a no-go, of course, given all the prior work (as far as 2024)
that had been done to fix this problem.

Thank you,

	Krzysztof
