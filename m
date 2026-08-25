Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB63E9F93;
	Tue, 25 Aug 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653138; cv=none; b=EN1a6NJ2QoAxBT9xNgzWC88EakhyFPUdEPyvrq7hpu/uRIZ1Mm31RK53xuA5mvasAOcwn2JOekKDE7Fd+qkO+MRMKs2Ob6aLuA0o4Xs4CcRpNzB+SBgW45Gtu1zIGN7RqD9Uod4LRQrmLQ/pxJcDJTu9uJM6cjHLI3o1B7ZK7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653138; c=relaxed/simple;
	bh=e7oRh+um67j4UtqjunQUfgTlVwdHiicyDeWrxTdt+YY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YFrZTD4gsvvpkBQy0NMoNBCa9b7+NsasX7UXoWQhOKmwBliMX7PFUvNRfFZD87GzA4kfjag1Z/R6539ldyDxEUmwy5xfV45kU6L5P6BaPn931L4CgRFWQIEEy+/NlEwe3et8HbsjKQTOGXoH5eKlCclOUrrLtPIqKYh3Iezva6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 96A7192009C; Tue, 25 Aug 2026 12:18:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 904F692009B;
	Tue, 25 Aug 2026 11:18:47 +0100 (BST)
Date: Tue, 25 Aug 2026 11:18:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Wild <andiwild@gmail.com>
cc: Thorsten Leemhuis <linux@leemhuis.info>, Aoxtj <aoxiangtianji@axtjblog.cc>, 
    linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-kernel@vger.kernel.org, 
    Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
In-Reply-To: <20260825070527.8481-1-andiwild@gmail.com>
Message-ID: <alpine.DEB.2.21.2608251117260.44766@angie.orcam.me.uk>
References: <20260801201244.4421-1-andiwild@gmail.com> <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc> <20260808063103.10940-1-andiwild@gmail.com> <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc> <20260811064233.11315-1-andiwild@gmail.com>
 <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info> <20260825070527.8481-1-andiwild@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Aug 2026, Andreas Wild wrote:

> > Are we waiting for a reply from Aoxtj before moving on with the fix at
> > the start of the thread? And whatever the answer is: would it make sense
> > to move on with that independently to get the other regression (boot
> > time delay) resolved?
> 
> Not on my side.  Aoxtj tested v3 early on and it does not help them, which
> is expected: their link is up at 2.5GT/s and v3 only skips ports with no
> link at all.  The two are separate failure modes needing separate fixes,
> so I see no reason to hold v3 back.

 I'd be happy to hear any results of your posted HASD check though.

  Maciej
