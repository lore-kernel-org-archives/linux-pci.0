Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74752C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5053E21855
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbfBKPqm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:46:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:45072 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730310AbfBKPqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 10:46:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 07:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="145910277"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 07:46:36 -0800
Date:   Mon, 11 Feb 2019 08:46:16 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, okaya@kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND] PCI/DPC: Fix print AER status in DPC event
 handling
Message-ID: <20190211154615.GB4525@localhost.localdomain>
References: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 03:02:59PM +0800, Dongdong Liu wrote:
> +static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> +					  struct aer_err_info *info)
> +{
> +	int pos = dev->aer_cap;
> +	u32 status, mask, sev;
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> +	status &= ~mask;
> +	if (!status)
> +		return 0;
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +	status &= sev;
> +	if (status)
> +		info->severity = AER_FATAL;
> +	else
> +		info->severity = AER_NONFATAL;
> +
> +	return 1;
> +}
> +

You can set info->severity to AER_FATAL since that's the only type we
enable DPC triggering.

>  static irqreturn_t dpc_handler(int irq, void *context)
>  {
>  	struct aer_err_info info;
> @@ -229,9 +251,12 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  	/* show RP PIO error detail information */
>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>  		dpc_process_rp_pio_error(dpc);
> -	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
> +	else if (reason == 0 &&
> +		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> +		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
>  		pci_cleanup_aer_uncorrect_error_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);

Good catch here, but let's clear the pending bits with a single call
to pci_cleanup_aer_error_status_regs() rather than NONFATAL and
FATAL separately.
