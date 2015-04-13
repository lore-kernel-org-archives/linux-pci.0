Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [Patch Part1 v8 00/37] Convert x86 to hierarchy irqdomain and stacked irqchip
Date: Mon, 13 Apr 2015 14:09:47 +0200
Message-ID: <4551925.SfnFYPAUbh@vostro.rjw.lan>
In-Reply-To: <20150413061914.GA13953@gmail.com>
References: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com> <20150413061914.GA13953@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 13, 2015 08:19:14 AM Ingo Molnar wrote:
> 
> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
> > Hi all,
> > 	The generic hierarchy irqdomain and stacked irqchip implementation
> > has been merged into v3.19, so this patch set converts x86 interupt
> > management to hierarchy irqdomain and stacked irqchip. You may access it at:
> > https://github.com/jiangliu/linux.git irqdomain/x86_p1_v8
> > 
> > 	This patch set has been reviewed several times and it missed v3.19
> > merging because several bugs got fixed just before the merging window.
> > The main changes since last review are:
> > 1) Rebased the patch set onto v4.0-rc6.
> > 2) Merged bugfixes into the patch introducing the bug so they don't break
> >    bisecting.
> > 
> > I will send out another following-on patch set to clean up code and interfaces
> > obseleted by this patch set.
> 
> So JFYI, the v4.1 merge window has just opened and I probably won't 
> have time to look at this for a week or two.

Same for me.  I rather won't be able to look at this in the next 2 weeks.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
