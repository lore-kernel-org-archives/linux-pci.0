Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbdA1Q1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jan 2017 11:27:47 -0500
Date: Sat, 28 Jan 2017 08:05:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Virtual functions numbering (SRIOV) - why odd numbers are not
 used ?
Message-ID: <20170128080510.436f0cb7@t450s.home>
In-Reply-To: <CAGXs5wVy0CPQB_NCsM+sSny4wj61p-gRAsTVbdSi_6drmz6TGg@mail.gmail.com>
References: <CAGXs5wVy0CPQB_NCsM+sSny4wj61p-gRAsTVbdSi_6drmz6TGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 28 Jan 2017 13:28:25 +0200
Kevin Wilson <wkevils@gmail.com> wrote:

> Hello,
> I had noticed that whenever I create virtual function on Nic devices,
> the numbering scheme is the same:
> the the last digit of first VF is .0, of the second one is .2, the
> third is .4, and so on; and no odd number are used.
> 
> For example, with Intel IXGBE nic, we have:
> 
> 
> echo 4 > /sys/bus/pci/devices/0000:06:00.0/sriov_numvfs
> 
> lspci | grep "Virtual Function"
> 06:10.0 Ethernet controller: Intel Corporation 82599 Ethernet
> Controller Virtual Function (rev 01)
> 06:10.2 Ethernet controller: Intel Corporation 82599 Ethernet
> Controller Virtual Function (rev 01)
> 06:10.4 Ethernet controller: Intel Corporation 82599 Ethernet
> Controller Virtual Function (rev 01)
> 06:10.6 Ethernet controller: Intel Corporation 82599 Ethernet
> Controller Virtual Function (rev 01)
> 
> Does anybody know what is the reason that odd numbers are not used ?
> are they kept for something else ?
> For example, why don't we get : 06:10.0,06:10.1,06:10.2,06:10.3 in this case ?

The SR-IOV capability defines the offset and stride for VFs.  On Intel
devices the stride is typically 2, so you get this even number VF
layout, but only on the even numbered PF.  The odd numbered PF
typically fills in the gaps, creating only odd numbered VFs.  In any
case, it's the card vendor that defines the VF layout via the SR-IOV
capability parameters.  Thanks,

Alex
