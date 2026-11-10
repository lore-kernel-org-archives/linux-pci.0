Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794321048;
	b=4kK/q3EY0SrPtDPaMbrZ0Kp5wNfhEuRcfMq5xORdSpMnkLxIELYgyp6YcfV2Z+yOpzHe
	 ZWyLirjcT4tBlSfr/MMMI1Fxff3ik30nq4eAkPmmLVwgjVET/7ZOhDG73f9xYmQxjbSV7
	 BVIuNpf2LL00Z1swedsu9wlybjYy/OHBiEFoHWYIC+GN4UQWOn96QSu5kvKcy270LnYcm
	 50fNZzaxFSGTOYTEirbTD6GCOR2M6FFd2eL845e7cKWHP+8HG8alYQ4rdB+Z7RAKWd5JO
	 94/PdVFF/oS7Y15uIitypKNTvXm37IMejXLM2N/BMqn4YbySust7o3PcpBn4ls+UB2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321048;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Uz3VQehd1ZO63zGzNf2pR7KZcKqmtRJlfsRiVXSrTt8=;
	b=gsiv7SHiPVBofv9V8DEYvC4EX5R1QozovsVrDxdzNemUd1BmT9fB6r2bvVdQVNkRZAsl
	 hR6XxEzkPnRMLH6cT24GR9YJK1mfqCQSv32RwrdAvRakcInvDphzZ/sedtSaPmW+/nVAi
	 dhqpMU4VjplL3dISMPzGSrrAgqnGTufs6UFV1txxKgFDrhjcEj8+Mg3oVxD6qKLn6kJj6
	 5jeUe5ricrY242Sj2Z+8gv18pUxakR7DHYVRkArD3OWwxojk94DNGkMBvltWyT/xoWwNZ
	 LAqDn5oam49HOQCTABCdNjtrqoPexp8wsT8FrTT5EqlTpsLOitNjSF2q0OLWUiWsARg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b="eK4KBa/i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67416606A334;
	Tue, 10 Nov 2026 14:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67416606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=eK4KBa/i
ARC-Seal: i=1; a=rsa-sha256; t=1794320990; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKnNEjVw8C3OyDG1l/YQIqFxBNBFCIgpDzKBFz2un/PdCKesy/c4CPA+XZHS+IiE9W5dh7BIe/XvNpI2oFYf53xXdkFpSov2ZGbB7g/GJT47T6DF06WnR5K3zYffBmfRFTzYcACkgYT1dSlM0CDpNj4S1JV0aAlZo2OUygJi6zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794320990; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uz3VQehd1ZO63zGzNf2pR7KZcKqmtRJlfsRiVXSrTt8=; 
	b=EJlopRIvPcgdOddz8srvfCbLveUW4h/huQeyRGH8jlodthrjb0e7mC/UWrGTbeOVQFFnNpG55p9fxDPVsjgkmCESEnX263xAfW5NbUb8LdkLp8xkpb7ubGh5ttzUsKGK9ZB6ffKLfN/5ezaGzDYWr5HWPSF7iWA4NKUwEoDhZs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=eK4KBa/iauSPX/nv2TVYReezT7FWcggkCddjkTE6acRx9KedKykkQMpkzmWSslM+jGGf/0GEhGriXleJ9Iq6ZvxkiFRtuA5fYK8b+7Tocs6NnMRcL7z+d2W7tULIA/QKTHnvtcE9Gii00Zh02A0ShEAycGqJo7DroDFGG6S41zQ=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=Uz3VQehd1ZO63zGzNf2pR7KZcKqmtRJlfsRiVXSrTt8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794320989675255.06119992728588;
	Tue, 10 Nov 2026 06:29:49 -0800 (PST)
Message-ID: <568d7c66-eb67-4369-8b15-5ee923471881@zohomail.com>
Date: Tue, 10 Nov 2026 22:29:36 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/19] PCI/CXL: Add CXL Device Reset sequencing
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-13-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261105185917.2667656-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112275078c8cd6af39e4f48d52aae00009eb5ad88169d258afe3326155aeda86fdec19a50683e8bdc99:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/6 02:59, Srirangan Madhavan 写道:
> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Wait for the timeout the device
> advertises, up to 100 seconds, and access only Status2 until reset
> completion, error or expiry, as CXL 4.0 section 9.7.3 requires. Control2
> cleanup runs only afterwards. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>
> ---
> Changes in v17:
> - Wait for the reset timeout the device advertises, up to 100 seconds,
>    instead of clamping it to 20 seconds, so that Control2 is not accessed
>    while the device may still be resetting. The warning for an unknown
>    timeout encoding now reports the timeout used (Richard)
>    https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/
>
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
> ---
>   drivers/pci/cxl.c             | 244 +++++++++++++++++++++++++++++++++-
>   drivers/pci/pci.h             |   5 +
>   include/uapi/linux/pci_regs.h |  12 ++
>   3 files changed, 260 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index a0d20f4210a5..9ac5948f595b 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -3,13 +3,17 @@
>   /*
>    * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
>    * memory device at enumeration, so it can be restored after a reset without
> - * a CXL driver. HDM register formats and programming live in drivers/cxl.
> + * a CXL driver, and implement CXL Device Reset. HDM register formats and
> + * programming live in drivers/cxl.
>    */
>   #include <linux/bitfield.h>
>   #include <linux/cleanup.h>
> +#include <linux/delay.h>
>   #include <linux/errno.h>
>   #include <linux/io.h>
>   #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> @@ -223,3 +227,241 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>   {
>   	cxl_hdm_cache_release(&pdev->hdm);
>   }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error. Wait for the full advertised timeout
> + * so that Control2 is not accessed while the device may still be resetting.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +/*
> + * CXL 4.0 section 9.6 permits using the device cache size to determine
> + * a timeout. Use a conservative fixed estimate of 100 ms.
> + */
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec,
> +				  u16 set, u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl2))
> +		return -ENODEV;
> +
> +	/*
> +	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
> +	 * that remains set in the value read back while updating persistent
> +	 * Control2 state.
> +	 */
> +	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> +	ctrl2 &= ~clear;
> +	ctrl2 |= set;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		return rc;
> +
> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	while (time_before(jiffies, deadline)) {
> +		usleep_range(CXL_CACHE_WBI_POLL_US,
> +			     CXL_CACHE_WBI_POLL_US * 2);
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (PCI_POSSIBLE_ERROR(status2))
> +			return -ENODEV;
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;
> +	}
> +
> +	pci_warn(pdev, "timed out waiting for CXL cache writeback and invalidate\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return rc;
> +
> +	return cxl_reset_wait_cache_wbi(pdev, dvsec);
> +}
> +
> +static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
> +					  u16 saved_ctrl2)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc)
> +		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding; using %u ms\n",
> +			 cxl_reset_timeout_ms[idx]);
> +	}
> +
> +	/* Allow one retry after the mandatory 100 ms quiet period. */
> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS);
> +	pci_info(pdev, "CXL reset timeout: %u ms\n", timeout_ms);
This log is improper, “CXL reset timeout:” seems like the timeout 
happens, but it just outputs the timeout value before starting waiting 
for CXL reset done. How about something like "Waiting for CXL reset to 
complete. (max wait: %u ms)\n"?
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);
> +
> +	for (;;) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (status2 != U16_MAX) {
> +			if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +				return -EIO;
> +			if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +				return 0;
> +		}
> +
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
How about outputing a pci_err() when timeout happens? Like what you did 
in cxl_reset_await_cache_wbi().
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	}
> +}
> +
> +static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
> +{
> +	if (initiate)
> +		return cxl_reset_update_ctrl2(pdev, dvsec,
> +					      PCI_DVSEC_CXL_INIT_CXL_RST |
> +					      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
> +					      0);
> +
> +	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +}
> +
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	if (!pci_wait_for_pending_transaction(pdev)) {
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_clear_memory(pdev, dvsec, true);
> +	if (!rc)
> +		rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
> +	rc2 = cxl_clear_memory(pdev, dvsec, false);
> +	if (rc2)
> +		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
> +	rc = rc ?: rc2;
> +
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	u16 saved_ctrl2;
> +	int rc, rc2;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +		return -ENODEV;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (!rc)
> +		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +	/* Restore cache policy after any attempt to disable caching. */
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	return rc ?: rc2;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	u16 dvsec, cap, ctrl;
> +	int rc;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -ENODEV;
There are many instances where we use pci_read_config_word() together 
with PCI_POSSIBLE_ERROR(). Would it make sense to introduce a helper to 
wrap pci_read_config_word() and its PCI_POSSIBLE_ERROR() error handling?
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9e218f236e66..743e65abd758 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -733,9 +733,14 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>   #ifdef CONFIG_CXL_RESET
>   void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>   void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>   #else
>   static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
>   static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>   #endif
>   
>   #ifdef CONFIG_PCI_NPEM
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ca3e77b72d87..7224857c7b30 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,10 +1352,22 @@
>   #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
>   #define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
>   #define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>   #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
