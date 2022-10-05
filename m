Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6AC433FE
	for <linux-pci@archiver.kernel.org>; Wed,  5 Oct 2022 03:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJEDcT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Oct 2022 23:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJEDbh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 23:31:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F173930;
        Tue,  4 Oct 2022 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664940492; x=1696476492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WCn4GBdjSdnAuPtFp2F+wnD5+iW9JUK9fNm6LNCDZ5I=;
  b=OmWvzmi6alDHpEGghd0L/dHJWahYqQVc+TxVMz7uDDbn5A8iDaACdqPa
   6g1xSvihaeQF93W15wkFlsPptoF7w1zdJtLdckxVkFCwup+Bt/cmC83rA
   Kihh7TrDNeCyNyedEq12h1m1WPok9pF8Ca3OYGwtrQRLuxu9cHOSgRslw
   mLYmn9qRyn96JHNeRab1stVlJ+swg7cu9NjAdFP26Fz5u130mGXlGp1sS
   2SgaeJ0lwy/dROEDzHGFWU3KCjb1ApP73fLx4M1dqI5RGsQfEGLPwDp8y
   MKpUsOMS/WWy68xBsrcBlubgjswpXOhWquXkHeNr0MrO5FbkwLdgzYwDi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282791461"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="282791461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 20:28:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="686821321"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="686821321"
Received: from tphilli1-mobl.amr.corp.intel.com (HELO [10.209.113.68]) ([10.209.113.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 20:28:08 -0700
Message-ID: <ca836507-50ca-13bc-ef88-7f69b1333c99@linux.intel.com>
Date:   Tue, 4 Oct 2022 20:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] PCI/ASPM: Fix L1SS issues
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20221005025809.2247547-1-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221005025809.2247547-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/4/22 7:58 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is really late, but I think we have two significant issues with L1SS:
> 
>   1) pcie_aspm_cap_init() reads from the L1SS capability even when it
>   doesn't exist, so it reads PCI_COMMAND and PCI_STATUS instead and treats
>   those as an L1SS Capability value.
> 
>   2) encode_l12_threshold() encodes LTR_L1.2_THRESHOLD as smaller than
>   requested, so ports may enter L1.2 when they should not.
> 
> These patches are intended to fix both issues.

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Bjorn Helgaas (3):
>   PCI/ASPM: Factor out L1 PM Substates configuration
>   PCI/ASPM: Ignore L1 PM Substates if device lacks capability
>   PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation
> 
>  drivers/pci/pcie/aspm.c | 155 +++++++++++++++++++++++-----------------
>  1 file changed, 90 insertions(+), 65 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
