Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36817 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2EQBP2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2012 21:15:28 -0400
Received: by pbbrp8 with SMTP id rp8so1830100pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 16 May 2012 18:15:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337213485.7669.YahooMailNeo@web160306.mail.bf1.yahoo.com>
References: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com>
	<CAE9FiQWK0Ur+dnQmJ4D_Zve+Bcqxt2u+R=Qp6s39vJCZJfhRqg@mail.gmail.com>
	<1337197170.68237.YahooMailNeo@web160304.mail.bf1.yahoo.com>
	<CAE9FiQU-aCZokS7V_77cpNMN-jK=WEekSJX3F4vnv8ZSEuv4Ow@mail.gmail.com>
	<1337213485.7669.YahooMailNeo@web160306.mail.bf1.yahoo.com>
Date: Wed, 16 May 2012 18:15:28 -0700
Message-ID: <CAE9FiQVGfMWH+yvmFRUsUsC+JzhR=Q2uAc2a_5tsUVQQM9MOrA@mail.gmail.com>
Subject: Re: Hotplug Debugging
From: Yinghai Lu <yinghai@kernel.org>
To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2012 at 5:11 PM, LinuxDrvDev
<ushmasonal-linuxmail@yahoo.com> wrote:
>
>
>>can you post whole log with "debug ignore_loglevel pciehp.pciehp_debug=1" ?
> Attached here is the log with above parameters.
>
> I will also try your kernel with resetting of pcie link.

pciehp: pcie_port_service_register = 0
pciehp: PCI Express Hot Plug Controller Driver version: 0.4

looks like your BIOS does not enable pcie native hotplug.

Yinghai
