Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:13754 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2GYWpb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 18:45:31 -0400
Message-ID: <50107709.2000301@tilera.com>
Date: Wed, 25 Jul 2012 18:45:29 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] tilegx pci: fix semantic merge conflict with 3527ed81c
References: <201207251946.q6PJklUm016228@farm-0002.internal.tilera.com> <CAErSpo7P4jCw=gTDR3JabY1F46xWiTF6ru90T86NzuT7Pxu1_A@mail.gmail.com>
In-Reply-To: <CAErSpo7P4jCw=gTDR3JabY1F46xWiTF6ru90T86NzuT7Pxu1_A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/25/2012 5:16 PM, Bjorn Helgaas wrote:
> On Wed, Jul 25, 2012 at 1:40 PM, Chris Metcalf <cmetcalf@tilera.com> wrote:
>> > Yinghai Lu removed pci_bus.subordinate in pci-next, which meant that
>> > the tile-next changes to add tilegx PCI support don't build.  This
>> > was expected (seen in linux-next) and this one-line fix is along
>> > the same lines as commit b918c62e for all other architectures.
>> >
>> > Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> You pushed the other tile changes, so I assume you'll do the same with
> this one.  

I will, thanks!

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

