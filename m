Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33579 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab2DYPnB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 11:43:01 -0400
Received: by lbbgf7 with SMTP id gf7so201988lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 08:43:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADLM8XMY6ndFoEWJuHkH5gUKQYVgf9pRTZGT_r-AGxYJK06C0Q@mail.gmail.com>
References: <CADLM8XMY6ndFoEWJuHkH5gUKQYVgf9pRTZGT_r-AGxYJK06C0Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Apr 2012 09:42:39 -0600
Message-ID: <CAErSpo5gufQSp0NaeCFp_vw4FU076o-VD6jxGrcUUH2JKx4Gbg@mail.gmail.com>
Subject: Re: What is the value of pci_bus.primary of Bus#0
To: Wei Yang <weiyang.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 9:21 AM, Wei Yang <weiyang.kernel@gmail.com> wrote:
> I go through the code and curious about the value of pci_bus.primary
> of Bus#0, the root bus.

There is no such thing as "the root bus."  There may be many root buses.

> On x86, the root bus is get by,
>     root->bus = pci_acpi_scan_root(root);
>
> While I scan the code not find some place set the *primary* field.
>
> I think this value indicate the upstream bus number, while for root
> bus, this value should be?
> So this value of the root bus is any value? Or some restriction?

The primary/secondary/subordinate fields in struct pci_bus are really
properties of the upstream P2P bridge.  Primary is the bus number of
the P2P bridge primary (upstream) interface.  In the case of a "root
bus," i.e., the bus immediately below a PCI host bridge, there is no
upstream P2P bridge, so primary is meaningless.

Bjorn
