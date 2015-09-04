Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33224 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260AbbIDQAg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2015 12:00:36 -0400
Received: by iofh134 with SMTP id h134so28882534iof.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2015 09:00:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150904141903.GA22997@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
Date: Fri, 4 Sep 2015 09:00:35 -0700
Message-ID: <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
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

On Fri, Sep 4, 2015 at 7:19 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> By keeping the bridge old size while sizing the bridge if the new size
> is < old size (ie bridge never shrinks), we implicitly assume that upon
> first scan of the bridge apertures that are not claimed should be set to
> size = 0 (ie as Bjorn said the size should be irrelevant in that case
> because we are sizing the bridge to figure out what the size should be),
> otherwise we might end up triggering issues as this thread shows because
> the old size is always taken into consideration.

oh, we have patches that will ignore old_size in last retry.

Please check

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-v4.3-next

exact patches should be:
https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=e8539db0a669fc076ac50800e274af165ce3c5fe
PCI: Treat optional as required in first try for bridge rescan

https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=a7a2e984194a051e77b88f59e2db030dd4d99e64
PCI: Get new realloc size for bridge for last try

Thanks

Yinghai
