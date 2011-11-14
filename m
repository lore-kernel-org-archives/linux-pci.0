Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61205 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1KNRhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 12:37:36 -0500
Received: by vws1 with SMTP id 1so5282396vws.19
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2011 09:37:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110826142424.4757cfe9@jbarnes-desktop>
References: <20110823161643.27268.89203.stgit@bhelgaas.mtv.corp.google.com> <20110826142424.4757cfe9@jbarnes-desktop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 14 Nov 2011 10:37:14 -0700
Message-ID: <CAErSpo6KSYqyj_oOVLo=rQFPZhE=CawZrhcF3TJT4sjnev9G+g@mail.gmail.com>
Subject: Re: [PATCH] PCI hotplug: shpchp: don't blindly claim non-AMD 0x7450
 device IDs
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Ralf Jung <ralfjung-e@gmx.de>,
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 26, 2011 at 3:24 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Tue, 23 Aug 2011 10:16:43 -0600
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> Previously we claimed device ID 0x7450, regardless of the vendor, which is
>> clearly wrong.  Now we'll claim that device ID only for AMD.
>>
>> I suspect this was just a typo in the original code, but it's possible this
>> change will break shpchp on non-7450 AMD bridges.  If so, we'll have to fix
>> them as we find them.
>
> Applied to my for-linus branch, thanks.

Jesse, I think this one got lost (at least, I don't see it in the
current upstream tree).

Bjorn
