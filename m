Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from scorn.kernelslacker.org ([45.56.101.199]:32816 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdK0VaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 16:30:25 -0500
Date: Mon, 27 Nov 2017 16:30:01 -0500
From: Dave Jones <davej@codemonkey.org.uk>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Wong Vee Khee <vee.khee.wong@ni.com>,
        Bodong Wang <bodong@mellanox.com>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [trinity] WARNING: CPU: 0 PID: 515 at
 drivers/pci/pci-sysfs.c:1224 pci_mmap_resource+0xd6/0x10e
Message-ID: <20171127213001.GA12537@codemonkey.org.uk>
References: <20171124001139.bmuq6dkj63wuqzls@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171124001139.bmuq6dkj63wuqzls@wfg-t540p.sh.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 24, 2017 at 08:11:39AM +0800, Fengguang Wu wrote:
 > Hello,
 > 
 > FYI this happens in mainline kernel 4.14.0-12995-g0c86a6b.
 > It at least dates back to v4.9 .
 > 
 > I wonder where can we avoid this warning, by improving trinity (or how
 > we use it), or the pci subsystem?
 > 
 > [main] Added 42 filenames from /dev
 > [main] Added 13651 filenames from /proc
 > [main] Added 11163 filenames from /sys
 > [   19.452176] ------------[ cut here ]------------
 > [   19.452938] process "trinity-main" tried to map 0x00004000 bytes at page 0x00000001 on 0000:00:06.0 BAR 4 (start 0x        fe008000, size 0x            4000)
 > [   19.454804] WARNING: CPU: 0 PID: 515 at drivers/pci/pci-sysfs.c:1224 pci_mmap_resource+0xd6/0x10e

That's a root-only operation, where we allow the user to shoot
themselves in the foot afaik.   What you could do now that you're
running an up to date trinity in 0day, is pass the --dropprivs flag
to setuid to nobody in the child processes.

	Dave
