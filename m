Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35413 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964882AbdGTWxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 18:53:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170720161554.45ce1673@ul30vt.home>
References: <20170720214101.7449-1-roland@kernel.org> <20170720161554.45ce1673@ul30vt.home>
From: Roland Dreier <roland.dreier@gmail.com>
Date: Thu, 20 Jul 2017 15:53:04 -0700
Message-ID: <CAG4TOxOrF9aLyujrwNmSsxPBWBPTaLx2yXkOJ88gxCj0QUGDow@mail.gmail.com>
Subject: Re: [PATCH] PCI: Update ACS quirk for more Intel 10G NICs
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Emil Tantilov <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 20, 2017 at 3:15 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:

> Most of the ACS capabilities are worded as "Must be implemented by
> devices that implement ..."  Shouldn't a hard-wired ACS capability
> sufficiently describe that, or is there something wrong with how
> they're hard wired?

Interesting question.  I just looked at what the PCI spec says about
the various bits for ACS functions in multi-function devices.  Many of
the functions are "must not be implemented."  Of the ones that are
"must be implemented if..." the key is that the if is for devices that
support peer-to-peer traffic.

I think the Intel NICs are compliant with the spec - they don't
support any ACS mechanisms for controlling peer-to-peer traffic, but
they also don't implement peer-to-peer traffic.  This means that the
PCI standard way of knowing that it is safe to assign individual
functions does not prove it is safe - but with device-specific
knowledge we do know it is safe.  Hence a quirk to give that
device-specific information to the kernel.

 - R.
