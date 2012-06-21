Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:52961 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab2FUM2S convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:7:1>);
	Thu, 21 Jun 2012 08:28:18 -0400
Message-Id: <4FE32FAA020000780008B157@nat28.tlf.novell.com>
Date: Thu, 21 Jun 2012 13:28:58 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Sherry Hurwitz" <sherry.hurwitz@amd.com>,
	"Wei Wang" <wei.wang2@amd.com>,
	"Andrew Cooper" <andrew.cooper3@citrix.com>,
	"Jeremy Fitzhardinge" <jeremy@goop.org>, <stable@kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	<linux-pci@vger.kernel.org>,
	"Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI/MSI: don't disable AMD IOMMU MSI on Xen dom0
References: <4FD72FE4.80009@amd.com>
 <4FD778C802000078000897EF@nat28.tlf.novell.com>
 <4FD76976.2020203@citrix.com>
 <4FD78DE6020000780008986D@nat28.tlf.novell.com> <4FD9D559.9050206@amd.com>
 <4FDA0ECD0200007800089FEA@nat28.tlf.novell.com> <4FDA0028.3090609@amd.com>
 <4FE30CBB020000780008B06B@nat28.tlf.novell.com><4FE30CBB020000780008B06B@nat28.tlf.novell.com>
 (Jan Beulich's message of "Thu, 21 Jun 2012 10:59:55 +0100")
 <8762ak9b29.fsf@xmission.com>
In-Reply-To: <8762ak9b29.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 21.06.12 at 13:08, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Jan Beulich" <JBeulich@suse.com> writes:
> 
>>>>> On 14.06.12 at 17:15, Wei Wang <wei.wang2@amd.com> wrote:
>>> Am 14.06.2012 16:18, schrieb Jan Beulich:
>>>> Have you at all considered getting this fixed on the kernel side?
>>>> As I don't have direct access to any AMD IOMMU capable
>>>> system - can one, other than by enumerating the respective
>>>> PCI IDs or reading ACPI tables, reasonably easily identify the
>>>> devices in question (e.g. via vendor/class/sub-class or some
>>>> such)? That might permit skipping those in the offending kernel
>>>> code...
>>> 
>>> AMD IOMMUs (both v1 and v2) uses class id 08 (System Base Peripheral) 
>>> and sub class id 06 (IOMMU). Combined with PCI_VENDEOR_ID_AMD, this 
>>> should be enough to identify amd iommu device. I could send you a kernel 
>>> patch for review using this approach. I would believe that fixing this 
>>> issue in 4.2, no matter how, is really important for amd iommu.
>>
>> As you didn't come forward with anything, here's my first
>> take on this:
>>
>> Commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0 ("PCI: msi: Disable msi
>> interrupts when we initialize a pci device") caused MSI to get disabled
>> on Xen Dom0 despite it having got turned on purposefully by the
>> hypervisor. As an immediate band aid, suppress the disabling in this
>> specific case.
>>
>> I don't think, however, that either the original change or this fix are
>> really appropriate. The original fix, besides leaving aside the
>> presence of a hypervisor like Xen, doesn't deal with all possible
>> cases (in particular it has no effect if the secondary kernel was built
>> with CONFIG_PCI_MSI unset). And taking into account a hypervisor like
>> Xen, the logic like this should probably be skipped altogether (i.e. it
>> should be entirely left to the hypervisor, being the entity in control
>> of IRQs).
> 
> The original fix is fine. Xen dom0 remains insane.  Although perhaps
> some better than Xen dom0 once was.
> 
> Why does the dom0 kernel even get any access to pci devices that
> Xen doesn't want it to touch?
> 
> As far as I can tell my patch has revealed a design bug in Xen.  If you
> don't want to be messed up by the kernel don't let the kernel touch
> things.

I rather think this is a design bug of the AMD IOMMU - it should
never have got surfaced as a PCI device.

Furthermore, fully hiding _any_ PCI device from Dom0 has its
own set of problems - depending on the nature of the device,
full emulation of all devices may become necessary to get this
implemented (because this can implicitly hide other devices, or
the Dom0 kernel re-assigning BARs could get in conflict with
what the hidden devices use).

Xen's model has always been to allow Dom0 full control over all
peripherals and bridges, so if all of the sudden PCI devices of
other kinds show up, we can't simply re-model everything.

>  At the very least we need an abstraction much cleaner
> than the patch below.

Probably - any suggestion? As said in the mail I sent, this is
meant to overcome the immediate problem, and a more
permanent fix would be desirable (ideally suppressing the
playing with the MSI related data altogether, following the
rest of the MSI support in Xen/Dom0).

Jan

