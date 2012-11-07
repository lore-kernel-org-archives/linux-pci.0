Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60856 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab2KGXGI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2012 18:06:08 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so1391408wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Nov 2012 15:06:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
References: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 7 Nov 2012 16:05:47 -0700
Message-ID: <CAErSpo6-5LoivBabP1Mfq_46stRo0rf0J0sd4d1eCimkeJ=ODA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] acpi,pci: disentangle ACPI-related code and
 PCI-related code at hostbridge
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 30, 2012 at 12:21 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:

> Hi all,
>
>     This patchset is to disentangle ACPI-related code and PCI-related code
>     at hostbridge addition/removal code.
>     This is based on the comment Bjorn suggested at
>         http://marc.info/?l=linux-pci&m=134825820111705&w=2
>
>   * [PATCH 1/5] ACPI: Pass segment/bus to _PRT add/del so they don't depend on pci_bus
>   * [PATCH 2/5] PCI,ACPI: Add _PRT interrupt routing info before enumerating devices
>   * [PATCH 3/5] PCI,ACPI: Remove _PRT info when removing a host bridge
>   * [PATCH 4/5] PCI: Change the signature of pci_ext_cfg_avail function
>   * [PATCH 5/5] PCI,ACPI: Requesting _OSC control before scanning pci tree in acpi_pci_root_add()

I applied these to my pci/taku-prt-cleanup branch (based on
pci/yinghai-for-pci-root-bus-hotplug) as v3.8 material.  Yinghai's
patches already included 3/5, so that one was redundant.

Thanks!
