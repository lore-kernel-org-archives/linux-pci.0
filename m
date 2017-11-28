Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:15070 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753640AbdK1MVW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 07:21:22 -0500
Date: Tue, 28 Nov 2017 20:21:17 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Wong Vee Khee <vee.khee.wong@ni.com>,
        Bodong Wang <bodong@mellanox.com>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Cc: Philip Li <philip.li@intel.com>
Subject: Re: [trinity] WARNING: CPU: 0 PID: 515 at
 drivers/pci/pci-sysfs.c:1224 pci_mmap_resource+0xd6/0x10e
Message-ID: <20171128122117.3kqzbjzewadakj67@wfg-t540p.sh.intel.com>
References: <20171124001139.bmuq6dkj63wuqzls@wfg-t540p.sh.intel.com>
 <20171127213001.GA12537@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171127213001.GA12537@codemonkey.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dave,

On Mon, Nov 27, 2017 at 04:30:01PM -0500, Dave Jones wrote:
>On Fri, Nov 24, 2017 at 08:11:39AM +0800, Fengguang Wu wrote:
> > Hello,
> >
> > FYI this happens in mainline kernel 4.14.0-12995-g0c86a6b.
> > It at least dates back to v4.9 .
> >
> > I wonder where can we avoid this warning, by improving trinity (or how
> > we use it), or the pci subsystem?
> >
> > [main] Added 42 filenames from /dev
> > [main] Added 13651 filenames from /proc
> > [main] Added 11163 filenames from /sys
> > [   19.452176] ------------[ cut here ]------------
> > [   19.452938] process "trinity-main" tried to map 0x00004000 bytes at page 0x00000001 on 0000:00:06.0 BAR 4 (start 0x        fe008000, size 0x            4000)
> > [   19.454804] WARNING: CPU: 0 PID: 515 at drivers/pci/pci-sysfs.c:1224 pci_mmap_resource+0xd6/0x10e
>
>That's a root-only operation, where we allow the user to shoot
>themselves in the foot afaik.   What you could do now that you're
>running an up to date trinity in 0day, is pass the --dropprivs flag
>to setuid to nobody in the child processes.

Got it. I wonder if running trinity in root mode (in QEMU, of course)
will help catch more bugs. If so, I'd like to keep the current state,
but ignore the known trinity specific oops (like this one and OOM). We
already have the code to ignore trinity triggered OOM, so it'd be
trivial to add one more oops pattern to ignore.

Thanks,
Fengguang
