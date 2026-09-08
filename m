Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B72FBE;
	Tue,  8 Sep 2026 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829052; cv=none; b=pfgoyF9BX8nAqQo0eMO1OjQsS2YEidYg/b9r3hLjUWVmKS/5pCXQXD3G8nyM+eMTAeVfnL5nm4tO5hSkg47PMZ4pxUlT0g3HPBG9c7wuzHHsDI8D29dt3smfPHYf4h2EQ7oFq4CgA3sL2RLpmXjkUdNg9D4z05VP1CeNf4NmYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829052; c=relaxed/simple;
	bh=tgIPkqLL574nRd6uH/OdIE9pkw6UuV75K0iwBwebEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4z1ufbFrR3yGwvmcbpLy4c69UPd/VGFmbt4CFu/YrMk5lvIS9Gyqlzep6buy2Qrk8sl+IwuH254QBC9piyrTF+afzII/l6YQ0e8eFAFCruZUqxaJJfSSTacLBtpUX2yEZddMn99fMcBFYDIQjuLYI/D/fmVn2XY6yC0Phx5B/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jszKzdoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jszKzdoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C3D1F00A3A;
	Tue,  8 Sep 2026 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829050;
	bh=MYAjivpgE01XT5FVIerMOmRGhLGhfUaCEwoU29tcf6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jszKzdoai+InfYmqoMr2Hwi6AkaxkKgAjPaC3XOlAocNZlFH+bleB4Na7aLPtFqCR
	 4rXAx5+mVPHU4XkgFbq2SP7kHXIHgoI9WFvyxjKYMZEpsj6WaMphZH152XdM0smFj1
	 n5S581LGPBGMNgj9PxBFK1AD3nzLKkPeKWKKZY5Juio+vPNCg9sQ4Ip0s3LiS43QO1
	 QKxcrAXdRWFzj+HyYLOCI4rmevEe0lO45IUiivVithYOEQYwddkYYNG3oMetBmTbCa
	 TIesKmw4l3TAxEETNXbZQdbxm88H1EKWjPJlT9oh0FVUR+RIMoUkP9feRGty1XH6FM
	 a3N1hXD1wmoYQ==
Date: Tue, 8 Sep 2026 01:57:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Bjorn Helgaas" <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun Guo"
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 "Lukas Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error
 flow
Message-ID: <20260908015723.6d6ebd44@jic23-huawei>
In-Reply-To: <20260902133933.2992457-3-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:26 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Establish a single CXL protocol error path shared by CXL Virtual
> Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
> handle_error_source() routes CXL protocol errors, gated by
> is_cxl_error(), through the AER-CXL kfifo to a cxl_core consumer for
> logging and recovery. Producer and consumer go live together so no CXL
> error is silently dropped across a bisect.
> 
> is_cxl_error() expands from Endpoint-only to also cover Root Port,
> Upstream Port, and Downstream Port. RCDs report on behalf of an upstream
> RCH Downstream Port and instead reach the kfifo via
> cxl_rch_handle_error().
> 
> For uncorrectable errors, cxl_proto_err_wait_for_empty() drains the CXL
> plane (RAS read, panic policy, state clear) before pci_aer_handle_error()
> drives PCIe recovery, so recovery does not tear down RAS iomaps while the
> consumer is still reading them. Correctable errors run asynchronously.
> 
> Panic policy: cxl_do_recovery() panics on a confirmed UCE, and also when
> the RAS registers cannot be mapped -- an unconfirmable UCE is treated
> conservatively as fatal since CXL.mem coherency may be lost. A
> mapped-but-clear status is logged as spurious with no panic.
> 
> to_ras_base() centralizes RAS base lookup (dport->regs.ras for
> Root/Downstream Ports, port->regs.ras otherwise) and provides an
> injection point for RAS status simulation during testing. The
> cxl_cor_error_detected() AER callback is removed; correctable Endpoint
> errors now route through the kfifo like every other CXL protocol error.
> 
> Update cxl_handle_rdport_errors() with locking to prevent dport from
> being freed and RAS from being unmapped.
> 
> At this step cxl_handle_rdport_errors() still dispatches a single
> severity per pass (matching the pre-series baseline). The following
> patch, "cxl/ras: Handle RCH correctable and uncorrectable errors in one
> pass", processes a simultaneously signalled CE and UCE together.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


