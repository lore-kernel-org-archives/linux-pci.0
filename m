Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1B227B8E;
	Mon, 23 Feb 2026 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888489; cv=none; b=evSmGCGSUUosHzfe4PCVAZ3wiok1uSug3TK3Y1Lsr9z29i2tKzz0hv0C4ORfW7zF/NLanyLXMC5Y/lcL0IfrOZdfxDIf58b0VkqkYKVL82SrulTY4k4eWfY6Tp/JYTkMliacXA0c17ZBhzdfKRkwEYEJ1IQnJzP5gIDCyq2tU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888489; c=relaxed/simple;
	bh=e01YIAWrx5GdNXgnWAkVWPXUF0aGhD02lZKJLFSQmyc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P7phHOaJUI8FB1PSeLlaUV5Gaz6GDKNtJJ1zdfXWSoE4EZFFlRDZBQk2JhI4Be+4N4THbtArmbnJdflGOaPGIlYAD9XsadWZKow3zsNJY9DxsZLiPbd+i8pvocu+pD+WNMIsLGUDtYAyo3wlHOiaXncGEB4UbinQnGerWEz7lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9335E92009C; Tue, 24 Feb 2026 00:14:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8D2CF92009B;
	Mon, 23 Feb 2026 23:14:37 +0000 (GMT)
Date: Mon, 23 Feb 2026 23:14:37 +0000 (GMT)
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
In-Reply-To: <20260223173603.GA3698515@bhelgaas>
Message-ID: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk>
References: <20260223173603.GA3698515@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Feb 2026, Bjorn Helgaas wrote:

> > > > Can we reconsider my patch that restricts the link retrain mechanism
> > > > to the specific device that created the work-around?
> > > > https://lore.kernel.org/all/20250702052430.13716-1-mattc@purestorage.com/
> > > 
> > > I think we already at least potentially meddle with the link on every
> > > device, and it definitely makes me nervous.  I would like it much
> > > better if it's possible to limit it to devices with known defects.
> > > 
> > > I'll defer these for now and we can see if a consensus emerges.
> > 
> > As I say it's logically impossible to figure out whether or not to
> > apply such a workaround where the culprit is the downstream device,
> > because until you've succeeded establishing a link you have no way
> > to figure out what the downstream device actually is.
> 
> IIUC Matthew [1] and Alok [2] have reported issues that only happen
> when we run pcie_failed_link_retrain().  The issues seem to be with
> NVMe devices, but I don't see a root cause or a solution (other than
> skipping pcie_failed_link_retrain()).

 I argue that by applying this change the issues with NVMe hot-plug will 
be sorted while keeping the configuration working that 
pcie_failed_link_retrain() is needed for.  Win-win.

 I note that active links are unaffected, so to say it's meddling with the 
link on every device is I think a bit of an overstatement, and reports of 
issues are from a few people only, of which Matthew insists on dropping 
the pcie_failed_link_retrain() stuff while Alok is happy with the solution 
proposed.

 Shall we try this change and drop the whole pcie_failed_link_retrain() 
stuff after all if it turns out to cause issues yet again?

 What outcome would you envisage had I taken the approach from this update 
right away with the original change?  My only fault was I have no use(*) 
for PCIe hot-plug and did not predict the impact there.  But no one can 
predict everything and I think dropping a solution rather than fixing it 
just because it wasn't perfect right from the beginning would be unfair.

 As to the root cause, I suppose it's hw people who see the problem in the 
lab could say more.

 I can only guess LBMS is set in the course of device removal, perhaps due 
to contacts bouncing.  It's not clear to me if this is compliant even, as 
the spec is explicit that LBMS is only allowed to be set if the port has 
not transitioned through the DL_Down status, which the loss of electrical 
connection (circuit open) would seem (?) to imply.

 Then again at x4 width which NVMe tends to imply the lanes may disconnect 
at different times each, so the loss of connection on one lane would not 
imply the loss of link, so the setting of LBMS could be legitimate before 
the device has gone for good.

 At insertion the link has to get running stable at 2.5GT/s first before 
switching to a higher speed, so even more so the LBMS is not supposed to 
be set.

 As I say it's only a guess and I may be missing something.  I can't claim 
any familiarity with the PCIe physical layer, though I can take some time 
and study it.

 In any case the unconditional unclamping and retraining actions proposed 
are expected to clean up the state, whether compliant or not.

(*) Except for ExpressCard in my laptop, but that's another story.

  Maciej
