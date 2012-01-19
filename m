Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48385 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2ASF0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2012 00:26:03 -0500
Received: by yhoo21 with SMTP id o21so1163944yho.19
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 21:26:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5xkXnibY2E56iWy4ARs573NQ_gfvBejiJigcORtHV4wg@mail.gmail.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003507.467.40594.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQX7-ceMTnh+wzDdNTMXYoea1Qt+H=nT0-Nwi3hj-Z81Ow@mail.gmail.com>
	<CAErSpo5xkXnibY2E56iWy4ARs573NQ_gfvBejiJigcORtHV4wg@mail.gmail.com>
Date: Wed, 18 Jan 2012 21:26:02 -0800
Message-ID: <CAE9FiQWdn05YQ8B-bMeCWjQUfqaXLYFjzxkcjyQx2DutnBduqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add struct pci_host_bridge and pci_scan_host_bridge()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2012 at 8:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> You're right.  x86 can't use pci_scan_host_bridge() yet, but most
> other architectures can, and I plan to convert them soon.

can you just add another list head in pci_bus struct?

then you can set up it when create_root_bus.

Thanks

Yinghai
