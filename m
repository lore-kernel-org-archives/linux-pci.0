Return-Path: <SRS0=uEhh=YS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12376CA9EA0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB52B21929
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571991381;
	bh=JHa/hSEb/t0poYTi2uk6JevGpIMf6TI2RYRYzriatso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTcX7t5zOyqXzFF4o129z0dmlyeQgSV8CtaA6GWQH2iu5s4eHQd3QLZfqo/JehSuq
	 TEQDUp3Xii85OQlQngQ8gaZf1ePAWkot6ex4H2CeO9Ygms/iZyeLasX4Nlw8xqeYUI
	 SeS4soJrg8hEILsLJnHfGxxMpTxE3Z/v/6Q6RK5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407697AbfJYIQV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:16:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407695AbfJYIQU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 04:16:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CED2B184;
        Fri, 25 Oct 2019 08:16:18 +0000 (UTC)
Date:   Fri, 25 Oct 2019 10:16:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     peterz@infradead.org, Yunsheng Lin <linyunsheng@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191025081617.GA17610@dhcp22.suse.cz>
References: <20191024092013.GW17610@dhcp22.suse.cz>
 <20191024174013.GA149516@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024174013.GA149516@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 24-10-19 12:40:13, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2019 at 11:20:13AM +0200, Michal Hocko wrote:
> > On Wed 23-10-19 12:10:39, Bjorn Helgaas wrote:
> > > On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
> > > > On 2019/10/23 5:04, Bjorn Helgaas wrote:
> > > > > On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
> > > 
> > > > > I think the underlying problem you're addressing is that:
> > > > > 
> > > > >   - NUMA_NO_NODE == -1,
> > > > >   - dev_to_node(dev) may return NUMA_NO_NODE,
> > > > >   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
> > > > >   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
> > > > > 
> > > > > For example, on arm64, mips loongson, s390, and x86,
> > > > > cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
> > > > > an invalid array index.
> > > > 
> > > > The invalid array index of -1 is the underlying problem here when
> > > > cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
> > > > is not NUMA_NO_NODE aware yet.
> > > > 
> > > > In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
> > > > disscusion, it is requested that it is better to warn about the pcie
> > > > device without a node assigned by the firmware before making the
> > > > cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
> > > > devices of "NUMA_NO_NODE" node can be fixed by their vendor.
> > > > 
> > > > See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/
> > > 
> > > Right.  We should warn if the NUMA node number would help us but DT or
> > > the firmware didn't give us one.
> > > 
> > > But we can do that independently of any cpumask_of_node() changes.
> > > There's no need to do one patch before the other.  Even if you make
> > > cpumask_of_node() tolerate NUMA_NO_NODE, we'll still get the warning
> > > because we're not actually changing any node assignments.
> > 
> > Agreed. And this has been proposed previously I believe but my
> > understanding was that Petr was against that.
> 
> I don't think Peter was opposed to a warning.

Now, he was opposed to cpumask_of_node handling IIRC.

> I assume you're
> referring to [1], which is about how cpumask_of_node() should work.
> That's not my area, so I don't have a strong opinion.  From that
> discussion:
> 
> Yunsheng> From what I can see, the problem can be fixed in three
> Yunsheng> place:
> Yunsheng> 1. Make user dev_to_node return a valid node id
> Yunsheng>    even when proximity domain is not set by bios(or node id
> Yunsheng>    set by buggy bios is not valid), which may need info from
> Yunsheng>    the numa system to make sure it will return a valid node.
> Yunsheng>
> Yunsheng> 2. User that call cpumask_of_node should ensure the node
> Yunsheng>    id is valid before calling cpumask_of_node, and user also
> Yunsheng>    need some info to make ensure node id is valid.
> Yunsheng>
> Yunsheng> 3. Make sure cpumask_of_node deal with invalid node id as
> Yunsheng>    this patchset.
> 
> Peter> 1) because even it is not set, the device really does belong
> Peter> to a node.  It is impossible a device will have magic
> Peter> uniform access to memory when CPUs cannot.
> Peter> 
> Peter> 2) is already true today, cpumask_of_node() requires a valid
> Peter> node_id.
> Peter> 
> Peter> 3) is just wrong and increases overhead for everyone.
> 
> I think Peter is advocating (1), i.e., if firmware doesn't tell us a
> node ID, we just pick one.  We can certainly do that in *addition* to
> adding a warning.  I'd like it to be a separate patch because I think
> we want the warning no matter what so users have some clue that
> performance could be better.

Yes, those should be two different patches.

> If we pick one, I guess we either assign some default, like node 0, to
> everything; or we somehow pick a random node to assign.

I have tried to explain that picking a default node is tricky because
node 0 is not generally available and you never know when a node might
just disappear if the device is not bound to it.

I really do not see why the proposed online_cpu_mask for that case is
such a big deal. It will likely lead to suboptimal performance but what
do you expect from a suboptimal HW description. There is no question
that the proper node affinity should be set and the warning might really
help here but trying to be clever and find a replacement sounds like
potential for more subtly broken results than doing a straightforward
thing.

But I will just go silent now because I am just repeating myself.

-- 
Michal Hocko
SUSE Labs
