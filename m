Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm40-vm6.bullet.mail.bf1.yahoo.com ([72.30.239.214]:49047 "HELO
	nm40-vm6.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756097Ab2EQCh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 May 2012 22:37:58 -0400
References: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com> <CAE9FiQWK0Ur+dnQmJ4D_Zve+Bcqxt2u+R=Qp6s39vJCZJfhRqg@mail.gmail.com> <1337197170.68237.YahooMailNeo@web160304.mail.bf1.yahoo.com> <CAE9FiQU-aCZokS7V_77cpNMN-jK=WEekSJX3F4vnv8ZSEuv4Ow@mail.gmail.com> <1337213485.7669.YahooMailNeo@web160306.mail.bf1.yahoo.com> <CAE9FiQVGfMWH+yvmFRUsUsC+JzhR=Q2uAc2a_5tsUVQQM9MOrA@mail.gmail.com>
Message-ID: <1337222277.26633.YahooMailNeo@web160306.mail.bf1.yahoo.com>
Date: Wed, 16 May 2012 19:37:57 -0700 (PDT)
From: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Reply-To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Subject: Re: Hotplug Debugging
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <CAE9FiQVGfMWH+yvmFRUsUsC+JzhR=Q2uAc2a_5tsUVQQM9MOrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Yinghai for your prompt responses. I looked around another Dell T5500 which is a newer system and even in that system doesn't support hotplug. Do you know of any reliable system which has hotplug support?
 


----- Original Message -----
From: Yinghai Lu <yinghai@kernel.org>
To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Sent: Wednesday, May 16, 2012 6:15 PM
Subject: Re: Hotplug Debugging

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
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
