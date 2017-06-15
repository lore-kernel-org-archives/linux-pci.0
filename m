Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:49618 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdFORCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2017 13:02:03 -0400
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
To: Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
From: Samuel Sieb <samuel@sieb.net>
Message-ID: <6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net>
Date: Thu, 15 Jun 2017 10:01:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170615140421.GB25710@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/15/2017 07:04 AM, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>>
>> ATS is broken on this hardware and causes IOMMU stalls and
>> system failure. Disable ATS on these devices to make them
>> usable again with IOMMU enabled.
>>
>> Note that the commit in the Fixes-tag is not buggy, it
>> just uncovers the problem in the hardware by increasing
>> the ATS-flush rate.
>>
>> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>>   drivers/pci/quirks.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
> 
> Any more objections on this patch? Please let me know if you want to
> have something changed.

The other patch seems to fix this issue without disabling ATS.  Isn't 
that better?
