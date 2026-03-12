Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4E21D00A;
	Thu, 12 Mar 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355080; cv=none; b=n06gpGqDyVHFwcsn3G8HzVB7Rtt8xodxFK5G64eH/xkuL197iLkVL+p76/5/Eqs24ffU1KZWiYVvIix1U7W7I7J7yU7mGFcQeKJ/l2kKCD/Y8IR4yVHbuuUuUB2A4pCF3B88qAd7WezEtAnbml/omvuyyCxVjpbJ0hUEQ7vIjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355080; c=relaxed/simple;
	bh=z9cfsNg/oiO3ipLCI/KoabGgexgoZyq7hg+OfePjRro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E3Z6rT3b6fZ8fmraf3BZqi6IHPsvgRTGWtPlBWuPX4BNA2DSYp+UAuRrqMz8pGphLLfGTlYaDR0OwFTOYPfdc0epa+WUgjEAlNU4kw/2yK68iR4sI3mxWrULQfeLE1B3OCuW6BMXXr+ZFPf1nprzdAZu/33QXv5A88s8KnxRi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ9imKgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ9imKgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB3C4CEF7;
	Thu, 12 Mar 2026 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773355079;
	bh=z9cfsNg/oiO3ipLCI/KoabGgexgoZyq7hg+OfePjRro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eJ9imKgP49aSp2zCrc7eeQchPQVnjVVB2euupOgnGqMFRWOJzTDyF+bb5LsWLxjPv
	 ce2W3ncKTlGKRpTq1G87l/StnLKgVfAaQJjE3Ct0tR4HmdacqxC0YNvFQvbHaHlwNe
	 9uzOMqLif38ZpG2Y2ZVkUJuZqDeJohQDr9xj0IlUbZpDrFIQF4xAYc2ZRwVnOOwlwq
	 noAvnLU/LECda9Dx53n2Eb3WuuNIAPqwXBlFPP4OCbO/3HWBQWN/mNFHfzrubmb1Tg
	 PHssIWlx+H8s4qikT4Ks9vKBUQR86UEyjb3+6j3VtXStlmG9tA1YsckvzxuIpY+5z6
	 7i6mLLNIy0b1w==
Date: Thu, 12 Mar 2026 17:37:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
Message-ID: <20260312223758.GA1241053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ba7402-a0f1-4203-8d8e-9b909003b9e1@hogyros.de>

On Thu, Mar 12, 2026 at 08:39:29AM +0900, Simon Richter wrote:
> On 2/21/26 4:49 AM, Bjorn Helgaas wrote:
> 
> > pci_set_vga_state() is only used in vgaarb.c.  Move it from pci.c to
> > vgaarb.c, make it static, and remove the declaration from
> > include/linux/pci.h.
> 
> pci_register_set_vga_state() would then be exported from vgaarb.c -- is it
> confusing to have a function with a "pci_" prefix inside a file where all
> others have a "vga_" prefix?
> 
> pci_notify() in vgaarb.c is static, so there is obvious precedent for a
> "pci_" prefix, but that's not externally visible.

Thanks for taking a look!

I don't care too much about the "pci_" vs "vga_" prefix.

But it *is* a problem to move pci_register_set_vga_state() to
vgaarb.c, which is only built when CONFIG_VGA_ARB is enabled, because
it's called from arch/x86/kernel/apic/x2apic_uv_x.c, which doesn't
depend on CONFIG_VGA_ARB.
