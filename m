Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45484 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbbBFRx5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Feb 2015 12:53:57 -0500
Received: by iecrd18 with SMTP id rd18so3110437iec.12
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2015 09:53:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54D4DD95.7000303@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <20150206151542.GD23190@e104818-lin.cambridge.arm.com> <54D4DD95.7000303@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Feb 2015 11:53:35 -0600
Message-ID: <CAErSpo6GOXHeKKfU8s5jCS3+Mui=HupZd=jpkLEyWAE94Ory5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 6, 2015 at 9:28 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 02/06/2015 10:15 AM, Catalin Marinas wrote:
>>
>> On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
>>>
>>> This patch add an important capability to PCI driver on Keystone. I hope
>>> to
>>> have this merged to the upstream branch so that it is available for
>>> v3.20.
>>
>> It's very late for 3.20 and the code hasn't been in linux-next at all
>> (but it's not me who's merging this code), unless you can squeeze it in
>> as a bug-fix.
>
> This is in fact a bug fix as PCI on Keystone is broken without this.

Oh, sorry, I didn't realize that this was so urgent.  I guess I read
"this adds an important capability" in the cover letter and concluded
that it was new functionality.

Anyway, if it's broken, presumably PCI on Keystone *did* work at one
point.  Can you identify the commit that broke it and requires these
fixes, so we can figure out how far the fixes need to be backported?

If I merge it, I would like to get into my for-linus branch and get a
little time in -next before asking Linus to pull it.  The merge window
is a little wrinkle there -- I don't like to add new things to the mix
during the window.  But if it's an important fix we can still get it
in before the final v3.20.

Bjorn
