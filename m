Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:65443 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965829AbbBCQuV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 11:50:21 -0500
Received: by mail-qg0-f54.google.com with SMTP id q108so53260492qgd.13
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2015 08:50:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87h9v42p22.fsf@spindle.srvr.nix>
References: <8761boas78.fsf@spindle.srvr.nix> <1422847799.2491.13.camel@zim.stowe>
 <87h9v42p22.fsf@spindle.srvr.nix>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Feb 2015 10:50:00 -0600
Message-ID: <CAErSpo4SKP=nKdn43rE37JFNW5SSb4uRyRyO6vAO5tqa2TOpQg@mail.gmail.com>
Subject: Re: [3.18.3 BISECTED REGRESSION] scx200_acb / cs5535-smb / geodewdt /
 cs5535-clockevt torpedoed
To: Nix <nix@esperi.org.uk>
Cc: Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Bill Unruh <unruh@physics.ubc.ca>, martin@lucina.net,
	Matthew Wilcox <willy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 2, 2015 at 11:36 AM, Nix <nix@esperi.org.uk> wrote:
> On 2 Feb 2015, Myron Stowe verbalised:
>
>> Nix:
>>
>> Thanks for the work you've already done with the bisection.  Let's see
>> if we can get to the bottom of this.  Would you capture two couple sets
>> of logs, one without the issue and another set with the commit at issue
>> included for comparison.

>  pci 0000:00:14.0: [1022:2090] type 00 class 0x060100
> -pci 0000:00:14.0: reg 0x10: [io  0x6000-0x7fff]
> -pci 0000:00:14.0: reg 0x14: [io  0x6100-0x61ff]
> -pci 0000:00:14.0: reg 0x18: [io  0x6200-0x63ff]
>  pci 0000:00:14.0: CS5536 ISA bridge bug detected (incorrect header); workaround applied

> +scx200_acb: can't allocate io 0x0-0x7

I think the problem is that these three BARs are read-only.  Prior to
36e8164882ca, we didn't detect that, and we computed the size based on
the lowest order bit that was set in the address.  This gave us
incorrect sizes, but it did work in the sense that the driver could
operate the device.

After 36e8164882ca, we detect that the BARs are read-only and ignore
them completely, which breaks this case because we don't mark the
resource as I/O and we don't fill in the starting address, so even
though the quirk runs, it just sets the first resource to [???
0x0000-0x0007], which doesn't work.

I think this is the right behavior for the PCI core because we can't
tell how big these BARs are.  The only alternative is to assume they
are as big as possible given their current addresses.  But that would
mean a 4KB read-only BAR that happened to be aligned on a 2GB boundary
would have to consume 2GB of address space, and *that* doesn't seem
reasonable.

We already have a quirk for this device, so I think the best fix is to
change the quirk so it reads these three BARs directly and restores
the resources based on its hard-coded knowledge of how big they are.

Bjorn
