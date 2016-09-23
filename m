Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 23 Sep 2016 12:57:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] x86/vmd: Add PCI domain specific LED option
Message-ID: <20160923165702.GA20686@keith>
References: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
 <1473779140-4016-2-git-send-email-keith.busch@intel.com>
 <20160923143441.GF1514@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160923143441.GF1514@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 23, 2016 at 09:34:41AM -0500, Bjorn Helgaas wrote:
> I made the necessary changes to match the renaming I did in the first
> patch, and I also used plain old "#ifdef" instead of "#if IS_ENABLED"
> since the rest of the file uses the former style.  If there's a reason
> to switch, we should change the whole file in a separate patch so we
> can explain the rationale.

The check was "IS_ENABLED" because VMD can be a loadable module, which
fails the ifdef check. I see Fengguang 0'dayed it using the module
configuration option. I can send you a fix based on your pci/hotplug
branch, or revert and apply the original patch if you prefer.

BTW, you had asked me not to split a series when incremental fixes
touched a single patch. I didn't resend the whole series here, and while
you got the right patches, I apologize for making it more difficult to find.
