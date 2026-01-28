Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6027703A
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640841; cv=none; b=SaOFrOzo5n++qxZwNCNS3WqZbFDIXuGC0bsYzDZxXypw/R6ISzt88i28XRFZoq/GwQwdEevlXEOGqOnwe2kj8eJwzfcWvQNMM7sWbSV2HQ8fcR+cFYhdzBi8eDJTqCRMeQOyUbulKM8MdPHtAshySAiJQ4yJTrDUCxdfYk1HVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640841; c=relaxed/simple;
	bh=XH3Oazv6O3HkSMweOQaToClHG2NbCbnIKSqdQHabDe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V1rW1AXIIcV6KoqrmH33kcKsBHcTwxFXio/CSWhFaHO4+nAOdnwHdXtmV3G7mQzcjS04RFws1coY9Tv29ow6ltA6SD8qvqnC8CDOEVYApNZOv+sv0EU2XAEDTQmFap9iHmkd6DhmsHNxZAWJTttNofgggLzaJHlPTUnprRDfcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNlqCwYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNlqCwYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97646C4CEF1;
	Wed, 28 Jan 2026 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640840;
	bh=XH3Oazv6O3HkSMweOQaToClHG2NbCbnIKSqdQHabDe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oNlqCwYWRFYL1Hmb2wk3M16tweQICgv8szIE79/mKXjzorfUiI9QVzaox3ysZiTt2
	 WUeztqdQYcEIQQdCGm+V8+b7e2xiWLx1juvHY9ASTTu0qb4vPjdOtZDG0WkHkwux/z
	 3LKcYollCr+HKxXXSiI4eA9h11ERTbSv7NsVxqnCFTd+sLsEyPASI69vNO6yjFCFlA
	 XRRzLEXpt6yFWqLTa2A4s5/05c40/cAtyXJT8EoU7/srUeQlcoXqtxOmjnmXQq8oWP
	 qMQ8GNiI1vmpSNN2zrrwCsJdb4nLtfq/9RohzxjrdOjKKnw6L1tu0rqs+XyPvXnz4g
	 Ryi+6oUorat1Q==
Date: Wed, 28 Jan 2026 16:53:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex@shazbot.org, lukas@wunner.de,
	Dan Williams <dan.j.williams@intel.com>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Message-ID: <20260128225359.GA437372@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXpf0OkCsiw6kePd@kbusch-mbp>

On Wed, Jan 28, 2026 at 12:13:20PM -0700, Keith Busch wrote:
> On Wed, Jan 28, 2026 at 12:03:38PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> > > prevent the warning:
> > 
> > I *think* this actually refers to pci_bus_trylock() and
> > pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
> > that's what this patch changes?
> 
> Oh, this patch is changing both pci_slot_trylock and pci_slot_lock since
> they were both missing the equivalent locks that the "bus" version of
> those functions were doing.

Wow. The patch has hunks for:

  pci_slot_lock()               # lock bridge
  pci_slot_unlock()             # unlock bridge
  pci_slot_trylock()            # lock bridge

which makes perfect sense.

But when I apply it on either pci/main (v6.19-rc1) or pci/next, "git
am" puts those hunks in:

  pci_slot_unlock()             # unlock bridge (as expected)
  pci_slot_trylock()            # lock bridge (as expected)
  pci_slot_restore_locked()     # lock bridge (completely wrong spot)

I have no idea why the pci_slot_lock() hunk got applied in
pci_slot_restore_locked().  I do notice that the line offsets in your
patch are much different than mine, so you must have other changes in
pci.c; maybe that accounts for the confusion.

Can you regenerate this patch based on v6.19-rc1?  And maybe
incorporate Dan's "bridge = slot->bus->self" idea at the same time?

I'll attach my "git log -p" at the bottom if you want to see why I was
so confused.  What a day ;)

> > It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
> > similar but separate.  If there were combined, this kind of issue
> > where one is fixed but the other isn't wouldn't happen.
> 
> Honestly I think the _slot versions should go away. Those don't handle
> resetting a bus with multiple device's on it: only some functions get
> saved and restored even though the bus reset hits all the devices. I'm
> working on a fix for that, but it's more difficult than these patches.
> 
> > But what about pci_bus_lock() and pci_slot_lock()?  They are also
> > almost identical, but pci_bus_lock() locks bus->self while
> > pci_slot_lock() does not.  Should it?
> 
> It should, and this patch is changing pci_slot_lock() to do that.
> 
> > All these almost-but-not-quite identical paths make my head hurt ;)
> 
> I agree! And the functions that sound almost the same but work quite
> different? Looking at "pci_bus_reset" vs "pci_reset_bus" :)
>  
> > >   pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  drivers/pci/pci.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 3378221c5723a..5f8b0d06a1459 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
> > >  {
> > >  	struct pci_dev *dev;
> > >  
> > > +	if (slot->bus->self)
> > > +		pci_dev_lock(slot->bus->self);
> > >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> > >  		if (!dev->slot || dev->slot != slot)
> > >  			continue;
> > > @@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
> > >  		else
> > >  			pci_dev_unlock(dev);
> > >  	}
> > > +	if (slot->bus->self)
> > > +		pci_dev_unlock(slot->bus->self);
> > >  }
> > >  
> > >  /* Return 1 on successful lock, 0 on contention */
> > >  static int pci_slot_trylock(struct pci_slot *slot)
> > >  {
> > > -	struct pci_dev *dev;
> > > +	struct pci_dev *dev, *bridge = slot->bus->self;
> > > +
> > > +	if (bridge && !pci_dev_trylock(bridge))
> > > +		return 0;
> > >  
> > >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> > >  		if (!dev->slot || dev->slot != slot)
> > > @@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
> > >  		else
> > >  			pci_dev_unlock(dev);
> > >  	}
> > > +
> > > +	if (bridge)
> > > +		pci_dev_unlock(bridge);
> > >  	return 0;
> > >  }
> > >  
> > > -- 
> > > 2.47.3


$ git log -p v6.19-rc1.. | cat
commit 44c651ea87f9 ("pci: fix slot reset device locking")
Author: Keith Busch <kbusch@kernel.org>
Date:   Fri Jan 16 10:41:50 2026 -0800

    pci: fix slot reset device locking
    
    Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
    prevent the warning:
    
      pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
    
    Signed-off-by: Keith Busch <kbusch@kernel.org>
    Reviewed-by: Dan Williams <dan.j.williams@intel.com>
    Link: https://patch.msgid.link/20260116184150.3013258-2-kbusch@meta.com
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59319e08fca6..73764e66cabd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5335,12 +5335,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+	if (slot->bus->self)
+		pci_dev_unlock(slot->bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = slot->bus->self;
+
+	if (bridge && !pci_dev_trylock(bridge))
+		return 0;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
@@ -5363,6 +5368,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 	return 0;
 }
 
@@ -5425,6 +5433,8 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	if (slot->bus->self)
+		pci_dev_lock(slot->bus->self);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
commit 3f2aea31058a ("pci: fix slot trylock error handling")
Author: Keith Busch <kbusch@kernel.org>
Date:   Fri Jan 16 10:41:49 2026 -0800

    pci: fix slot trylock error handling
    
    The device lock isn't held if pci_bus_trylock() fails, so the code had
    been attempting to improperly unlock it.
    
    Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
    Signed-off-by: Keith Busch <kbusch@kernel.org>
    Reviewed-by: Dan Williams <dan.j.williams@intel.com>
    Link: https://patch.msgid.link/20260116184150.3013258-1-kbusch@meta.com
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..59319e08fca6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}

