Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20141030170913.GA6982@google.com>
References: <1414621570-20777-1-git-send-email-yinghai@kernel.org>
	<20141030170913.GA6982@google.com>
Date: Thu, 30 Oct 2014 11:57:56 -0700
Message-ID: <CAE9FiQVU7F=MXUVEwmemz61=TbL5imFecHexUik+3DtqWKOHGA@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix sriov enabling with virtual bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 10:09 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rafael, linux-acpi]

> This raises the question of what the correct behavior should be.  Your
> patch certainly avoids the NULL pointer dereference.  It does so by making
> acpi_pci_get_bridge_handle() fail gracefully, which means we will not look
> for _HPP/_HPX for VF devices.  Is that what we want?
>
> Most of the fields included in _HPX are read-only or not applicable for
> VFs, but we need to at least ask the question of whether we want to
> completely ignore _HPX for VFs.  If we do, I think maybe we should make
> that more explicit in the code, e.g., by adding an explicit test of
> dev->is_virtfn, instead of relying on this special case behavior of
> acpi_pci_get_bridge_handle() that in turn depends on the obscure property
> of a VF not having a bridge device.
>
> Personally, I think that since the _HPX spec doesn't mention VFs at all, we
> might want to assume that _HPX should apply to VFs, just like it applies to
> PFs.  I can imagine future _HPX record formats, or non-ACPI firmware
> configuration hints, that *would* apply to VFs, so it seems like it would
> be pretty arbitrary to say "we won't configure VF devices at all."

Yes, VF should be treated as PF if possible.

>
>> Add checking with pbus->slef and bail out early.
>>
>> Fixing: commit 6cd33649fa83 ("PCI: Add pci_configure_device() during enumeration")
>
> Thanks for including this, but why not use the same format everybody else
> does:
>
> Fixes: 6cd33649fa83 ("PCI: Add pci_configure_device() during enumeration")

will do that later. Is that formalized ?
checkpatch.pl only need 12 commit code, and (" ..") format.

Yinghai
