Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008782D063E;
	Thu, 12 Mar 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318521; cv=none; b=sDuvCRUVAHBuLRF2cmhiS2jeyCPXBcTfXNCEbyennT0CIF0w0tWMn4AGdKLw4dQulLvpNrZmFFMwykmY8eKK3APrtxHMY6V6b/H5n/qjRGhhycVWJ+qjHNxmGsr6omvRMu8W5QxailQbeeVcsmIq/qhlLGZExOnV14PouKn0YV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318521; c=relaxed/simple;
	bh=lSrzo9N9U7HvisT5Cj5la+rqunfO7D9Z9jEglvygi4U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txjq/p/JAmB6jVp0YQEezjqZ7CFwvqZAm37wTpSoie1EI1umRkmXVNpcfo5LOr/bs4gl+ulyS314rvDfb5rc7zQXQC1pGosVcgaK8mMa+BEIjeLdU4MI8pRKFXZqy4gvUXRKt2PfZejGlXiB9wVfg+2Khp16CtmApSAsbAJoODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWn2y5b4czHnHG9;
	Thu, 12 Mar 2026 20:28:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 682D240572;
	Thu, 12 Mar 2026 20:28:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 12:28:35 +0000
Date: Thu, 12 Mar 2026 12:28:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <alwilliamson@nvidia.com>,
	<jeshuas@nvidia.com>, <vsethi@nvidia.com>, <skancherla@nvidia.com>,
	<vaslot@nvidia.com>, <sdonthineni@nvidia.com>, <mhonap@nvidia.com>,
	<vidyas@nvidia.com>, <jan@nvidia.com>, <mochs@nvidia.com>,
	<dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI: Add cxl DVSEC state save/restore across resets
Message-ID: <20260312122833.00002cc7@huawei.com>
In-Reply-To: <20260306080026.116789-5-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Mar 2026 08:00:18 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Save and restore CXL DVSEC control registers (CTRL, CTRL2), range
> base registers, and lock state across PCI resets.
> 
> When the DVSEC CONFIG_LOCK bit is set, certain DVSEC fields
> become read-only and hardware may have updated them. 

This I'm not following.  Can you give an example of which
fields the hardware is allowed to change after lock is set?

> Blindly
> restoring saved values would be silently ignored or conflict
> with hardware state. Instead, a read-merge-write approach is
> used: current hardware values are read for the RWL
> (read-write-when-locked) fields and merged with saved state,
> so only writable bits are restored while locked bits retain
> their hardware values.
> 
> Hooked into pci_save_state()/pci_restore_state() so all PCI reset
> paths automatically preserve CXL DVSEC configuration.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>



