Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FD39A062;
	Mon, 20 Jul 2026 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590838; cv=none; b=iLV3nfkxJtBVGMLdC3BRFYMh/+qW4ZKsXVc4iLJEOC8CT0uD42DfrGrpCD/omoxxC0Yrou0Mzla23+04XKnysyO/le3Wg3SWKKEXCib7hU0fGfjAUbRfjRJKZFxf52KQh4RoMbk2AwQ6lBnOYz+fJC5JPZFfHCJm7TwovMcmMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590838; c=relaxed/simple;
	bh=lydmT9QPb0HhWCh9P5Ltk/DZdnauhKbiPR+Ldrm2xU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lifGBS6/Tu0jhy2EroF4VNMpmLqAz0ZtRx9YM0+DNznfQrXo0G0WFRe1EYNqXwkS/7XdXFw/qc6+QGe4Iv7RsgnHBeH7Fe9xEsOAbdHBWCJbeJ2sll6bdR8fj+4tejzl9Ac1KIf+gH2CbgSedBP1Ey+0zhmaok7M1Kzjh2vIJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTHm740A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTHm740A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784590835; x=1816126835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lydmT9QPb0HhWCh9P5Ltk/DZdnauhKbiPR+Ldrm2xU0=;
  b=bTHm740AAunP/oRM4uTuRUn+Hs/+GfHk7lN1mPwpL22B0oGdghVLqLdP
   quQEnrK8efJC6+Du/HSaBiGW6rAJUdVJQ86e+B0qqRD9hh0sPITrrvnXG
   qaqAcfp1ugK442QNoI4Sj7gIqHj9MOkKfoOYWrzVUCXoREO3534jI4is5
   t4wefUO6QGvI74aM/FkXrGXHl+PgvZvGB1dt+S3mIOpXadBxj6POzrH94
   FOymKJO+ZCgvPlZuq9OmGF2Vq8leiOv3gu/1CuiJBYSM1AX04Dq6YuFGC
   cysFaEtuNygbw5JRc3Db34IQI40MJ5cYA5aODfKbedOatntbLi5KHUtmT
   A==;
X-CSE-ConnectionGUID: 63qF7kjxRXSr4ILv5I2Lzw==
X-CSE-MsgGUID: ulkjiSF8RT6GDRHaSE71YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85303131"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85303131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:40:34 -0700
X-CSE-ConnectionGUID: xdpNpaTmRs6oLXB5OLhIQA==
X-CSE-MsgGUID: VehHV57MR2OdwA7yawkO4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254184453"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:40:30 -0700
Message-ID: <57f4dff0-e1ae-45ad-a663-f89ecd34e76e@intel.com>
Date: Mon, 20 Jul 2026 16:40:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 13/13] Documentation: cxl: Document CXL protocol error
 handling
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-14-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
> +AER Internal Errors: PCI_ERR_COR_INTERNAL for correctable events and
> +PCI_ERR_UNC_INTN for uncorrectable events.  The actual fault
> +information lives in CXL RAS capability registers, not in the PCIe AER
> +status registers.
> +
> +The kernel routes every CXL Internal Error through a producer/consumer
> +pipeline shared by all CXL device types: Root Ports, Upstream/Downstream
> +Switch Ports, Endpoints, and Restricted CXL Devices (RCDs).
> +
> +
> +Architecture
> +============
> +
> +Two error planes run side by side:
> +
> +* The **PCIe AER plane** handles native PCIe errors (receiver
> +  overflows, malformed TLPs, completion timeouts, etc.).
> +* The **CXL protocol error plane** handles CXL Internal Errors.
> +  The AER core forwards them to cxl_core via a dedicated kfifo;
> +  cxl_core reads the CXL RAS registers, emits trace events, and
> +  applies recovery/panic policy.
> +
> +The boundary between the two planes is enforced by is_cxl_error() in
> +aer_cxl_vh.c.  It checks info->is_cxl, the PCIe device type
> +(Endpoint, Root Port, Upstream, or Downstream), and whether the AER
> +status word indicates an internal error.  RC_END devices are excluded
> +from is_cxl_error() because they reach the kfifo via the separate
> +cxl_rch_handle_error() path instead.
> +
> +The pipeline:
> +
> +1. **Producer** (aer_cxl_vh.c, aer_cxl_rch.c) - AER threaded
> +   handler context.  Classifies and enqueues a
> +   struct cxl_proto_err_work_data into the kfifo.
> +2. **Queue** - the AER-CXL kfifo plus a backing work_struct.
> +3. **Consumer** (cxl_core/ras.c) - workqueue context.  Resolves
> +   the CXL port topology and dispatches to CE/UE handlers.
> +
> +
> +Topologies
> +==========
> +
> +Virtual Hierarchy (VH)
> +----------------------
> +
> +Standard PCIe topology: Root Port, optional switch (Upstream Port with
> +one or more Downstream Ports), and Endpoints.  Each component raises
> +Internal Errors directly via the Root Port's AER interrupt.
> +
> +Producer: cxl_forward_error() in aer_cxl_vh.c.
> +
> +Restricted CXL Host (RCH)
> +--------------------------
> +
> +A Root Complex Event Collector (RCEC) aggregates errors from RCDs
> +attached as Root Complex Integrated Endpoints.  The AER driver
> +iterates RCDs beneath the RCEC via pcie_walk_rcec() and forwards
> +each qualifying device through cxl_forward_error() into the same
> +kfifo.
> +
> +Producer: cxl_forward_error() in aer_cxl_vh.c, called from
> +cxl_rch_handle_error_iter() via pcie_walk_rcec().
> +
> +
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
> +uncorrectable status register.  If UE bits are set, the kernel panics.
> +CXL.cachemem traffic cannot be safely recovered once an uncorrectable
> +error is signaled; continuing risks silent data corruption across
> +interleaved HDM regions.  This panic policy applies to the native AER
> +path.  On firmware-first (CPER/GHES) platforms the CPER handler emits
> +trace events only and does not call cxl_do_recovery().
> +
> +**Fatal UCE on EP/USP** - The AER core driver does not read AER status
> +registers for Endpoint and Upstream Ports with fatal events because the
> +link is down.  Without AER status, is_cxl_error() cannot classify
> +the event as a CXL protocol error and it falls through to standard
> +AER recovery.
> +
> +RCH special case
> +================
> +
> +When the consumer sees is_cxl_restricted(pdev), it calls
> +cxl_handle_rdport_errors() first to process the RCH Downstream
> +Port's RAS registers (accessed via RCRB, not standard config space).
> +It then continues to process the RCD Endpoint's own RAS registers
> +via the common path.  Both register blocks are checked because
> +errors can appear in either independently.
> +
> +cxl_handle_rdport_errors() acquires the port lock internally.
> +Callers must not hold it.
> +
> +
> +Trace events
> +============
> +
> +Two trace events cover all device types and both the native AER and
> +CPER/GHES firmware-first paths:
> +
> +* cxl_aer_correctable_error
> +* cxl_aer_uncorrectable_error
> +
> +Fields:
> +
> +* ``memdev`` - memdev name for Endpoints; empty for non-Endpoints.
> +* ``port`` - CXL port device name.
> +* ``dport`` - Downstream Port device name; empty when not applicable.
> +* ``host`` - parent host bridge or uport device name.
> +* ``serial`` - PCI Device Serial Number from pdev->dsn (cached at
> +  enumeration; no config-space read in the error path).
> +
> +
> +Interrupt masking
> +=================
> +
> +CXL Internal Error bits (PCI_ERR_UNC_INTN and PCI_ERR_COR_INTERNAL)
> +are unmasked in the AER capability only after the CXL RAS register
> +block is successfully mapped.  A devm teardown action restores the
> +mask when the port or dport is removed, ensuring clean state after
> +driver removal.
> +
> +
> +Source files
> +============
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - File
> +     - Role
> +   * - drivers/pci/pcie/aer.c
> +     - AER core; IRQ, dispatch
> +   * - drivers/pci/pcie/aer_cxl_vh.c
> +     - VH producer; kfifo
> +   * - drivers/pci/pcie/aer_cxl_rch.c
> +     - RCH dispatch; RCEC walk
> +   * - drivers/cxl/core/ras.c
> +     - Consumer; CE/UE handlers; CPER
> +   * - drivers/cxl/core/ras_rch.c
> +     - RCH dport RAS handling
> +   * - drivers/acpi/apei/ghes.c
> +     - CPER/GHES kfifo producer

