Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90473C870C;
	Fri, 10 Apr 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830385; cv=none; b=CsnKUBwNBqzAz2R4QrMpnu5ACzhrhPGM0ErJ0L9pdCw8UuxEv8Qz4G0Xj+FQA/0jN/Gg7efCqU5pTKsXTIGpw0TolIVl1RQE7tq3c/8BSHxnDOxsOjU3IKvoe+YPV5f2CCz9V711cGRybH8VW8rDcaX4W2ONO+99xs4NytkYAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830385; c=relaxed/simple;
	bh=uV0t5LYuSmVgoRCD/8UaWZFFrbghzgH7RgkzIYhRDNQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eQvyqcOeceaLyfvzmw31chSh2H289e1uq1zVpagQgiOI0d47X5MCiNoFzXpryirQlXd3Bp87px642Wr/pS5G42yod96wZiRvWZgIcAVJrC/TbY6pIiwt8LoqJZ696ov2JDLwRi/QZddQ7XkiksNtLHJOl8vvmyP0810egPbk1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7CCD292009C; Fri, 10 Apr 2026 16:13:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6E87392009B;
	Fri, 10 Apr 2026 15:13:01 +0100 (BST)
Date: Fri, 10 Apr 2026 15:13:01 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Heiner Kallweit <hkallweit1@gmail.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: Remove no_pci_devices
In-Reply-To: <20260407194812.GA250485@bhelgaas>
Message-ID: <alpine.DEB.2.21.2604101408570.29980@angie.orcam.me.uk>
References: <20260407194812.GA250485@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Apr 2026, Bjorn Helgaas wrote:

> [+cc Maciej]
> 
> On Fri, Apr 03, 2026 at 12:15:34AM +0200, Heiner Kallweit wrote:
> > Remove the last user of no_pci_devices(), and then the function itself.
> > 
> > Heiner Kallweit (2):
> >   input: pc110pad: change PCI check to get rid of orphaned
> >     no_pci_devices
> >   PCI: Remove no_pci_devices
> 
> Applied Dmitry's patch to remove pc110pad and your patch to remove
> no_pci_devices() to pci/enumeration for v7.1, thanks!

 What can I say?

 This:

static int pc110pad_io = 0x15e0;

seems to be a reasonably safe location in the PC/AT architecture to poke 
at blindly, especially while guarded with request_region().  Ralf Brown's 
"Ports List" doesn't list anything at location 0x1e0 modulo 0x400, and for 
PCI/e we never assign locations 0x100-0x300 modulo 0x400 anyway.  With PCI 
systems featuring a southbridge ISA is subtractively decoded, so unclaimed 
accesses will simply time out.

 There could be an issue though with preventing the claimed IRQ from being 
used for a legitimate device, and the call to no_pci_devices() only pushes 
the problem to non-PCI systems.  Poking at the handshake port and checking 
for it being fixed at all-ones might be a way to figure out whether there 
is anything actually wired there.

 Overall this seems a case for a platform device, but these are hard to 
wire in arch/x86 given how the platform has evolved.  I imagine there's no 
way to probe for a PC-110 system, as back in the day stuff used to rely on 
manual configuration, though there could be a vendor BIOS call available 
for guesswork.  A kernel parameter to tell the various odd systems apart 
would IMHO be a reasonable approach if this part of the kernel were being 
implemented now.

 Then I have nothing to say as to the removal of the driver itself; if I 
do manage to find time to revive 486 support via emulation as I outlined 
last year, then whoever wants the driver they can bring it back too; it's 
not like the most complex piece of code I've ever seen.

 Thanks for looping me in.

  Maciej
