Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37306 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005AbbHKPLE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:11:04 -0400
Received: by wibhh20 with SMTP id hh20so200816427wib.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8c1e7f957cc5a6f0404b883c864b5145@jcornwall.me>
References: <8c1e7f957cc5a6f0404b883c864b5145@jcornwall.me>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Aug 2015 10:10:26 -0500
Message-ID: <CAErSpo6OLAjVde8St2kCoqx3h9hX9ki+X9Ojy0eFqugvBKRrwg@mail.gmail.com>
Subject: Re: PCIe 3.0 AtomicOp capabilities
To: Jay Cornwall <jay@jcornwall.me>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jay,

On Mon, Aug 10, 2015 at 1:36 PM, Jay Cornwall <jay@jcornwall.me> wrote:
> There is some interest in using the PCIe 3.0 AtomicOp capability with a
> subset of devices supported by drm/amdgpu.
>
> Adding this line to drm/amdgpu produced correct results in our tests:
> pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, 0x40);
>
> I have found only a handful of examples of capability use throughout
> drivers/. I see that the ARI capability is enabled if supported in
> drivers/pci/pci.c.
>
> Should the AtomicOp capabilities be similarly enabled if available? Or might
> there be a reason for doing this on a per-driver basis?

I think the PCIe capability structure (including device, link slot,
etc., capability, status, and control registers) should be managed by
the PCI core, not by individual drivers, because these things often
have implications beyond the scope of a driver.  There are some
existing cases where drivers fiddle with the PCIe capability, but I
try to avoid adding new ones.

I'm not very familiar with the AtomicOp functionality, but a quick
skim of the spec suggests that it does have system implications and
should be handled by the core.  For example, AtomicOp support is
optional, and it looks like it would be a bad idea to enable it in an
endpoint if the upstream switch didn't support it.

Bjorn
