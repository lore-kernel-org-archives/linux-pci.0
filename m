Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D3EC27C7A
	for <linux-pci@archiver.kernel.org>; Wed, 16 Aug 2023 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbjHPWiZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbjHPWiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:38:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90091BEE;
        Wed, 16 Aug 2023 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692225480; x=1723761480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=euq9NdibtHtzWMvCS7PtlIjI7UY3aAeGSiEMvUmh9t0=;
  b=XjXjjMvEB9tNyDqPa9Y9e/ZzyWQOOn7EDawp+hCA4F5GBvT/os17Dmu3
   x8fghdk5wNsaKTk+OaYU+LAyJ0He6mm9O2UAsNRdJwdoJ1vxWJk5kyb4P
   lrATH9JLAEHWHL2N2P+2gNAy+vUn3jKBVuHQ+sCKO+7yCU9jJdqVHyeIY
   PBEmvOm5+CREHS3Yhk+tEtfPa1RoDZGdXIjB1+mavax6YxX0JMFAgcmFT
   hyOz5T9WRkgR2yi2XcoEdLDaXxo5KUQmGypusgBJFWwbgWBB34JF4yg8l
   w4Rp9BHQ6rOA94PrPasnNoE+fvSUwRqVNvPN9nOFAWzrTtD/kNG5j0mCr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375422515"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="375422515"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 15:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908163198"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="908163198"
Received: from gokunbor-mobl1.amr.corp.intel.com (HELO [10.255.229.16]) ([10.255.229.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 15:38:00 -0700
Message-ID: <e4a15547-0a84-429e-8047-f0ea7b1ad38d@linux.intel.com>
Date:   Wed, 16 Aug 2023 15:38:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
 <20230816204143.66281-3-mario.limonciello@amd.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230816204143.66281-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 1:41 PM, Mario Limonciello wrote:
> The #ifdef currently is guarded against CONFIG_X86, but these are
> actually sleep related functions so they should be tied to
> CONFIG_SUSPEND.

Explain why #ifdef and functions you are talking about clearly in the 
commit log?

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v11->v12:
>   * change to CONFIG_SUSPEND
> v9->v10:
>   * split from other patches
> ---
>   include/linux/acpi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0d5277b7c6323..f1552c04a2856 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>   
>   acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>   					   u32 val_a, u32 val_b);
> -#ifdef CONFIG_X86
> +#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
>   struct acpi_s2idle_dev_ops {
>   	struct list_head list_node;
>   	void (*prepare)(void);
> @@ -1109,7 +1109,7 @@ struct acpi_s2idle_dev_ops {
>   };
>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>   void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> -#endif /* CONFIG_X86 */
> +#endif /* CONFIG_SUSPEND && CONFIG_X86 */
>   #ifndef CONFIG_IA64
>   void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>   #else
