Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33964 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbbDJNmP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 09:42:15 -0400
Received: by qkgx75 with SMTP id x75so30581574qkg.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 06:42:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1428658811.2796.2.camel@pengutronix.de>
References: <20150409194923.19293.96454.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <DM2PR0301MB064005C336CD164FD8C0A061E2FA0@DM2PR0301MB0640.namprd03.prod.outlook.com>
 <1428658811.2796.2.camel@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Apr 2015 08:41:54 -0500
Message-ID: <CAErSpo5hMtTqzoQR9pP_FwOdVyvUcNhPeTVxQXPKKQMi2i8XZg@mail.gmail.com>
Subject: Re: [PATCH] PCI: layerscape: Simplify platform_get_resource_byname()
 failure checking
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 4:40 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Freitag, den 10.04.2015, 02:08 +0000 schrieb
> Minghuan.Lian@freescale.com:
>> Hi Bjorn,
>>
>> Thanks for your improvement.
>> I notice my new patches to add support arm32 and arm64 for designware
>> and layerscape also have the similar issues, I will fix and submit
>> them v2 .
>> Could you tell me whether it is acceptable that I add a new file
>> pcie-designware-base.c  to re-implement designware PCIe driver for
>> compatible with arm32 and arm64.  The benefit  is that  the new
>> implementation is simple clear and platform-independent. In addition,
>> MSI driver will be split to a separate file. But we may need to push
>> other platform PCIe maintainer to port the driver based on
>> pcie-designware-base.c .
>>
> In that case you probably should have put the other maintainers of
> designware based PCI drivers on CC for your patches. You will not gain
> momentum for such a radical change if you fail to address the right
> people.

I haven't reviewed your patches in detail, but you might need to go
even farther and do the conversion yourself.  That's what somebody
introducing new infrastructure usually does.

Bjorn
