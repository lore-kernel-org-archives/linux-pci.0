Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53588 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757928Ab2IGWIs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:08:48 -0400
Received: by lbbgj3 with SMTP id gj3so132372lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:08:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
 <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net> <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 15:08:26 -0700
Message-ID: <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2012 at 8:45 PM, Zang Roy-R61911 <r61911@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
>> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Liu Shengzhou-B36685
>> Sent: Thursday, July 26, 2012 11:45 AM
>> To: bhelgaas@google.com; linux-pci@vger.kernel.org; akpm@linux-
>> foundation.org
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
>> Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
>> MSI/INTx interrupt
>>
>> Hello,
>>
>> A gentle reminder!
>> Any comments are appreciated.
>
> Who can help to review and pick up this patch?

I merged this to a staging branch and will merge it to my "next"
branch as soon as it gets a build/smoke test by Fengguang.  Thanks!

Bjorn
