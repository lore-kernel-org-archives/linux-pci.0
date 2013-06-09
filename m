Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:54098 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931Ab3FIPXR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jun 2013 11:23:17 -0400
Date: Sun, 9 Jun 2013 17:22:59 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v3 06/27] ia64, irq: Add dummy create_irq_nr()
Message-ID: <20130609152259.GC2245@breakpoint.cc>
References: <1370644273-10495-1-git-send-email-yinghai@kernel.org>
 <1370644273-10495-7-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370644273-10495-7-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 07, 2013 at 03:30:52PM -0700, Yinghai Lu wrote:
> create_irq() will return -1 when fail to allocate.
The ia64 code here will return -ENOSPC. 

> create_irq_nr() will return 0 when fail to allocate.
> 
> Will use it to fix one return value checking for dmar_msi irq.

What about to unify the interface? Using -1 is kinda bad.

Sebastian
