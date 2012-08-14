Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55191 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab2HNRib (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 13:38:31 -0400
Received: by lbbgj3 with SMTP id gj3so382163lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 14 Aug 2012 10:38:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com> <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Aug 2012 10:38:08 -0700
Message-ID: <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] resource: add PCI configuration space support
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 13, 2012 at 10:55 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Mon, Aug 13, 2012 at 10:00:45PM -0700, Bjorn Helgaas wrote:
>> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > This commit adds a new flag that allows marking resources as PCI
>> > configuration space.
>> >
>> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> > ---
>> > Changes in v3:
>> > - new patch
>> >
>> >  include/linux/ioport.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> > index 589e0e7..3314843 100644
>> > --- a/include/linux/ioport.h
>> > +++ b/include/linux/ioport.h
>> > @@ -102,7 +102,7 @@ struct resource {
>> >
>> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
>> >  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resource */
>> > -
>> > +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration space */
>>
>> What is the purpose of this?  It seems that you are marking regions
>> that we call MMCONFIG on x86, or ECAM-type regions in the language of
>> the PCIe spec.  I see that you set it in several places, but I don't
>> see anything that ever looks for it.  Do you have plans to use it in
>> the future?  If it really does correspond to MMCONFIG/ECAM, we should
>> handle those regions consistently across all architectures.
>
> The purpose is ultimately to obtain the MMCONFIG/ECAM resources assigned
> to a PCI host controller. I've used this in the of_pci_parse_ranges()
> and in the static board setup code to mark ranges as such. Perhaps
> IORESOURCE_ECAM or IORESOURCE_MMCONFIG might have been better names. I
> also just noticed that I'm not using this anywhere, but the plan was to
> eventually use it with platform_get_resource(). However that doesn't
> seem to work either because the lower bits of the flags aren't use for
> comparison in that function.
>
> Any other ideas how that could be handled? Basically what I need is a
> way to mark a resource as an MMCONFIG/ECAM range so that it can be used
> to program the PCI host controller accordingly. I don't know how these
> are assigned on x86. I was under the impression that the MMCONFIG/ECAM
> space was accessed through a single single address/data register pair.

The legacy config access mechanism (CF8h/CFCh registers described in
PCI 3.0 spec sec 3.2.2.3.2) is a single address/data pair, but this is
mostly x86-specific.  The ECAM mechanism (described in the PCIe 3.0
spec sec 7.2.2) is not a single address/data pair; instead, each byte
of config space is directly mapped into the host's MMIO space.

Here's what we do on x86 (omitting some historical grunge that
complicates things):

  - Discover the host bridge via a PNP0A08 device in the ACPI namespace.
  - Discover the bus number range behind the bridge using a _CRS
method in the PNP0A08 device.
  - Discover the ECAM space for those buses via a _CBA method in the
PNP0A08 device.
  - Tell the config accessors (struct pci_ops) that the ECAM space for
buses A-B is at address X.
  - Enumerate the devices behind the host bridge by calling
pci_scan_root_bus(), passing the config accessors.

It sounds like you want a way to parse the resources at one point,
saving them and marking the ECAM region, then at a later point, look
up the ECAM from a saved list.  We don't do that on x86 because the
config accessors keep an internal list of the ECAM area for each bus.

We do of course want to put this ECAM space in the IORESOURCE_MEM tree
because it consumes address space and we have to make sure we don't
put anything else on top of it.  But we don't have any reason to
describe the MMIO -> config space function in that tree.  From the
point of view of the rest of the system, it's just MMIO space that's
consumed by the PCI host bridge, just like any other device-specific
MMIO area.

Bjorn
