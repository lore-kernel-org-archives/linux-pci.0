Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34744 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbINQFu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 12:05:50 -0400
Received: by vkhf67 with SMTP id f67so62177043vkh.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 09:05:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150914100929.GB18886@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
	<CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
	<20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150907091230.GB29293@red-moon>
	<20150914100929.GB18886@red-moon>
Date: Mon, 14 Sep 2015 09:05:50 -0700
Message-ID: <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 14, 2015 at 3:09 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> As I said, ARM is not the only platform affected, MIPS and possibly
> Alpha suffer from the same issue and I think it should be fixed
> in core code (I think __pci_bus_size_bridges() should ignore the
> old aperture size on first scan).

We could just revert
dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
arch code")
instead.

Yinghai
