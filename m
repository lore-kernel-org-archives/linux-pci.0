Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 8 Aug 2014 15:21:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Ingo Molnar <mingo@kernel.org>
cc: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Grant Likely <grant.likely@linaro.org>, x86@kernel.org,
	Len Brown <lenb@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [GIT PULL] x86/apic changes for v3.17
In-Reply-To: <20140807113346.GA24225@gmail.com>
Message-ID: <alpine.DEB.2.02.1408081519240.7430@chino.kir.corp.google.com>
References: <1407209178-18644-1-git-send-email-jiang.liu@linux.intel.com> <1407209178-18644-2-git-send-email-jiang.liu@linux.intel.com> <20140805183729.GA23068@pd.tnic> <53E201FC.6010102@linux.intel.com> <20140806170937.GA4895@pd.tnic> <20140807110332.GB10043@pd.tnic>
 <20140807113346.GA24225@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 7 Aug 2014, Ingo Molnar wrote:

> Linus, please pull the latest x86-apic-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
> 
>    # HEAD: 5e3bf215f4f2efc0af89e6dbc5da789744aeb5d7 x86/apic/vsmp: Make is_vsmp_box() static
> 
> 
> The main changes in this cycle are:
> 
>     * Remove obsolete APIC driver abstractions. (David Rientjes)
> 

These changes are unrelated from the other issues and can still be pulled 
from

	git://git.kernel.org/pub/scm/linux/kernel/git/rientjes/linux.git x86/apic 

if we want the cleanups for 3.17.  The x86 pull request was originally at 
http://marc.info/?l=linux-kernel&m=140678961924050.

It would be a shame to miss out on that because the changes share the same 
tip branch.
