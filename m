Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5296ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F03205F4
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F03205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJSTvn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:51:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:57828 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbeJSTvm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 15:51:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 04:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,399,1534834800"; 
   d="scan'208";a="267061100"
Received: from mylly.fi.intel.com (HELO [10.237.72.72]) ([10.237.72.72])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2018 04:45:54 -0700
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181018212513.GM5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <a7d488d6-0700-0666-8b59-d416f6b43df0@linux.intel.com>
Date:   Fri, 19 Oct 2018 14:45:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018212513.GM5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/19/2018 12:25 AM, Bjorn Helgaas wrote:
> On Thu, Oct 18, 2018 at 03:30:38PM +0300, Jarkko Nikula wrote:
>> Allow PCI core to do runtime PM to devices without needing to use dummy
>> runtime PM callback functions if there is no need to do anything device
>> specific beyond PCI device power state management.
>>
>> Implement this by letting core to change device power state during
>> runtime PM transitions even if no callback functions are defined.
>>
>> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: <stable@vger.kernel.org>
> 
> I applied this with Rafael's reviewed-by to pci/misc for v4.20,
> thanks!
> 
> But I dropped the stable tag because if I understand correctly, the
> point of this is to avoid the need for SIMPLE_DEV_PM_OPS() in drivers
> that don't need to do anything for PM.
> 
> That's worthwhile, but it's not transparently obvious that it would
> qualify for a stable backport based on this:
> 
>    https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst
> 
> If there's an argument for adding a stable tag, I'll add it , but that
> justification should be explicit in the changelog.
> 
No disagreement here. I was thinking a second or two before sending the 
patch may I Cc or not the stable. I went adding it since this actually 
fixes a PM regression on i2c-i801 after v4.18. SMBus PCI device doesn't 
go to D3 and
/sys/bus/pci/devices/[0000:00:1f.3 etc]/power/runtime_status
shows "error" when runtime PM framework attempts to autosuspend the device.

But given that most of the platforms I have seen don't implement the PM 
capabilities for SMBus PCI device, a few do implement though, and we 
haven't got any regression reports either so this is not very fatal IMHO.

I definitely don't want to see massive regression from different PCI 
systems either. Queueing for v4.20 sounds reasonable and we can ask to 
cherry-pick the commit into v4.18 and v4.19 stable kernels if nothing 
fatal shows up.

-- 
Jarkko
