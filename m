Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365AbbEMJVI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 May 2015 05:21:08 -0400
Date: Wed, 13 May 2015 17:21:02 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
Message-ID: <20150513092102.GG3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
 <20150513090035.GE3736@dhcp-128-28.nay.redhat.com>
 <555315A1.5020402@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555315A1.5020402@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/13/15 at 05:13pm, Li, ZhenHua wrote:
> Hi Baoquan,
> I am using a list here to store all the mapped addresses, and unmap
> them out of iounmap.

> 
> About the reason, please check the old mails. I cannot remember the
> detailed reasons.

Yeah, I understand that the list is used to collect all mapped addresses
and unmap them all after spin_unlock_irqsave. 

that's why it's better to put the reason in patch log. Patch log is used
to record this kind of explanation so that you needn't say it again and
again. My personal opinion.

Thanks
Baoquan
