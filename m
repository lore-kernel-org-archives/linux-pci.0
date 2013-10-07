Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:46597 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3JGHTw convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:5:1>);
	Mon, 7 Oct 2013 03:19:52 -0400
Message-Id: <52527CB102000078000F91F3@nat28.tlf.novell.com>
Date: Mon, 07 Oct 2013 08:19:45 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Aaron Opfer" <me@aaronopfer.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Clemens Ladisch" <clemens@ladisch.de>,
	<xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] ASMedia ASM1083/1085 rev3 and Xen DMA Failure
References: <CAOsGJpcuNuaEsBHk9mV2Lh_qiygzgfLYigSsbDoBke1GJ_XG-Q@mail.gmail.com>
 <20131004172958.GA18743@google.com>
In-Reply-To: <20131004172958.GA18743@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 04.10.13 at 19:29, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Oct 02, 2013 at 04:43:46PM -0400, Aaron Opfer wrote:
>> First time submitting the kernel dev list, so if I have demonstrated
>> gross incompetence in some way, please cut me some slack. :)
>> 
>> I discussed with Clemens Ladisch an issue I was having that I thought
>> was related to the driver he authored for my soundcard, but on his
>> suggestion I experimented with other PCI devices and we have narrowed
>> the issue to the PCI Bridge.
>> 
>> What hints me toward DMA handling being the fault is the following
>> message I receive during kernel initialization after rebooting from an
>> Xen hypervisor into a baremetal-kernel, without a power-cycle:
>> 
>> [0.012815] dmar: DRHD: handling fault status reg 3
>> [0.012868] dmar: DMAR:[DMA Read] Request device [07:00.0] fault addr 7e00000
>> [0.012868] DMAR:[fault reason 02] Present bit in context entry is clear

That's a firmware or native Linux problem then - even during a
"warm" boot all settings a prior OS may have effected to the
hardware must be erased by the firmware (i.e. all components
have to undergo a sufficient level of resetting) for the new OS
to be permitted to make assumptions of the system coming up
in a reasonably consistent state. IOW either some assumption
made by native Linux is invalid, or the firmware doesn't make
sure a valid assumption actually holds.

Jan

