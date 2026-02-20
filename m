Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10872874F5;
	Fri, 20 Feb 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589001; cv=none; b=e6thkWKYog+yYUrzkADuZIbdHFlfNm0Q0g7831olxDms2Xp/TQtVLmqYeJjYFi2U36PdYhmF6dzuQe8TnH3La+hyzAA2PBypKUml3LEFTaXtROtEdrnM4bbo7sAncsH9H881ZQ9RGE47v397/sjjdMbHBtsbJhF5srpJpVk/OCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589001; c=relaxed/simple;
	bh=BwEd7gtA2o5mFG4fW5xx6lktdFpQHnG0Y2L39b5Ob6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J16O+qeNFPnIiZkRk5tDHxsX0ruzuYH4GtbCP5F5aeV83Q5j5mblY8CMt+HRE8DJxPPeAS+/120sQYfSkL4zct+FPA+Lh1zwZ8IbMKg4b7D7VdHoG/Y8Yv0pHdpeRt5AO+1wqDfKP1h50HMLUg02gaOFvtwKE6WMm6MFjTa4i/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2C80592009C; Fri, 20 Feb 2026 13:03:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 22A6C92009B;
	Fri, 20 Feb 2026 12:03:17 +0000 (GMT)
Date: Fri, 20 Feb 2026 12:03:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Matthew W Carlis <mattc@purestorage.com>, ahuang12@lenovo.com, 
    alok.a.tiwari@oracle.com, ashishk@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <20260219225322.GA3501275@bhelgaas>
Message-ID: <alpine.DEB.2.21.2602200124060.61446@angie.orcam.me.uk>
References: <20260219225322.GA3501275@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Feb 2026, Bjorn Helgaas wrote:

> > Can we reconsider my patch that restricts the link retrain mechanism
> > to the specific device that created the work-around?
> > https://lore.kernel.org/all/20250702052430.13716-1-mattc@purestorage.com/
> 
> I think we already at least potentially meddle with the link on every
> device, and it definitely makes me nervous.  I would like it much
> better if it's possible to limit it to devices with known defects.
> 
> I'll defer these for now and we can see if a consensus emerges.

 As I say it's logically impossible to figure out whether or not to apply 
such a workaround where the culprit is the downstream device, because 
until you've succeeded establishing a link you have no way to figure out 
what the downstream device actually is.

  Maciej
