Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72459370D5D
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924610; cv=none; b=OVKRiy1t9x+D0rIE66f5x1eeiC9lRCQIFO29Vx36wq9lpM7CzLIGI2FB6MYvHqjgj4gmjtKGBQ/CWf6/H4CQ//TBIYSYtCK98AJUhL6SbeNeK2puOIqHhhdXugceCvGMbPyheQ81XVDDxSfLezx97rJ5Mlv3yFi0KtUDHrhI0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924610; c=relaxed/simple;
	bh=B12VaDSwcV6Imr9ZRBpX9WibNhGcvX1MUyCf0LOs8cc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WOer6HxOR05P7vxlACrFCRaTlIyikwilFe+mPFGqysMBW6raBbrDxWBppGxlhbo+yBD/gp8KJzIofMYcGhveTXZy6GQlkrtMlNSaBRf3oZWc0jWZJaKoErf3QGQs+uG//0BZ2vw8+siRUo+yx0pxCv8TRlB8Os1gPoL6N2y6D3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi3LUFkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi3LUFkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42D31F000E9;
	Wed,  1 Jul 2026 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782924609;
	bh=MRxY+Sr+8xdGXwIDuDiuT5Ic22icJlWOnkfY1s7R9/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hi3LUFkLZNS5GZA1Z8F0vzsFJKk/poI6cVMlo+GcvkQ00O0cNPUmBQHY5RVJcNCms
	 CmihKlYUXhD26oXt7af29mj1BudmEkcLiWEgtNqA9EJMWqOEo03hDw0lis8YZKNbqK
	 QPZMr23uAJ2LwNQXAOc9I2EOsqZ8lJwV2IYDGIsAnAMV6uQXuNfn0LVzMgYgiSecS5
	 dZLolJ1MLwIUreWr0NwFGo1cowCspTTQW18JlBqWHrswxTrN1BFArBGnG2PpkrrNZ0
	 gPBg97WXAXeCmjXuRvbfdEBphnDSLMr+TrA4nTk0G4P7PUysR9Oip2G5GTa7+QPhvB
	 jTJeKUMR4Jjbg==
Date: Wed, 1 Jul 2026 11:50:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Lukas Wunner <lukas@wunner.de>,
	Mitran Karthikeyan <kmitran@axiado.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE
 entry
Message-ID: <20260701165007.GA288736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178288258234.309464.3851851961009909953.b4-ty@b4>

On Wed, Jul 01, 2026 at 07:09:42AM +0200, Manivannan Sadhasivam wrote:
> On Thu, 18 Jun 2026 10:08:11 +0200, Manivannan Sadhasivam wrote:
> > Karthikeyan's Mobiveil email address is now bouncing and there is no sign
> > of him [1] willing to carry out maintainership duties for this driver. So
> > drop him from the MAINTAINERS entry for MOBIVEIL PCIE.
> 
> Applied, thanks!
> 
> [1/1] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE entry
>       commit: 8fb2ca9b9d3c82b8629c7331da6684bf269c60fb

I moved this to pci/for-linus so we can include it in v7.2.  There's
no risk for MAINTAINERS updates, so I don't think we need to wait for
the next merge window.
