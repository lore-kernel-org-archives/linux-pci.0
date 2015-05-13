Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbbEMJBR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 May 2015 05:01:17 -0400
Date: Wed, 13 May 2015 17:00:35 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
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
Message-ID: <20150513090035.GE3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431337974-545-5-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> Add some functions to copy the data from old kernel.
> These functions are used to copy context tables and page tables.
> 
> To avoid calling iounmap between spin_lock_irqsave and spin_unlock_irqrestore,
> use a link here, store the pointers , and then use iounmap to free them in
> another place.

Hi Zhenhua,

I remember you mentioned iounmap will cause error inside
spin_lock_irqsave. Do you know why it happened now? And could you also
describe why avoid calling iounmap between
spin_lock_irqsave/unlock_irqsave  is needed here and what's the status
now? 

I think other reviewer may want to know it too.

Thanks
Baoquan

