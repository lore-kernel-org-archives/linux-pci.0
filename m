Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:48716 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaLHArt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 19:47:49 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 8 Dec 2014 06:17:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6A907E0053
	for <linux-pci@vger.kernel.org>; Mon,  8 Dec 2014 06:18:13 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB80nlu04522246
	for <linux-pci@vger.kernel.org>; Mon, 8 Dec 2014 06:19:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB80lblw005813
	for <linux-pci@vger.kernel.org>; Mon, 8 Dec 2014 06:17:38 +0530
Date: Mon, 8 Dec 2014 11:47:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	weiyang@linux.vnet.ibm.com
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141208004735.GA15508@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
 <20141204173411.GA5949@google.com>
 <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417777177.4741.69.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 05, 2014 at 09:59:37PM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2014-12-04 at 14:06 -0800, Yinghai Lu wrote:
>> > I'm considering reverting 5b28541552ef (assuming that would fix this radeon
>> > regression) because I think the radeon problem is worse than the 74151
>> > problem and I think we can solve 74151 in a different way.
>> >

Commit 5b28541552ef affects PowerPC PCI greatly. Without the commit, those
adapters requesting large BAR would fail and can't work properly. Another
related thing is SRIOV support. Currently, VF BARs are covered by 64-bits
prefetch windows and we expect VF BARs allocated from 64-bits prefetchable
windows. If we're going to revert commit 5b28541552ef, too much things are
affected. I think it's more reasonable to find a solution for bug#85491 if
that's not too hard.

Looking at bug#85491 and the logs from Marek, BIOS didn't configure windows
and BARs for PCI bridge and adapters properly, which forces the kernel to
reassign those BARs/windows failing to be claimed previously. If I'm correct,
we need a way to reassign the bridge's non-prefetchable window and with it,
find_free_bus_resource() needn't check on "!r->parent".

Another way to fix it would be to returning error from pbus_size_mem() for
64-bits-prefetchable case so that prefetchable BARs will be assigned from
prefetchable windows (64-bits flag will be ignored). I guss Yinghai will
have more comments on this.

>> > Guo, Ben, this would affect you!  It's too late to revert 5b28541552ef for
>> > v3.18, but we really need to work on this for v3.19.
>> >
>> > FOr 85491 (the radeon problem), we might be able to work around it by
>> > fixing the bridge window, but I'm not sure we could even get that done
>> > before v3.18.  I'll work on that today.
>> 
>> shrink bridge mmio pref range instead of reject it?
>
>Guo unfortunately doesn't work for us anymore. Gavin, Richard, can
>you handle this please ?
>

Thanks,
Gavin

>Cheers,
>Ben.
>
>

