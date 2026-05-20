Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CA3403F4;
	Wed, 20 May 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293624; cv=none; b=G7yJnE+hgeVqF4ghb6XjrZ5/W0UPO876IFiH28ZEUlvrf4rJngnxHdf4X7H34kMoppkRGELiLP7sJrteFfr/qhHA9N1lKY6Th1vz85pNB4ONXO9VhzCXZV/VXo0sKcNy/3HpLpbOTu+bcTyAEBRPeQOObH552jiRKlux+OoFTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293624; c=relaxed/simple;
	bh=/iz4c6O6193vrn9tVark4e/AlBuHcQ626mDLH0DPrew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjzKSO4bVuNNF5kMlBoktsR/wXdzA7QipzxcdxikoMAy97NLdsOk+PcqiYhOhYZRz5DJBbNLsR39QVdfyhctRCZShCY5F2l1O9bUhQYHes3/Goeu8lhAzuk6Md8Q+kJZF7Zvx8tXHFOU3eTy8ywwb+fC4B7b7o4K24i9zGShYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WHQYw8KD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQwdY+8n; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WHQYw8KD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQwdY+8n"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62C6C7A00AD;
	Wed, 20 May 2026 12:13:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 12:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779293620;
	 x=1779380020; bh=V+CKQCPtB2JT0ym5TTL4BeSXjy94i97nlV6FT7Mz3vE=; b=
	WHQYw8KDA7cz9V2SDRMiilMa2IdY9SkaslM/Csuk7uQS0pNc/0zlH1abZRmeS1R2
	g8GuXcWw4+TqU1b2r0ucl9TRFuZWe1i0w0OXhdLRCWtR+aG8l/Hh+bExSBXNDyQA
	GqaXJrwduQRDuvHFHY57lOc7PBxIZbR+a2SkH+2iW7ZzbsjGg65ZkXCVxKIPUW7v
	9ksRpZGCMyP1IAdH3kPwZe6twVrKHtgJdpvCPcw60qRnd7W/X30PrWGtC4YppTiZ
	RZ+RmI513wphAdXoeXhuWzRZ0iSxDEEXUceVzwv/Yx7O/nyZDyai0zRwBRpgKk2Y
	1qR3eXILpYEL6Rvrt7dDbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779293620; x=
	1779380020; bh=V+CKQCPtB2JT0ym5TTL4BeSXjy94i97nlV6FT7Mz3vE=; b=B
	QwdY+8nUYGZeCHhS51zjkGGWRyEIgTI3bA8T5yQ91umOuZHTdyoo13J9oqwNOAWc
	lGfhIBfg5QaQMyEzUznsfLRFlwUTfX928ehlF2gSFhDX9x6leU0jkVUiTLq34FbI
	MoKdXNvHfzkVT9xzol1A9DKE4LXJqEqhw33dRZTaSK3kf6L6XH3AdLQP4YeszKNA
	zAok+9IZe0y7D7DqNyexJHI7qgmH5HnLQ3pv9QT8DoKNvY752ByDzfmqsqMw6dHA
	BCBb98psV4Vv0vawJct45wx/oZvE11HLjFg2Lpfeyp5+KVMpNvBvMkFSUhrQFAJV
	tpAwLo4C6SWwDSV5vECdA==
X-ME-Sender: <xms:s90NaqIkmByPiXZhl44vi_Fryec-r4iEkInE1HGlmVA7L1lPnAl0ew>
    <xme:s90NajpPqqQVXVdBcCTrGy1lzGNv1qgkjIXng66rDBPPnsTujRywVLE4oDBnj8VxA
    k0TZq5TPqvi7kq_7kHuVVzHJzhKSdYnlu69bqxtgCn8pBI2dnhO9Q>
X-ME-Received: <xmr:s90NaqyUP6rYBXLLL9heU8xBDIzKdI1QDcsuLANCxK-e7dAA3_ptxABPUxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjthhorhhn
    ohhsmhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:s90NavMuMdeRpZpWZSCCpHtzsuY7llyV3JsSiRlxlrfEbZN7ysqH4Q>
    <xmx:s90Nan6XXCidziJjHTVxfitmfxA8n_0pfvymD-QLtGxDpXQ5Dvaicw>
    <xmx:s90Nagn2IEMXgixGznQuq9EkFp_ns63OP2TahGUdf-MLA8aPYzjhXQ>
    <xmx:s90NaoQyJBlNue-28Jv99MCVOTnfpEGzBAKeEyZvCzuNTMPgZPtNug>
    <xmx:tN0NavhykKnB70TgIzzkxu4AjV4H9GTykCNq2_Aev7WjbTkFQKvTASzl>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 12:13:39 -0400 (EDT)
Date: Wed, 20 May 2026 10:13:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Message-ID: <20260520101338.21fe1e13@shazbot.org>
In-Reply-To: <20260519053551.7140-1-jtornosm@redhat.com>
References: <20260518111555.6b1ce60d@shazbot.org>
	<20260519053551.7140-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 07:35:50 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Hello Alex,
> 
> Thank you for the feedback. I understand the concern about reporting reset
> capabilities for all devices.
> 
> Regarding the sysfs power state approach: I tested this, but the challenge
> is that VFIO needs automatic reset during VM crash/reassignment. When a VM
> terminates uncleanly, VFIO calls the device reset path automatically before
> reassignment - there's no opportunity for userspace to manipulate sysfs power
> state in that flow.
> 
> For the device-specific approach you mentioned, what if I modify the "soft"
> method to require an explicit quirk flag? Something like:
> 
>   static int pci_soft_reset(struct pci_dev *dev, bool probe)
>   {
>       /* Only available if device explicitly quirked for soft reset */
>       if (!(dev->dev_flags & PCI_DEV_FLAGS_ALLOW_SOFT_RESET))
>           return -ENOTTY;
> 
...
> 
> Would this approach be acceptable?

Device specific resets are made for this scenario.  Look at
pci_dev_specific_reset() and pci_dev_reset_methods[].  The supporting
evidence that this performs a worthwhile reset is still a bit weak, but
heuristically it seems better than nothing, which is what we're left
with otherwise.  Reset via D3hot for a device that does not expose
NoSoftRst- is not something we should enable or endorse for any common
use case.  Thanks,

Alex
