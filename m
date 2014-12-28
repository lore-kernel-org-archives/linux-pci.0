Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:62407 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaL1BXK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Dec 2014 20:23:10 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so8490619qcq.11
        for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2014 17:23:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141227103655.GA27544@e102568-lin.cambridge.arm.com>
References: <1415637706-2195-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141120225449.GD7987@google.com> <20141227103655.GA27544@e102568-lin.cambridge.arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 27 Dec 2014 18:22:49 -0700
Message-ID: <CAErSpo6KA2jbs_aqXYRHjcxAnuXhxzGH2P=xv4udJWeRvve78A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] drivers: pci: move PCI domain assignment to
 generic PCI code
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 27, 2014 at 3:36 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Bjorn,
>
> On Thu, Nov 20, 2014 at 10:54:49PM +0000, Bjorn Helgaas wrote:
>> On Mon, Nov 10, 2014 at 04:41:46PM +0000, Lorenzo Pieralisi wrote:
>> > The current logic used for PCI domain assignment in arm64
>> > pci_bus_assign_domain_nr() is flawed in that, depending on the host
>> > controllers configuration for a platform and the respective initialization
>> > sequence, core code may end up allocating PCI domain numbers from both DT and
>> > the core code generic domain counter, which would result in PCI domain
>> > allocation aliases/errors.
>> >
>> > This patch fixes the logic behind the PCI domain number assignment and
>> > moves the resulting code to generic PCI core code so that the same domain
>> > allocation logic is used on all platforms selecting
>> >
>> > CONFIG_PCI_DOMAINS_GENERIC
>> >
>> > instead of resorting to an arch specific implementation that might end up
>> > duplicating the PCI domain assignment logic wrongly.
>> >
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Liviu Dudau <liviu.dudau@arm.com>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>
>> Applied with Liviu and Arnd's acks to pci/domain for v3.19, thanks.
>>
>> It doesn't matter whether I'm in the to: or cc: list.  The important thing
>> is that it appears on the linux-pci list, because I use patchwork as my
>> to-do list, and patchwork only vacuums up stuff from linux-pci.
>
> This patch has not been merged last cycle and it is a prerequisite for
> the ARM pcibios domain code removal patchset you merged in your pci/domain
> branch. Please consider pulling it there so that the ARM pcibios domain
> removal patchset can be based correctly on top of this patch, at the
> moment it can't compile (see kbuild test report).

Huh, I can't remember why I didn't merge that for v3.19.  Maybe I just
missed it by mistake.

Anyway, I picked that patch into pci/domain for another try.

Bjorn
