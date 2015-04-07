Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbbDGDuq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Apr 2015 23:50:46 -0400
Date: Tue, 7 Apr 2015 11:49:57 +0800
From: Dave Young <dyoung@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Hatch, Douglas B (HPS Linux PM)" <doug.hatch@hp.com>,
	"Hoemann, Jerry" <jerry.hoemann@hp.com>,
	"Vaden, Tom (HP Server OS Architecture)" <tom.vaden@hp.com>,
	"Zhang, Li (Zoe@HPservers-Core-OE-PSC)" <li.zhang6@hp.com>,
	"Mitchell, Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>,
	"billsumnerlinux@gmail.com" <billsumnerlinux@gmail.com>,
	"Wright, Randy (HP Servers Linux)" <rwright@hp.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150407034957.GC7213@localhost.localdomain>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <551E56F6.60503@hp.com>
 <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
 <534F7596-2172-4BE1-B374-4D18D2DA5110@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534F7596-2172-4BE1-B374-4D18D2DA5110@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/03/15 at 02:05pm, Li, Zhen-Hua wrote:
> The hardware will do some verification, but not completely.  If people think the OS should also do this, then it should be another patchset, I think.

If there is chance to corrupt more memory I think it is not a right way.
We should think about a better solution instead of fix it later.

Thanks
Dave
