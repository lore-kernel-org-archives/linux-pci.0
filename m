Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4683B583A;
	Mon, 20 Jul 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589173; cv=none; b=Yk3VRBY81V1+ZysA8eSpTCleyr6kT9onZDugELt9iQks2hvP+nCCvas2U1u0eMGxPxCdn44C8X3lzktCJ+urZbnMkvyhwmUEOagrydddPtS/PHW6hrPeii6G18bEC2V3G8M8rmzRnAjV1gqi9E4+5W263V4lBnev8GsrhmtTlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589173; c=relaxed/simple;
	bh=w1nuaSrfDbaTMXsQ5dhnwSbJXZtQ0N5GKXabTuDHKC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhWn4g/pc0h8+adlcimYP3857ala8g+2jI1RxmASPi1cKcbzOrZYigvMWVTlKXJ/CiZbOkSCshlqVyedEMpYrc2e5G3loEPSsqfLnYWXeGL4rlqR0B/I/k+mMiWwhkHRmPd0KSxFeO8Z6KHhtAJHjkRRLScGw2n/UGq2Fm4fCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4YLLEPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4YLLEPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A061F000E9;
	Mon, 20 Jul 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589171;
	bh=HJodb/MUa0/2fzgcr0wdUYzVVN1f52BWBDtc7+OJ2ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G4YLLEPuA0iYilz7rpjGkTucZ5H9/6mwEO66Ls21BCum485HBWiy+B9HpMh8k3cmE
	 nK2LLQiyPstIfR8X518Gi8gKrABRPwR4tmmI4c6XHEGvwJaWeUvismbjdjJQ5jQcuz
	 a7uCoteF4YZBCh0rI12DiGzRccpLWdu9ew601GrsXxsgytSCx6/PfaVubRdXl8NJDY
	 yP3Etmvu6lf183J7jeJdE1NRXhCF/ZnwU5msYJ87tlSa+uCevbodtk96bgReXkoCut
	 r5nKD4yyjtRT9l5s5BrgektFc0XfLo877tnb1BuLrYwpQBHp/ivSznO0jx2ZKbMmMS
	 icdvXXEdxLOKA==
Date: Tue, 21 Jul 2026 00:12:43 +0100
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
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
Message-ID: <20260721001243.54ad7716@jic23-huawei>
In-Reply-To: <20260717222706.3540281-8-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Restricted CXL Host (RCH) error handling is a separate path from the
> new CXL Port error handling flow. Fold RCH error handling into the
> Port flow so both share a common entry point.
> 
> Update cxl_rch_handle_error_iter() to forward RCH protocol errors
> through the AER-CXL kfifo. Change cxl_rch_handle_error() return type
> from void to bool so handle_error_source() can determine whether work
> was enqueued and call cxl_proto_err_flush() before AER recovery
> proceeds.
> 
> For RC_END devices, __cxl_proto_err_work_fn() calls

Can we refer to these as RCiEPs to match the spec? I have no idea
where RC_END naming came from but to me it isn't obviously that same
thing. Or talk about the narrow case of RCDs here as well.

> cxl_handle_rdport_errors() to process RCH Downstream Port errors,
> then falls through to the VH path for RC_END Endpoint handling.
> 
> An RCD uncorrectable CXL RAS error now panics via cxl_do_recovery().
> Before this patch the RCH Downstream Port UCE path called
> cxl_handle_ras() but ignored its return value - no panic. After this
> patch the same condition calls cxl_do_recovery() which panics on
> confirmed UCE. The Endpoint UCE path already panicked at the parent
> commit. This matches the panic policy added in the common CXL Port
> protocol error flow.
> 
> Remove cxl_cor_error_detected() and its .cor_error_detected
> registration in cxl_error_handlers. Correctable Endpoint errors are
> now routed through the AER-CXL kfifo like all other CXL protocol
> errors.
> 
> Drop the cxlds->rcd / cxl_handle_rdport_errors(cxlds) branches from
> cxl_error_detected(). RCH downstream port error handling is now
> performed by __cxl_proto_err_work_fn() via the kfifo path, which
> calls cxl_handle_rdport_errors(pdev) before the common dispatch.
> 
> Change cxl_handle_rdport_errors() to take a struct pci_dev * instead
> of a struct cxl_dev_state *, matching the new caller context. Re-fetch
> dport under guard() to close the TOCTOU window between
> cxl_pci_find_port()'s lockless xa_load() and the first dereference of
> the returned pointer.
> 
> Change find_cxl_port_by_dev() RC_END lookup from
> find_cxl_port_by_dport(dev->parent) to find_cxl_port_by_uport(dev),
> matching the Endpoint lookup path. RC_END Endpoint port resolution
> uses the uport (the RC_END device itself), while the separate RCH
> Downstream Port lookup is handled by cxl_handle_rdport_errors().
> 
> The RCH Downstream Port and the RCD Endpoint (RC_END) are separate
> devices with independent RAS register blocks. cxl_handle_rdport_errors()
> handles the RCH Downstream Port RAS. RCD Endpoint (RC_END) is handled in
> cxl_handle_proto_error().
> 
> Use to_ras_base() in cxl_handle_rdport_errors() instead of referencing
> dport->regs.ras directly. Make to_ras_base() non-static in ras.c and
> declare it in core.h so ras_rch.c can access it. Route all RAS base address lookups
> through a single helper to prepare for CXL RAS error injection testing
> that follows this series.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
Other than taking another look at the patch description and seeing
if it can be more concise, this one looks fine to me.

Jonathan
