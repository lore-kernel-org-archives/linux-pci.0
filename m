Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:33005 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcAOSZM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:25:12 -0500
MIME-Version: 1.0
In-Reply-To: <20150826042136.GA14584@gmail.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
 <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
 <20150825075318.GA2735@gmail.com> <20150825154837.GL8051@wotan.suse.de>
 <20150825134358.990073a55012c60a638b3144@linux-foundation.org>
 <20150825231912.GW8051@wotan.suse.de> <20150825162540.0591c8c8276b1ff279785e49@linux-foundation.org>
 <20150826042136.GA14584@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 15 Jan 2016 10:24:52 -0800
Message-ID: <CAB=NE6UucJOwy3O58Oydoy_yR_05k0ebbBXpFVcNWM_g6ez-aA@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
To: Ingo Molnar <mingo@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, vinod.koul@intel.com,
	Dan Williams <dan.j.williams@intel.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	X86 ML <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 25, 2015 at 9:21 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> > There's a catch-22 issue here either way, for instance this rename patch has
>> > been being baked for probably 2 releases already but the difficulty has been
>> > trying to find the appropriate time to merge it without conflict.
>> >
>> > If you do it in the beginning of the merge window, you have to ask yourself in
>> > what tree it will be done. Since subsystems are topic specific that means that
>> > subsystem will end up having a conflict at the end of the merge window.
>>
>> Yes it's a special case.  I think the best way of handling such things is to get
>> them in to Linus either right at the end of the merge window or the day after he
>> releases -rc1.  This is when most people's trees are mostly empty.
>
> Yes, that was the plan last time around as well - but the end of the merge window
> is when we have the least maintainer bandwidth as well ...
>
> Anyway, I applied most of the patches (sans the rename), so the rename patch
> should be a lot simpler to execute at the right moment this time around.

Ingo, should we try this again some time? I have some ideas on how to
make these sorts of changes easier to manage in the future, it
involves having an automatic git rebase option to use Coccinelle for
you if a patch is annotated to have been completely done with
Coccinelle, but future tooling is needed for that [0]. In the meantime
I (or you) can simply run the script at any point in time to catch all
the names as-is in the kernel / point in time we decide to merge this
simple rename.

[0] http://kernelnewbies.org/KernelProjects/linux-oven

 Luis
