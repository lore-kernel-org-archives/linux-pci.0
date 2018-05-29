Return-Path: <SRS0=sQbd=IQ=siemens.com=jan.kiszka@kernel.org>
Return-Path: <SRS0=sQbd=IQ=siemens.com=jan.kiszka@kernel.org>
Subject: Re: [pci:pci/resource 5/8] drivers/pci/of.o: warning: objtool:
 of_pci_map_rid.cold.1()+0x20: call without frame pointer save/setup
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <201805300154.nOPOblp6%fengguang.wu@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <de8d5272-6fb6-0247-3f2b-d57986f5bb0b@siemens.com>
Date: Tue, 29 May 2018 19:35:03 +0200
MIME-Version: 1.0
In-Reply-To: <201805300154.nOPOblp6%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-29 19:09, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
> head:   ae5dab4220cf9ef3e7ecd6d520ab3a5750bb0eb6
> commit: bdf501f350aaa3432e4c85d4f8f57f6aa7bc9c1d [5/8] PCI: Use dev_printk() in of_pci_get_host_bridge_resources()
> config: x86_64-randconfig-x004-201821 (attached as .config)
> compiler: gcc-8 (Debian 8.1.0-3) 8.1.0
> reproduce:
>         git checkout bdf501f350aaa3432e4c85d4f8f57f6aa7bc9c1d
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/of.o: warning: objtool: of_pci_check_probe_only()+0x8e: sibling call from callable instruction with modified stack frame
>    drivers/pci/of.o: warning: objtool: of_pci_map_rid()+0x134: sibling call from callable instruction with modified stack frame
>    drivers/pci/of.o: warning: objtool: of_irq_parse_and_map_pci()+0x1f8: sibling call from callable instruction with modified stack frame
>    drivers/pci/of.o: warning: objtool: of_pci_check_probe_only.cold.0()+0x17: call without frame pointer save/setup
>>> drivers/pci/of.o: warning: objtool: of_pci_map_rid.cold.1()+0x20: call without frame pointer save/setup
>    drivers/pci/of.o: warning: objtool: of_irq_parse_and_map_pci.cold.2()+0x15: call without frame pointer save/setup
> 

Can someone enlighten me what that means? And I don't see how this patch
could directly contribute to it.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
