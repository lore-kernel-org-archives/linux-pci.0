Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD337AA63;
	Sat,  9 May 2026 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778298561; cv=none; b=F5/4fvO9piaXTjywoFBJ3GGTijr33JIanIV5t9A+4k1m5ksTIzx+Y+KSZmh5clC+Ob24ZB2Y0eLqFoo/lieKFt8EpbyAUfkoS0YaazztjsqLEnjdsK3fovuN9XzKJWP54yiq5PO1+On5ELIb25JmL6uS7aCE5lz82WtGH0uuoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778298561; c=relaxed/simple;
	bh=AjbX2/PuJjVkTJXhV0OHUmvecqEZOKJQGxfINAzjECs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CeYK1chWRCRtGkbpDwa1V0Gs7Nn1VH5QdtNTE7A9FP3vGGeZqG3H03geQyWP3GhJQcW7dhsFEaIQkC43fLTrMWrSE4xaZo916dvHtc5HN4vQPXxJz50sUHtI8XcqksDfPiHJYOxIc+pUEjUu09EidcVsJCAxDW8NL0pH2fdmaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAGMGVdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAGMGVdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB59C2BCC4;
	Sat,  9 May 2026 03:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778298561;
	bh=AjbX2/PuJjVkTJXhV0OHUmvecqEZOKJQGxfINAzjECs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uAGMGVdJpeo2DVc9ZdIfqD3HewoTBgjuZxyEOpftEU4lcm+MmDWyzGc7q+rAUxQxW
	 A9xQYpG/PibsHOvB9wubPgWl+eR6qT4dLilOAcXFkwOlyrOFGNTUei5RCQovscmPP+
	 1vn4gl4Iq9otD6R/NgQm5+t9vMeUKWDbZSYgtN2si4FlYpZBiGBy+Aw0fjngMbV5yz
	 tm58EFatJKGO4+S7QyjLrQwOdDh9Q3GxRzLiHVdwczUbjBOVERSM3+4AcYBnxut/4W
	 rkA21Wrdf/uZuWquDD/e35aSw8IgQNFVFpOsqjI+oaMIZB4NccfHEWjf2wgy9Vr1C1
	 edI3kT5q0CYlA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0F57FF40081;
	Fri,  8 May 2026 23:49:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 08 May 2026 23:49:19 -0400
X-ME-Sender: <xms:vq7-aQ4_xvATOb1WMTDcHkp7RP6K3e-kOEUgp1toRM6LtBrzZai2Gg>
    <xme:vq7-abjwQmIuY2mbo0Jc94K0i2Ra90ZVLPPvs7qOWZw0g3TuJH2BEAK25qo5-P2d2
    IdqfCYv4STBDil3IdVZhBQq4kSJHFBZpcV8dlvSN3n07GPKtQCD7Ho>
X-ME-Received: <xmr:vq7-aS42y6DI2R2GZFTfkfj6s-0UXl0MXOigJ8uciBXfQBK4lHHCvbsLBoNtreP2WUP1Z1rvgAfMYFU-UlkBvW8FSF-ee7aeOxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedtkeelkefgtdegudeiiedttdfgueegieekjeffueffueet
    jeffkeevtefflefhheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleegtdegje
    dqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgtvdefse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtvghrrhihrdgsohifmhgrnhesrghmugdr
    tghomhdprhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvghtpdhrtghpthhtoh
    epuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghlihhsohhn
    rdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhrtghpthhtohepughjsgifsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepshhhihhjuhdrjhhoshgvsehhuhgrfigvihdrtghomhdprhgtphhtth
    hopehmihhnghdrlhhiseiiohhhohhmrghilhdrtghomh
X-ME-Proxy: <xmx:vq7-acBFo02_fLfFu834Ew_CWBormYOgwYwrdcrWu7zVsOSSYXNNng>
    <xmx:v67-afSQBYfb4eYJxFgVJS1zCBYVCi7Be_lJtvvgw4Hm7mOCqUbR6Q>
    <xmx:v67-aTYvf0pi_CHt8KFsja7M4ArCFxvp1kIqgg_8mq13hGagvP122w>
    <xmx:v67-aUVMc7ALQiL2NnpSL1vkV1MrGzLGB52_nj1B8586V-uOqCuGzw>
    <xmx:v67-aQVrv4zT3DqE58fljWuO-CN9wOH7oDngriJRNxa1aUhkLWkdxz9J>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 23:49:18 -0400 (EDT)
Date: Fri, 08 May 2026 20:49:17 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 djbw@kernel.org, 
 bhelgaas@google.com, 
 shiju.jose@huawei.com, 
 ming.li@zohomail.com, 
 Smita.KoralahalliChannabasappa@amd.com, 
 rrichter@amd.com, 
 dan.carpenter@linaro.org, 
 PradeepVineshReddy.Kodamati@amd.com, 
 lukas@wunner.de, 
 Benjamin.Cheatham@amd.com, 
 sathyanarayanan.kuppuswamy@linux.intel.com, 
 vishal.l.verma@intel.com, 
 alucerop@amd.com, 
 ira.weiny@intel.com, 
 corbet@lwn.net, 
 rafael@kernel.org, 
 xueshuai@linux.alibaba.com, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Message-ID: <69feaebd471c3_1b86a100b@djbw-dev.notmuch>
In-Reply-To: <20260508150533.04e19cf9@jic23-huawei>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-3-terry.bowman@amd.com>
 <20260507190836.70197e24@jic23-huawei>
 <8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
 <20260508150533.04e19cf9@jic23-huawei>
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Thu, 7 May 2026 13:33:45 -0500
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
[..]
> > > This concerns me (sorry I wasn't paying attention to the v16 thread).
> > > It is a userspace regression against code that is out in the wild and typically
> > > not updated in sync with the kernel.
> > > 
> > > If you are suggesting breaking ras-daemon at the very least +CC the maintainer.

Sorry, that was not the intent, see below.

> > > 
> > > To get to a unified tracepoint add a new one that does what you want, but
> > > maintain the existing ones as well.  Userspace can then migrate and maybe
> > > in 5+ years time we can delete the non unified ones.
> > > 
> > > No actually comments on the code, just left it all here for Mauro,
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > 
> > Dan was clear about using a single set of CE and UE handlers for all CXL RAS 
> > protocol errors. While I understand there may be concerns, please direct any 
> > objections to Dan and clarify what changes are required to avoid this 
> > repeatedly going back and forth.
> > 
> > [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/
> 
> Sure - Dan's on this thread so I'm sure he'll see it sooner or later.
> 
> Perhaps I'm missing something that makes this less critical than it appears.

No, it is breakage and a thinko on my part on the advice to Terry on the
backwards compatibility rules for tracepoints. At the time I was only
tracking data type and order of the payload. I.e. string at same
position. However, the name of the argument is ABI.

Something like this incremental fixup I think gets this back on track.
It keeps legacy ABI support for "memdev" field in the payload. It
incrementally lets updated userspace understand "port" and "dport"
events. It stops us from growing a new set of events just to update the
arguments. It enhances the CPER events to now handle switch ports in
addition to endpoint ports.

The bulk of the change is passing @port and @dport to the CXL trace
events instead of a plain @dev.

-- >8 --
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ff39985d363f..ed3a56966369 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -183,9 +183,10 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct device *dev, u64 serial,
-			void __iomem *ras_base);
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, u64 serial,
+		    void __iomem *ras_base);
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+			u64 serial, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 6f3957b3c3af..3857d2fc279d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -49,20 +49,24 @@
 )
 
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl,
-		 u64 serial),
-	TP_ARGS(dev, status, fe, hl, serial),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport, u32 status,
+		 u32 fe, u32 *hl, u64 serial),
+	TP_ARGS(port, dport, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
 	),
 	TP_fast_assign(
-		__assign_str(device);
+		__assign_str(memdev);
 		__assign_str(host);
+		__assign_str(port);
+		__assign_str(dport);
 		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
@@ -72,8 +76,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("device=%s host=%s serial=%lld status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld status: '%s' first_error: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -98,22 +103,27 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 )
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct device *dev, u32 status, u64 serial),
-	TP_ARGS(dev, status, serial),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport, u32 status, u64 serial),
+	TP_ARGS(port, dport, status, serial),
 	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
 	),
 	TP_fast_assign(
-		__assign_str(device);
+		__assign_str(memdev);
+		__assign_str(port);
+		__assign_str(dport);
 		__assign_str(host);
 		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("device=%s host=%s serial=%lld status: '%s'",
-		  __get_str(device), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld status: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..83e161d48405 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -101,6 +101,12 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
+/* trace-event helpers */
+const char *cxl_trace_memdev_name(struct cxl_port *port);
+const char *cxl_trace_host_name(struct cxl_port *port);
+const char *cxl_trace_port_name(struct cxl_port *port);
+const char *cxl_trace_dport_name(struct cxl_dport *dport);
+
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b45e2b539b5f..33e78f155916 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -8,16 +8,20 @@
 #include <cxlpci.h>
 #include "trace.h"
 
-static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, u64 serial,
-					 struct cxl_ras_capability_regs *ras_cap)
+static void
+cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+			     u64 serial,
+			     struct cxl_ras_capability_regs *ras_cap)
 {
 	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
 
-	trace_cxl_aer_correctable_error(&pdev->dev, status, serial);
+	trace_cxl_aer_correctable_error(port, dport, status, serial);
 }
 
-static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
-					   struct cxl_ras_capability_regs *ras_cap)
+static void
+cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+			       u64 serial,
+			       struct cxl_ras_capability_regs *ras_cap)
 {
 	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
 	u32 fe;
@@ -28,10 +32,12 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
 					  ras_cap->header_log, serial);
 }
 
+static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport);
+
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
@@ -40,19 +46,26 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	struct cxl_dport *dport;
 
 	if (!pdev)
 		return;
 
-	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver)
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port_by_dev(&pdev->dev, &dport);
+
+	if (!port)
+		return;
+
+	guard(device)(&port->dev);
+	if (!port->dev.driver)
 		return;
 
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(pdev, pci_get_dsn(pdev),
+		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
 					     &data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(pdev, pci_get_dsn(pdev),
+		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
 					       &data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
@@ -222,13 +235,12 @@ static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 
 static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct device *dev = &pdev->dev;
 	bool ue;
 
 	if (pci_dev_is_disconnected(pdev))
 		panic("CXL cachemem error: device disconnected during UE recovery");
 
-	ue = cxl_handle_ras(dev, pci_get_dsn(pdev),
+	ue = cxl_handle_ras(port, dport, pci_get_dsn(pdev),
 			    to_ras_base(port, dport));
 	if (ue)
 		panic("CXL cachemem error.");
@@ -238,7 +250,8 @@ static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct
 	pci_aer_clear_fatal_status(pdev);
 }
 
-void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+			u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -250,7 +263,7 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, status, serial);
+		trace_cxl_aer_correctable_error(port, dport, status, serial);
 	}
 }
 
@@ -275,7 +288,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, u64 serial,
+		    void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -302,7 +316,7 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -358,7 +372,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 		cxl_handle_rdport_errors(pdev);
 
 	if (severity == AER_CORRECTABLE) {
-		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
+		cxl_handle_cor_ras(port, dport, pci_get_dsn(pdev),
 				   to_ras_base(port, dport));
 		pcie_clear_device_status(pdev);
 	} else {
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index cbd02cabefbc..1bcd3c491aaa 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -113,9 +113,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
+		cxl_handle_cor_ras(port, dport, pci_get_dsn(pdev),
 				   dport->regs.ras);
 	else
-		cxl_handle_ras(&pdev->dev, pci_get_dsn(pdev),
-			       dport->regs.ras);
+		cxl_handle_ras(port, dport, pci_get_dsn(pdev), dport->regs.ras);
 }
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index 7f2a9dd0d0e3..df42d119c53d 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -2,7 +2,42 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include <cxl.h>
+#include <cxlmem.h>
 #include "core.h"
 
+const char *cxl_trace_memdev_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(&cxlmd->dev);
+	}
+
+	return "";
+}
+
+const char *cxl_trace_host_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(cxlmd->dev.parent);
+	}
+
+	return dev_name(port->uport_dev);
+}
+
+const char *cxl_trace_port_name(struct cxl_port *port)
+{
+	return dev_name(&port->dev);
+}
+
+const char *cxl_trace_dport_name(struct cxl_dport *dport)
+{
+	if (dport)
+		return dev_name(dport->dport_dev);
+	return "";
+}
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
