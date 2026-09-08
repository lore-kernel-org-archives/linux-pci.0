Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103D595741;
	Tue,  8 Sep 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891204; cv=none; b=be+ju2aoKXd+q8GaC25ChLVrvJ+4qA3h98cvFLBMtxkTQGKnpVcjUsLcqrkV1CuURrzDj/4ZtqR1tv2l6VHpaZl/mEcywX4kNPEWyRXaoLSj6607g1Ie1U9lW+RvPKIgAtDzKJXQd37swWL7+Msf34vunBIT0h8UviVmlnqjgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891204; c=relaxed/simple;
	bh=q3tyUGXjtAIqbsKQHr85fM2v5b40q0UKMmYZXD804ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNMLRcbc9Dwkb9N4Tc1AAV2pCeH7T1/fzp883DgLbkhjHys5G8pI0Q01EJOB8q+9RqKjwvN86NrEuHojYGDL8dqwQ+ub/I5ZT1XrZ+vk/1tYrRM3yDs/3ILWGtmvUyUZotdkos/GivdLWNLRP5CwUbY1k8+tPd7AIiW8ZKqL3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVlD2paD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVlD2paD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E972E1F00A3A;
	Tue,  8 Sep 2026 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891203;
	bh=eU35bkyDh/FOzv63wY00YqRoS00L3uB7DlSZ4bmKhe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JVlD2paDQ8kwI7ZdrDhJncU45Hqih7sy8gRe0JhjYAY/xuGZxsrxwfUUjRWLoWkGc
	 kDPyz40bYgpBi7qYLNAPcdi+oRFuGt4NkhMv22IGcBbvPdjMwxexYZxLgQ2TmOQw1s
	 7uNKWr0b6yYrofBN3H0ZZIfvQj7mr5R0aMVZ6aQzRbOsSTGJCzXahzxLqG4Ae6MzZo
	 6fTE5JILBfMJQkqHpMYp8b9ZLV0+h2eq7VJWaJpTp7K71lTi0MWmcaMPXDCr+wX0Sr
	 5mPQf6lhzqaUVnMENvCC9RFdDXdk3UrfzWNb9ibO9EixjMY0Gp+/qOfn0R1SYXVcV6
	 //3psex6atJ/Q==
Date: Tue, 8 Sep 2026 19:13:19 +0100
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
Subject: Re: [PATCH v20 7/9] cxl: Add port and dport identifiers to CXL AER
 trace events
Message-ID: <20260908191319.3ae39bdb@jic23-huawei>
In-Reply-To: <20260902133933.2992457-8-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:31 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_* trace events
> instead of a plain struct device * derived at the caller. The trace event
> helpers then derive the right strings for Endpoints, Switch Ports, Root
> Ports, and RCH Downstream Ports consistently across the CPER and native AER
> paths.
> 
> The unified cxl_aer_* events keep "memdev" as the legacy field (Endpoint
> events populate it with the memdev name; non-Endpoint events emit
> memdev="") and add new "port" and "dport" string fields populated for all
> CXL device classes. Updated userspace can key off "port" and "dport"
> without a parallel set of events.
> 
> Remove the separate cxl_port_aer_uncorrectable_error and
> cxl_port_aer_correctable_error trace events. All CXL AER events now use the
> unified cxl_aer_* events with port and dport fields.
> 
> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and the
> unified trace helpers, replacing the per-port-type branching and
> bus_find_device() memdev lookup.
> 
> The TP_printk format string places "port=%s dport=%s" between "memdev=%s"
> and "host=%s", changing the text-mode field order from the pre-patch output.
> This does not affect consumers such as rasdaemon that use libtraceevent to
> parse fields by name rather than by fixed text position.
> 
> For non-Endpoint events (Switch Port, Root Port, RCH Dport), "memdev" is
> empty and "port"/"dport" carry the topology information.
> 
> CPER: trace firmware-supplied protocol errors even when the host device is
> unbound; the record is self-contained in ras_cap and reads no MMIO. Keep
> the host lock only to serialize the dport lookup against teardown.
> 
> Below are examples of the different CXL devices' error trace logs
> after this patch:
> 
>      ---------------------
>      | CXL RP - 0C:00.0  |
>      ---------------------
>                |
>      ---------------------
>      | CXL USP - 0D:00.0 |
>      ---------------------
>                |
>      --------------------
>      | CXL DSP - 0E:00.0 |
>      --------------------
>                |
>      ---------------------
>      | CXL EP - 0F:00.0  |
>      ---------------------
> 
> Root Port:
> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>    first_error: 'Cache Address Parity Error'
> 
> Upstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
> PCI AER callbacks that are not CXL aware.
> 
> Downstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> RCH Downstream Port (RCD attached under a host bridge, no switch):
> cxl_aer_correctable_error: memdev= port=root0 dport=pci0000:0c \
>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=root0 dport=pci0000:0c \
>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> For RCH topologies, both correctable and uncorrectable protocol errors
> were previously traced against the memdev via the cxl_aer_* events with
> memdev populated. They now emit memdev="" with the RCH Downstream Port
> carried in the "dport" field (dport->dport_dev, the host bridge) and the
> host bridge in "host". Consumers that keyed RCH errors off "memdev" must
> key off "dport" instead.
> 
> Endpoint:
> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

A trivial 'maybe it looks nicer like this' suggestion inline.
Feel free to ignore.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 7f2a9dd0d0e3f..df42d119c53dd 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -2,7 +2,42 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include "core.h"
>  
> +const char *cxl_trace_memdev_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(&cxlmd->dev);

Similar to below if you make that change.

> +	}
> +
> +	return "";
> +}
> +
> +const char *cxl_trace_host_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(cxlmd->dev.parent);

		return dev_name(to_cxl_memdev(port->uport_dev)->dev.parent);

Maybe that's too ugly though.

> +	}
> +
> +	return dev_name(port->uport_dev);
> +}

