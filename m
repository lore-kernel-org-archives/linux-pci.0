Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58177 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbDMHJr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2015 03:09:47 -0400
Date: Mon, 13 Apr 2015 09:09:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Ingo Molnar <mingo@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch Part1 v8 00/37] Convert x86 to hierarchy irqdomain and
 stacked irqchip
In-Reply-To: <552B60FF.5050804@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1504130909000.3845@nanos>
References: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com> <20150413061914.GA13953@gmail.com> <552B60FF.5050804@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Apr 2015, Jiang Liu wrote:
> On 2015/4/13 14:19, Ingo Molnar wrote:
> > 
> > * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> > 
> >> Hi all,
> >> 	The generic hierarchy irqdomain and stacked irqchip implementation
> >> has been merged into v3.19, so this patch set converts x86 interupt
> >> management to hierarchy irqdomain and stacked irqchip. You may access it at:
> >> https://github.com/jiangliu/linux.git irqdomain/x86_p1_v8
> >>
> >> 	This patch set has been reviewed several times and it missed v3.19
> >> merging because several bugs got fixed just before the merging window.
> >> The main changes since last review are:
> >> 1) Rebased the patch set onto v4.0-rc6.
> >> 2) Merged bugfixes into the patch introducing the bug so they don't break
> >>    bisecting.
> >>
> >> I will send out another following-on patch set to clean up code and interfaces
> >> obseleted by this patch set.
> > 
> > So JFYI, the v4.1 merge window has just opened and I probably won't 
> > have time to look at this for a week or two.
> Hi Ingo,
> 	Thanks for reminder:) Thomas pinged me on this patch set,
> so I send it out right now. Originally I planned to send it out
> after v4.1 merge window.

Right. I'm taking a look in the next days.
