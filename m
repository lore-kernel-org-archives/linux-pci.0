Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeIEFj4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 01:39:56 -0400
Subject: Re: RFC on PCI Device Lock
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
 <20180904165202.4e5bb59d@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
Date: Tue, 4 Sep 2018 18:12:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180904165202.4e5bb59d@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 3:52 PM, Alex Williamson wrote:
> I won't deny that we're getting a little sloppy with some of the reset
> interfaces and I'd love to solve the device lock issue more generally,
> but trying to abstract slot vs bus and hide the lower level interfaces
> from drivers doesn't seem like it's really working here.  Thanks,

Counter argument is that drivers need to know about bus/slot distinction
and call two different API for hotplug capable systems. I think that's
too much to ask.

The motivation for original patch was that hotplug information was leaking
and we could do a better job about it. But, you are right; I partially
covered VFIO needs as it seemed to be doing more work than a simple
reset due to ownership dependencies.
