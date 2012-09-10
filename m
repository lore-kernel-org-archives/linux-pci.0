Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51422 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab2IJXdV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Sep 2012 19:33:21 -0400
Message-ID: <1347319987.2603.3.camel@pasglop>
Subject: Re: [PATCH V9 0/5] Minimal alignment for p2p bars
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Date: Tue, 11 Sep 2012 09:33:07 +1000
In-Reply-To: <CAErSpo41vr4f4YkLZc-QwHU8CTQv1FxzGF9h5-eu85NaTUhPaw@mail.gmail.com>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <CAErSpo559Hr-fnZTDZGOfz9T6_GSHKhoKChgNbq-apLuLqbaYQ@mail.gmail.com>
	 <1347061864.2385.59.camel@pasglop>
	 <CAErSpo41vr4f4YkLZc-QwHU8CTQv1FxzGF9h5-eu85NaTUhPaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2012-09-10 at 16:42 -0600, Bjorn Helgaas wrote:
> > Any chance you can poke me when you do so ? At that point I'll
> include
> > them as well along with the rest of the stuff that depends on them.
> 
> I merged these to my "next" branch and pushed it.  Are you sure you
> want to pull that as opposed to just using the
> pci/gavin-window-alignment branch?  Both "next" and
> "pci/gavin-window-alignment" have identical commits, but
> "pci/gavin-window-alignment" is less likely to be rebased.

No I will pull gavin's branch, but I didn't want to do so before it was
in your -next as well, just in case a problem creeped up needing a
rebase (I want to avoid rebasing powerpc-next).

Thanks !

Cheers,
Ben.


