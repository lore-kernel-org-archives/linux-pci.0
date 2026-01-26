Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207172BEFE4;
	Mon, 26 Jan 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466883; cv=none; b=X5Bn1UcIbYNr7n3WaHWQqEgHlDl4IWSNKMWn5TL32beAolxgxixCar1P1sX3aXugcS9w7OVApMaPhl4O7VOcQ+5WhVLCfIHESp5w7i0bzgQU4I3pe/MxysX1SvSd1qOKgTtM3WpxchBQ94DzYdZ2xKtS1OBtKthhRvia4uK2YGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466883; c=relaxed/simple;
	bh=ro51QC27+W5I88V/nGtYSebVxQoU2s5nrfOhLYNVzEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEXTZ0ylII3l7v3188noQWvz8cHZ3Ch4E2aJ7y2M0ljAnDbfUuAJMYEpDtWmuWb2OLy/Q3QrfAjqR0zNiYLIRGgzVFoEQhE3rXuACMoq30dmfOmOQzz1Pu3bYCIBvgCFDTGhXNv+4PV9xjh1Cv/XB558t0DiQ2ArEpPM8/BOj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TkSg2s7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bP6xUZlb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TkSg2s7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bP6xUZlb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 469E5140015A;
	Mon, 26 Jan 2026 17:34:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 26 Jan 2026 17:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769466880;
	 x=1769553280; bh=xAGPvojhta1VuvbsrbWfrWy+3cZRbKMd7diWfHMZx6k=; b=
	TkSg2s7M0F8x1dJ4J3+BJsYh961kXdsrnIgS+kKKLLY9/XdrFpXMte8VstnZfyrx
	G1vOisOt8NVHH4trkZBrXdFy/OHi9AmX1hzOPF4OYuM7EaSCr++tnC/QcQacRUUx
	V1+gXc31tVpy5lenuXAJMZP0/HHgL5OXDH1IBrWHdHt5WOy3vWBVQsYUTokXHO7Y
	yF2UASehqENnizFbm86uejnj6fVvRfqqeEyhGmEeoNTWcndXCck5N483jB58wZYe
	APOYOmfjWhyjC/9Gnalx5nLUQvT7IFspiJ72U5NFOxxJXmBNfygU9iG0S9DuCFQX
	BOpwpXvH7jKdIwiRd8e5jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769466880; x=
	1769553280; bh=xAGPvojhta1VuvbsrbWfrWy+3cZRbKMd7diWfHMZx6k=; b=b
	P6xUZlbt39eKg2mCYbGmGX9PZJdpVZLhgQTNEQGs8Wl8Op6QVr+XidZaGfhRo6fT
	YgG+q6UK9HmwNihuA+yiPK+MeMVgnl6cV6CkgBBWOJv969NNrSjUEX/4EsWabqR9
	A0MbLDau0506LhLVlIxp9FnbvGghRCws4LJZ1DLkC8mDBUBMeljl7ORy3JNR9EG1
	cei4Cy7E7JLlqRTHwR+R+z2M+GaizZg5ivjb0bnIbbw1MtjHpXqpN0HcaW5b6wgS
	bflOLJ6Os+Y3D0cHYf0iSsXpeg1P5EzOzGpljKjJEasNdAEDoE4PtElDu0Ol8sdo
	cONEmFVZVUIAtA5ZidX+g==
X-ME-Sender: <xms:_-t3aagA6faN5mzxmNpM5WMaA89nWoVXB008JjcS7nTTg6dUX_HWkQ>
    <xme:_-t3aSqwY7rQmA0aRZDVY2qvUHcJumF_GXp8eO1LAXo_RAdLhB7qixMfa0-bAzLub
    5o1F7iOeqtpy4jhtk2GGm9LFm8luoSaGCdSGigp-cH28Ewk2z44Qg>
X-ME-Received: <xmr:_-t3aSTFONXapY8uLk_V8gcIZSj6_3BS3g0DbN3S6blwoteYeCrRe3_vTko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvdefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurg
    ifvghirdgtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphht
    thhopehsmhgrughhrghvrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopegurghvvg
    esshhtghholhgrsghsrdhnvghtpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhht
    vghlrdgtohhmpdhrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:_-t3abQtPCYW28zwH7SDTJntf7QRL0IcA_nX_28nRLGSjvGoU_lTMw>
    <xmx:_-t3aYXUsFgiNJFwFV0Gha_gDMoTdIf50XiFIka_KqOYxLCe6hwNjg>
    <xmx:_-t3aQ2X0LDEITVxtYVW77JDVr4rR5GG0b2wMIh3tGIwMwY27Nccbw>
    <xmx:_-t3af_x0jgackgaeVEAwlgm5GM2kwrI8jOnvdy9SknqaDOLmsAGEw>
    <xmx:AOx3aSgf7PAaXQj-n81710s0w_DHhBvRPwZTKo1gumB-BRmZtEGHFoGI>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 17:34:37 -0500 (EST)
Date: Mon, 26 Jan 2026 15:34:35 -0700
From: Alex Williamson <alex@shazbot.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, <smadhavan@nvidia.com>,
 <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
 <rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
 <huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
 <sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
 <jsequeira@nvidia.com>, "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v4 09/10] PCI: save/restore CXL config around reset
Message-ID: <20260126153435.5f1557df@shazbot.org>
In-Reply-To: <20260122104745.00001fea@huawei.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-10-smadhavan@nvidia.com>
	<aXH1lfR8g1q--oJc@wunner.de>
	<20260122104745.00001fea@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 10:47:45 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Thu, 22 Jan 2026 11:01:57 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > On Tue, Jan 20, 2026 at 10:26:09PM +0000, smadhavan@nvidia.com wrote:  
> > > +++ b/drivers/pci/pci.c
> > > @@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
> > >  	if (probe)
> > >  		return 0;
> > > 
> > > +	pci_save_state(dev);
> > > +	rc = cxl_config_save_state(dev, &cxl_state);
> > > +	if (rc)
> > > +		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
> > > +    
> > 
> > Hm, shouldn't the call to cxl_config_save_state() be moved to
> > pci_save_state() (and likewise, cxl_config_restore_state() moved to
> > pci_restore_state())?
> > 
> > E.g. when a DPC event occurs, I assume CXL registers need to
> > be restored as well on recovery, right?  
> The CXL spec has some comic language around DPC that basically says
> "use with care, DPC trigger will bring down physical link, reset devicestate,
> disrupt CXL.cache and CXL.mem traffic".
> or in shorter words
> 'Good luck'
> 
> If a CXL device undergoes DPC high chance you'll either trigger CXL isolation
> which we aren't handing yet in Linux because we aren't convinced software
> can really recover form it, or stall a CPU and end up rebooting.
> 
> Maybe we'll one day we'll figure this out. Today turn off DPC on CXL ports! :)

Even if we hand-wave that DPC isn't an issue, save/restore of the PCI
state happens at a higher level for every other PCI reset method and
we're creating inconsistency here.

PCI-core includes interfaces for saving PCI state, offloading PCI state
as an opaque blob, reloading, and restoring that state, and performing
resets without saving and restoring state.  This has a couple users,
including vfio.

If we want similar behavior for CXL type2 devices for a future vfio use
case, we shouldn't create unnecessary differentiation here with saving
the CXL state separately and making the reset method behave
differently.  Thanks,

Alex
