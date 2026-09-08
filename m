Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FB5964F0;
	Tue,  8 Sep 2026 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892756; cv=none; b=BapyqamdRZvlqVXDIax3nOhLS7YomWl45IwZYyOUkByX0aSA/C6wepRwgJEqLpe0x5C4VQcFJHlsHGWVfjRobKxeApRH8f9jGV4vCQSTfJVxCvoXwNsqYojV75lPv5jh7COqYSbVz7Sl35mS7wQLqP6t38keT8au7A5JaJMi+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892756; c=relaxed/simple;
	bh=RXvS/DbLE/Z+LeWdSdrUOHcOobt/9vSEKzGA0NSWBwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfXIhSsZgk9UObeJeWvw5PctTSqY8db/Argz9ZzZDJ8aLwBTgqKGf5CdmQQw7BoeUDmjAdjb3jxEMNceFZuhdbvvIiZVV38vwsh8GPqsMrvUaLiSUHA6E5GDAFxOMp4BKapEfmOKfmtG0Oumm3rXee4IebocTDWspTMsYA0Gpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRTPFE3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRTPFE3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76041F00A3A;
	Tue,  8 Sep 2026 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892753;
	bh=8gYQri0gkSMtdqvPScp9bYWtriSeUO+1CUCy2d4eraU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bRTPFE3w1pEszfLI7CaHj5kIKU9NrVh6AYDD/KWHrJxO+v2Bv38/WhOG7qTkqdGhb
	 9I8XfjGrFh7Zs7jve8n1o3bsQUKrwkF/APHlzk+wUkhD1aEMqEBc7f6oenuGEln9zn
	 q+BSzIYJsHUn3TTcftrjW6rmF3iguPf/AysMd3JFUzUUoCiP1WPpbSP2bdktkHRYw7
	 U83FX8egqzlfyOhSijyQZArFGrp7pkCkM9s3kFESsrO99ei7UcpI3s90SGQ+dFtDCF
	 WoXgRQIdYmJ0O7AAVUrg0xz306+slCLs6JncFtcRt9S9/4gvh1pHAcky7w7Es+yWX6
	 aNVHKFJ0JmWmg==
Date: Tue, 8 Sep 2026 19:39:06 +0100
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
Subject: Re: [PATCH v20 9/9] Documentation: cxl: Document CXL protocol error
 handling
Message-ID: <20260908193906.093dd008@jic23-huawei>
In-Reply-To: <20260902133933.2992457-10-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-10-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:33 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
> 
> This documents the architecture introduced by the preceding patches in
> this series.
> 
> Assisted-by: Claude:claude-opus-4.8
Assited-by: LLM
for all of these (kernel documentation was recently changed on this).
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>


...

> diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> new file mode 100644
> index 0000000000000..1da71d0409a05
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> @@ -0,0 +1,441 @@
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
> +   |  aer_irq() -> aer_isr()              |
> +   |  -> find_source_device()             |
> +   |  -> handle_error_source(dev, info)   |
> +   +--------------------------------------+
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | handle_error_source() dispatch       |
> +   |                                      |
> +   |  1. cxl_rch_handle_error()           |
> +   |     [always; filters internally.     |
> +   |      RC_END enters the kfifo here    |
> +   |      via pcie_walk_rcec(), NOT via   |
> +   |      is_cxl_error() below]           |
> +   |                                      |
> +   |  2. if is_cxl_error():               |
> +   |       cxl_forward_error()            |
> +   |       [enqueue to kfifo; EP/RP/USP/  |
> +   |        DSP only, RC_END excluded]    |
> +   |                                      |
> +   |  3. if cxl_pending && non-CE:        |
> +   |       cxl_proto_err_wait_for_empty() |
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

Why so narrow. Seems like bits of this diag would be more readable if
you use the whole 80 chars?


> +
> +.. code-block:: text
> +
> +   Fatal UCE on Endpoint (VH Endpoint or RCD; link down, no AER status)
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | PCIe core error recovery             |
> +   |  pcie_do_recovery()                  |
> +   |  -> report_error_detected()          |
> +   |  -> cxl_pci_error_detected()         |
> +   |     [pci_error_handlers callback in  |
> +   |      cxl_core/ras.c; the RAS handler,|
> +   |      NOT the AER kfifo path]         |
> +   +--------------------------------------+
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | cxl_pci_error_detected()             |
> +   |                                      |
> +   |  if is_cxl_restricted(pdev):         |
> +   |    cxl_handle_rdport_errors()        |
> +   |    [RCD-only: RCH Dport RAS first]   |
> +   |                                      |
> +   |  if port->dev.driver == NULL:        |
> +   |    return DISCONNECT [port unbound]  |
> +   |                                      |
> +   |  cxl_handle_ras(port, NULL,          |
> +   |                 to_ras_base(...),    |
> +   |                 pdev->dsn)           |
> +   |    [EP RAS read, independent of      |
> +   |     channel state (not skipped for   |
> +   |     io_normal); dead link            |
> +   |     readl()==0xFFFFFFFF sets all UE  |
> +   |     bits -> panic]                   |
> +   |                                      |
> +   |  if ue: panic("CXL cachemem error")  |
> +   |                                      |
> +   |  else switch (channel state):        |
> +   |    io_normal      -> CAN_RECOVER     |
> +   |    io_frozen      -> release driver, |
> +   |                      NEED_RESET      |
> +   |    perm_failure   -> DISCONNECT      |
> +   +--------------------------------------+

Similar.  I have a new favourite irritation - overly narrow LLM (I guess)
generated diagrams!



> +.. code-block:: text
> +
> +   Platform firmware CPER record (CPER_SEC_CXL_PROT_ERR)
> +            |
> +            v
> +   +----------------------+
> +   | GHES/APEI (ghes.c)   |
> +   |  ghes_do_proc()      |
> +   |  cxl_cper_post_      |
> +   |    prot_err()        |
> +   |  kfifo_put(CPER-CXL) |
> +   |  schedule_work()     |
> +   +----------------------+
Ouch. Definitely wider here too to avoid splitting those function names.

> +            |
> +            v
> +   +----------------------+
> +   | CPER-CXL kfifo       |
> +   | + work_struct        |
> +   +----------------------+
> +            |
> +            v
> +   +----------------------+
> +   | cxl_cper_prot_err_   |
> +   |   work_fn() consumer |
> +   | (cxl_core/ras.c)     |
> +   |  drain kfifo ->      |
> +   +----------------------+
> +            |
> +            v
> +   +--------------------------------+
> +   | cxl_cper_handle_prot_err()     |
> +   |  pci_get_domain_bus_and_slot() |
> +   |  find_cxl_port_by_dev()        |
> +   |  cxl_find_dport_by_dev()       |
> +   |                                |
> +   |  if CE: trace correctable      |
> +   |  else:  trace uncorrectable    |
> +   |  [trace-only; no panic,        |
> +   |   no cxl_do_recovery()]        |
> +   +--------------------------------+

> +Severity policy
> +===============

> +**Fatal UCE on EP/USP** - A fatal event brings the link down, so the AER
> +core reads no AER status and is_cxl_error() cannot enqueue the event to the
> +kfifo. Endpoints and RCDs are instead handled through the
> +pci_error_handlers .error_detected callback (cxl_pci_error_detected()),
> +which reads the CXL RAS registers when they are mapped and panics on any UE
> +bit. If the RAS registers are unmapped the read is skipped without a panic,
> +because this path has no prior confirmation that the error is CXL internal.
> +Upstream Ports bound to portdrv fall back to standard AER recovery - a known
> +limitation. See "Fatal UCE flow for Endpoints and RCDs" above for the full
> +path and channel-state handling.

This 'known limitation' language kind of implies there is a solution. I'm curious,
do you have one in mind?  I can sort of see maybe that the class of UCE that leaves
CXL.io up is larger than that for PCIe so maybe it would be worth logic to probe
the device and see if we can get to it's registers?  Anyhow, job for another day.


This looks good to me and even the diag things is just a 'make it prettier' so
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
