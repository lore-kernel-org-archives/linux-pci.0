Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:61946 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaBNTYM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 14:24:12 -0500
Received: by mail-ob0-f178.google.com with SMTP id wn1so14582293obc.9
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 11:24:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704696651@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704695360@DFLE11.ent.ti.com>
	<20140214164444.GA29491@google.com>
	<3E54258959B69E4282D79E01AB1F32B704696651@DFLE11.ent.ti.com>
Date: Fri, 14 Feb 2014 11:24:11 -0800
Message-ID: <CAE9FiQWRvQNpGXhDJXFGV1rhqPrRctBO5HO9dzwGk1xSzJgE=Q@mail.gmail.com>
Subject: Re: PCI memory BAR assigned by u-boot not honored when using recent kernel
From: Yinghai Lu <yinghai@kernel.org>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 9:32 AM, Karicheri, Muralidharan
>>There is no guarantee that the kernel will keep the BAR assignments done by firmware or
>>a bootloader.  Usually the kernel *does* keep them, as long as they are valid, but you
>>can not rely on that.

Not sure what arch in your case.

You need to have code like pcibios_resource_survey() in x86 to
checking and reserve resource from firmware.

Also firmware need to make sure mmio assignments are valid otherwise
kernel will reject and reassign a new one.

Thanks

Yinghai
