Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 15 Jan 2016 19:32:06 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115193206.GB13227@localhost.localdomain>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115181938.GA5296@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 12:19:38PM -0600, Bjorn Helgaas wrote:
> I applied these to pci/host-vmd with the changes below.  Most of them
> are cosmetic (rewrapping changelogs, fixing whitespace, etc.), but
> there are a few I'd like you to take a close look at:
> 
>   - Added VMD_CFGBAR and similar #defines
>   - Added vmd_cfg_addr() to factor out the addr computation and
>     validation
>   - Resource setup in vmd_enable_domain().  I suggested a temporary to
>     make the lines shorter.  I had the vmd->dev->resource[n] in mind,
>     but you added a temporary for vmd->resources[n].  Either way is
>     fine, but I liked the look of the v7 init, so I reverted to that,
>     with a temporary for vmd->dev->resource[n].
>   - Flags setup in vmd_enable_domain().  This was pretty confusing,
>     and I *think* what I did is equivalent, but you should verify.

Thanks for the cleanups. All the new changes look good to me, and I will
test your tree today to confirm no regressions.
 
> I'm still hoping to get this in during the merge window.

Thanks a bunch. This would be great timing to align the hardware
availability with various software and OEM vendors.
 
> If you want to test this, I recommend using my git branch
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-vmd
> instead of applying the patch below on top of your v8.  If you want
> to make changes, post an incremental patch based on that branch.

I'll give this a test today.
