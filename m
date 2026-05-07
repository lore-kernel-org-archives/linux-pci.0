Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4E449EA0;
	Thu,  7 May 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176398; cv=none; b=TQjhxgOcixOftbif/5/C5qvqAvDt+1tu3eLzYqCtovx0UrbzkSxKMumZLySO2YCNenXFoGzlQ+AqgYRqNxqUiN+EEOfEwmuSQ43ZojbNyQD6/Q+99POEd2iPNzRhHgeWt/14ftDe38x/O0qGhGT+cv6F4xk5Aa44g0FAjjS07EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176398; c=relaxed/simple;
	bh=89kmpux1Lhq4nyJP39nykhEYyXhOAZB3p/RS2GVPyxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/GvrLJ4FGGCXapitGrPrBV5h+jFpCT3w2jI/3qQ5zQX1/k5aiAMDLT0i6G4TKAkHx5Kx0h+V+hMccl7NvYk5zcEzingzI6H0xCge9W5sx3upbjue4QRYCKuCoyTE9k2UMoJmub5qPW5I0LEaOI/rYR/Ed7KypsFDemIKVicHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV1ZCd+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV1ZCd+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC3FC2BCB8;
	Thu,  7 May 2026 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778176398;
	bh=89kmpux1Lhq4nyJP39nykhEYyXhOAZB3p/RS2GVPyxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FV1ZCd+7kWW/PSVh+j58E2CpoqJsuRzptw6hDTxOo16k72c1uqO/PXOwI107vyAjz
	 jJHJQ6I+I02CEAxWVWNrOUFA6n656GZ6IXEHvcfa9N+B3Na9vkwAyLsGUwmnNSze3C
	 aymns9w7zlFVz7jKYWPefpnlnl2Ka7hkUIe7+ElgbYZz8JYXIUrYOegzmeBCgLylBk
	 FqOBbIaQONUNnAJvMUy1Ke6L49G5du+xvlP4QL5l5utIdrubOQ7XTmzeM2cg2ReNkx
	 2QbXIR8l87hgrJ2c+A4ttw3g/9v2EjokrA1KUgEo/jyeJbY68ma3ZsUQDe7Gq9R1xC
	 y1wHWvoDKqu2g==
Date: Thu, 7 May 2026 18:53:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
 <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
 <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
 <dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
 <lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
 <alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
 <rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v17 01/11] PCI/AER: Introduce AER-CXL Kfifo
Message-ID: <20260507185303.329cf964@jic23-huawei>
In-Reply-To: <20260505173029.2718246-2-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-2-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:30:19 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL virtual hierarchy (VH) native RAS handling for CXL Port devices will be
> added soon. This requires a notification mechanism for the AER driver to
> share the AER interrupt with the CXL driver. The CXL drivers use the
> notification to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology refers to CXL VH and not CXL RCH
> errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol
> errors: pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. Multiple
> AER IRQ worker threads can be running and enqueueing concurrently, so
> include write path synchronization. Pack the kfifo, the spinlock, the
> rwsem, and the work pointer into a single structure. Initialize the
> kfifo with INIT_KFIFO() from a subsys_initcall so its mask, esize and
> data fields are valid before any producer or consumer runs.
> 
> Add CXL work queue handler registration functions in the AER driver.
> Export them so the CXL driver can assign or clear the work handler.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work
> data. It contains a reference to the PCI error source device and the
> error severity. The cxl_core driver uses this when dequeuing the work.
> 
> Introduce cxl_forward_error() to add a given CXL protocol error to a
> work structure and push it onto the AER-CXL kfifo. This function takes
> a pci_dev_get() on the source device. The kfifo consumer is responsible
> for the matching pci_dev_put() after dequeue. On enqueue failure
> cxl_forward_error() does the put itself.
> 
> Synchronize accesses to the work function pointer during registration,
> deregistration, enqueue, and dequeue.
> 
> handle_error_source() is intentionally not changed here. The is_cxl_error()
> switch that routes errors to cxl_forward_error() is added in a later patch
> together with the kfifo consumer registration. This way the producer and
> consumer land in the same commit, so CXL errors are not silently dropped
> during bisect.
> 
> Also add MAINTAINERS entries for both drivers/pci/pcie/aer_cxl_vh.c
> (new in this patch) and drivers/pci/pcie/aer_cxl_rch.c (already in tree
> but previously unlisted) under the existing CXL entry. This way the CXL
> maintainers are CC'd on changes to the AER-CXL bridging code.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko did have one comment on what happens if there are multiple things
in the kfifo and fn fails.  At that point I think we are in the all
bets are off corner and stranding a driver is fine, but open to other opinions!

https://sashiko.dev/#/patchset/20260505173029.2718246-1-terry.bowman%40amd.com

So with that in mind

Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..c0fea2c2b9bc
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c


> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			   cxl_proto_err_fn_t fn)
> +{
> +	int rc;
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		rc = fn(wd);
> +		pci_dev_put(wd->pdev);
> +		if (rc)
> +			return rc;
This is where Sashiko complains. Specifically:
"If the consumer callback fn() returns an error, does this early return
strand the remaining items in the kfifo?
Because cxl_forward_error() takes a pci_dev reference for each enqueued
item, it looks like these stranded items might leak their pci_dev references
and prevent clean unbinding or hot-unplug until a new error triggers the
queue again."

I'd go with indeed it does, but there is no right thing to do here. I guess
we could flush the kfifo and call pci_dev_put() on each of them, but that's horrible.
Would basically mean calling the same stuff you have for cancelling outstanding
entrees on exit().


> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
