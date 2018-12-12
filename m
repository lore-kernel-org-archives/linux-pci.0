Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570CC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34762208E7
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34762208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeLLLmd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:42:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:45265 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeLLLmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 06:42:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 03:42:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="125216997"
Received: from mylly.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2018 03:42:30 -0800
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Stable <stable@vger.kernel.org>
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
 <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
Date:   Wed, 12 Dec 2018 13:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 10/25/18 4:57 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
>> runtime PM") nullified the runtime PM suspend/resume callback pointers
>> while keeping the runtime PM enabled.
>>
>> This causes that SMBus PCI device stays in D0 power state and sysfs
>> /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
>> when the runtime PM framework attempts to autosuspend the device. This
>> is due PCI bus runtime PM which checks for driver runtime PM callbacks
>> and returns with -ENOSYS if they are not set.
>>
>> Since i2c-i801.c don't need to do anything device specific beyond PCI
>> device power state management Jean Delvare proposed if this can be fixed
>> in the PCI subsystem core level rather than adding dummy runtime PM
>> callback functions in the PCI drivers.
>>
>> Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
>> that they allow change the PCI device power state during runtime PM
>> transitions even if no runtime PM callback functions are defined.
>>
>> This change fixes the runtime PM regression on i2c-i801.c.
>>
>> It is not obvious why the code had hard requirements for the runtime PM
>> callbacks. Test has been here since the code was introduced by the
>> commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>>
>> On the other hand similar change than this was done to generic runtime
>> PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
>> generic runtime pm callbacks").
>>
>> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
>> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # 4.18+
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
I guess this patch with Reviewed-by tags from Rafael and Jean got buried 
under other list traffic as I don't find this from pci.git or linux-next?

-- 
Jarkko
