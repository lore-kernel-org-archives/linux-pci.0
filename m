Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849B33711D;
	Mon,  9 Mar 2026 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058833; cv=none; b=Epoix6UJNtI/gZQY5Exu8Ne0QE1EmdbDza6zGSxJgmR5GIc2Uxu1ww4ssyrh98WUKFblP2NggIoUroXCBaH6iCrY1E+M4epNDcLgwySnbGRucehwj+FNNkQUDCFnOLVFyP8DAFuWax7bSVjb+L7/5vEVCYnhsWzmXcwTUCvKYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058833; c=relaxed/simple;
	bh=jptFEPt+jIan2RPp4cNu/vmZSU84NnVL+vSymmIlCIM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKvCXKiAV/kGjEt5LH+BNG9G3WmW+7JNIlZbTAC1p3nT2/jORykLlaNV4iKLa3ca+NEQxzqazcWXqM+0pjXRpl2YLAqj9QHBOBvzs62iGsxxaN/3DwZShTwLUNUKBv/o8/oSveCpOgWSt2ixcoNZw3tmPviKxbXOSOHGxxB4BaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTx1422ZXzHnHhl;
	Mon,  9 Mar 2026 20:20:24 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id EF63840086;
	Mon,  9 Mar 2026 20:20:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 12:20:26 +0000
Date: Mon, 9 Mar 2026 12:20:25 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
Message-ID: <20260309122025.000036de@huawei.com>
In-Reply-To: <20260302203648.2886956-2-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
	<20260302203648.2886956-2-terry.bowman@amd.com>
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

On Mon, 2 Mar 2026 14:36:39 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the PCI error source device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Introduce cxl_forward_error() to take a given CXL protocol error and add it
> to a work structure before pushing onto the AER-CXL kfifo. This function
> takes a reference count increment of the PCI device. The kfifo consumer is
> responsible for reference decrementing. If there is an error on adding the
> work then this function must decrement the reference count.
> 
> Synchronize accesses to the work function pointer during registration,
> deregistration, enqueue, and dequeue. Further synchronization fixes will
> be added in the following patch.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
Hi Terry,

Just some include related comments.  There are a few missing that
should be included from the c file.

Thanks,

Jonathan


> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..7e2bc1894395
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/types.h>
> +#include <linux/kfifo.h>
> +#include <linux/aer.h>

What motivated the decisions on which includes to have here?
Generally follow include what you use, with exceptions for some
cases where there is something inherent that means a header will
always include another one.

I'd definitely expect rwsem.h and cleanup.h (for guard()) for instance.
Also workqueue.h for schedule_work()


> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	struct rw_semaphore rwsema;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rwsema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsema)
> +};

