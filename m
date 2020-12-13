Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF49C4361B
	for <linux-pci@archiver.kernel.org>; Sun, 13 Dec 2020 05:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA703230FF
	for <linux-pci@archiver.kernel.org>; Sun, 13 Dec 2020 05:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLMFLW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:11:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:48309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgLMFLV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Dec 2020 00:11:21 -0500
IronPort-SDR: rh7TJDJfqv00PM8ZyUZoA9i9TFFMIzelb+/rEY4DB8kKgx++sSfcYcbSK/ukoPa5HebaaHeaqg
 XyEsw9wHytDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="238690323"
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="238690323"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:09:34 -0800
IronPort-SDR: VULFeSzlvORzFoLgMzzy83Dkw5iWbIcQdw2eC8to6i6A4W1bakbFTJT8XWn/pQC/r0Q6N3i8Tc
 qj8Uhf0YayJw==
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="366436241"
Received: from ascinco-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.175.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:09:34 -0800
Subject: Re: [PATCH v8 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, knsathya@kernel.org
References: <b464e4c8b3022ce3e0c69e64456619fc86378c15.1603740826.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d12dd711-cdaf-0a79-8deb-e2381b79163b@linux.intel.com>
Date:   Sat, 12 Dec 2020 21:09:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b464e4c8b3022ce3e0c69e64456619fc86378c15.1603740826.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/20 12:37 PM, Kuppuswamy Sathyanarayanan wrote:
> Currently if report_error_detected() or report_mmio_enabled()
> functions requests PCI_ERS_RESULT_NEED_RESET, current
> pcie_do_recovery() implementation does not do the requested
> explicit device reset, but instead just calls the
> report_slot_reset() on all affected devices. Notifying about the
> reset via report_slot_reset() without doing the actual device
> reset is incorrect. So call pci_bus_reset() before triggering
> ->slot_reset() callback.
Gentle ping! Any comments on this patch set?
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>   Changes since v7:
>    * Rebased on top of v5.10-rc1.
> 
>   Changes since v6:
>    * None.
> 
>   Changes since v5:
>    * Added Ashok's Reviewed-by tag.
> 
>   Changes since v4:
>    * Added check for pci_reset_bus() return value.
> 
>   drivers/pci/pcie/err.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..315a4d559c4c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -152,6 +152,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
> +	int ret;
>   
>   	/*
>   	 * Error recovery runs on all subordinates of the first downstream port.
> @@ -181,11 +182,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	}
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
> +		ret = pci_reset_bus(dev);
> +		if (ret < 0) {
> +			pci_err(dev, "Failed to reset %d\n", ret);
> +			status = PCI_ERS_RESULT_DISCONNECT;
> +			goto failed;
> +		}
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(dev, "broadcast slot_reset message\n");
>   		pci_walk_bus(bus, report_slot_reset, &status);
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
