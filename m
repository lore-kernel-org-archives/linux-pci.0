Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35149 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755799AbeEHXl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2018 19:41:27 -0400
Date: Wed, 9 May 2018 08:41:23 +0900
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        devel@linuxdriverproject.org, linux-input@vger.kernel.org,
        linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180508234123.GA23307@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
 <20180507011429.GG30581@MiWiFi-R3L-srv>
 <20180508114845.GA19459@WeideMacBook-Pro.local>
 <20180508121123.GI30581@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180508121123.GI30581@MiWiFi-R3L-srv>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2018 at 08:11:23PM +0800, Baoquan He wrote:
>On 05/08/18 at 08:48pm, Wei Yang wrote:
>> On Mon, May 07, 2018 at 09:14:29AM +0800, Baoquan He wrote:
>> >Hi Wei Yang,
>> >
>> >On 04/26/18 at 09:18am, Wei Yang wrote:
>> >> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
>> >> >The struct resource uses singly linked list to link siblings. It's not
>> >> >easy to do reverse iteration on sibling list. So replace it with list_head.
>> >> >
>> >> 
>> >> Hi, Baoquan
>> >> 
>> >> Besides changing the data structure, I have another proposal to do the reverse
>> >> iteration. Which means it would not affect other users, if you just want a
>> >> reverse iteration.
>> >> 
>> >> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
>> >> is a better solution to your first proposal in
>> >> https://patchwork.kernel.org/patch/10300819/.
>> >> 
>> >> Below is my proposal of resource reverse iteration without changing current
>> >> design.
>> >
>> >I got your mail and read it, then interrupted by other thing and forgot
>> >replying, sorry.
>> >
>> >I am fine with your code change. As I said before, I have tried to change
>> >code per reviewers' comment, then let reviewers decide which way is
>> >better. Please feel free to post formal patches and joining discussion
>> >about this issue.
>> 
>> Yep, while I don't have a real requirement to add the reverse version, so what
>> is the proper way to send a patch?
>> 
>> A patch reply to this thread is ok?
>
>I am not sure either. Since my patches are still under reviewing. And
>you have pasted your patch. It depends on maintainers, mainly Andrew and
>other reviewers who have concerns.

Ok, thanks.

-- 
Wei Yang
Help you, Help me
