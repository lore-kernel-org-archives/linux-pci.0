Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793156533;
	b=inz+Tu97uu1wjkvIhMuA0Fu7gInDl56P8/l6mTg6XVH8YYIVA6GpK0DDaEPD8ez8xpqv
	 F19dLV7ld6XdweisrXlkHFUhSWkDE626MS4x0WeGJzeemdYvxf2mpIo0z7jgwwmAf0sbX
	 PuANRoI8MH8n9A8aN8g7msulyosxZkhh0AKt/IpvC06pRbQPZ0NPIvBfqpJKhRRV+odi4
	 rfxVrCUXDppk1DzHRi2zjPV7Sa30+APclvL4SwXBcBc4803sX86WfSSm6JamdfzQgQXu0
	 bgnWHcK7CPoRz4ODsVM1+Tw15ODPQPcTPrEPYr5msnaVw2ZcMYhWy/NphznxiU+OC4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156533;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=9Ep5ZGCOPzJgaBvSsiI45IrfOU+KwKtWoFJMmEot9dQ=;
	b=fDh9tuloc4lPdaH6CdNzYiYG7lJlSh2jclLDy0KU0W1HvjAVjXF1YAcCrn+8GQ+C0l64
	 888rL263gKjRGoDtVmhmxsiZ7ta0eiwwxV3YLcuY1rwyiSCypgrca0UCeE6dEbSrrKkj5
	 LrXBUn4eHkaY3tKY7ya3kRk3PFidvNViF608xUpvGQc5q0qgUI5d8bJ48agICZpVjytsx
	 peRHb30r+A12E8UYxqCVgvN+Q+6AHTHHEWsIdTwVSxl/nHgKF3wj60uqDm2o8fER2vMJm
	 XdGdOfmRyH7WkFfESgqMMU3yc78REqq5bRkrKkK5GzMw+6MeVmyH6GK7ypLJaI2ZuNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=OOgLrYoT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD454606A332;
	Wed, 28 Oct 2026 03:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD454606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=OOgLrYoT
ARC-Seal: i=1; a=rsa-sha256; t=1793156516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fw1D14/cmWDpP6r13f0uHiYP7HARa9MUrN5wX+ZNd3zImh5DeTT3HtXdnASPp0bxVw2E8IkKL+OK7dn//mYAS6NMSjnWdDl3qW7cZBzhoZEkvX7WPuZRu9aLEZmIbdcOh8Klc0eNnt4C6UZOo13llzrILjRR2jCbQyEhwFQc79I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793156516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Ep5ZGCOPzJgaBvSsiI45IrfOU+KwKtWoFJMmEot9dQ=; 
	b=VAJ2YtGJoT5xHdcCSqgxRwsgiT2aaFaLc0pv8pXjtM/qLwCXFeT9xmzuM6s2c4JWxyJG3C3J5QadKATuhrJRCY/1xB8nfEsSNUkCCTq7zbGPYIBNesYz5yi3cufruQ3zCaerQ+MA3arOP9AQ463/UUnMJ/ztctoNX8J7T5zZh7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793156516;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=9Ep5ZGCOPzJgaBvSsiI45IrfOU+KwKtWoFJMmEot9dQ=;
	b=OOgLrYoTmMOZ+jvln9uC6DiyUi/GaHmaO+a3d5PydbIrxImiBmuOUzYdQhVvmTOi
	MsKwt8EFdjNuCUuiGi40AoSwzU1RJMFrmRIkFzjCL6VW4T0b/5mgcu4PWnUojOaj3rD
	RMhvyvc0nchzFLIXQLP7eYr8ph1k/gHIXTNVD3n8=
Received: by smtp.zohomail.com with SMTPS id 1793156513768853.2509454165186;
	Tue, 27 Oct 2026 20:01:53 -0700 (PDT)
Message-ID: <37c6f2bc-53b3-4260-aa27-04f89c45e950@zohomail.com>
Date: Wed, 28 Oct 2026 11:01:46 +0800
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
Subject: Re: [PATCH v15 10/16] PCI/CXL: Add CXL Device Reset sequencing
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-11-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261011021422.3428136-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227f9a06f15f01b217c8f5af17a00005c66a3146a1dd455837ec18d79dfc7d3e9be92dd262450e365:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/11 10:14, Srirangan Madhavan 写道:
> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/pci/cxl.c             | 249 +++++++++++++++++++++++++++++++++-
>   drivers/pci/pci.h             |   5 +
>   include/uapi/linux/pci_regs.h |  14 ++
>   3 files changed, 267 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 471b57391593..9eb13adf0daa 100644
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
> @@ -221,3 +225,246 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>   {
>   	cxl_hdm_cache_release(&pdev->hdm);
>   }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +#define CXL_RESET_MAX_WAIT_MS 20000
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
Why is it 100000us? I think it is worth a comment.
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
> +					    u16 set, u16 clear)
If there is no a similiar function called cxl_reset_update_ctrl2(), I 
think that is better to use cxl_reset_update_ctrl2() as this function name.
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl2))
> +		return -ENODEV;

I think this PCI_POSSIBLE_ERROR() checking is not needed, in 
pci_bus_read_config_word() marco, if bus->ops->read() returns a error, 
then the function will use PCI_SET_ERROR_RESPONSE() then returning the 
errno. That means that we can always get an error as return value of 
pci_read_config_word() while ctrl2 is an error response.

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
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
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
Same as above
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;
> +	}
> +
> +	/* Do not miss completion concurrent with the polling deadline. */
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(status2))
> +		return -ENODEV;
> +	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +		return 0;
I think checking again after deadline is not needed, if it usually 
happens, it means we should adjust CXL_CACHE_WBI_TIMEOUT_US.
> +
> +	return -ETIMEDOUT;
It is better to output a warning before returning -ETIMEDOUT.
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
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
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
> +					      PCI_DVSEC_CXL_DISABLE_CACHING);
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
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, CXL_RESET_MAX_WAIT_MS);
> +		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +	}
> +
I noticed that the worst situation is that we have to wait cxl reset 
done for 100s. If my understanding is correct, userspace would hang on 
"echo 1 > reset" until reset done. Is it better to add a pci_info() here 
to output the reset timeout value?
> +	/* Allow one retry after the mandatory 100 ms quiet period. */
> +	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
> +			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
> +			     CXL_RESET_MAX_WAIT_MS);
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
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	}
> +}
> +
> +static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
> +{
> +	if (initiate)
> +		return cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +						      PCI_DVSEC_CXL_INIT_CXL_RST |
> +						      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
> +						      0);
> +
> +	return cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
> +					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
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
> index facaa324bd86..7224857c7b30 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,8 +1352,22 @@
>   #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
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
