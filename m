Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:51773 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaFYEB3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 00:01:29 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so1232458qcz.9
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 21:01:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53A98A95.2030401@ti.com>
References: <53A98A95.2030401@ti.com>
Date: Wed, 25 Jun 2014 09:31:28 +0530
Message-ID: <CAHM4w1kSH0C3N3rfy9yCBNwUXZTJmzZt5rnsLBbgjG9DLY9L2A@mail.gmail.com>
Subject: Re: SATA AHCI controller detection during PCI enumeration
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 24, 2014 at 7:56 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> All,
>
> I have a board with PCI controller connected to a Marvell AHCI controller,
> 88SE9182 connected to a PCIe bus and the PCI scan doesn't show up the SATA
> end point. My question is in order to detect the EP,
> is it expected to have a hard drive connected to the SATA port?

No

> Currently with and without the SATA connected, the PCI scan doesn't
> show up the device. Also is there any other requirements at the
> hardware level to detect this SATA controller.

Does this PCIe2SATA card work with standard PC?

I do not know about this Marvell controller, but I remember one
silicon image controller which worked with only Gen1 host port.
You may ask card vendor if there is any such limitation.

~Pratyush

>
> Thanks in advance for your reply.
>
> Murali
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
