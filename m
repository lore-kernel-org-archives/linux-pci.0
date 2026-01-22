Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAE3D410B;
	Thu, 22 Jan 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078874; cv=none; b=kEW/imjQ5OzjqdezXxPmVTRkMRF2Ug8lLWb6aFHGOG9hlPzd709/vQGZ1VThvrBydjkMdPuXEWDukhWcgAbEcD6qiYL3lx7XELH8V5HmBvjikQ6y6pRcuCRgaz9h9O6fNMZBi4jVpS/dDQnslyTiMtoOm+6MMxF73LnuKvDiNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078874; c=relaxed/simple;
	bh=l7jVi52ioWfWY9WDGWpQ38Gn+k0Kvx/HI3I3BWo3NEg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT4ctHNeRUsbM2HtAAlms36rAUWGd22uGJk0yDgTRLLup2IJqaLbPlsKGyylBR54R5pglMVxFq0ZZsyl8bP4VBIXh+QbW3Fqoc/x09f6GveYIl1Ddj2jhQu51q4Ey/ZQ5sKdwXj95zXwxdmqm0l0TjYODJYaFNAeeG0TMbkZZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxd6m5kB5zHnHGk;
	Thu, 22 Jan 2026 18:47:12 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5447F40086;
	Thu, 22 Jan 2026 18:47:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:47:47 +0000
Date: Thu, 22 Jan 2026 10:47:45 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: <smadhavan@nvidia.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<ming.li@zohomail.com>, <rrichter@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huaisheng.ye@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vaslot@nvidia.com>, <vsethi@nvidia.com>, <sdonthineni@nvidia.com>,
	<vidyas@nvidia.com>, <mochs@nvidia.com>, <jsequeira@nvidia.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v4 09/10] PCI: save/restore CXL config around reset
Message-ID: <20260122104745.00001fea@huawei.com>
In-Reply-To: <aXH1lfR8g1q--oJc@wunner.de>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-10-smadhavan@nvidia.com>
	<aXH1lfR8g1q--oJc@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 22 Jan 2026 11:01:57 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Jan 20, 2026 at 10:26:09PM +0000, smadhavan@nvidia.com wrote:
> > +++ b/drivers/pci/pci.c
> > @@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
> >  	if (probe)
> >  		return 0;
> > 
> > +	pci_save_state(dev);
> > +	rc = cxl_config_save_state(dev, &cxl_state);
> > +	if (rc)
> > +		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
> > +  
> 
> Hm, shouldn't the call to cxl_config_save_state() be moved to
> pci_save_state() (and likewise, cxl_config_restore_state() moved to
> pci_restore_state())?
> 
> E.g. when a DPC event occurs, I assume CXL registers need to
> be restored as well on recovery, right?
The CXL spec has some comic language around DPC that basically says
"use with care, DPC trigger will bring down physical link, reset devicestate,
disrupt CXL.cache and CXL.mem traffic".
or in shorter words
'Good luck'

If a CXL device undergoes DPC high chance you'll either trigger CXL isolation
which we aren't handing yet in Linux because we aren't convinced software
can really recover form it, or stall a CPU and end up rebooting.

Maybe we'll one day we'll figure this out. Today turn off DPC on CXL ports! :)


J


> 
> Note that since v6.19-rc1, state is saved on enumeration and
> thus always available for recovery, see a2f1e22390ac.
> 
> As a general remark on this series, it seems to have considerable
> overlap with Terry's work on AER support for CXL, particularly in
> patch [01/10], as Jonathan has remarked.  Please cc Terry on future
> submissions and coordinate with him on conflicting parts of your
> patches:
> 
> https://lore.kernel.org/all/20260114182055.46029-1-terry.bowman@amd.com/
> 
> Thanks,
> 
> Lukas
> 

