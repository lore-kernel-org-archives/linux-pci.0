Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32953 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267AbbFBQco (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2015 12:32:44 -0400
Received: by qkhg32 with SMTP id g32so103996776qkh.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2015 09:32:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150602145510.GE23650@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Jun 2015 11:32:23 -0500
Message-ID: <CAErSpo4+dGM4_FSk2BXq+QkC1s98CaFXm+zU_+zebnQNpoVBZA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 2, 2015 at 9:55 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, May 27, 2015 at 10:04:47PM +0100, Bjorn Helgaas wrote:

>> I really like the idea of pushing this into pci_read_bridge_io().
>>
>> I wonder if we can do the same with pci_read_bridge_mmio_pref(), and
>> somehow get rid of pci_bridge_check_ranges() altogether?
>>
>> I think I looked at doing that a while back, and it seems like there was
>> some wrinkle, but I don't remember what it was.
>
> While at it, do you think it is reasonable to also claim the bridge
> windows (resources) in the respective pci_read_bridge_* calls ?

I *do* think that's reasonable, and I think it would simplify some
things.  Of course, we can only claim them if firmware has already
programmed them.  If firmware hasn't done anything, the claim should
fail and we can treat it as an unassigned resource and allocate and
claim the space later.

I'm sure we'll trip over some issues when trying this, but it seems
like a logical thing to do, so I think it'd be great if you tried it
out.

Bjorn
