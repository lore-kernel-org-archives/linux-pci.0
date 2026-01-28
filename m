Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D234EEEF;
	Wed, 28 Jan 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603822; cv=none; b=nzQ8VSc/MH26EqBKapkjHrP3PoOCk8qBQSwFHzfCQa8N3K3elBx6J4BUi21fYZFaB6aj4TfWsFwZ4ZMOTXFTtfnt0KshAv3Go3SsaFcpCyl8/SFAo2rVnXlRrJuiO9b3uBtmMkrEGaqZX6Y7FMOZSsxWV+l7fUbS9UDI9Z85JBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603822; c=relaxed/simple;
	bh=kNaws1xCzyQVOVgfLs5bTUmNdvu/jmnMakEwKN4/ads=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUI5MGyK9h2fQc8X9WVOyQjU75w9lCZSvFteIq1KP7AJqJSV/OrVrbgoirwOOBzNN11bzHow37Vkbl/i9dDKKRDMMMgXJl5sp7dI4O0FLa+IhTxeWqiDMX7PJP8oPJNFNeQPmH4j/cgfbtikH/PJIyyfmlNpZoLMRvDWMldmlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1MFZ4Vt1zHnGdR;
	Wed, 28 Jan 2026 20:36:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 253FE40569;
	Wed, 28 Jan 2026 20:36:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Jan
 2026 12:36:48 +0000
Date: Wed, 28 Jan 2026 12:36:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	Srirangan Madhavan <smadhavan@nvidia.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Message-ID: <20260128123647.0000602f@huawei.com>
In-Reply-To: <697985c2c622_1d33100a2@dwillia2-mobl4.notmuch>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260127093343.67715d5e@shazbot.org>
	<6978ef9919421_1d3310036@dwillia2-mobl4.notmuch>
	<LV8PR12MB9182DEE18D9F83194A6E0034BD90A@LV8PR12MB9182.namprd12.prod.outlook.com>
	<697985c2c622_1d33100a2@dwillia2-mobl4.notmuch>
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

On Tue, 27 Jan 2026 19:42:58 -0800
dan.j.williams@intel.com wrote:

> Vikram Sethi wrote:
> > Hi Dan,
> >   
> > >Once the protocol error handling series has landed there is a potential
> > >to extend that with CXL Reset recovery. However, that needs a clear
> > >error model defined as to which resets have a chance of recovering
> > >*system* operation when CXL.cache/mem fails. In Terry's series, panic /
> > >reboot is the recovery, not reset.  
> > 
> > It's not just about CXL protocol error handling though. Type2 Device
> > passthrough will be a common usecase for CXL reset (entire device is
> > assigned to VM) across different VM assignment.  
> 
> I understand. The point about CXL Protocol Error handling series is that
> it at least enlightens the PCIe core about the presence of active CXL
> links.
> 
> It is also the case that it much closer to being upstream than this set
> which still has fundamental questions.
> 
> > The cache and mem of the device must be cleared via CXL reset for full
> > device passthrough in addition to the PCIe/CXL.IO reset. Another
> > usecase is when the device is reconfigured either in baremetal or in
> > VM for passthrough usecase. Such usecases often require a reset of the
> > device, and it's cache, mem and not a narrow "memregion" reset, so I'm
> > not in favor of exposing it via CXL.mem sysfs entries. IMO, device
> > sysfs attribute reset method is appropriate for type2 devices.  
> 
> That case is already handled today with secondary bus reset to
> completely reset an entire device. That path is problematic for CXL
> because PCI reset has no idea about how to manage caches or handle
> memory unplug.
> 
> Administrator is responsible for making sure that event is not a
> surprise memory removal or cache protocol corruption event. That is a
> level of explosiveness that PCI reset has never needed to consider.
> 
> CXL Reset wants to be more surgical than secondary bus reset. The only
> way to be more surgical is to cooperate with the CXL core that knows
> whether the explosives have been rendered inert.
> 
> > Finally, there is the error usecase, which in the common case is as
> > simple as an uncorrected ECC error in the HDM. While not strictly
> > necessary, it is common practice to reset the device in such cases, to
> > recover the bad page/row via PPR on device reset. You want reset of
> > the memory controller as part of the CXL reset here, FLR is not
> > enough.  
> 
> ??
> 
> CXL memory repair is already upstream without CXL Reset, see
> CONFIG_CXL_EDAC_MEM_REPAIR.

To actually do it we rely on tear down of all access to the device
(if it it's disruptive).
There is new spec stuff covering asking a device to just do it next reset
that would fit more closely with this flow. No support yet I think.

Mind you we are talking type 2, so who knows what people will implement.
Nice if they used that part of the spec but I doubt we can rely on it!

Jonathan


> 
> > Regarding scope, and "recoverability", we have significant experience
> > with recovering "pre-CXL" coherent GB200 devices for device errors:
> > memory ECC or other, by killing the application using device memory,
> > unloading driver, resetting the device, and reloading driver. The CXL
> > protocol error series can use CXL reset series, but I don't see that
> > this series needs to wait for protocol error handling to be merged.    
> 
> I do want to get to the point where device memory error recovery is a
> first class citizen. CXL Protocol Error handling just happens to be at
> the top of the review queue and safe to assume it can be a foundation
> for further RAS features.
> 
> 

