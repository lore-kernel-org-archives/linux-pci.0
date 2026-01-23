Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA630215A;
	Fri, 23 Jan 2026 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174004; cv=none; b=eyu0eZ301NcmAyM3SokhDgixlaAc1rtIHAczlOY2clWGTS+XtcrYzc2rPe3u4G9kB8wDvds/zyagTXJWXnwfPT4BzxMo0NPuxgr25AHLlzoMC+JZ8rmpefe53RazW2TsCoTx+MuF7q/zoIrpORXbkiEzGaQmGeY1bU2xKOxEcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174004; c=relaxed/simple;
	bh=pSV1L8RgN/mU70+d47WQYCIbNrVf91DGy9jz0bsDbIc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvUkELAIy/ckzo+blnmMCleXwp0OvzLSBGsBW8UpITbzR0N7rqcabN0oS4f171Xz9N9jMI+wJZ8EsjD7r2SuxzSOq8iAF5aBkTxitXq8Ml4rwLgYxi1VXlzylH2gUIlWmssWxZQnkWfglf4OrY7ita0XXhy/d3/lTvsCe7YfG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyJJC1N7GzJ4685;
	Fri, 23 Jan 2026 21:12:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 91D5240086;
	Fri, 23 Jan 2026 21:13:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 13:13:11 +0000
Date: Fri, 23 Jan 2026 13:13:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Vikram Sethi <vsethi@nvidia.com>
CC: Srirangan Madhavan <smadhavan@nvidia.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, Souvik
 Chakravarty <souvik.chakravarty@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Message-ID: <20260123131310.00006d6c@huawei.com>
In-Reply-To: <LV8PR12MB9182859B472646DC93B72FF6BD97A@LV8PR12MB9182.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
	<20260121112005.00001e80@huawei.com>
	<PH7PR12MB9175CDFC163843BB497073CEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
	<20260122103109.000049d6@huawei.com>
	<LV8PR12MB9182859B472646DC93B72FF6BD97A@LV8PR12MB9182.namprd12.prod.outlook.com>
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

On Thu, 22 Jan 2026 19:24:49 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> Hi Jonathan,
> Happy new year!
> 
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Date: Thursday, January 22, 2026 4:31 AM
> > To: Srirangan Madhavan <smadhavan@nvidia.com>
> > Cc: dave@stgolabs.net <dave@stgolabs.net>, dave.jiang@intel.com <dave.jiang@intel.com>, alison.schofield@intel.com <alison.schofield@intel.com>, vishal.l.verma@intel.com <vishal.l.verma@intel.com>, ira.weiny@intel.com <ira.weiny@intel.com>, dan.j.williams@intel.com <dan.j.williams@intel.com>, bhelgaas@google.com <bhelgaas@google.com>, ming.li@zohomail.com <ming.li@zohomail.com>, rrichter@amd.com <rrichter@amd.com>, Smita.KoralahalliChannabasappa@amd.com <Smita.KoralahalliChannabasappa@amd.com>, huaisheng.ye@intel.com <huaisheng.ye@intel.com>, linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>, linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>
> > Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function reset  
> 
> 
> >Prefetching should (hopefully) not make any dirty lines. Hopefully
> >no one does clean writebacks (and there is a way to check if they
> >do in the ACPI tables).  You need to flush again after to force out
> >that stale stuff though before any demand fetches occur.  
> 
> I am aware of some systems which do clean writebacks to device memory. 
> What exact ACPI table has this discovery?

CEDT (so in the CXL spec, it's there in 3.2 and 4, I'm too lazy to open
earlier specs) Specifically the CXL System Description Structure (CSDS)
System Capabilities bit[1]

No Clean Writeback: Specifies the clean writeback beahvior of hte host
- 0 = The host may or may not generate clean writebacks.
- 1 = The host guarantees to never generate clean writeback at the host's
      cacheline granularity.


> 
> >I need to think a bit more on this as there are some scary
> >comments in the spec on CXL.reset such as all CXL.mem reads
> >are dropped (timeout fun). Mind you a device is permitted
> >to do that anyway before cxl.mem is enabled, so hopefully n
> >one times out if a prefetcher hits the device before that's on..  
> 
> Yes, any sensible coherent memory device reset will have to include first offlining the memory such that there is no demand or speculative fetch possible, else you get to deal with CXL error isolation fun.
> 
> >From a kernel point of view SMCCC needs to be just one option as a
> >bunch of hardware (I'll only point at ours as not sure what else is
> >public) provide MMIO accessible agents to do this stuff and going via
> >EL3 to talk to an engine the kernel can poke directly is silly.  
> 
> We have a similar custom engine for efficient flushing, but the interface is not available to the kernel, so the SMCCC is preferred for our implementation. Like you say, the AML wrapper for SMCCC is another option, although we also have some device tree based systems where the efficient custom flushing is desirable. 

Great.  So all that work they did before dropping the PSCI call
was worth doing.  I'll keep an eye open for the new spec.

> 
> >I'm not against the PSCI thing coming back though if someone needs it.
> >Preferably without the CPU rendezvous stuff though -> or Linux can
> >just reject anyone who does that.  
> 
> Agreed. I think Souvik also agreed offline that rendezvous is not needed for the SMC based cache flush.

Great.

Thanks,

Jonathan

> 
> Vikram
> 

