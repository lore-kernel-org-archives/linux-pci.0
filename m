Return-Path: <SRS0=Y6al=NC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FFC67863
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 06:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7C20779
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 06:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A7C20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJVOVN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:21:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:29682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJVOVN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Oct 2018 10:21:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2018 23:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,410,1534834800"; 
   d="scan'208";a="90214819"
Received: from mylly.fi.intel.com (HELO [10.237.72.72]) ([10.237.72.72])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2018 23:04:06 -0700
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
To:     Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.de>
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181019152105.0325a663@endymion>
 <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <895fc530-c345-a419-b234-646423e98d83@linux.intel.com>
Date:   Mon, 22 Oct 2018 09:04:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/2018 07:19 PM, Bjorn Helgaas wrote:
> On Fri, Oct 19, 2018 at 03:21:05PM +0200, Jean Delvare wrote:
>> Later in this function, pm is dereferenced again. It happens twice in
>> the "if (error)" condition where it is currently safe (error can't be
>> non-zero if pm->runtime_suspend() has not been called, and obviously
>> pm->runtime_suspend() can't have been called if pm was NULL). However
>> it also happens later without the condition:
>>
>> 	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
>> 	    && pci_dev->current_state != PCI_UNKNOWN) {
>> 		WARN_ONCE(pci_dev->current_state != prev,
>> 			"PCI PM: State of device not saved by %pF\n",
>> 			pm->runtime_suspend);
>> 		return 0;
>> 	}
>>
>> I am no expert of the PM framework but is there no risk to dereference
>> NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
>> be NULL, leading to a confusing warning message?
>>
Thanks for spotting this! I don't have any excuse why I was so 
completely blind.

>> More generally, I would feel better if instead of initializing error to
>> 0, we would move under the "if (pm && pm->runtime_suspend)" condition
>> everything that must not be run if pm->runtime_suspend is not defined.
>> That would make the possible code flows a lot clearer.
> 
> I agree, this isn't good.  Even if it's safe (and I don't think that
> second spot is safe), it's too hard to analyze.  I'm going to drop
> this for now.
> 
Thanks. I'll cook a better version.

-- 
Jarkko
