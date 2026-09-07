Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60593C0625;
	Mon,  7 Sep 2026 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784402; cv=none; b=E4GyzEO5eQhia2n+jhKdpsOjn2bC9bYRFDzVAR3rT1KBfIHID4S0ry/o17JlvjKXbgGMzbe5VIQyRpZ25nTOGvapnvgkp2Z3sl0CmtC6EkPCsgZpyJBIK8EEOx8wDjCoRESCwG3JdC/fjrcgEEFyLD7Wi3hTVxmZq6udknWbzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784402; c=relaxed/simple;
	bh=Xq5/ce3tivwpMGp2s9/KRURLmeqJnprW1NrEIHmsBNY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jlOVU1lmnxKYG2BiWpxzky1YZNpXpBkWQUWyr3u1s2+bd0bkRlFA6/V2+9t+pL6twNJ3+MaM3VMZVN9c+9llvNz4nEOjNLSdMa8CmzHk/WCBc5p+tNCv4LYZDg83GNc6VuHYWBnmlbSxpRWU5+LCV03hCpNoWSDqTZMi5PgyOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C849A92009E; Mon,  7 Sep 2026 14:33:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C489792009B;
	Mon,  7 Sep 2026 13:33:17 +0100 (BST)
Date: Mon, 7 Sep 2026 13:33:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: Bjorn Helgaas <bhelgaas@google.com>, Aoxtj <aoxiangtianji@axtjblog.cc>, 
    linux-pci@vger.kernel.org, Andreas Wild <andiwild@gmail.com>, 
    linux-kernel@vger.kernel.org, 
    Linux kernel regressions list <regressions@lists.linux.dev>, 
    restafvalendergelijke@outlook.com
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
In-Reply-To: <fdbe2872-6fe3-4746-9d10-1ccef3a3e88d@leemhuis.info>
Message-ID: <alpine.DEB.2.21.2609071332380.46717@angie.orcam.me.uk>
References: <20260801201244.4421-1-andiwild@gmail.com> <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc> <20260808063103.10940-1-andiwild@gmail.com> <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc> <20260811064233.11315-1-andiwild@gmail.com>
 <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info> <20260825070527.8481-1-andiwild@gmail.com> <alpine.DEB.2.21.2608251117260.44766@angie.orcam.me.uk> <fdbe2872-6fe3-4746-9d10-1ccef3a3e88d@leemhuis.info>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Sep 2026, Thorsten Leemhuis wrote:

> Thx for the clarification. Would afaics be really good to get that fix
> in to solve that problem. Bjorn, is this somewhere on your todo list?
> >  I'd be happy to hear any results of your posted HASD check though.
> There is another report from Mich (now CCed). Mich, can you maybe test
> that if you haven't yet (your report is really verbose, which makes
> things somewhat hard to follow)?

 Thank you for the update.  I'm back from holiday today and will review
the situation in detail in the coming few days.

  Maciej
