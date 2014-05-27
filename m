Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37809 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaE0VWl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 17:22:41 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so9539896iec.29
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 14:22:40 -0700 (PDT)
Date: Tue, 27 May 2014 14:22:37 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Patch V3 05/37] x86, PCI, ACPI: use kmalloc_node() to optimize
 for performance
In-Reply-To: <1401178092-1228-6-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.02.1405271421470.14064@chino.kir.corp.google.com>
References: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com> <1401178092-1228-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 27 May 2014, Jiang Liu wrote:

> Use kmalloc_node() instead of kmalloc() when possible to optimize
> for performance on NUMA platforms.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: David Rientjes <rientjes@google.com>

All the handling to make sure sd->node refers to either NUMA_NO_NODE 
(fallback to local allocation) or an online node looks to be handled 
properly.
