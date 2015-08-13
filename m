Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:31305
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751590AbbHMNbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 09:31:25 -0400
Subject: Re: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
To: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com> <20150805092318.GB6092@arm.com>
CC: Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Ming Lei <ming.lei@canonical.com>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <55CC98AE.5010604@amd.com>
Date: Thu, 13 Aug 2015 20:16:30 +0700
MIME-Version: 1.0
In-Reply-To: <20150805092318.GB6092@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 8/5/15 16:23, Will Deacon wrote:
> On Wed, Aug 05, 2015 at 12:49:56AM +0100, Bjorn Helgaas wrote:
>> >On Wed, Aug 05, 2015 at 02:23:38AM +0530, Jayachandran C wrote:
>>> > >The current code in pci-host-generic.c uses pci_common_init_dev()
>>> > >from arm architecture to do some part of the PCI setup, and this
>>> > >prevents it from being used with arm64 architecture.
>>> > >
>>> > >The part of pci_common_init_dev() that is really needed by
>>> > >pci-host-generic.c is very limited and can be done in the same
>>> > >file without using hw_pci API of ARM. The ARM platform requires
>>> > >a pci_sys_data as sysdata for the PCI bus, this can be handled by
>>> > >setting up gen_pci to have a pci_sys_data variable as the first
>>> > >element.
>>> > >
>>> > >Signed-off-by: Jayachandran C<jchandra@broadcom.com>
>>> > >Acked-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
>>> > >Tested-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
>>> > >Tested-by: Pavel Fedin<p.fedin@samsung.com>
>> >
>> >I applied all three of these to my pci/enumeration branch for v4.3.
>> >
>> >I made a few changes, the most important being to call
>> >pcie_bus_configure_settings() before pci_bus_add_devices(), because drivers
>> >may claim devices in pci_bus_add_devices(), and the PCI core shouldn't
>> >touch devices after drivers claim them.
>> >
>> >I dropped the acks and tested-by because of that change, but I'll happily
>> >add them back if Lorenzo and Pavel confirm.  The patches are here if you
>> >want to review/test them:
>> >
>> >https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration
>> >
>> >I'm sure the other patches on that branch will need some tweaks, too, so I
>> >don't have any problem with updating these.

I have also tested on AMD Seattle (w/ non-PROBE_ONLY mode).

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
