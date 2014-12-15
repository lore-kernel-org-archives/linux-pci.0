Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Dec 2014 17:13:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Li, ZhenHua" <zhen-hual@hp.com>, alex.williamson@redhat.com,
	Takao Indoh <indou.takao@jp.fujitsu.com>, tom.vaden@hp.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, lisa.mitchell@hp.com,
	jerry.hoemann@hp.com, iommu@lists.linux-foundation.org,
	ddutile@redhat.com, doug.hatch@hp.com,
	ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, li.zhang6@hp.com, dwmw2@infradead.org,
	vgoyal@redhat.com
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
Message-ID: <20141215091323.GA12150@dhcp-16-116.nay.redhat.com>
References: <545AD061.4000102@hp.com>
 <545AD353.8060207@jp.fujitsu.com>
 <545AD8D3.90709@hp.com>
 <545B2885.8070009@jp.fujitsu.com>
 <545B2C07.1070701@hp.com>
 <5465A0E0.4020001@hp.com>
 <20141117133858.GA31920@8bytes.org>
 <20141210084652.GA25091@dhcp-16-105.nay.redhat.com>
 <548A521B.5020705@hp.com>
 <20141212161102.GC24292@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141212161102.GC24292@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/12/14 at 05:11pm, Joerg Roedel wrote:
> On Fri, Dec 12, 2014 at 10:25:31AM +0800, Li, ZhenHua wrote:
> > Sorry I have no plan yet.
> > Could you send me your logs on your AMD system?
> 
> > On 12/10/2014 04:46 PM, Baoquan He wrote:
> > >This issue happens on AMD iommu too, do you have any plans or
> > >thoughts on that?
> 
> I think the best approach for now is to get a prove-of-concept on the
> VT-d driver. If it works there the way we expect, we can implement the
> same handling in the AMD driver. But I see no reason to hold back the
> VT-d patches until it is also fixed for AMD systems.

Yes, I agree with you. Just raise this issue to upstream. 

Thanks, Joerg.

