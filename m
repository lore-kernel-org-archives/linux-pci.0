Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 28 Sep 2014 13:05:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFT Part2 v2 00/24] Enable hierarchy irqdomian on x86 platforms
Message-ID: <20140928110531.GB7351@pd.tnic>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
 <20140926142931.GA10066@nazgul.tnic>
 <542594A6.4040504@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <542594A6.4040504@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 26, 2014 at 11:30:30AM -0500, Aravind Gopalakrishnan wrote:
> Okay, I shall start looking into the patches and RFH as needed.

Btw, apparently, there's a third patchset too:

https://lkml.kernel.org/r/1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com

Jiang, do you have a tree which has all required patches for testing so
that people don't have to go hunting for them..?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
