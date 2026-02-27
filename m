Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF925B663;
	Fri, 27 Feb 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199261; cv=none; b=LdOfTHab1eWaBj3KVY+IjNP+GyAnKSc8BWoWKmabe2PpfMQU9DiIoBjK6Lx22kiffSfBb2GtLteEJuCKvpjNEYgXafixUzTFuOXnQzM1BmVzmvrV2N+SVHEGsPGZ9xnqb9zjOu07zn8WDkbRT/AFDheRemzKvrvsJUpCV1890r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199261; c=relaxed/simple;
	bh=Gj1ZRHoFyfOCPG4wFYQ7NFuIyqac++id6WLS2szSxL8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBRf1rraTDHJSuf+nXNfDlbeJcXaa6NEMxin2scgxvIhL+gQ+qsPjoZ2CSnJpGfUBie+HOURI2+8iRDTX2nqDsaVHRvJzLC09rjM871xAQPHiAeFB3rjDTAH4Srer23LIKdRxc1Dd63NOubrTqcuPHYI25Fr09GcR8ofS58sjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMq6M6GpwzJ46c9;
	Fri, 27 Feb 2026 21:33:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E5F04056E;
	Fri, 27 Feb 2026 21:34:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 13:34:13 +0000
Date: Fri, 27 Feb 2026 13:34:12 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
	<raphael.norwitz@nutanix.com>, <vsethi@nvidia.com>, <sdonthineni@nvidia.com>,
	<smadhavan@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
Subject: Re: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
Message-ID: <20260227133412.0000139a@huawei.com>
In-Reply-To: <b7c04f27-39a9-41df-af0a-14bc5005518e@intel.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
	<20260225133801.30231-1-vidyas@nvidia.com>
	<b7c04f27-39a9-41df-af0a-14bc5005518e@intel.com>
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

On Wed, 25 Feb 2026 09:34:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 2/25/26 6:38 AM, Vidya Sagar wrote:
> > The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
> > the "Unmask SBR" bit in the Port Control Extensions Register.
> > When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
> > in the Bridge Control register has no effect on the downstream bus.
> > 
> > Currently, the Linux PCI core checks this condition in
> > pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
> > execution of the reset. However, during the probe phase (when probe=true),
> > the function currently returns 0. This 0 return value incorrectly signals
> > to the PCI subsystem that SBR is a viable reset method for the device.
> > 
> > As a result, 'bus' is listed in the device's
> > /sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
> > is incapable of performing it. If a user attempts to write bus to reset
> > method or triggers a reset that falls back to SBR, the operation fails
> > with: "bash: echo: write error: Inappropriate ioctl for device" error.
> > 
> > This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
> > if cxl_sbr_masked() is true, regardless of the probe argument. This
> > ensures that 'bus' is not advertised in reset_methods when the hardware
> > prevents it, improving clarity for users and aligning the sysfs capability
> > report with actual hardware behavior.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
