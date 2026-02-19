Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C7148850
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771473996; cv=none; b=eKJi25zvusDTOmUhm/UDFaN/ritVzZ5cUlZbzxUOkg0m++TSXi39RMxlf40rWptfKeQoU4dHnis+PTlcQk6ULSbUO65bIy8nusXPcVL7s9B32Cryuv3gQe7c2yn2J3K2oAgx/14blgINPMIornMsRs5lSxNywIRKSU2fLjN3CzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771473996; c=relaxed/simple;
	bh=1MZpqN8qtr7NQRQrSwXhx5ioLx8vCHl81eOh2YFfKHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqG3VRMIFKdDluOBXZ5f3X6ySi1Bu4ZEXiG+xQHtTOhxwjZ9b9yIXyMUGk+k24/rw+WjR0Zxr2UoLGNBq0o4r4oMihJ8ykJm6D8DMqdDQyrCqcB7dWLF4Ta+uu5Q9lanvFZS1yR0uOJstQJI3yuOl0yLjoiIFc2v0HFaTzo2W1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id E296A3F1F5;
	Thu, 19 Feb 2026 05:06:24 +0100 (CET)
Message-ID: <9f297568-5616-40b6-b401-df1af57d5e14@hogyros.de>
Date: Thu, 19 Feb 2026 13:06:22 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Bridges without VGA support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260218175111.GA3434382@bhelgaas>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260218175111.GA3434382@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 2/19/26 2:51 AM, Bjorn Helgaas wrote:

> I'm not sure if you also fixed the kernel test robot warnings
> (https://lore.kernel.org/all/202602180912.N7IZbIal-lkp@intel.com,
> https://lore.kernel.org/all/202602181332.NDKD0g1P-lkp@intel.com).

I think I did, but the () are still missing, will do another round.

> I assume this series fixes some problem where VGA isn't enabled
> correctly in some topology?  It wasn't obvious to me from the commit
> logs, but it would be good to include that if so.

It's the missing error handling if VGA cannot be enabled because a 
bridge on the way doesn't support VGA forwarding and hardwires the VGA 
bit to zero.

The i915 driver has a workaround for two internal state machines that go 
out of sync when voltage regulators are reprogrammed, so it needs to 
perform a few VGA accesses on initialization, or there is a risk of a 
bus error later when control is returned to vgacon.

This isn't a concern if VGA accesses *never* work, so we can simply skip 
it in this case, but we need to know that there was an error.

The i915 counterpart to this is

     https://patchwork.freedesktop.org/series/161721/

which changes code introduced in December, so if the pci/vgaarb patches 
are backported, that one also needs to be backported manually.

That's what the __must_check are for, the warnings they generate go away 
when the i915 patch is applied, so it probably makes sense to do that first.

So, for v3:

  - expand commit messages with the text above
  - recheck commit message style

Does it make sense to Cc stable on these?

    Simon
