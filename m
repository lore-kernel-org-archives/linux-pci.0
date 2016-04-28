Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58584 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcD1Odm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 10:33:42 -0400
Date: Thu, 28 Apr 2016 09:33:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: pci_ioremap_set_mem_type(), pci_remap_iospace()
Message-ID: <20160428143332.GC12470@localhost>
References: <20160427225827.GC17629@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160427225827.GC17629@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, manually inserted reply, sorry again]

Liviu wrote:
> On Wed, Apr 27, 2016 at 05:58:27PM -0500, Bjorn Helgaas wrote:
>> Looking at __arm_ioremap_pfn_caller() makes me
>> suspect that pci_remap_iospace() is not safe on arm.

> Hmm, not sure how you reached that conclusion. __arm_ioremap_pfn_caller()
> does call in the end ioremap_page_range() for ARMv7 || ARM_LPAE, which is
> what pci_remap_iospace() does as well. Beside the possibly different
> pgprot_t values, what would make it unsafe for arm?

The different pgprot_t is exactly what I'm worried about.  The callers of
pci_ioremap_io() probably get the right thing (a pgprot tweaked to deal
with this Cortex problem), but other callers of ioremap_page_range(),
pci_remap_iospace() in particular, don't get that tweak:

  pci_ioremap_io
    ioremap_page_range(..., __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte))

  pci_remap_iospace
    ioremap_page_range(..., pgprot_device(PAGE_KERNEL))
      ioremap_pud_range(..., pgprot_device(PAGE_KERNEL))
        ioremap_pmd_range(..., pgprot_device(PAGE_KERNEL))
          ioremap_pte_range(..., pgprot_device(PAGE_KERNEL))
            set_pte_at(..., pfn_pte(pfn, pgprot_device(PAGE_KERNEL)))
