Return-Path: <SRS0=HrMp=IR=intel.com=philip.li@kernel.org>
Return-Path: <SRS0=HrMp=IR=intel.com=philip.li@kernel.org>
From: "Li, Philip" <philip.li@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, lkp <lkp@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, "Vladimir
 Zapolskiy" <vladimir_zapolskiy@mentor.com>
Subject: RE: [kbuild-all] [pci:pci/resource 5/8] drivers/pci/of.o: warning:
 objtool: of_pci_map_rid.cold.1()+0x20: call without frame pointer save/setup
Date: Wed, 30 May 2018 01:01:04 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CB9C110@shsmsx102.ccr.corp.intel.com>
References: <201805300154.nOPOblp6%fengguang.wu@intel.com>
 <de8d5272-6fb6-0247-3f2b-d57986f5bb0b@siemens.com>
In-Reply-To: <de8d5272-6fb6-0247-3f2b-d57986f5bb0b@siemens.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

>=20
> On 2018-05-29 19:09, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git=
 pci/resource
> > head:   ae5dab4220cf9ef3e7ecd6d520ab3a5750bb0eb6
> > commit: bdf501f350aaa3432e4c85d4f8f57f6aa7bc9c1d [5/8] PCI: Use
> dev_printk() in of_pci_get_host_bridge_resources()
> > config: x86_64-randconfig-x004-201821 (attached as .config)
> > compiler: gcc-8 (Debian 8.1.0-3) 8.1.0
> > reproduce:
> >         git checkout bdf501f350aaa3432e4c85d4f8f57f6aa7bc9c1d
> >         # save the attached .config to linux build tree
> >         make ARCH=3Dx86_64
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/pci/of.o: warning: objtool: of_pci_check_probe_only()+0x8e: =
sibling
> call from callable instruction with modified stack frame
> >    drivers/pci/of.o: warning: objtool: of_pci_map_rid()+0x134: sibling =
call from
> callable instruction with modified stack frame
> >    drivers/pci/of.o: warning: objtool: of_irq_parse_and_map_pci()+0x1f8=
: sibling
> call from callable instruction with modified stack frame
> >    drivers/pci/of.o: warning: objtool: of_pci_check_probe_only.cold.0()=
+0x17: call
> without frame pointer save/setup
> >>> drivers/pci/of.o: warning: objtool: of_pci_map_rid.cold.1()+0x20: cal=
l without
> frame pointer save/setup
> >    drivers/pci/of.o: warning: objtool: of_irq_parse_and_map_pci.cold.2(=
)+0x15:
> call without frame pointer save/setup
> >
>=20
> Can someone enlighten me what that means? And I don't see how this patch
> could directly contribute to it.
Hi Jan, allow us to double check this since we upgrade gcc to 8.1 which may=
 bring
some different warnings/issues. You can kindly ignore this for now.

>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
