Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E251429D;
	Tue,  8 Sep 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828711; cv=none; b=GvuM/7GVAcX06y3CCXRh5cguV5VGj1lXSdfvoiXIlaoFBuzpoUmQR1eOqidlyq5hsWtzXmp1iy3P8ITrBEG4F/wHtTcdeUjVk6uLg6lTqrp6hCW3/dFDJcdepPtHiFuvyJdFpbU8gM6QojN4Xg45oNwtdNIJxFsg9UNaZvtLOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828711; c=relaxed/simple;
	bh=7ApgOXS7+Zc62TeYh/05EG4TAA8IiFgxmmXi2Gv0UiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sN3c9gEZ+KHGA5CLu4a3oJ5f2FN6Ehrw3BUwN8Ru+T1l42YX0M8Re0QL5QKHdtV+1fRpLCoJiu5zz3sl2VpApZp/0b2gWg8Xv+OVrUzp2YcN/rIL6XElF3+ZxqlsW/BDgT8tm8kBRnr1MPviFfKemH6bXYKud7+pjBfPD7p3do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwGYGMz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwGYGMz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671F11F00A3A;
	Tue,  8 Sep 2026 00:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828710;
	bh=vlSM9I+RRl9gXEOFgqKrbkaOZdEoPx1m6vVEOqLY5Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HwGYGMz6SbXwE/i05mqw9jutk5YGBRI2zTDNa7oDm3g6M4J53dpG6qJS4kq4vAyvM
	 zwHq+6+XHmdtTKOr3lK8jI5vAGMAWeW81ydBEULaOevAf+bzfM/rbyHQgIBdIwS4X9
	 ApXHf921HpKQEfXusMRhjMWPW81NjxkpGRtaOZvNqB7fzJmmCFL5H0JT3Kf0k1sHHg
	 PQtNhqhkb/QMoYioAGI5jDARYRFDo+tOTPdZ/ehiNEhd6o0JALX1+Qx2/j5WB8uRl/
	 hNPToP86LifPhQYT0esr6IFrB2Z88jtrBcnerNlhQejx2HGxSyqqBYo3LR9o/wXPJI
	 5T5P+nqe2UAFw==
Date: Tue, 8 Sep 2026 01:51:44 +0100
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
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
Message-ID: <20260908015144.62ee9c1c@jic23-huawei>
In-Reply-To: <20260902133933.2992457-2-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
	<20260902133933.2992457-2-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 08:39:25 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL VH RAS handling requires the AER driver to hand off CXL protocol
> errors to cxl_core for logging and recovery before PCIe AER recovery
> tears down the device. Introduce pci/pcie/aer_cxl_vh.c to implement
> this handoff via a kfifo-backed work item.
> 
> The producer, cxl_forward_error(), is gated by is_cxl_error() and
> enqueues the error source PCI device and severity. cxl_core registers a
> consumer via cxl_register_proto_err_work(); the consumer drains the
> kfifo with for_each_cxl_proto_err(). For uncorrectable errors,
> cxl_proto_err_wait_for_empty() lets the AER path block until the CXL
> plane has finished so recovery does not race device teardown.

Do we need most of this last paragraph?
Maybe the bit about letting AER block but the rest smells like implementation
details to me with no info on 'why' or anything unexpected.
> 
> A rwsem serializes registration, deregistration, enqueue, and dequeue
> against concurrent AER IRQ threads; a spinlock serializes concurrent
> kfifo writers. is_aer_internal_error() moves into this file and now
> evaluates info->status & ~info->mask rather than the raw info->status,
> so a masked internal-error bit is treated as not-set. For the RCH RCEC
> path this is equivalent because cxl_rch_enable_rcec() first calls
> pci_aer_unmask_internal_errors(), which clears those mask bits in
> hardware before the AER status is read back.
> 
> A subsequent patch wires cxl_forward_error() into handle_error_source().
> 
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
> entry.

I couldn't immediately find any discussion about switching away from panic
on a kfifo overflow.  Was there a reply to an earlier version with a
discussion of that?  I'm not against the change but a 'why' 
here would be good to have.

> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
One trivial thing inline to add to Ben's nits.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> +/**
> + * Callback for processing a CXL protocol error from the AER-CXL kfifo.
> + */
> +typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
> +
> +void cxl_register_proto_err_work(struct work_struct *work,
> +				void (*flush)(void));

Align to after the ( Looks to be 1 space short. If this is a local
style thing ignore me ;)

> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn);
> +void cxl_unregister_proto_err_work(void);
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

