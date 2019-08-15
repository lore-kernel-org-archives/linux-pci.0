Return-Path: <SRS0=qLqV=WL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C7C3A589
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152D20644
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565907423;
	bh=zYyZFhq7O1M4F4sAgDEOwatL2jcGmbzUeMrh99SI3e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwIXmx18qj18wGQFvqWNLoiWdenRhHpEWOZBBNf6C0GpCvLOpAtZOrzE3zQUAAztu
	 JEwWjr3as2Qhw5eH0wp+tyC7wpCX0cYaHRv5RAxtvZ0Y4cStJ+AZBtTiIZT1u+nGFw
	 NV77Fyn8ERxs5fXspxTV5rgRnsjkY0Pp8b6tbnlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfHOWRC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfHOWRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 18:17:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ED720644;
        Thu, 15 Aug 2019 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565907422;
        bh=zYyZFhq7O1M4F4sAgDEOwatL2jcGmbzUeMrh99SI3e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2okHcZFs3On2MHtpWAXrm/Q1WZIAWnceofWfnCK0OM9qshMVcNVXr7wgEZQqnIeqk
         Q76yDHkTiJYWOAHbcvv81U9/DZzDjFqT40mpugwc4Va2Xsj2DB/jJwh9UmKaRlD5NT
         kavIHd62Q8FNZVtmetqI7gsyyjoBXZ9PuTJGXv3s=
Date:   Thu, 15 Aug 2019 17:16:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v6 1/9] PCI/ERR: Update error status after reset_link()
Message-ID: <20190815221629.GI253360@google.com>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <6be594215ae2ea0935d949537bfb84ff9e656a36.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be594215ae2ea0935d949537bfb84ff9e656a36.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:43:11PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> reset_link() to recover from fatal errors. But, if the reset is
> successful there is no need to continue the rest of the error recovery
> checks. Also, during fatal error recovery, if the initial value of error
> status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> even after successful recovery (using reset_link()) pcie_do_recovery()
> will report the recovery result as failure. So update the status of
> error after reset_link().
> 
> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 773197a12568..aecec124a829 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -204,9 +204,13 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
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
> +		else
> +			goto done;

This will be easier to read without the negation, i.e.,

                if (status == PCI_ERS_RESULT_RECOVERED)
                        goto done;
                else
                        goto failed;

> +	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
> @@ -228,6 +232,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
> +done:
>  	pci_dbg(dev, "broadcast resume message\n");
>  	pci_walk_bus(bus, report_resume, &status);
>  
> -- 
> 2.21.0
> 
