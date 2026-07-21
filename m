Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65A2AEE4;
	Tue, 21 Jul 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593151; cv=none; b=KDVJk3kq3KMogcflv0uD4SesHjED8vXqxBQd6O6MQbjRy9lna1HFXJft/Mut1TktgjHFyjN0kD99vTDd+QenqluB+mGEFpREgwGnMtHrJCLmltP1MNZ6Nxtmer/SyzDxh/SNA5v8d0aSXl388ShCZ+QCpu7OQs+eU1HN2uRVVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593151; c=relaxed/simple;
	bh=2qMl910BJFt0Lw11Zr9MfYs7NAOKMTQWr82xCgXmBxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfn1FE7DT436xQq0Nxvd3O7uSl6Zxp4PfxV3zrFuAshbIsrZjOQuTmGciPEcd5YcTVve0GZY0EnNIMj3N2oNM3+RtHFckOekIFLyJfmsRISnJHXR3gingslS6ek76pNY4gInHRY31RJAzFMD9BpN/Bpa1LVORLAU9pjn9YwsLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+xaV714; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+xaV714"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A856B1F000E9;
	Tue, 21 Jul 2026 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593150;
	bh=AFoF5hI+TyonHgFrZiKmtrN1ti4k0VjnSpnUvsJ8h/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a+xaV714k0eHw8rUI7q1qTfijKgxRQ55rJXLUXJV5tiqYUp9mFNwYfDo5yCIs92XJ
	 9cKUZ6WSbtixHdiBNa3tfHIgCpRpSPgNxKtCYTYhCAZ3s57qRUwM2UhAqkub1zl3gv
	 v1Q2HorUH2vmYIh59cS2ON7m56FcZUVOTLlZaHAYeybX92bmOkiVYuSkRGkXHFZZHJ
	 +ONVwY2lra+naEsQ8nxIUIPF4pSuZ3oGXu3q1xXaH7r3eXxlO3VlqQOKT7BxbLTlE2
	 DLcnLtmOnvlC3uZvjq81uYtPH9ZFZDaTUFoi2v/sZtoxn983OV9rqUu7bE79n1EMrW
	 Od3dcqVbVo/+w==
Date: Tue, 21 Jul 2026 01:19:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 13/13] Documentation: cxl: Document CXL protocol
 error handling
Message-ID: <20260721011902.0a93da2d@jic23-huawei>
In-Reply-To: <20260717222706.3540281-14-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-14-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:06 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
> 
> This documents the architecture introduced by the preceding patches in
> this series.
> 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
A couple of trivial things inline to tidy up. Actual text seems good
to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> ---
> Changes in v17->v18:
> - Simplify document for readability (Jonathan)
> - Drop historical context that goes stale (Jonathan)
> - Shorten ASCII flow diagram (Jonathan)
> - Drop manual backtick markup, use automarkup (Jonathan)
> - Clarify USP/DSP as single switch component (Dave)
> - Fix line wrapping to 80 chars (Jonathan)
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/protocol-error-handling.rst     | 222 ++++++++++++++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 3dfae1d310ca5..6861b2e5726a3 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     linux/dax-driver
>     linux/memory-hotplug
>     linux/access-coordinates
> +   linux/protocol-error-handling
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> new file mode 100644
> index 0000000000000..67f0492e56702
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> @@ -0,0 +1,222 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +CXL Protocol Error Handling
> +==============================
> +
> +CXL devices report protocol-layer failures (CXL.cachemem RAS) as PCIe

Why short wrap?  Docs are 80 chars I think.

> +AER Internal Errors: PCI_ERR_COR_INTERNAL for correctable events and
> +PCI_ERR_UNC_INTN for uncorrectable events.  The actual fault
> +information lives in CXL RAS capability registers, not in the PCIe AER
> +status registers.

> +Error flow
> +==========
> +
> +.. code-block:: text
> +
> +   CXL device raises AER Internal Error
> +   (PCI_ERR_COR_INTERNAL or PCI_ERR_UNC_INTN)
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | AER core (aer.c)                     |
> +   |  aer_irq() -> aer_isr()             |
> +   |  -> find_source_device()             |
> +   |  -> handle_error_source(dev, info)   |
> +   +--------------------------------------+
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | handle_error_source() dispatch       |
> +   |                                      |
> +   |  1. cxl_rch_handle_error()           |
> +   |     [always; filters internally]     |
> +   |                                      |
> +   |  2. if is_cxl_error():              |

Smells like a missing space.

> +   |       cxl_forward_error()            |
> +   |       [enqueue to kfifo]             |
> +   |                                      |
> +   |  3. if cxl_pending && non-CE:        |
> +   |       cxl_proto_err_flush()          |
> +   |       [sync drain before recovery]   |
> +   |                                      |
> +   |  4. pci_aer_handle_error() [always]  |
> +   +--------------------------------------+
> +                   |
> +          (kfifo -> workqueue)
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | __cxl_proto_err_work_fn() consumer   |
> +   |                                      |
> +   |  if is_cxl_restricted(pdev):         |
> +   |    cxl_handle_rdport_errors()        |
> +   |    [RCH dport RAS first]             |
> +   |                                      |
> +   |  port = find_cxl_port_by_dev(        |
> +   |           &pdev->dev, NULL)           |
> +   |  dport = cxl_find_dport_by_dev(      |
> +   |           port, &pdev->dev)           |
> +   |  [dport NULL for EP/USP; set RP/DSP] |

check the alignment here as well.  A couple of extra spaces in the
lines above I think.

> +   |                                      |
> +   |  cxl_handle_proto_error()            |
> +   +--------------------------------------+
> +            |                |
> +            v                v
> +   +-----------------+  +--------------------+
> +   | CE              |  | UCE                |
> +   | cxl_handle_     |  | cxl_do_recovery()  |
> +   |   cor_ras()     |  |  read RAS status   |
> +   | trace + clear   |  |  trace + panic     |
> +   +-----------------+  +--------------------+
> +
> +cxl_do_recovery() reads the CXL RAS uncorrectable status register.
> +If UE bits are set, it emits the trace event and panics.  If no bits
> +are set (e.g. RAS mapped but error already cleared), it logs a
> +diagnostic and defers to AER recovery.
> +
> +
> +Severity policy
> +===============
> +
> +**CE** - cxl_handle_cor_ras() reads the CXL RAS correctable status
> +register, clears set bits, and emits a cxl_aer_correctable_error
> +trace event.  No recovery action.
> +
> +**UCE (non-fatal, and fatal on Root Port/Downstream Port)** - cxl_do_recovery() reads the CXL RAS

Wrap needs an update here.

> +uncorrectable status register.  If UE bits are set, the kernel panics.
> +CXL.cachemem traffic cannot be safely recovered once an uncorrectable
> +error is signaled; continuing risks silent data corruption across
> +interleaved HDM regions.  This panic policy applies to the native AER
> +path.  On firmware-first (CPER/GHES) platforms the CPER handler emits
> +trace events only and does not call cxl_do_recovery().
