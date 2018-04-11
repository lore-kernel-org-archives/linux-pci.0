Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35249 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeDKDW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 23:22:28 -0400
Date: Wed, 11 Apr 2018 11:22:20 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>, Nicolas Pitre <nico@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        devel@linuxdriverproject.org, linux-input@vger.kernel.org,
        linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource sibling
Message-ID: <20180411032220.GA49071@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
 <20180410134416.GM19345@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410134416.GM19345@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2018 at 09:44:16PM +0800, Baoquan He wrote:
>Hi Rob,
>
>Thanks a lot for looking into this and involve Nico to this thread!
>
>On 04/09/18 at 09:49am, Rob Herring wrote:
>> +Nico who has been working on tinification of the kernel.
>> 
>> On Mon, Apr 9, 2018 at 4:08 AM, Baoquan He <bhe@redhat.com> wrote:
>> > The struct resource uses singly linked list to link siblings. It's not
>> > easy to do reverse iteration on sibling list. So replace it with list_head.
>> 
>> Why is reverse iteration needed?
>
>This is the explanation I made when Andrew helped to review the v1 post:
>https://lkml.org/lkml/2018/3/23/78
>
>Because we have been using kexec-tools utility to search available
>System RAM space for loading kernel/initrd/purgatory from top to down.
>That is done in user space by searching /proc/iomem. While later added
>kexec_file interface, the searching code happened in kernel, and it
>only search System RAM region bottom up, then take an area in that found
>RAM region from top to down. We need unify these two interfaces on
>behaviour since they are the same on essense from the users' point of
>view, though implementation is different. As you know, the singly linked
>list implementation of the current resource's sibling linking, makes the
>searching from top to down very hard to satisfy people. 
>
>Below is the v1 post, we make an temporary array to copy iomem_resource's
>first level of children, then iterate the array reversedly. Andrew
>suggested me to try list_head after reviewing. In fact we can optimize
>that patch to only copy resource pointer into array, still the way is
>ugly.
>https://lkml.org/lkml/2018/3/21/952
>
>Then Wei pasted a patch he had made as below. He didn't mention if he
>also has requirement on reversed iteration of resource. That is an O(n*n)
>way, from personal feelings, hard to say if it's bettern than v1 post.
>https://lkml.org/lkml/2018/3/24/157

I don't have requirement on reverse iteration of resource structure.

My approach is almost the same as current walk_system_ram_res(). Since each
resource keeps parent, we could get previous resource by search on
res->parent->child.

The complexity of a whole iteration is O(N * W / 2), where N is the number of
resources in the tree and W is the average number of siblings of each
resource.

And this approach doesn't need to change current structure.

>
>That's why I would like to have a try of the list_head linking.
>

-- 
Wei Yang
Help you, Help me
