Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 May 2015 14:14:23 +0800
From: Dave Young <dyoung@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Baoquan He <bhe@redhat.com>, "Li, ZhenHua" <zhen-hual@hp.com>,
	dwmw2@infradead.org, indou.takao@jp.fujitsu.com, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150505061423.GC31063@dhcp-128-4.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
 <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
 <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
 <20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
 <20150504162318.GH15736@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150504162318.GH15736@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/04/15 at 06:23pm, Joerg Roedel wrote:
> On Fri, Apr 24, 2015 at 04:49:57PM +0800, Dave Young wrote:
> > I'm more than happy to see this issue can be fixed in the patchset, I
> > do not agree to add the code there with such problems. OTOH, for now
> > seems there's no way to fix it.
> 
> And that's the point. We discuss this issue and possible solutions for
> years by now, and what ZhenHua implemented is what we agreed to be the
> best-effort on what we can do in the kdump case with IOMMU enabled.
> 
> Of course there are still failure scenarios left, but that is not
> different from systems without any IOMMU.

The failure is nothing different, but as I said in another reply the
difference is we could use corrupted data to possiblly cause more failure. 

Thanks
Dave
