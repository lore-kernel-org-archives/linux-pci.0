Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:40956 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbbCMOsq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2015 10:48:46 -0400
Received: by qgdq107 with SMTP id q107so26348845qgd.7
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2015 07:48:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150313113156.GA4739@bart.dudau.co.uk>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <20150312212306.GH7346@google.com> <20150313113156.GA4739@bart.dudau.co.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Mar 2015 09:48:25 -0500
Message-ID: <CAErSpo7KuchFy0U=80buz4oRKwn-tcwz1Ej9-hBZHg+a-eYCbw@mail.gmail.com>
Subject: Re: [PATCH v6 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	"x86@kernel.org" <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 13, 2015 at 6:31 AM, Liviu Dudau <liviu@dudau.co.uk> wrote:
> On Thu, Mar 12, 2015 at 04:23:06PM -0500, Bjorn Helgaas wrote:
>> On Mon, Mar 09, 2015 at 10:33:57AM +0800, Yijing Wang wrote:
>> > ...
>> > Yijing Wang (29):
>> >   PCI: Rip out pci_bus_add_devices() from pci_scan_bus()
>> >   PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
>> >   sparc/PCI: Claim bus resources before pci_bus_add_devices()
>>
>> I put the above patches plus a cleanup patch on my pci/enumeration branch.
>> Please rebase your next revision to that.  If there's anything else
>> non-controversial that we can pull in to chip away at this, let me know.
>
> Hi Bjorn and Yijing,
>
> Sorry for not providing feedback earlier on this series (or any previous ones),
> I'm just crawling out from under a rock of doing graphics drivers :)
>
> The patch ripping out pci_bus_add_devices() from pci_scan_root_bus() misses out
> the users of that function from drivers/pci/host. If Yijing is going to refresh
> the series it is probably worth starting with adding back the call into pcie-xilinx.c
> and pci-versatile.c.

Huh, sure enough, I missed those, too.  Yijing, when you add those,
can you pull my branch, update the patch, and repost it?  That way
you'll keep my changelog and cleanup updates.

Bjorn
