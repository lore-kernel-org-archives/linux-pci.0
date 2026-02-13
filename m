Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AA2F872
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945771; cv=none; b=pzl1lpZEbb1DdNxfj+NsskE/mk4A9Mx8j/qrlm1wbIUc//txYSZmmauvq7+c+EqRhJC/a5V3BPECNJXlIsA/xlJHarOmzwvliowRJ4KwRqxut+MMVHhBuK6KotBjAwxlJepStQ1p7XYE3cttANfa9ggZmHeNGLyiDiJF2pqdO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945771; c=relaxed/simple;
	bh=Zw4igzxZQEpnvo9DeEcYt/JbPfcdWvKRVQpYA0WvAJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRWbL9rcWrtXJ3Vy1Ew2K9tUDY1BsYQb93hx95n1j/nRmLRSOwKG/cUurlgthLre/KbVZ0Efte2e8O2LlneL+hMZTuXILJNhQu0sChRgTnAeZ+0wM4mitmXDoBH6YARwNxrXY6HAx6lynFF/ZjxuIyYBQvo/ONIA31DndEjzQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8l66Inr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8l66Inr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EBFC4CEF7;
	Fri, 13 Feb 2026 01:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945771;
	bh=Zw4igzxZQEpnvo9DeEcYt/JbPfcdWvKRVQpYA0WvAJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8l66InrL1UOVOS0pK77FoZ/vUP99dcoHTDMmB6thh1s43q2FHOGJL7YED44JB03H
	 C5UHtxmhzpKImPZmRUq0EeTOXER/JrE1OWHL2KhOfF7PCvgpsMU8ac7JSbFUgramTa
	 jZXYXQqc/BZ2bJJ8Q72VeXXXdPEY+sK4xkWFJvGpz/WNT6ObBQE7aafQ/Q6TrZyNQo
	 qjSpvUo7ZzNCUbZrxsP/KHB2HcGsxH4V8oiAbN9j9pSRUbXztahLUGiYsY4A4bgA9D
	 lRqDa1iudZtahyHnKNpG89KwwRhYhGeoqpCbm1TzzvkNYgfmZKE7qxZAdWZ2EvRaZ3
	 RMIQZZ7UxX78Q==
Date: Thu, 12 Feb 2026 18:22:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Danielle Costantino <dcostantino@meta.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY586W1YoKVyfBJZ@kbusch-mbp>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
 <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
 <aY5QMlr_7XLIbOsV@kbusch-mbp>
 <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>

On Thu, Feb 12, 2026 at 02:51:46PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/12/2026 2:12 PM, Keith Busch wrote:
> 
> As per EDR flow, firmware waits for _OST reply from OS to complete the
> current interrupt handling. After receiving _OST, firmware decides whether
> recovery should continue or if the link should be disabled. When/how firmware
> handles subsequent DPC events depends on firmware's implementation.

You at least agree the OS controls the "Trigger Status". That controls
whether the link stays contained or not, but now you're saying the
firmware gets to yank the link after the OS returns _OST success?
There's no flow in the spec suggesting any such behavior.

> > Sure, there's no explicit language in any spec I can find that the OS
> > must write 1 to bit 3 of the status register, but it doesn't say
> > firmware owns that bit either. The firmware handed control of the status
> > to the OS in this path. It would not make sense to return to firmware in
> > a state that makes it impossible to report new errors during that
> > transition window.
> 
> The spec explicitly lists what the OS can write during the EDR window. For
> few registers it gives full contro; For DPC status, it explicitly states
> which bit it can clear (DPC trigger status). 

What harm do you think will come if we return the dpc status register to
firmware in a state that indicates the OS handled it to completion?

> > Besides, is firmware first even triggering off an interrupt? Pretty sure
> > it's triggering off the ERR_COR message, no? Why would it need to own
> > the Interrupt Status bit when it's not even relying on it?
> 
> If it not triggered by interrupt, then interrupt status bit does not
> matter (even for OS handler).

Emperically speaking, yes, it does matter. Otherwise why would this
patch exist?

Or the other way, if you think it doesn't matter, then why oppose
improving Linux hardware interop?
