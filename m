Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBB5FDA7;
	Mon,  3 Aug 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794847; cv=none; b=LMsHCRQrAYRTcp6hU4+M4nBQwYU4IGdLO3zA7yC5icnfz5ZiAcoH2mtTYcyFgkg9jwWjSFHolbIQJRpJGRmm2/Fm31Pehnnhix0FnJlEaU+izAcJs7p24iQUkL/mMCP/akvv4JhWXWZXkrhL4f5p8rve1D6Vf33Z9PONNW3/Ya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794847; c=relaxed/simple;
	bh=rmFMREnTBIjEXj9bMh4iMaywZD7aqXUUh5HXEtOM/JM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Po587ddBsL5O+jCs5tH6msG5Ji3L6n3y0uxsPN6c8KWGuYEtglHTxCE3Kf/FSoWCJ/RfM+l9ix0oUziGaPxaTcZpps+4yzxyh9MIYIeyzvKL4Sb9HBxb2zE3wdC5l/7+rParriBa4t0y2sTC2o762SAZX4z8QGGlumfY7WkI64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6032292009C; Tue,  4 Aug 2026 00:07:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5A3FE92009B;
	Mon,  3 Aug 2026 23:07:16 +0100 (BST)
Date: Mon, 3 Aug 2026 23:07:16 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: Andreas Wild <andiwild@gmail.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
    Linux kernel regressions list <regressions@lists.linux.dev>, 
    edwardmalik95@icloud.com
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
In-Reply-To: <4cf40370-47e8-4143-bebe-bfab78ac2fd4@leemhuis.info>
Message-ID: <alpine.DEB.2.21.2608032257510.55540@angie.orcam.me.uk>
References: <20260801201244.4421-1-andiwild@gmail.com> <4cf40370-47e8-4143-bebe-bfab78ac2fd4@leemhuis.info>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Thorsten Leemhuis wrote:

> > Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
> > failed link retraining") the Target Speed quirk lifts a firmware-imposed
> > 2.5GT/s restriction on any downstream port, without checking whether the
> > link is up.  Where nothing is plugged in, the retraining that follows can
> > never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
> > quirk makes two of them -- the initial one and the restore on the error
> > path -- adding a fixed 2 s to every boot.
> 
> TWIMC, this patch fixes a regression Edward reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=221801

 Thank you for the pointer.

 As it happens attempts were made to cc me on that bug, which however went 
nowhere as messages were sent to my long-defunct <macro@linux-mips.org> 
e-mail address, a clear oversight of mine as I went, back in the day, 
through numerous sites to get this updated.

 I have now asked bugzilla admins to help me recover my account.

> [side note: the report could be more specific, yes -- I wanted to ask
> Edward to clarify a few things (like the actual slowdown) before
> forwarding it, but it didn't came to that when I noticed this patch and
> asked Edward to just check if it helped -- which is did.]

 Tested-by tags welcome!

 And thank you for your input overall, really useful and appreciated!

  Maciej
