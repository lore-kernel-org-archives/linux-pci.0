Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og124.obsmtp.com ([64.18.0.212]:34719 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754036AbbDIRVW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 13:21:22 -0400
Received: by oblw8 with SMTP id w8so141830399obl.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 10:21:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
References: <cover.1425497218.git.dhdang@apm.com> <ca98e05f8a8dabdc6cc5b6e8c3ce50cf4e900fac.1425497218.git.dhdang@apm.com>
 <5509BE7C.1000901@arm.com> <CADaLNDn0V8F27Yu1-j8H0Dw2t-Ac04TZcbtsg++ALdB4orXrUQ@mail.gmail.com>
 <5509C951.30402@arm.com> <CADaLNDnhbR+i3b7X2zE7Fyou55Pu8qv-6QxpnRf4hqfq=0XyJQ@mail.gmail.com>
 <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 9 Apr 2015 10:20:51 -0700
Message-ID: <CADaLNDmgv-kvxRvk70rEOEh_xTifO2AOzJ6tH13Av_+=f7gfvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Loc Ho <lho@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On Wed, Apr 8, 2015 at 12:44 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Tue, 7 Apr 2015 20:56:48 +0100
> Duc Dang <dhdang@apm.com> wrote:
>
> Hi Duc,
>
>> On Wed, Mar 18, 2015 at 11:52 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > On 18/03/15 18:29, Duc Dang wrote:
>> >> On Wed, Mar 18, 2015 at 11:05 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >>> On 04/03/15 19:39, Duc Dang wrote:
>> >>>> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
>> >>>> 16 HW IRQ lines.
>> >>>>
>> >>>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> >>>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> >>>
>> >>> I just had a quick look at this, and this seems to be going in the exact
>> >>> opposite direction compared to what we now have on arm64, where we move
>> >>> away from using struct msi_controller for most thing, and implement PCI
>> >>> MSI/MSIX in a generic way, using MSI domains.
>> >>>
>> >>> I suggest you have a look at how GICv2m and GICv3 ITS implement the MSI
>> >>> support. You can also have a look at what I did for the Tegra MSI
>> >>> controller in this patch:
>> >>>
>> >>> https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081
>> >>>
>> >>> Eventually, the plan is to kill msi_controller entirely, so introducing
>> >>> new drivers that rely on it is not something I'm eager to see.
>> >>
>> >> Thanks, Marc.
>> >>
>> >>  X-Gene 1 MSI is handled by separate MSI controller block, so its
>> >> driver implementation is different from GICv2m and GICv3. I will refer
>> >
>> > It will certainly be different in the sense that you won't use a stacked
>> > domain on top of the GIC. But what I want to see is the use of a generic
>> > pci_msi_domain on top of an irq_domain, just like we have on v2m and v3.
>> > Thomas has also been vocal enough about that in the past, and x86 is
>> > going down that road as well.
>> >
>> >> to what you did for Tegra MSI, but I don't see your latest changes in
>> >> 4.0-rc4. Is the change you made for Tegra MSI going to mainline soon?
>> >
>> > Not yet. As you can see in this branch, this relies on some other
>> > cleanups. But you can already convert most of your driver and put it in
>> > the shape that matches what we have for v2m and v3. Once the required
>> > cleanups are in, I'll remove the last traces of msi_controller myself if
>> > necessary.
>> >
>>
>> Hi Marc, Bjorn,
>>
>> I follow Marc's suggestion and convert my X-Gene 1 MSI driver to
>> remove msi_controller struct and use generic pci_msi_domain on top of
>> an irq_domain. The code requires Marc's changes in
>> irq/kill-msi-controller branch to be compiled and function correctly,
>> so I plan to post the patch on top of Marc's tree. Please let me know
>> if you think I should have different approach to post this patch.
>
> I don't think you should rely on this branch just yet (this is why I
> suggested matching what we currently have for GICv2m and v3). Keeping
> msi_controller is fine at the moment, even if we only use to store the
> MSI domain. If and when this series makes it to mainline, I'll go over
> the individual drivers to convert them to the new scheme, just like I
> did for GIC and Tegra.
>
>> Another question I have is when do you plan to roll out this hierarchy
>> irq domain implementation for MSI, as I see some of Marc's changes to
>> kill msi_controller structure and implement MSI irq domain still does
>> not get into Bjorn's tree.
>
> I'm still tinkering with it (I have some long standing comments from
> Bjorn to address), and I'm working on non-PCI MSI support at the moment.
>
> But the core MSI irq domain stuff is already in (this is what GICv2m
> and GICv3 ITS are using), and this should be an easy thing to convert
> your code.
>
> Please let me know if I can be of any help.
>

Thanks for your suggestion. I converted my code using the core MSI irq
domain (similar to GICv2m, still have msi_controller structure) and
posted
a new version (v3) of this patch. Can you please take a look when you
have some time?

Regards,
Duc Dang.

> Thanks,
>
>         M.
> --
> Without deviation from the norm, progress is not possible.
