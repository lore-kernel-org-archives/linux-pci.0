Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002736EAB8;
	Thu, 22 Jan 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105794; cv=none; b=tzxm8KgUoGc3g82rFuuhh2idj30rFVoSkmLs6vaCVeiTbE0EIy7ygjtQsNGU8SHGhIWOgJMXW7E7gGP5LVYxjO8PSXkDhvQv/VPzoAZVjKKksLvHReBJW9CL8OA5vTmqIVDmRXgoB/Ef3oNcKY+jxJ8l7SiXpasV9Xa5jKI/wAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105794; c=relaxed/simple;
	bh=B+VTRAMPF/5hfKD7XYDcddVM/g7Pc3Pr1FC8TaMmDvY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R3c8xaAwj0lEXcCh3pP4IDPpHV1dAxjGYSXsLp7DzZKSwVqNZ12Lk5Qu/MFgpIfkw79+vdtQksE7pijAWlykCp7MbJ0+UbHFLCiv/oPV0rkMhD3yW1+TlaMn4b+gJcDEr/It6j2Foiz0SLCWZb+qKXO8yWhjmTOGmt400rbIfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3090292009C; Thu, 22 Jan 2026 19:16:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2A46392009B;
	Thu, 22 Jan 2026 18:16:11 +0000 (GMT)
Date: Thu, 22 Jan 2026 18:16:11 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, 
    Serge Semin <Sergey.Semin@baikalelectronics.ru>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU
 setup
In-Reply-To: <aXI8ByG3RlLpIRRa@ryzen>
Message-ID: <alpine.DEB.2.21.2601221806080.6421@angie.orcam.me.uk>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com> <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com> <aXI8ByG3RlLpIRRa@ryzen>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Jan 2026, Niklas Cassel wrote:

> Also see my series here:
> https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/T/
> 
> That tries to clean up this mess.

 Is your patchset referred meant to replace this one or does it apply on 
top?  Shall I verify yours with my RISC-V HiFive Unmatched system so as to 
determine whether it is as good a fix for the port I/O access regression 
caused by commit f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling 
ECAM mechanism using iATU 'CFG Shift Feature'")?  You don't seem to refer 
to either my issue previously reported or the offending commit.

  Maciej
