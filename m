Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34365 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcDJKyX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2016 06:54:23 -0400
Received: by mail-ig0-f170.google.com with SMTP id gy3so63131456igb.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Apr 2016 03:54:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201604101000.oQktaJEg%fengguang.wu@intel.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
	<201604101000.oQktaJEg%fengguang.wu@intel.com>
Date: Sun, 10 Apr 2016 12:54:22 +0200
Message-ID: <CACna6rzz+j6GONeh31xOfX+MuHERxAz9z9fREwZXp2=7Xodknw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 April 2016 at 04:59, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.6-rc2 next-20160408]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/PCI-iproc-Support-DT-property-for-ignoring-aborts-when-probing/20160410-055241
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: "hook_fault_code" [drivers/pci/host/pcie-iproc.ko] undefined!

Oh, it seems  hook_fault_code is not an exported SYMBOL and can't be
used when building iproc as module.

Any idea how to resolve this problem?

-- 
Rafał
