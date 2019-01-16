Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4CEC43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 09:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D4620840
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 09:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfAPJhs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:37:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:30317 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391688AbfAPJhs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jan 2019 04:37:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 01:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="115060200"
Received: from mylly.fi.intel.com (HELO [10.237.72.89]) ([10.237.72.89])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2019 01:37:46 -0800
Subject: Re: [PATCH] PCI: fix using __initdata memory after free in
 disable_acs_redir parameter
To:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190115173203.14850-1-logang@deltatee.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <48a93172-25a2-d6a6-e908-7d27249f1bc2@linux.intel.com>
Date:   Wed, 16 Jan 2019 11:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115173203.14850-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 1/15/19 7:32 PM, Logan Gunthorpe wrote:
> The disable_acs_redir parameter stores a pointer to the string passed to
> pci_setup(). However, the string passed to PCI setup is actually a
> temporary copy allocated in static __initdata memory. After init, once
> the memory is freed, it is no longer valid to reference this pointer.
> 
> This bug was noticed in v5.0-rc1 after a change in commit c5eb1190074c
> ("PCI / PM: Allow runtime PM without callback functions") caused
> pci_disable_acs_redir() to be called during shutdown which manifested
> as an unable to handle kernel paging request at:
> 
> RIP: 0010:pci_enable_acs+0x3f/0x1e0
> Call Trace:
>     pci_restore_state.part.44+0x159/0x3c0
>     pci_restore_standard_config+0x33/0x40
>     pci_pm_runtime_resume+0x2b/0xd0
>     ? pci_restore_standard_config+0x40/0x40
>     __rpm_callback+0xbc/0x1b0
>     rpm_callback+0x1f/0x70
>     ? pci_restore_standard_config+0x40/0x40
>      rpm_resume+0x4f9/0x710
>     ? pci_conf1_read+0xb6/0xf0
>     ? pci_conf1_write+0xb2/0xe0
>     __pm_runtime_resume+0x47/0x70
>     pci_device_shutdown+0x1e/0x60

So this doesn't happen if you revert c5eb1190074c?

I guess this is due dev->state_saved being true set by 
pci_pm_runtime_suspend() -> pci_save_state() after my patch and now 
pci_pm_runtime_resume() -> pci_restore_standard_config() -> 
pci_restore_state() reach the pci_enable_acs(). I think this is possible 
to trigger also before my patch if device has the runtime PM callback 
defined?

> It was also likely possible to trigger this bug when hotplugging PCI
> devices.
> 
> To fix this, instead of storing a pointer, we use kstrdup to copy the
> disable_acs_redir_param to its own buffer which will never be freed.
> 
I wasn't able to trigger this but I saw
"PCI: Can't parse disable_acs_redir parameter: " followed by a few lines 
of junk during boot when I defined pci=disable_acs_redir=0000:00:xy.z 
which disappear after your patch.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
