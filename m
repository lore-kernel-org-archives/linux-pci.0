Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240D40FD98
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221586; cv=none; b=qQqg6mmPI77rWOn52CkIZCyns9E1ciPhrdSsio34hbZSft/bO7vu8ztP7iUh8ZpDREFSPRKTm6JY4OkVrmdnTZrBJtNLJ8rD4Cllz05VZalYJNXqLB1RBYfJ5twIjS6FbcQmk0F3jl2dvgMSHa9VAsQPF/TNOkRlTwGwA9BASM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221586; c=relaxed/simple;
	bh=WUOWSFpPSsBImUTgRBfJ0UFPVVpolQHRziYZCuY9ZB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=am9RFR3jcD8a9BuH27tU7tJZ6u8Eq4XMKmyXmKT68lxYujoim9ORBlKcv/84AEwqxsSm76GbgqD9ieDrWFl+rgXIurXL8AZ0OHBMrWNltZsnchzrsrnfPOj5YV/1iqjtRC9HxXQnC4oVqpobAX628/O5sYVe2XIWNiX55tQw9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1CFA99200B3; Wed,  4 Feb 2026 17:13:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 16BDB92009C;
	Wed,  4 Feb 2026 16:13:05 +0000 (GMT)
Date: Wed, 4 Feb 2026 16:13:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Randolph Lin <randolph@andestech.com>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, 
    Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
In-Reply-To: <aYCc1GpSr4k2HdHJ@ryzen>
Message-ID: <alpine.DEB.2.21.2602041606040.12532@angie.orcam.me.uk>
References: <20260127151038.1484881-5-cassel@kernel.org> <zdxpiisnc4eq5a26dlaelchri3vu4aoyndy2pnif2rotbiyj72@c3hbnd3cwubz> <aYCc1GpSr4k2HdHJ@ryzen>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Feb 2026, Niklas Cassel wrote:

> > Series looks good to me. However, I'd prefer waiting for Maciej's testing before
> > merging.
> 
> Maciej,
> 
> Any chance to get a Tested-by?
> 
> 6.19-rc8 is already out.
> 
> Even if they are fixes, it would be nice if it they could make it for 7.0.

 Hectic time here.  I've verified it now using the system I've originally 
encountered the regression with.  No significant change in the kernel log 
compared to the previous fix by Krishna, except for different IRQ numbers 
assigned to devices (but that I reckon could be something else present in 
the pci tree that isn't there in Linus's master), and the system seems to 
boot correctly, so I do hope all is in order.

  Maciej

