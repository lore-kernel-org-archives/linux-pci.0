Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB76C67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB81420849
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB81420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLMAcb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:32:31 -0500
Received: from ale.deltatee.com ([207.54.116.67]:52088 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbeLMAca (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 19:32:30 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gXEvU-0002Rv-5d; Wed, 12 Dec 2018 17:32:29 -0700
To:     Jon Mason <jdmason@kudzu.us>
Cc:     wesley.sheng@microchip.com,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
 <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com>
 <f22b6112-920b-37f1-68fe-f43164a18f05@deltatee.com>
 <CAPoiz9xesBdtgVg1UGF8LuD28tjMp6VpVuHVjdwcWJq93Phi3w@mail.gmail.com>
 <ff7019a0-bac2-2de2-d06c-d54a82286b90@deltatee.com>
 <CAPoiz9wB4d6bL9=C9uQWrkeo8PwdXoWN0ridoEyiC1yHAg32Eg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <391d02f2-b986-83ca-00ae-103fe22de0ef@deltatee.com>
Date:   Wed, 12 Dec 2018 17:32:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wB4d6bL9=C9uQWrkeo8PwdXoWN0ridoEyiC1yHAg32Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com, jdmason@kudzu.us
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory
 windows
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-12 5:25 p.m., Jon Mason wrote:
> On Wed, Dec 12, 2018 at 7:01 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2018-12-12 4:57 p.m., Jon Mason wrote:
>>> On Wed, Dec 12, 2018 at 6:42 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2018-12-12 4:00 p.m., Jon Mason wrote:
>>>>> So, you based your patches on a series of patches not in the
>>>>> ntb/ntb-next branch?  Please don't do this.  I see nothing in these
>>>>> patches which requires that series, which makes this even more
>>>>> unnecessary.  Since these are fairly trivial, I'm taking them and
>>>>> pushing to the ntb-next branch to give these more time to be tested
>>>>> (due to not being tested on the proper branch).  I would really
>>>>> appreciate you testing the ntb-next branch as a sanity check.
>>>>
>>>> The NTB test tools don't work with switchtec hardware without that patch
>>>> set, so there's no way to test the changes without that branch.
>>>
>>> Then let's get those patches in.  IIRC, I asked you to split up the
>>> patch series to be bugfixes and features (or at least reorder the
>>> series so I can split it up that way in my branches).  Also, I think
>>> Serge had some comments that may/may not need to be addressed.  Could
>>> you please reorder and resend (and Serge can comment as needed on the
>>> resend)?
>>
>> I resent a while back and responded to all the feedback. Every patch in
>> that series fixes a bug. None of them add features.
> 
> Per https://lkml.org/lkml/2018/6/12/552, I asked the series be split
> up and the comments to be cleaned-up.  You repushed without addressing
> this (or Serge's comments), which caused me to ignore the series.
> Again, I'm happy to take it as a single series and split it up on my
> end, I just need the patches reordered to have the bugfixes I
> specified in the front to allow for this to be easily done.

And what was not clear about my response?

https://lkml.org/lkml/2018/6/12/577

That commit is absolutely *not* a feature request. Without it, none of
the other fixes will fix anything and are thus worse than useless.

I responded to Serge's comments and then responded *again* in the cover
letter of v2. What he was asking for was, and still is, physically
impossible.

Logan
