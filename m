Return-Path: <SRS0=OdYA=3L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D22C32771
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 04:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956E121569
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 04:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVEu4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:50:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:12835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgAVEuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jan 2020 23:50:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 20:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="215781251"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 20:50:53 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200121141712.GA94911@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <48576108-c261-1bb8-cea9-db3b6782f383@linux.intel.com>
Date:   Wed, 22 Jan 2020 12:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121141712.GA94911@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 1/21/20 10:17 PM, Bjorn Helgaas wrote:
> [+cc linux-pci, thread athttps://lore.kernel.org/r/20200101052648.14295-1-baolu.lu@linux.intel.com]
> 
> On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
>> The new parameter takes a list of devices separated by a semicolon.
>> Each device specified will have its iommu_passthrough bit in struct
>> device set. This is very similar to the existing 'disable_acs_redir'
>> parameter.
> Almost all of this patchset is in drivers/iommu.  Should the parameter
> be "iommu ..." instead of "pci=iommu_passthrough=..."?
> 
> There is already an "iommu.passthrough=" argument.  Would this fit
> better there?  Since the iommu_passthrough bit is generic, it seems
> like you anticipate similar situations for non-PCI devices.
> 

Yes. Fair enough.

Best regards,
baolu
