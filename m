Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:44928 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbaKAMc3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Nov 2014 08:32:29 -0400
Received: by mail-ig0-f171.google.com with SMTP id hl2so2366864igb.16
        for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2014 05:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com> <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 1 Nov 2014 13:32:08 +0100
Message-ID: <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm: cns3xxx: pci: remove artificial dependency
 on pci_sys_data domain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Krzysztof Halasa <khalasa@piap.pl>, liviu.dudau@arm.com,
	Arnd Bergmann <arnd@arndb.de>,
	Anton Vorontsov <avorontsov@mvista.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2014-10-30 12:44 GMT+01:00 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
[...]
> @@ -323,6 +308,14 @@ static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
>  void __init cns3xxx_pcie_init_late(void)
>  {
>         int i;
> +       void *private_data;
> +       struct hw_pci hw_pci = {
> +              .nr_controllers = 1,
> +              .ops = &cns3xxx_pcie_ops,
> +              .setup = cns3xxx_pci_setup,
> +              .map_irq = cns3xxx_pcie_map_irq,
> +              .private_data = &private_data,
> +       };
>
>         pcibios_min_io = 0;
>         pcibios_min_mem = 0;
> @@ -335,7 +328,8 @@ void __init cns3xxx_pcie_init_late(void)
>                 cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
>                 cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
>                 cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
> -               pci_common_init(&cns3xxx_pcie[i].hw_pci);
> +               private_data = &cns3xxx_pcie[i];
> +               pci_common_init(&hw_pci);
>         }

This looks weird. hw_pci.private_data is a pointer to a (temporary)
pointer to private data?

Best Regards,
Michał Mirosław
