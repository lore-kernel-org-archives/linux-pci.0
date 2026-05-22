Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF193BCD38;
	Fri, 22 May 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458431; cv=none; b=cX1sGzTO3SSKEE67lZRjPYeywXfCyIcjakDu1pC6aCHX1Vfldc8lYKhtBEAcZ4De7f2wM9C7C+n86FO9ALpdIj+rtZWzIFR8EW3YSDSdAwjqrSntDOthtKnMHtTSCKqsvoGVKbQKhj6Unxfp3ZbsQYCPaT/zQ1BMnJcWvPVZyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458431; c=relaxed/simple;
	bh=7pNBbYkLnMY2b8HqI8mFIJHke2B5kktZeu8fjtNJHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzYp1L+gxRRE4ZwKbbgnTdbotEJLFqAajScFfGmljHTPRAGZBpd66eyjh0UiRLCebgVCwMGN4r5a7AVZVOV2spSnSghesVE3UDhY+h1Amxagc60tEvWKnWRS4sDH/Ecft39+dG0GbsSFl4q2HroCkjBEPfZtxl08LnPVGhR48AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KBxM9uk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjUOf/7u; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KBxM9uk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjUOf/7u"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3854A1400100;
	Fri, 22 May 2026 10:00:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 10:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779458425;
	 x=1779544825; bh=f6qZu3mjuZB7aeVooNRq0zeE78N1e6ESYl7W/xgClb8=; b=
	KBxM9uk7qg94yX0lgMGChDTXLRDDbL7PI0nECUI2ugvZ0ScTGU0dyIC7sHfuX3bu
	FlQPBXcApwI9brkiwxG5pHmkoHN7B4IfeimxwOkMIfk0DI3dxvso8RAsdkdaY5jT
	Tb2tj1o8IGKlivfPgP06HAXqS7C0pPrYZ6JxzTUIaWPnokEo6TbBYXmnvPt+O7Ly
	PlouuYJfdC4iCkJxiWImJqrfOGdfi2dnz46e5A8HxVxq/RfZD30YAxGUB6N1QsrU
	Xkhq2AU6vfklcPDdtL+NvxmDOKbOY3KSp5bME9j258vb05++jk3vo4xnPjN0ESWT
	m+2bc36IF3a9kbL/ivGdmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779458425; x=
	1779544825; bh=f6qZu3mjuZB7aeVooNRq0zeE78N1e6ESYl7W/xgClb8=; b=J
	jUOf/7uwsEA//+YGZDSYm04aJc/KBTL0vKpZkpzO4LymW3McVSNgUmSAlTc7Q92B
	ekjBOCZUTS43VmXjPcHUgXo9T278DaDnQuzSk421VyAsVCQ6L0nf/X4jyEW4n9Ca
	KIzxIFnR8YNSpBegjM4YWbHM42kDKB3fIooB0hWBrDRE+ETz6kDR52P7Iz+Vyh13
	/uAfu/7OuA2UzISPrmYIg9Eit4ENgWlfCDlklyEHdRpV3Wn96UzoIwR6FUGpqFRm
	eZYMosboQxSGwnXqwiFKMMnw62fH9lu8ChXJkMpfy+fFQfl3vhIDnFheiOOhQK66
	66JibzN2yf6tDjFWyxcQg==
X-ME-Sender: <xms:eGEQah_hko2aJ5D0W0brsbmg6AmwRce7WPuOuL3JdSGN3We8SknE2A>
    <xme:eGEQaj862Ao4EX4DFKFb2UuiQqZoIDuTaQIDv_U2dRgGr5ADvE56iCNoTC2IQDkhk
    gNu6ULFNAfPjkx6eIQi3QhUzqIpRms7VetvlQlHLndVSqQ9_Qh7NA>
X-ME-Received: <xmr:eGEQaoWqxy19pTX3AHKeMmIoCUHtURKa5AvqRZTcP0pvr3c7QQFIjadLFds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvnhhg
    tghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehjghhgseiiihgvph
    gvrdgtrgdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrghgvgesrghrmhdr
    tghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifvghirdhhuhgrnhhgvdesrghmugdrtghomhdprhgtphhtthhopeifrghnghiihhho
    uhdusehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepfigrnhhghihushhhrghnud
    dvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgr
    figvihdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eGEQaofrt2A3b54FDNnlDrZ4jDVqOkk1kb-SFKkXPBwkxD5-mafIKQ>
    <xmx:eGEQapatKW5UWo9nfU-mH7wapzw8mgq4M6oTYtf6F-v-Mp0XmgZYNw>
    <xmx:eGEQasMXLTEiqmSDNxOqjuOdqYp0qM1Gc64bdEaOUpv46y5ABBBZAw>
    <xmx:eGEQanWJoT1TOsro0O4wh0EGSqWn26UFx-hKwsITThgiaH8V8DOgEQ>
    <xmx:eWEQamoj1HP5l3R9MswNGTgyPnm3CuwFvNSpg4d6b4u_qOBjwwLSY-KG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 10:00:23 -0400 (EDT)
Date: Fri, 22 May 2026 08:00:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
Message-ID: <20260522080020.11f1d86b@shazbot.org>
In-Reply-To: <15bffd1b-e0c7-4393-8cbc-ba54586884c9@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-4-fengchengwen@huawei.com>
	<20260521221022.322c2af9@shazbot.org>
	<15bffd1b-e0c7-4393-8cbc-ba54586884c9@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 17:18:39 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 5/22/2026 12:10 PM, Alex Williamson wrote:
> > On Mon, 18 May 2026 15:16:59 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> >   
> >> Add a helper to query enabled TPH mode on a PCI device. This is useful for
> >> drivers like VFIO-PCI that need to validate TPH state before allowing
> >> access to steering tag tables.
> >>
> >> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> >> ---
> >>  drivers/pci/tph.c       | 12 ++++++++++++
> >>  include/linux/pci-tph.h |  3 +++
> >>  2 files changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> >> index ba31b010f67a..91c1e83410a3 100644
> >> --- a/drivers/pci/tph.c
> >> +++ b/drivers/pci/tph.c
> >> @@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >>  }
> >>  EXPORT_SYMBOL(pcie_enable_tph);
> >>  
> >> +/**
> >> + * pcie_tph_enabled_mode - Get current enabled TPH mode
> >> + * @pdev: PCI device
> >> + *
> >> + * Return the enabled TPH mode (IV/DS) or 0 if disabled.
> >> + */
> >> +int pcie_tph_enabled_mode(struct pci_dev *pdev)
> >> +{
> >> +	return pdev->tph_enabled ? pdev->tph_mode : 0;
> >> +}
> >> +EXPORT_SYMBOL(pcie_tph_enabled_mode);  
> > 
> > Doesn't this create ambiguity with PCI_TPH_ST_NS_MODE?  Maybe return an
> > -errno if not enabled.  Duplicate same for stub below.  Thanks,  
> 
> Because pcie_enable_tph(PCI_TPH_ST_NS_MODE) could also enable TPH,
> but PCI_TPH_ST_NS_MODE mean "The function must use a value of all
> zeros for all Steering Tags" So I think pcie_enable_tph() should
> treat PCI_TPH_ST_NS_MODE as a invalid input.

This doesn't make any sense to me, PCI_TPH_ST_NS_MODE is a valid enable
mode for the TPH capability.  Thanks,

Alex
