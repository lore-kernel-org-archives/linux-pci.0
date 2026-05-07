Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B64534AC;
	Thu,  7 May 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177331; cv=none; b=MSBbPgFIJzJRXnwSFzlQrhdUXQGGsvtHPbvkyJzMGhEnlHlhrmaOiVO2SiRwvwvPLoRz+uQIqjqSV4mukK4cBwGxpeMVSBEPW+zSyYRoE2ptMlHu8Nd3jc/mTBW7aM6mr0YjjlugpSi2ItFGcnPAsnxQCJCdR4J1aXA3reve1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177331; c=relaxed/simple;
	bh=UsDR5qi5bqk2X9YkW3TzvwcnSyAyyGEZbjSHDw1G98U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVCu8DiUo1769vKsg/6bBG+UOQGVSiVUAElFpBNwAcEMT+8+iEj2B73Ju+dU3AcsxEqGrMnlG0nI8yLs/e3gVLiwZ/1Nz2sMadnmda0SlpGf8sbLcGyhq9i5RI8B/X67RjzfgIVeAnBJ9DbydXK++rN57npqoeW9Z3JeFzFAhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx1oTv3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx1oTv3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF6C2BCB2;
	Thu,  7 May 2026 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778177330;
	bh=UsDR5qi5bqk2X9YkW3TzvwcnSyAyyGEZbjSHDw1G98U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yx1oTv3gPz/fefXxL08tGjK2871zFbV1PkN1h51ha3YC9p3GTdPOQNEu8iYICHruI
	 l6cQmc/bzSt4Rz0m6+296qQRg202CazP9R+Zhj+PXs/xoPIKhZC5pzpMUAEMQDrk6A
	 9o1al2JdgJCi1MycbBqzNtsp0JBMzXvShy9ml1oYk8P9juBIj1Yeox9EqgUT+NVYwF
	 /MNdNw1kj5t35YxPavh3kToP7BHmR/lb/SyAOMdba8EII4BrXeYEyGmjuco7uu8/9S
	 wFsWxsFeMMu44TuKxv822e6gQY2HKzcE9VaiiJHIJuYSw2M4D25m5tsiKzPJG41Qas
	 vT2L5IBU/cenw==
Date: Thu, 7 May 2026 19:08:36 +0100
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
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Message-ID: <20260507190836.70197e24@jic23-huawei>
In-Reply-To: <20260505173029.2718246-3-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:30:20 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>

+CC Mauro - rasdaemon related - see below.

> 
> CXL protocol error logging uses two parallel sets of trace events. The
> cxl_port_aer_correctable_error() and cxl_port_aer_uncorrectable_error()
> events are used by CPER for CXL Port devices. The cxl_aer_correctable_error()
> and cxl_aer_uncorrectable_error() events are used for CXL Endpoints. Update
> the trace routines to use the latter for all CXL devices on both the CPER
> and native AER paths.
> 
> Generalize cxl_aer_correctable_error()/cxl_aer_uncorrectable_error to
> take a struct device * and a u64 serial argument supplied by the caller.
> cxl_handle_ras() and cxl_handle_cor_ras() gain the new u64 serial parameter,
> sourced from pci_get_dsn().
> 
> The CPER path keeps its existing Port-vs-Endpoint dispatch and passes the
> new arguments to the unified trace events. The CPER path will be folded
> together in a following patch.
> 
> Remove the now-unused cxl_port_aer_correctable_error() and
> cxl_port_aer_uncorrectable_error().
> 
> **WARNING: ABI BREAK**
> Rename the trace event field "memdev" to "device" so all CXL device types
> (Ports and Endpoints) can be reported under a common field name. Note this
> is an ABI break for userspace tools that key off the old "memdev" field.
> Specifically, rasdaemon's ras-cxl-handler.c looks up "memdev" and bails on
> NULL, so an unmodified rasdaemon will drop every CXL CE/UCE event once this
> kernel ships. A rasdaemon update is needed in a separate series.
> 
> The need for the field rename was discussed in v16 review [1].

This concerns me (sorry I wasn't paying attention to the v16 thread).
It is a userspace regression against code that is out in the wild and typically
not updated in sync with the kernel.

If you are suggesting breaking ras-daemon at the very least +CC the maintainer.

To get to a unified tracepoint add a new one that does what you want, but
maintain the existing ones as well.  Userspace can then migrate and maybe
in 5+ years time we can delete the non unified ones.

No actually comments on the code, just left it all here for Mauro,

Thanks,

Jonathan

> 
> Also, for CXL Upstream Switch Port (USP) and Endpoint (EP) fatal UCE,
> the cxl_aer_uncorrectable_error trace event is not emitted. The AER core
> only retrieves PCI_ERR_UNCOR_STATUS for Root Ports, RCECs, and Downstream
> Ports, or for non-fatal severities. PCI config reads to the source device
> are expected to fail otherwise, so the AER core never reads the status
> word, is_cxl_error() does not classify the event as CXL, and the AER path
> handles it instead. In this case the AER handler consumes the event and
> logs it as an AER error without calling the CXL RAS handlers or trace
> logging.
> 
> Before this patch, Endpoint and Port devices emitted different events:
> 
>   # Endpoint (cxl_aer_*):
>   cxl_aer_correctable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'
>   cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
> 
>   # Port (cxl_port_aer_*, no serial field):
>   cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='CRC Threshold Hit'
>   cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
> 
> After this patch, all CXL devices emit the unified cxl_aer_* events
> with the same field layout:
> 
>   cxl_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'CRC Threshold Hit'
>   cxl_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
> 
> [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> 
> ---
> 
> Changes in v16->v17:
> - Replace cxlds->serial with pci_get_dsn()
> - Change 'memdev' to 'device' (Dan)
> - Updated Commit message
> 
> Changes in v15->v16:
> - Add Dan's review-by
> - Incorporate Dan's comment into commit message:
> "Add the serial number at the end to preserve compatibility with
> libtraceevent parsing of the parameters."
> 
> Changes in v14->v15:
> - Update commit message.
> - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> 
> Changes in v12->v13:
> - Added Dave Jiang's review-by
> 
> Changes in v11 -> v12:
> - Correct parameters to call trace_cxl_aer_correctable_error()
> - Add reviewed-by for Jonathan and Shiju
> 
> Changes in v10->v11:
> - Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
> and unchanged TP_printk() logging.
> ---
>  drivers/cxl/core/core.h    | 11 ++++--
>  drivers/cxl/core/ras.c     | 39 +++++++++++--------
>  drivers/cxl/core/ras_rch.c |  6 ++-
>  drivers/cxl/core/trace.h   | 76 ++++++++------------------------------
>  4 files changed, 49 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 82ca3a476708..132ac9c1ebf4 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -183,8 +183,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> +bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct device *dev, u64 serial,
> +			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> @@ -195,11 +196,13 @@ static inline int cxl_ras_init(void)
>  	return 0;
>  }
>  static inline void cxl_ras_exit(void) { }
> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static inline bool cxl_handle_ras(struct device *dev, u64 serial,
> +				  void __iomem *ras_base)
>  {
>  	return false;
>  }
> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
> +static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
> +				      void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..d7081caaf5d3 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>  
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +	trace_cxl_aer_correctable_error(&pdev->dev, status, pci_get_dsn(pdev));
>  }
>  
>  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> @@ -28,20 +28,24 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  	else
>  		fe = status;
>  
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
> +					  ras_cap.header_log,
> +					  pci_get_dsn(pdev));
>  }
>  
> -static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> +static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +					 struct cxl_memdev *cxlmd,
>  					 struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>  
> -	trace_cxl_aer_correctable_error(cxlmd, status);
> +	trace_cxl_aer_correctable_error(&cxlmd->dev, status,
> +					pci_get_dsn(pdev));
>  }
>  
>  static void
> -cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> +cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> +			       struct cxl_memdev *cxlmd,
>  			       struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> @@ -53,8 +57,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
> -					  ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
> +					  ras_cap.header_log,
> +					  pci_get_dsn(pdev));
>  }
>  
>  static int match_memdev_by_parent(struct device *dev, const void *uport)
> @@ -101,9 +106,9 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  
>  	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  
> @@ -183,7 +188,7 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -195,7 +200,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		trace_cxl_aer_correctable_error(dev, status, serial);
>  	}
>  }
>  
> @@ -220,7 +225,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -247,7 +252,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -270,7 +275,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +				   cxlmd->endpoint->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -299,7 +305,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		ue = cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +				    cxlmd->endpoint->regs.ras);
>  	}
>  
>  	switch (state) {
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b6388..61835fbafc0f 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -115,7 +115,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +				   dport->regs.ras);
>  	else
> -		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +			       dport->regs.ras);
>  }
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a972e4ef1936..6f3957b3c3af 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,49 +48,22 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> +TRACE_EVENT(cxl_aer_uncorrectable_error,
> +	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl,
> +		 u64 serial),
> +	TP_ARGS(dev, status, fe, hl, serial),
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
>  		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -		__entry->first_error = fe;
> -		/*
> -		 * Embed the 512B headerlog data for user app retrieval and
> -		 * parsing, but no need to print this in the trace buffer.
> -		 */
> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> -	),
> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> -	)
> -);
> -
> -TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(cxlmd, status, fe, hl),
> -	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>  	),
>  	TP_fast_assign(
> -		__assign_str(memdev);
> +		__assign_str(device);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		 */
>  		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("device=%s host=%s serial=%lld status: '%s' first_error: '%s'",
> +		  __get_str(device), __get_str(host), __entry->serial,
>  		  show_uc_errs(__entry->status),
>  		  show_uc_errs(__entry->first_error)
>  	)
> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  
> -TRACE_EVENT(cxl_port_aer_correctable_error,
> -	TP_PROTO(struct device *dev, u32 status),
> -	TP_ARGS(dev, status),
> +TRACE_EVENT(cxl_aer_correctable_error,
> +	TP_PROTO(const struct device *dev, u32 status, u64 serial),
> +	TP_ARGS(dev, status, serial),
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
>  		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -	),
> -	TP_printk("device=%s host=%s status='%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_ce_errs(__entry->status)
> -	)
> -);
> -
> -TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> -	TP_ARGS(cxlmd, status),
> -	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(memdev);
> +		__assign_str(device);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("device=%s host=%s serial=%lld status: '%s'",
> +		  __get_str(device), __get_str(host), __entry->serial,
>  		  show_ce_errs(__entry->status)
>  	)
>  );

