Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBCC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE602087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfDOStw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:49:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:18020 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbfDOSrG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 11:47:05 -0700
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="134570653"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.94]) ([10.254.202.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 15 Apr 2019 11:47:04 -0700
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com>
 <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
 <20190411182938.GB14495@ziepe.ca>
 <A503C24F5B2FB844864C0DD400A8F742121C859F@ORSMSX108.amr.corp.intel.com>
 <20190412135544.GB3765@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <ef74c759-a5ac-c497-0e82-345ddf3c9255@intel.com>
Date:   Mon, 15 Apr 2019 14:47:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412135544.GB3765@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/12/2019 9:55 AM, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2019 at 08:37:53PM +0000, Arumugam, Kamenee wrote:
> 
>> On Thu, Apr 11, 2019 at 06:22:45PM +0000, Arumugam, Kamenee wrote:
>>
>>> This is a device bug then.
>>
>>> A RDMA device must accept and respond to all TLPs that the CPU could create for the user accessible BAR pages.
>>
>>> A user process must not be able to crash the CPU or make the device malfunction by accessing the exposed BAR page. This includes a broad range of topics, like mis-aligned acceses, SSE instructions, atomics, >etc.
>>
>>> Is blocking AER even enough here? If the device isn't generating a reasonable reply I have a bad feeling worse will happen.
>>
>> After blocking unsupported request error, we don't see any other issue including no system hang.
> 
> Are you specifically testing all the special TLPs the CPU can produce?

All the special TLPs should have been tested. This however seems to be a 
missed test case. Not that surprising though given differences in BIOS 
and things of that nature that something falls through the cracks and is 
extra hard to find.

-Denny

