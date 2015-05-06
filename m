Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 May 2015 10:25:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dave Young <dyoung@redhat.com>
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
Message-ID: <20150506082559.GC20611@8bytes.org>
References: <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
 <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
 <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
 <20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
 <20150504162318.GH15736@8bytes.org>
 <20150505061423.GC31063@dhcp-128-4.nay.redhat.com>
 <20150505153157.GQ15736@8bytes.org>
 <20150506015135.GB14065@dhcp-128-4.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150506015135.GB14065@dhcp-128-4.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 09:51:35AM +0800, Dave Young wrote:
> DMA write will modify system ram, if the old data is corrupted  it is possible
> that DMA operation modify wrong ram regions because of wrong mapping.
> Am I missing something and is it not possible?

This might have happened already before the kdump kernel even boots.
Also, if there is no IOMMU, this can happen as well. This (unlikely
but possible) situation doesn't make things worse.


	Joerg

