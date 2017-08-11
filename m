Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:4188 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753363AbdHKUpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 16:45:43 -0400
Date: Fri, 11 Aug 2017 14:29:00 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/host-vmd 3/3] drivers/pci/host/vmd.c:791:2: warning:
 ignoring return value of 'pcim_enable_device', declared with attribute
 warn_unused_result
Message-ID: <20170811202857.bh2jz45qqafh4yc2@sbauer-Z170X-UD5>
References: <201708120431.anbQ6jpI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201708120431.anbQ6jpI%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 12, 2017 at 04:37:33AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-vmd
> head:   6cf59d3b557e60a8fe3012761f336615d332a539
> commit: 6cf59d3b557e60a8fe3012761f336615d332a539 [3/3] PCI: vmd: Free up IRQs on suspend path
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 6cf59d3b557e60a8fe3012761f336615d332a539
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/host/vmd.c: In function 'vmd_resume':
> >> drivers/pci/host/vmd.c:791:2: warning: ignoring return value of 'pcim_enable_device', declared with attribute warn_unused_result [-Wunused-result]
>      pcim_enable_device(pdev);


ugh, It was my intention to RESEND the original patch (without enable/disable).
I had forgotten when Jon suggested to disable/enable that I squashed that in.
I didn't do my due diligence before the resend to verify it was the original.

Bjorn, how do you want me to fix this should I send a patch on top of this one,
removing the enable/disables? Or do you want to rip them out? Let me know what's
easiest for you.
