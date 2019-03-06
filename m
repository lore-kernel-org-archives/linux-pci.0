Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A27C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9E62064A
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfCFTL1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:11:27 -0500
Received: from ale.deltatee.com ([207.54.116.67]:41746 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfCFTL1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 14:11:27 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h1bwh-0002qW-Ui; Wed, 06 Mar 2019 12:11:17 -0700
To:     Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-8-logang@deltatee.com>
 <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
Date:   Wed, 6 Mar 2019 12:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, dave.jiang@intel.com, allenbh@gmail.com, joro@8bytes.org, bhelgaas@google.com, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 07/12] NTB: Introduce functions to calculate multi-port
 resource index
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-05 6:24 p.m., Serge Semin wrote:
>> + * In a 5 peer system, this function will return the following matrix
>> + *
>> + * pidx \ port    0    1    2    3    4
>> + * 0              0    0    1    2    3
>> + * 1              0    1    2    3    4
>> + * 2              0    1    2    3    4
>> + * 3              0    1    2    3    4
>> + *

Oh, first, oops: looks like I copied this down wrong anyway; the code
was what I had intended, but the documented example should have been:

pidx \ local_port     0    1    2    3    4
 0                    0    0    1    2    3
 1                    0    1    1    2    3
 2                    0    1    2    2    3
 3                    0    1    2    3    3

And this is definitely the correct table we are aiming for.
ntb_peer_resource_idx() is supposed to return the result of
ntb_peer_port_idx(ntb, local_port) when run on the peer specified by pidx.

Note: this table also makes sense because it only uses 4 resources for 5
ports which is the best case scenario. (In other words, to communicate
between N ports, N-1 resources are required on each peer).

> This table is too simplified to represent a generic case of port-index
> mapping table. In particular the IDT PCIe switch got it ports numbered
> with uneven integers like: 0 2 4 6 8 12 16 20 or 0 8 16, and so on.
> Moreover some of the ports might be disabled or may have NTB functions
> deactivated, in which case these ports shouldn't be considered by NTB subsystem
> at all. Basically we may have any increasing subset of that port
> numbers depending on the current IDT PCIe-switch ports setup.

Yes, I did not consider situations where there would be gaps in the
"port number" space. It wasn't at all clear from the code that this was
possible. Switchtec hardware could be configured for such an
arrangement, but I don't know why anyone would do that as it just
needlessly complicates everything.

As you point out, with a gap, we end up with something that is wrong:

pidx \ port     0    1    3    4    5
 0              0    0    2    3    4
 1              0    1    2    3    4
 2              0    1    3    3    4
 3              0    1    3    4    4

Here, the relationship between ntb_peer_resource_idx() and
ntb_peer_port_idx() is not maintained and it seems to prescribe 5
resources for 5 ports. If there were more gaps it would be even more wrong.

>> +static inline int ntb_peer_resource_idx(struct ntb_dev *ntb, int pidx)
>> +{
>> +	int local_port, peer_port;
>> +
>> +	if (pidx >= ntb_peer_port_count(ntb))
>> +		return -EINVAL;
>> +
>> +	local_port = ntb_port_number(ntb);
>> +	peer_port = ntb_peer_port_number(ntb, pidx);
>> +
>> +	if (peer_port < local_port)
>> +		return local_port - 1;
>> +	else
>> +		return local_port;
>> +}
>> +
> 
> Instead of redefining the port-index table we can just fix the
> ntb_peer_resource_idx() method, so it would return a global port index
> instead of some number based on the port number. It can be done just by
> the next modification:
> 
> +     if (peer_port <= local_port)
> +             return pidx;
> +     else
> +             return pidx + 1;
> 

This creates a table that looks like:

pidx \ port     0    1    2    3    4
 0              1    0    0    0    0
 1              2    2    1    1    1
 2              3    3    3    2    2
 3              4    4    4    4    3

Which is not correct. In fact, it seems to require 5 resources for 5
ports. This appears to be what is done in the current ntb_perf and I
think I figured it out several months ago but it's way too messy and
hard to understand and I don't want to spend the time to figure it out
again.

IMO, in order to support gaps, we'd need to, on some layer, create an
un-gapped numbering scheme for the ports. I think the easiest thing is
to just have Logical and Physical port numbers; so we would have
something like:

Physical Port Number: 0  2  4  6  8  12  16  20
Logical Port Number:  0  1  2  3  4  5   6   7
Peer Index (Port 0):  x  0  1  2  3  4   5   6
Port Index (Port 8):  0  1  2  3  x  4   5   6
(etc)

Where the Physical Port Number is whatever the hardware uses and the
logical port number is a numbering scheme starting with zero with no
gaps. Then the port indexes are still as we currently have them. If we
say that the port numbers we have now are the Logical Port Number, then
ntb_peer_resource_idx() is correct.

I would strongly argue that the clients don't need to know anything
about the Physical Port Number and these should be handled strictly
inside the drivers. If multiple drivers need to do something similar to
map the logical to physical port numbers then we should introduce helper
functions to allow them to do so. If the Physical Numbers are not
contained in the driver than the API would need to be expanded to expose
which numbers are actually used to avoid needing to constantly loop
through all the indexes to find this out.

On a similar vein, I'd  suggest that most clients shouldn't even really
need to do anything with the Logical Port Number and should deal largely
with Port Indexes. Ideally, Logical Port Numbers should only be used by
helper code in the common layer to help assign resources used by the
clients (like ntb_peer_resource_idx()).

This world view isn't far off from what we have now, though you *may*
need to adjust your IDT driver and we will have to eventually clean up
the existing test clients to use the new helper functions.

> Personally I'd prefer the first solution even though it may lead to the
> "Unsupported TLP" errors and cause a greater code changes. Here is why:
> 1) the error might be IDT-specific, so we shouldn't limit the API due to
> one particular hardware peculiarity,
> 2) port-index table with global indexes implementation shall simplify the IDT
> NTB hw driver and provide a cleaner NTB API with simpler shared resources
> utilization code.

> The final decision is after the NTB subsystem maintainers. If they agree with
> solution #1 I'll send a corresponding patchset on this week, so you can
> alter this patchset being based on it.

I think what we have right now is close enough and we just have to clean
up the code and fix things. I don't think we need to do another big
change to the semantics. I *certainly* don't want to risk breaking
everything again to do it.
 Logan
