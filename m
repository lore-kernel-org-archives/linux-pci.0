Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34478 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdFZU2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2017 16:28:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so1506591pge.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2017 13:28:04 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rth@twiddle.net
To: ink@jurassic.park.msu.ru
To: mattst88@gmail.com
To: vgupta@synopsys.com
To: linux@armlinux.org.uk
To: catalin.marinas@arm.com
To: will.deacon@arm.com
To: geert@linux-m68k.org
To: ralf@linux-mips.org
To: ysato@users.sourceforge.jp
To: dalias@libc.org
To: davem@davemloft.net
To: cmetcalf@mellanox.com
To: gxt@mprc.pku.edu.cn
To: bhelgaas@google.com
To: viro@zeniv.linux.org.uk
To: james.hogan@imgtec.com
To: linux-alpha@vger.kernel.org
To: linux-kernel@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
To: linux-m68k@lists.linux-m68k.org
To: linux-mips@linux-mips.org
To: linux-sh@vger.kernel.org
To: sparclinux@vger.kernel.org
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Date: Mon, 26 Jun 2017 13:27:55 -0700
Message-Id: <20170626202756.22220-1-palmer@dabbelt.com>
In-Reply-To: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
References: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>On Mon, Jun 26, 2017 at 7:39 AM, kbuild test robot <lkp@intel.com> wrote:
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v4.12-rc6]
>> [cannot apply to next-20170623]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
>> config: m68k-allnoconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 4.9.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=m68k
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)
>
>I can't seem to find this dependency of PCI_GENERIC_SETUP on MMU?

It looks like M68K only includes the PCI Kconfig entry when MMU is enabled.  I
moved the select around a bit and it builds the config that was failing for me.

The updated patch is threaded.
