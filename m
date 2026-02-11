Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC22D9EF4
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823357; cv=none; b=H23PbrG/VbRIGQVJwZ2TckoDTaw43tWm+NtvtE2M9P7ZWyrw60fbd9LIQ0jePYwOQOFYP2s+ozX8w6OdzOoXZmP8D9Sf8qJhwhe29KM7E6OhC3qweYxg1Zj27krf6A/4rfCW6qzUonidw1d9BBehv1p8I6JOqAgri2wiYZOAuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823357; c=relaxed/simple;
	bh=+ayDMMQA/15/FwdZueY4BbYMxFTf8ljN5GxOxE2UQhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE9oNUZKkKrbfcMGWyGdOdbK/bt6JTgwsCM9LA/2fkMa4j0Te6H1MGN1HJnJerNL8eownBBDKtLDxBbVethjyC7CHCtacKt78ESgWF8SzYQYZ6RBeK/p71si6gAGPMbA8q0rMm+/QQZiJBsOmdWFfHYWbNP+MbYz1I8EfjvlPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=jiOBtNeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixQ2zRsT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="jiOBtNeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixQ2zRsT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33FFA7A00BC;
	Wed, 11 Feb 2026 10:22:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770823352;
	 x=1770909752; bh=F4a5H8RjG6BBOG7Y3Ec1/2hMLYnVsSTKzVHxAi9HsSA=; b=
	jiOBtNeHp7UDtLtUIPsGwJCz8Sbv6Y18HgStQMx8P1W+e7XPW33wfdv3E3U5upCf
	1+QLX6jtQnF5ESYun7oCvfsbqHNFBI+UvUaQC6zzzGtDhqtTNrRLuG3ZifTa9t3D
	VJE+uLw7NVX1OqByK7/SCWEAkQgs1OyqMZTNpNisuHbuGBRxmRBgkWnUG94an3dU
	NOqJ640wclmnsqyGQh5aKTgNoG/KepCNS1riTSWoDkHUUsok7lRFWjJ1ruI0diu5
	Qh90B3YjcHo1+vZ7rB950FvHv09enQIAiPXbQI80EXe8GYJQgwxowVlyQw6QB/kt
	gsgF9KqbQCbqsZHj1PooPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770823352; x=
	1770909752; bh=F4a5H8RjG6BBOG7Y3Ec1/2hMLYnVsSTKzVHxAi9HsSA=; b=i
	xQ2zRsT79cd8oKAINF7LrgUenxl9rK53Yg4H1XnJJ8OeGd0yqUbWrnBPZMvLqU/F
	x+880Muz9ShRPy1Pau+v9Ta6WzFIoeo2qAYwr3V/Ba0DVioYPt0hAtaBWwydk93D
	JKSgbI8esJ3DScd1shwoVMJKTQLGA/u/5sitLZFKpHutn6o3fkkQoXGRcLlinjAe
	VeAAgzGA9EzSYesFcdg0awNPBCa7aDIs9PkKgA8aptuVqmrlmbY0ee5YS3DFzPtI
	zAQcguwPZtEnnvvz6tzMA2S8cPm1TMnYvQfqPSO5+HDtMnsGzpAxTYSVo0uOCu98
	mtd+4t7WagNNe+gwKvWhg==
X-ME-Sender: <xms:t56MaRlLFz3uGrXbfRijP7DrR8bY7JgnNB8SM3kp47Uq3VQ1nB63YA>
    <xme:t56MaW2NWE4SqTTUfqReptAHVn6acoUHhtpOjKUORdIJ9xKriQBFNSBk_2odxZ6iI
    M6G0xj9q2DFjjEqghoFlzBxjjSc33EcrThnvMPvuRnsP8Jfalwc4Q>
X-ME-Received: <xmr:t56MaeSzfvnglupSkSsPHBFvyvR0Wx9DzG3w7H6vClRYg1RdvcTUMiQIDQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehksghushgthhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgt
    ihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghp
    thhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epghhuohhjihhnhhhuihdrlhhirghmsegshihtvggurghntggvrdgtohhmpdhrtghpthht
    ohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:t56MafxteX8uvUWePxcaM-FRrhakp5M7VhSdC287Z7i2xx-4nGQlFw>
    <xmx:t56MaeCMl84bTRC3FFS4lytO4QPLplc_1W8jhGllax7NwrQmCXz6zA>
    <xmx:t56MabEbTHBjIf_ryjsIYfvPSUAVkGXv02smhKSyOLnOk6MvonxCGw>
    <xmx:t56MaVOlkr1cekft2OR3pY43Y8EFSu5o0WmQx_7Gm5W_avBfSR4FsA>
    <xmx:uJ6MacnhR49sH0kskp1Iu2zD4i3gJj8_fQDK504n8OzyzmyOWTYZOZ3x>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:22:31 -0500 (EST)
Date: Wed, 11 Feb 2026 08:22:29 -0700
From: Alex Williamson <alex@shazbot.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
 helgaas@kernel.org, lukas@wunner.de, dan.j.williams@intel.com,
 guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <20260211082229.4e746e32@shazbot.org>
In-Reply-To: <aYvJXRGnsIYVdVUm@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
	<20260205212533.1512153-4-kbusch@meta.com>
	<20260210164623.74d38699@shazbot.org>
	<aYvJXRGnsIYVdVUm@kbusch-mbp>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 17:12:13 -0700
Keith Busch <kbusch@kernel.org> wrote:

> On Tue, Feb 10, 2026 at 04:46:23PM -0700, Alex Williamson wrote:
> > On Thu, 5 Feb 2026 13:25:32 -0800
> > Keith Busch <kbusch@meta.com> wrote:
> >   
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> > > PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> > > every function on every "D", not just the ones with a matching "slot".
> > > The slot lock/unlock and save/restore functions, however, are only
> > > handling a subset of the functions, breaking the rest.  
> > 
> > So are we deprecating conventional PCI hotplug slots?    
> 
> No, this still calls the slot's specific reset callback via
> pci_reset_hotplug_slot. The only thing this does is add locking, config
> state save/restore, and driver reset prepare/complete calls for the
> entire bus rather than matching "slots" on that bus. In the worst case
> scenario, this patch has the kernel do a little more work than it needed
> to.

But with this change, when vfio-pci calls pci_probe_reset_slot() we
test pci_bus_resettable() rather than pci_slot_resettable().  The
former is a superset of the latter.  Another slot on the same bus might
have a bridge card or quirked device that previously wouldn't have
affected the ability to reset a separate physical, conventional slot.
The risk is small, but the semantics are different.

> > I've always
> > understood these to be a subset of the bus, where we find the devices
> > sharing the same physical PCI slot by comparing the pci_dev.slot across
> > the bus, as done in all the code removed here.  pci_create_slot()
> > certainly is not simply a reflection of PCI_SLOT().    
> 
> pci_create_slot assigns devices that match PCI_SLOT() of the bus's
> devices, so it certainly is a reflection of that, no? The problem is
> that PCI_SLOT() macro doesn't actually reflect the true nature of what
> devices belong in the slot: the devices in a particular "slot" does not
> define the actual blast radius of resetting that "slot".

struct pci_slot, the thing created by pci_create_slot(), represents a
physical slot.  PCI_SLOT() is the bus addressing.  Not all pci_devs
have a struct pci_slot, not all pci_devs within the same physical slot
share the same B:D.F slot number (with ARI).

The vfio code does assume that 'slot' defines the blast radius of a
pci_slot_reset() and I'm confused how it should operate if we're now
going to conflate slot and bus reset scopes.
 
> > Is the error below
> > really a reflection that pci_dev.slot isn't carried over to the full
> > set of functions?  
> 
> Correct, the pci slot today in a pciehp hotplug slot is not getting
> assigned to all the functions in that slot, so slot resets completely
> miss handling those functions, which inevitably break them.

Isn't this then a pciehp hotplug issue that all children of the bus
should be linked via the struct pci_slot regardless of PCI_SLOT()?
Thanks,

Alex
