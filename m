Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677837DE84;
	Thu, 12 Mar 2026 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339850; cv=none; b=ZlD+q6QU6B6SqGKCn8Qva1HYpG9Sg1tMpbSbKVXjckL33A6iAGOKDVilfiX1COMVYFq72EhsaYt++d1j/EsUTy4EaJIL+RYtO8QhwfgzjxJ12m7fxEpFv0r8JeDfhb0afw2QYT8oVK5SushxWCH8ZVWIgPL3bGu03HI+j9lKTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339850; c=relaxed/simple;
	bh=GJPok1N29I2rdd1Y56hNtB8ClOGNj3H1Xdxe6sT9QyU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXTj/ab9mAR/LqZnx704HooX9oA2C17oZWaz9SmfXwExT23P+PcC9TFbV+HqxUanA1uMnx8/+OFjY/JW5x6UzxnvXIFHe7OjCXdxWaq1FxOmS3PM8SYN+2A1kgxHZnLMciMw9qWj6dBhgsBw3+cbDFxnYRUts0v5X/BXyrBiPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWwwN3rZwzJ468c;
	Fri, 13 Mar 2026 02:23:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C176340585;
	Fri, 13 Mar 2026 02:24:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 18:24:03 +0000
Date: Thu, 12 Mar 2026 18:24:01 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alex Williamson <alex@shazbot.org>
CC: Lukas Wunner <lukas@wunner.de>, <smadhavan@nvidia.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>, Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v4 09/10] PCI: save/restore CXL config around reset
Message-ID: <20260312182401.00001adc@huawei.com>
In-Reply-To: <20260126153435.5f1557df@shazbot.org>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-10-smadhavan@nvidia.com>
	<aXH1lfR8g1q--oJc@wunner.de>
	<20260122104745.00001fea@huawei.com>
	<20260126153435.5f1557df@shazbot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 26 Jan 2026 15:34:35 -0700
Alex Williamson <alex@shazbot.org> wrote:

> On Thu, 22 Jan 2026 10:47:45 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> > On Thu, 22 Jan 2026 11:01:57 +0100
> > Lukas Wunner <lukas@wunner.de> wrote:
> >   
> > > On Tue, Jan 20, 2026 at 10:26:09PM +0000, smadhavan@nvidia.com wrote:    
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
> > > >  	if (probe)
> > > >  		return 0;
> > > > 
> > > > +	pci_save_state(dev);
> > > > +	rc = cxl_config_save_state(dev, &cxl_state);
> > > > +	if (rc)
> > > > +		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
> > > > +      
> > > 
> > > Hm, shouldn't the call to cxl_config_save_state() be moved to
> > > pci_save_state() (and likewise, cxl_config_restore_state() moved to
> > > pci_restore_state())?
> > > 
> > > E.g. when a DPC event occurs, I assume CXL registers need to
> > > be restored as well on recovery, right?    
> > The CXL spec has some comic language around DPC that basically says
> > "use with care, DPC trigger will bring down physical link, reset devicestate,
> > disrupt CXL.cache and CXL.mem traffic".
> > or in shorter words
> > 'Good luck'
> > 
> > If a CXL device undergoes DPC high chance you'll either trigger CXL isolation
> > which we aren't handing yet in Linux because we aren't convinced software
> > can really recover form it, or stall a CPU and end up rebooting.
> > 
> > Maybe we'll one day we'll figure this out. Today turn off DPC on CXL ports! :)  
> 
> Even if we hand-wave that DPC isn't an issue, save/restore of the PCI
> state happens at a higher level for every other PCI reset method and
> we're creating inconsistency here.
> 
> PCI-core includes interfaces for saving PCI state, offloading PCI state
> as an opaque blob, reloading, and restoring that state, and performing
> resets without saving and restoring state.  This has a couple users,
> including vfio.
> 
> If we want similar behavior for CXL type2 devices for a future vfio use
> case, we shouldn't create unnecessary differentiation here with saving
> the CXL state separately and making the reset method behave
> differently.  Thanks,
> 

I'm a bit concerned that, unlike PCI where no traffic flows after reset
and restore of basic PCIe stuff, for CXL once you've put the decoders
etc back in place, CXL.mem traffic can happen autonomously. It's
cacheable and physical address prefetchers on the CPU side may be able
wander into it more or less randomly, whether there are page tables yet
or not.

This is somewhat similar to PCI devices misbehaving if you enable
bus mastering without ensuring they are in a clean state (just in the
other direction).

So I'm not sure how safe it is to restore the generic CXL state with
out the driver taking control.

I don't think there are tight enough guarantees that devices should be
able to survive this if their drivers haven't managed the setup of CXL.mem
carefully as they did during driver bind etc.  Maybe they had to
load a firmware first before there was anything behind a CXL protocol
front end.

The drivers can't stop CXL.mem in a prepare reset callback
prior to saving state as it may be RWL by an annoying BIOS.

Maybe I'm overly paranoid and all device manufacturers are sensible.
Or I missed some spec text that says devices should politely handle
traffic turning up before they are ready.  If they implement the memory
ready checks then we may be fine as hopefully Media Status == Ready
doesn't happen until it's safe to enable access (though the spec
doesn't actually say that is sufficient that I can find).

I need to do some more digging and maybe a spot of prototyping.
Also more than plausible I'm missing a nugget of code in here
that makes this all safe.

Jonathan


> Alex

