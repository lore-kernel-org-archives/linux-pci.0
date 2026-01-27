Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9662EBDCD;
	Tue, 27 Jan 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508657; cv=none; b=nNEc3fe06qNj1fsgHzHJolgYA2nKuqP9Fig0wz/agPsJZb6sLcrs0DO3InrmPCpXPJJkZjidjg04wHLjiQl9U9OpWBERHd2HVzTbbS502HgXlvim+OjV4nxJgj/KUgVjxvIuIfZngKlnU9IMr767rxP+Q0IgcdX3OVaj8O2pcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508657; c=relaxed/simple;
	bh=6Edij2+xw+u7ypTIdPDdseGXRzPmAkd/3Evl8d3Wx08=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/R1NdELBQe3MJrv8MYQmVB+bfRrpwNFwAWdD1kD3/CEtZFbWV5ApD2exw8Vd497g3bhrwun0967jE1dzevczPZFMvHWrVyMiaZMD/PB8d/iE1lHtXhq4yKKs29d68PMl+xUN7ZPbtpDfsYtm+3XDrp0ZxWa4aaNVfYbtkilVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0h3q5wXLzJ46jd;
	Tue, 27 Jan 2026 18:10:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D28740585;
	Tue, 27 Jan 2026 18:10:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 10:10:50 +0000
Date: Tue, 27 Jan 2026 10:10:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 1/5] PCI/DPC: Clarify naming for error port in DPC
 Handling
Message-ID: <20260127101049.0000640d@huawei.com>
In-Reply-To: <20260124074557.73961-2-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-2-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 24 Jan 2026 15:45:53 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> dpc_handler() is registered for error port which recevie DPC interrupt
> and acpi_dpc_port_get() locate the port that experienced the containment
> event.
> 
> Rename edev and pdev to err_port for clear so that later patch will
> avoid misused err_port in pcie_do_recovery().
> 
> No functional changes intended.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Seems like a good readability improvement to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

