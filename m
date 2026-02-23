Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF033122A;
	Mon, 23 Feb 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868165; cv=none; b=KK3SVvL0eUCFPDqcZ/Q+0sDU4J5eiajQfiMsz/qQooVOrTaugbR1dlUW1pnoIj5pGAX+93hxQ+uROwt8Lgi1yPGOdhyrxvN8Dy/mygdhd4iyPqlV4kHp88ZGIMzSHXZNIrcNwsk9ylZLpthC02kUuleObGFwvmlspktvWYzVbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868165; c=relaxed/simple;
	bh=UzeMxeCSwdtGeC1IFbmAYXxyY2BAf+KHGNJVeFD5WIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U8PLx32BsVHU21rCMonUtzwmfPHA60I5/amT1U6ryJfZHwWl3ox7JOpzl3B2pIzNYajw0RhrM8I9y6hGDVEZryrxGxsqwEREpRlZzJsgc2TgHEfEBYtI1GZJSssHvW09IxSoRSjKcksHfIee5FKt6hrEseu0OZ9xpnBeiVXHU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+3sf/GB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+3sf/GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B57C19421;
	Mon, 23 Feb 2026 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868164;
	bh=UzeMxeCSwdtGeC1IFbmAYXxyY2BAf+KHGNJVeFD5WIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c+3sf/GBD7hRLO03G3THuSoxWUyLuZiNVcGveNHfPj+Wg7mWr08BSf3vADCAJpoDj
	 Kw/Tx3MLaOZe336eaSlX6oKa0KOpfE/0rCX4NHfeSFuoNKzrcuDHqIo1dCczPe2Fpy
	 uvDEiAVlbsXu930mhWDOPtYIWlA1vPUm6o+xoPQagbVuggk78Yyq4yxji7tG/fDIVQ
	 LIXsJqEB64fyUEqlv7+ApB5UubLYPjir2xGs0F8M5yMIcyQDZYpclVBasxaHJI0iTY
	 AtFKVDq6E7fxAVmCqJMo4OUpsM5fwYFzavA5O36XwBTPETm3eZGi1P+n8cDg+EbPB3
	 FQZlc4vlX3VrA==
Date: Mon, 23 Feb 2026 11:36:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Matthew W Carlis <mattc@purestorage.com>, ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com, ashishk@purestorage.com,
	Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
Message-ID: <20260223173603.GA3698515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2602200124060.61446@angie.orcam.me.uk>

On Fri, Feb 20, 2026 at 12:03:17PM +0000, Maciej W. Rozycki wrote:
> On Thu, 19 Feb 2026, Bjorn Helgaas wrote:
> 
> > > Can we reconsider my patch that restricts the link retrain mechanism
> > > to the specific device that created the work-around?
> > > https://lore.kernel.org/all/20250702052430.13716-1-mattc@purestorage.com/
> > 
> > I think we already at least potentially meddle with the link on every
> > device, and it definitely makes me nervous.  I would like it much
> > better if it's possible to limit it to devices with known defects.
> > 
> > I'll defer these for now and we can see if a consensus emerges.
> 
> As I say it's logically impossible to figure out whether or not to
> apply such a workaround where the culprit is the downstream device,
> because until you've succeeded establishing a link you have no way
> to figure out what the downstream device actually is.

IIUC Matthew [1] and Alok [2] have reported issues that only happen
when we run pcie_failed_link_retrain().  The issues seem to be with
NVMe devices, but I don't see a root cause or a solution (other than
skipping pcie_failed_link_retrain()).

[1] https://lore.kernel.org/all/20250702052430.13716-2-mattc@purestorage.com/
[2] https://lore.kernel.org/all/c296df33-f9c0-42f7-8add-6966d89d00c4@oracle.com/
