Return-Path: <SRS0=hcWO=4O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D2AC4BA12
	for <linux-pci@archiver.kernel.org>; Wed, 26 Feb 2020 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9872468C
	for <linux-pci@archiver.kernel.org>; Wed, 26 Feb 2020 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582724514;
	bh=CFivbeDC16Vex/a/sIDrC01sS730JjaXfcD6K0v8Wec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=qeqIOPvMl6r/H5s2L4HIPPuMI3HDVldjB7UZzZaSzMdc+/UJyEOVbQs84ZRhoqBM1
	 LLWQZcEHlhvMgRMoL8Y+1Eh3H7IRI/JkU8I4liH8RGKqT0ZiZwnG1uKA/Z01CxFt9r
	 WhaPgn6X2a3PQN6SPc92n2KVfBiWE9SrFWYtJ2O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBZNlx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgBZNlx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:53 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D032467B;
        Wed, 26 Feb 2020 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582724512;
        bh=CFivbeDC16Vex/a/sIDrC01sS730JjaXfcD6K0v8Wec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fFrddYuvYg+1YT7T+dVwZ5UWKuydmMFGUlDj1oLCTimb8qXu1FRNmcfWH4zJcSdFd
         cqeMfc7ZO2NxqKda+HhZNTcaOGD+x7UCgEBfEi3Ecmo51pgC7xJxJVt5utXiyFCCM8
         trGCq5EEzNA5JJZ5Sg/fAuyHaJD6U321+5YovRzs=
Date:   Wed, 26 Feb 2020 07:41:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v15 1/5] PCI/ERR: Update error status after reset_link()
Message-ID: <20200226134150.GA107992@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6c0ed2b56935187a58659d089e51ffc91a03fe.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 10:20:13AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> reset_link() to recover from fatal errors. But during fatal error
> recovery, if the initial value of error status is
> PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> even after successful recovery (using reset_link()) pcie_do_recovery()
> will report the recovery result as failure. So update the status of
> error after reset_link().
> 
> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>

I raised the possibility of a stable tag for this.  If you'd like
that, please add the tag and some justification per
Documentation/process/stable-kernel-rules.rst.

A kernel.org bugzilla pointer to show the user-visible effect of this,
e.g., "lspci -vv" and a dmesg log showing an error that should be
recoverable but isn't, would be a good start.  That would actually be
useful even if you don't want a stable tag.

> ---
>  drivers/pci/pcie/err.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 01dfc8bb7ca0..eefefe03857a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -208,9 +208,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	else
>  		pci_walk_bus(bus, report_normal_detected, &status);
>  
> -	if (state == pci_channel_io_frozen &&
> -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> -		goto failed;
> +	if (state == pci_channel_io_frozen) {
> +		status = reset_link(dev, service);
> +		if (status != PCI_ERS_RESULT_RECOVERED)
> +			goto failed;
> +	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
> -- 
> 2.21.0
> 
