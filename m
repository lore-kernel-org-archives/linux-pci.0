Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:54945 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab2DNUky (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Apr 2012 16:40:54 -0400
Date: Sat, 14 Apr 2012 14:40:52 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: "Hao, Xudong" <xudong.hao@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v5] Quirk for IVB graphics FLR errata
Message-ID: <20120414204052.GB28678@parisc-linux.org>
References: <403610A45A2B5242BD291EDAE8B37D300FD0FF14@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <403610A45A2B5242BD291EDAE8B37D300FD0FF14@SHSMSX102.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2012 at 08:22:18AM +0000, Hao, Xudong wrote:
> Changes from v4: (based on Matthew and Don's comments)
> - using jiffies to set timeout instead of tsc.
> - correct type mmio_base variable
> - using readl() and writel() to access io.
> - correct code style, use spaces around the multiply operator.

Much better!  Just a couple of minor nits ...

> +	val = readl(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
> +	writel(val, mmio_base + PCH_PP_CONTROL);
> +	do {
> +		timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
> +		while (1) {

Personally, I'd write this as:

	while (time_before(jiffies, timeout)) {
		...
	}

> +			val = readl(mmio_base + PCH_PP_STATUS);
> +			if (((val & 0x80000000) == 0)
> +				&& ((val & 0x30000000) == 0))

Is there a reason why this shouldn't be:

		if ((val & 0xB0000000) == 0)

> +				break;
> +			if (time_after(jiffies, timeout))
> +				break;
> +			cpu_relax();
> +		}
> +	} while (0);

Why do we need this to be in a do { } while (0) loop?

Putting those three suggestions together, I think it should look like this:

	writel(val, mmio_base + PCH_PP_CONTROL);
	timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
	while (time_before(jiffies, timeout)) {
		val = readl(mmio_base + PCH_PP_STATUS);
		if ((val & 0xB0000000) == 0)
			break;
		cpu_relax();
	}
	writel(0x00000002, mmio_base + 0xd0100);

With that change, please add:

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
