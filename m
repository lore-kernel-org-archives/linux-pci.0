Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994751A0712
	for <linux-pci@vger.kernel.org>; Sun, 25 Jan 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360608; cv=none; b=r9ptHl8ZpXTNq0JCUtxoBtJkMSUPbrErAtM9UNhHNAistUOVKdiecvbqhYzIJw9StY3NEvKBxO++8Zxg0iviyWfkDFhGFJyJWHZg10ait7E49i/pV5x6FUIgl5cRvTd+34n2I8xcRM1V4+BDK/EQ398bzgub2vzS5T1epmv9ZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360608; c=relaxed/simple;
	bh=4B7SAjXkc8LxMwmVt4GoXkM4Bl2uJR6qijCJSx0edkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLL3woctnmq42zk9dI9cDJjqV37O8BX0DRxCRlMeCFk6WdCcajvbglKT+r3pc0G6HeEU6gmY/pKHrgu0dJkvADp82uOuETZZn4p/M8lu4YsIocm6YeUpLplCrV3QUGomQetmnVosDJOZdVTqtGG1X431Rq3Pe+d7DLtHSNAS12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1xxOsXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1xxOsXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC481C19421;
	Sun, 25 Jan 2026 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769360608;
	bh=4B7SAjXkc8LxMwmVt4GoXkM4Bl2uJR6qijCJSx0edkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1xxOsXznrUKAL2yJ50eOq493OBwJOcu4zTYSrUdcRnCCM0jfjoO97hhhacdtbYDm
	 GW0fs/vm3YmzxhNTiksT5YD8yFVoKllu7zunwRh/6UJdI1qEP/PNTlSTCWI/BDC82K
	 9gKUvastQrFNEG+z9YwhLlGWJVaSNnFep4rnjWDzM3M47BGD2CerbPBColHM4NfThv
	 OSHIMxdHqBmIfQMj7oKwi0BflwLndXXadVSBt28dRnL1HzjpLVWH43DtZnOO2uTEqk
	 owZZIbeAGVDa4ZNMuOYxhwBTTaHIxBHT9FSmpvGazmGIJcRvxu8a8pdP/mMlW7J6Eq
	 SDpEdKhIghZTQ==
Date: Sun, 25 Jan 2026 19:03:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"logang@deltatee.com" <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rajur@chelsio.com" <rajur@chelsio.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH V11 7/8] PCI: Enable 10-Bit Tag support for PCIe Endpoint
 device
Message-ID: <20260125170323.GH13967@unreal>
References: <20211105173949.GA932723@bhelgaas>
 <53978a8a-18b6-419d-8a54-b7c16f98253d@nvidia.com>
 <aXUT7Xg7V6Dusek8@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXUT7Xg7V6Dusek8@wunner.de>

On Sat, Jan 24, 2026 at 07:48:13PM +0100, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 02:35:12PM +0000, Vidya Sagar wrote:
> > On 05/11/21 23:09, Bjorn Helgaas wrote:
> > > On Fri, Nov 05, 2021 at 04:24:24PM +0800, Dongdong Liu wrote:
> > > > Current we use sysfs to enable/disable 10-bit tags for a requester also
> > > > depend on the RP support 10-bit tag completer, so it will be ok.
> > > 
> > > Ah, OK.  So we can never *enable* 10-bit tags unless the Root Port
> > > supports them.
> > >
> > > I misunderstood the purpose of this file.  When the Root Port doesn't
> > > support 10-bit tags, we won't enable them during enumeration.  I
> > > though the point was that if we want to do P2PDMA to a peer that
> > > *does* support them, we could use this file to enable them.
> > >
> > > But my understanding was wrong -- the real purpose of the file is to
> > > *disable* 10-bit tags for the case when a P2PDMA peer doesn't support
> > > them.
> [...]
> > Hi Dongdong Liu,
> > Thanks for pushing this patch series.
> > I would like to know your plan to pursue this series in getting them merged.
> > Given that there is no action on this series since 2021, I would like to
> > take it up if you don't have an imminent plan.
> 
> Smita (+cc) took another stab at 10-bit tag support in 2023:
> 
> https://lore.kernel.org/all/20230828095429.GA17864@wunner.de/
> 
> The approach proposed by Dongdong Liu -- to disable 10-bit tag support
> via sysfs -- doesn't seem right.  The kernel has all the information
> it needs to automatically determine when to enable or disable 10-bit tags.
> User space has no business overriding that.  There is an in-kernel API
> to set up P2PDMA and it can automatically disable or re-enable 10-bit tags
> when it is appropriate.  I think the only reason why a sysfs interface
> would be needed is to support setting up P2PDMA behind the kernel's back
> for proprietary technologies such as Nvidia GPU Direct.  I hereby
> preemptively NAK patches that add a sysfs interface for this purpose.

There is no need to be so dramatic. NVIDIA GPUDirect works correctly with the
upstream kernel, without requiring any special hacks.

Thanks
