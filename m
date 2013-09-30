Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:24966
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960Ab3I3BvC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2013 21:51:02 -0400
Message-ID: <5248D94E.7080904@freescale.com>
Date: Mon, 30 Sep 2013 09:52:14 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>	<1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com> <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
In-Reply-To: <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Timur,

Thanks for your comments.

How about PCI_FSL_COMMON?

Thanks,
Minghuan

On 09/30/2013 07:56 AM, Timur Tabi wrote:
> On Wed, Sep 18, 2013 at 6:02 AM, Minghuan Lian
> <Minghuan.Lian@freescale.com> wrote:
>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 38f3b7e..6fd6348 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -690,6 +690,7 @@ config FSL_SOC
>>
>>   config FSL_PCI
>>          bool
>> +       select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx
> I think having two config options, one called FSL_PCI and the other
> PCI_FSL, is very confusing.  Surely, you can pick better names than
> that?
>


