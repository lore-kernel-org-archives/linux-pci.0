Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350FEC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC7420663
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 23:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCFXWo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:22:44 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43916 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFXWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 18:22:44 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h1frw-00065h-Dx; Wed, 06 Mar 2019 16:22:37 -0700
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
 <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
 <20190306224542.4eu2dvsixfzc75gr@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4acf79c1-766b-1db6-45c1-4cdd4cbba437@deltatee.com>
Date:   Wed, 6 Mar 2019 16:22:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306224542.4eu2dvsixfzc75gr@mobilestation>
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





On 2019-03-06 3:45 p.m., Serge Semin wrote:
[Snip]

Pretty sure everything above is just agreement...

> So your current approach is inbound MW-centralized, while mine is developed
> around the outbound MWs.

I don't think this has anything to do with inbound vs outbound. The
problem is the same no matter from which direction you assign things.

>> Physical Port Number: 0  2  4  6  8  12  16  20
>> Logical Port Number:  0  1  2  3  4  5   6   7
>> Peer Index (Port 0):  x  0  1  2  3  4   5   6
>> Port Index (Port 8):  0  1  2  3  x  4   5   6
>> (etc)
> 
> That's what I suggested in the two possible solutions:
> 1st solution: replace current pidx with Logical Port Number,
> 2nd solution: alter ntb_peer_resource_idx() so it would return the Logical Port Number.

Well my solution wasn't to change pidx and no, we don't want to change
ntb_peer_resource_idx() to return the logical port number because that's
not how it's being used and I have no use for a
ntb_peer_port_global_idx() function. Functions are supposed to be added
by code that needs to call them, not by some grand design. Part of the
reason we have this confusing mess is because the API was reviewed and
merged before any users of the API were presented. Usually this is not
accepted in kernel development.

My suggestion is to simply say that the existing port numbers are the
logical port number and have the drivers handle the physical port number
mapping internally. That requires the fewest changes.

> IMO In case of the 2nd solution I'd also suggest to rename the
> ntb_peer_resource_idx() method into ntb_peer_port_global_idx(),
> and then consider the current port indexes used in the NTB API
> as local port indexes. The resource indexing can be abstracted
> by a macro like this:
> #define ntb_peer_resource_idx ntb_peer_port_global_idx

That define would not be useful.

> Finally in order to close the space up we'd also need to define
> a method: ntb_port_global_idx(), which would return a Logical (global)
> index of local port.

Again, I'd rather not add a bunch of large semantic and infrastructure
changes at this point. It's confusing enough as it is and we don't need
to introduce yet another indexing scheme API to the clients that really
do not need it. What the clients need is a simple API to decide which
resources to use for which peers, and to figure out which peers used
which resources. ntb_peer_port_idx() and ntb_peer_resource_idx() suit
these purposes. Nothing else really needs to exist.

>> Where the Physical Port Number is whatever the hardware uses and the
>> logical port number is a numbering scheme starting with zero with no
>> gaps. Then the port indexes are still as we currently have them. If we
>> say that the port numbers we have now are the Logical Port Number, then
>> ntb_peer_resource_idx() is correct.
>>
> 
> Current port numbers are the physical port numbers with gaps. 

I think that's up for interpretation as, based on the existing code, I
naturally interpreted it the other way and therefore it's pretty simple
to say that it's the logical port number and fix the one driver that
needs to change.

> That's why we
> introduced the port-index NTB API abstraction in the first place, to have these gaps
> eliminated and to provide a simple way of bulk setup. Although that abstraction
> turned out not that suitable to distribute the shared resources. So
> the Logical (Global) indexing is needed to do it (that's what ntb_pingpong used
> to do and ntb_perf still does now).

My interpretation of the port-index was simply to match what was done in
the two port case seeing code like ntb_transport simply uses the default
0 as the port index. There was no reason to believe, based on the code,
that there would be gaps.

>> I would strongly argue that the clients don't need to know anything
>> about the Physical Port Number and these should be handled strictly
>> inside the drivers. If multiple drivers need to do something similar to
>> map the logical to physical port numbers then we should introduce helper
>> functions to allow them to do so. If the Physical Numbers are not
>> contained in the driver than the API would need to be expanded to expose
>> which numbers are actually used to avoid needing to constantly loop
>> through all the indexes to find this out.
>>
> 
> Absolutely agree with you. The main idea of NTB API was to provide a set
> of methods to access the NTB hardware without any abstractions but
> with possible useful helpers, like your NTB MSI library, or transport library,
> or anything else. So the physical port numbers must be available for
> the client drivers.

Huh? How can you say you absolutely agree with me? I said the clients
should not need to know about physical port numbers and you said the
physical port numbers *must* be available to clients. I think this
statement needs to be justified. Why should the clients need to know
about the physical port numbers?

>> On a similar vein, I'd  suggest that most clients shouldn't even really
>> need to do anything with the Logical Port Number and should deal largely
>> with Port Indexes. Ideally, Logical Port Numbers should only be used by
>> helper code in the common layer to help assign resources used by the
>> clients (like ntb_peer_resource_idx()).
>>
> 
> This is the main question. Do we really need the current port indexes
> implementation at all? After all these years of NTB API usage I don't really
> see it useful in any case except to loop over the outbound MW resources
> automatically skipping the local port (usefulness of this is also questionable).
> As I already said I created the port-index table this way due to the IDT NTB
> MWs peculiarity, which doesn't seem to me a big problem now comparing to all
> these additional complications we intend to introduce.

To me, it seems like the port indexes are used everywhere. A client
almost always wants to deal with every port except itself. That seems
entirely natural to me. Using the port index as the resource index makes
perfect sense (which is why I implemented the inverse
ntb_peer_resource_idx()).

> The rest of the drivers code really need to have the Logical (global)
> port indexes, at least to distribute the shared resources, and don't use
> the current pidx that much.

Drivers don't care about port indexes or how the resources are
distributed. I would expect that all they'd do is map the port index
(which all existing APIs take) to the physical address and program
hardware as necessary.

> Wouldn't it be better to just redefine the current port-index table
> in the following way?
> ntb_port_number() - local physical port number,
> ntb_port_idx() - local port logical (global) index,
> ntb_peer_port_count() - total number of ports NTB device provide (including the local one),
> ntb_peer_port_number() - physical port number of the peer with passed logical port index,
> ntb_peer_port_idx - logical port index of the passed physical port number.

No, from the perspective of the client, the physical port numbers are
useless. I don't want the count to include the local one because that
means I'd always have to subtract one every time I want to loop through
all peers (I never want to loop through all ports including the local
one).  I have no idea what your distinction between logical (global)
index and logical port index is. In fact I find this all confusing.

> while currently we have:
> ntb_port_number() - local physical port number,
> ntb_peer_port_count() - total number of ports NTB device provide (excluding the local one),
> ntb_peer_port_number() - physical port number of the peer with passed port index,
> ntb_peer_port_idx - port index of the passed physical port number;

What we currently have all makes perfect sense to me and is exactly what
I want for the clients, except I think ntb_port_number() needs to be the
logical port number (with the gaps removed), so that we can more easily
implement ntb_peer_resource_idx(). If ntb_port_number() corresponds to
the physical port number, then the correct implementation of
ntb_peer_resource_idx() is going to be crazy, essentially needing to
generate a logical port number for every port, every time it's called.

Logan

