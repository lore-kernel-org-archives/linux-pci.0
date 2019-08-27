Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B99C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB8214DA
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfH0RJm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:09:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:34341 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0RJm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 13:09:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 10:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="380107312"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2019 10:09:41 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 0F06E580409;
        Tue, 27 Aug 2019 10:09:41 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
References: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <bddfd223-fa9b-dd7c-6997-b9bc568ef2b0@linux.intel.com>
Date:   Tue, 27 Aug 2019 10:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/27/19 8:18 AM, Andy Shevchenko wrote:
> This simplifies and standardizes slot manipulation code
> by using for_each_set_bit() library function.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pcie/aer.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..f883f81d759a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -15,6 +15,7 @@
>   #define pr_fmt(fmt) "AER: " fmt
>   #define dev_fmt pr_fmt
>   
> +#include <linux/bitops.h>
>   #include <linux/cper.h>
>   #include <linux/pci.h>
>   #include <linux/pci-acpi.h>
> @@ -657,7 +658,8 @@ const struct attribute_group aer_stats_attr_group = {
>   static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   				   struct aer_err_info *info)
>   {
> -	int status, i, max = -1;
> +	unsigned long status = info->status & ~info->mask;
> +	int i, max = -1;
>   	u64 *counter = NULL;
>   	struct aer_stats *aer_stats = pdev->aer_stats;
>   
> @@ -682,10 +684,8 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   		break;
>   	}
>   
> -	status = (info->status & ~info->mask);
> -	for (i = 0; i < max; i++)
> -		if (status & (1 << i))
> -			counter[i]++;
> +	for_each_set_bit(i, &status, max)
> +		counter[i]++;
>   }
>   
>   static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
> @@ -717,14 +717,11 @@ static void __print_tlp_header(struct pci_dev *dev,
>   static void __aer_print_error(struct pci_dev *dev,
>   			      struct aer_err_info *info)
>   {
> -	int i, status;
> +	unsigned long status = info->status & ~info->mask;
>   	const char *errmsg = NULL;
> -	status = (info->status & ~info->mask);
> -
> -	for (i = 0; i < 32; i++) {
> -		if (!(status & (1 << i)))
> -			continue;
> +	int i;
>   
> +	for_each_set_bit(i, &status, 32) {
>   		if (info->severity == AER_CORRECTABLE)
>   			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
>   				aer_correctable_error_string[i] : NULL;

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

