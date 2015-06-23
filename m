Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35859 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933968AbbFWXCf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2015 19:02:35 -0400
Received: by wicnd19 with SMTP id nd19so119547668wic.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2015 16:02:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435099588.3996.14.camel@kernel.crashing.org>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon> <1435099588.3996.14.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 23 Jun 2015 18:02:14 -0500
Message-ID: <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 23, 2015 at 5:46 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-06-02 at 15:55 +0100, Lorenzo Pieralisi wrote:
>> While at it, do you think it is reasonable to also claim the bridge
>> windows (resources) in the respective pci_read_bridge_* calls ?
>
> No, don't claim in read. There's a clear distinction between gathering
> resources and claiming them, and we need to keep that.
>
> Some fixups might happen in between the two for example.

Are there any existing fixups like that?  Concrete examples would help
figure out the best way forward.

Most arches call pci_read_bridge_bases() from pcibios_fixup_bus().  I
think that's a poor place to do it because it's code that normally
doesn't have to be arch-specific.  Resource claiming is also usually
done from arch code, and it shouldn't be arch-specific either.

If we move both the read and claim into generic code, then we might
need to make sure there's a fixup phase in between or something.

Bjorn
