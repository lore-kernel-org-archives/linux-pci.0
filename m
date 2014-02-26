Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38349 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaBZVDR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 16:03:17 -0500
Received: by mail-ie0-f182.google.com with SMTP id tp5so1219787ieb.41
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2014 13:03:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5165962.7bqj51B15Z@wuerfel>
References: <201402241200.21944.arnd@arndb.de> <CAErSpo5RV=w+DkgHSZZPOFGiEBBxMSraLV3TepYUZwDJuV+Jzg@mail.gmail.com>
 <5165962.7bqj51B15Z@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 26 Feb 2014 14:02:57 -0700
Message-ID: <CAErSpo5uHCOpMGxdbtBwvZEV0jNOBkBch0rG-VVwxdLJgCkUnA@mail.gmail.com>
Subject: Re: DMABOUNCE in pci-rcar
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-sh@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben-linux@fluff.org>,
	Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 26, 2014 at 12:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 26 February 2014 12:48:17 Bjorn Helgaas wrote:
>> On Mon, Feb 24, 2014 at 4:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Hi Magnus,
>> >
>> > I noticed during randconfig testing that you enabled DMABOUNCE for the
>> > pci-rcar-gen2 driver as posted in this patch https://lkml.org/lkml/2014/2/5/30
>> >
>> > I didn't see the original post unfortunately, but I fear we have to
>> > revert it and come up with a better solution, ...
>>
>> Sounds like I should drop the following patches from my pci/host-rcar
>> branch for now?
>>
>>   PCI: rcar: Add DMABOUNCE support
>>   PCI: rcar: Enable BOUNCE in case of HIGHMEM
>>   PCI: rcar: Make the Kconfig dependencies more generic
>
> Sounds good to me. The last patch is actually fine, but you'll have to
> fix the context to apply it without the other two.

OK, I dropped the DMABOUNCE and BOUNCE patches and force-updated my
"next" branch.

Bjorn
