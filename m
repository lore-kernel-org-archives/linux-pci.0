Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752488AbcJYTk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Oct 2016 15:40:57 -0400
Subject: Re: [PATCH] PCI: pci-stub: accept exceptions to the ID- and
 class-based matching
To: Alex Williamson <alex.williamson@redhat.com>
References: <20161025182419.22910-1-lersek@redhat.com>
 <20161025124218.2696e55a@t450s.home>
 <fdce64d5-1610-5d68-81c2-58ed61c398f4@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Grigore <andrei.grg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jayme Howard <g.prime@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d777a8f1-4936-eb65-e392-c815bdf6d7e9@redhat.com>
Date: Tue, 25 Oct 2016 21:40:54 +0200
MIME-Version: 1.0
In-Reply-To: <fdce64d5-1610-5d68-81c2-58ed61c398f4@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/16 21:24, Laszlo Ersek wrote:
> On 10/25/16 20:42, Alex Williamson wrote:

>> FWIW, I think the reason
>> this hasn't been done to date is that PCI bus addresses (except for
>> root bus devices) are not stable.  Depending on the system, the address
>> of a given device may change, not only based on the slot where the
>> device is installed, but whether other devices in other slots are
>> populated.
> 
> I agree.
> 
> However, while the addresses are not stable in the face of hardware
> changes, I think the addresses don't change haphazardly (that is,
> without hardware changes).
> 
> So, if you plug in another card, your current pci-stub.except=...
> parameter might become invalid; but that's not very different from the
> case when you plug in the second instance of a preexistent card right
> now -- then the pci-stub.ids=... filter won't match uniquely anymore,
> and assignment vs. host-side use might not work as intented.

Sorry about the self-followup; I just wanted to add -- although it might
not carry a lot of weight for the host kernel -- that the libvirt domain
XML hard-codes the host-side PCI BDF anyway, for assigned devices:

http://libvirt.org/formatdomain.html#elementsHostDev

"""
  <devices>
    <hostdev mode='subsystem' type='pci' managed='yes'>
      <source>
        <address domain='0x0000' bus='0x06' slot='0x02' function='0x0'/>
      </source>
      ...
    </hostdev>
  </devices>

  ...

  source
    The source element describes the device as seen from the host using
    the following mechanism to describe:

    ...

    pci
      PCI devices can only be described by their address.
"""

Thanks
Laszlo
