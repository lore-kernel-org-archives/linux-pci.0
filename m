Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAF4B4867;
	Fri, 18 Sep 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728008; cv=none; b=qwIHibf1DI3AQvo75IQpTyrMWXKqLFSrHitILdT0qFKR/XsQ2F5EHk9y2YBtSHfyxmBQZb2bi8F+dbg4wjBCiR+khrn2byE9VLAnsenWO8siu+EBfHwSMUiwJYzdkSWDYkElOUOvipVgJmlHNYE4zRYSSkvnt+YACdjpIuiZBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728008; c=relaxed/simple;
	bh=b4+2kCHdCntN6hwb7OVHCLetqcPS37a/05JscKoObpM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X88hfoTkt26yR3afaaep5iK/imH39jKOosHOTGNYbVZCpnVhxqr93N2ds7stLWDBVHqEMkntHlLLgvSSqry3NemMxtG86fmrXeaUoiKeV4r04OlbUW0Y2bYOdgZRtP2hmd9/9tazGJMZ1944PJAA4iNRvPjJiabRE3vpOTU21zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9DCF192009D; Fri, 18 Sep 2026 12:39:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 980A092009C;
	Fri, 18 Sep 2026 11:39:58 +0100 (BST)
Date: Fri, 18 Sep 2026 11:39:58 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>, 
    linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>, 
    regressions@lists.linux.dev, M M <restafvalendergelijke@outlook.com>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
In-Reply-To: <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
Message-ID: <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
References: <20260917233355.GA1115024@bhelgaas> <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:

> > But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
> > 2.5GT/s restriction in PCIe failed link retraining") even with this
> > patch
> > (https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)
> > 
> > And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
> > this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)
> > 
> > So evidently there are still issues but maybe this patch fixes part of
> > them?
> Yeah, Maciej ten days expressed that we to look into this. Anyway, I
> suggest someone that is affected by that problem starts a new thread
> (please CC all those that are affected by it and the regression list)
> with summarizing the current state + this patch, as this thread got a
> bit confusing... (please drop a link to that thread here afterwards)

 It remains on my radar, no worries.  Hectic time here, a lot is going on.  
I'll do my best to look into it as soon as possible.  Also I'll be at LPC 
in Prague in a couple of weeks' time, so this may be an opportunity to 
discuss the issues in person.

  Maciej
