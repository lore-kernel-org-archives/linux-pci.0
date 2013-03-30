Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48082 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab3C3WKl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 30 Mar 2013 18:10:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
Date: Sat, 30 Mar 2013 23:18:13 +0100
Message-ID: <8031557.xcL7PI6L4K@vostro.rjw.lan>
In-Reply-To: <515725B0.60605@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz> <5156457C.9020201@fold.natur.cuni.cz> <515725B0.60605@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, March 30, 2013 06:49:36 PM Martin Mokrejs wrote:
> Martin Mokrejs wrote:
> > Rafael J. Wysocki wrote:
> >> On Saturday, March 30, 2013 02:17:38 AM Martin Mokrejs wrote:
> >>> Rafael J. Wysocki wrote:
> >>>> On Friday, March 29, 2013 03:11:13 PM Martin Mokrejs wrote:
> >>>>> Hi Ying,
> >>>>>   thank you for the patch. Here are the results.
> >>>>>
> >>>>> Huang Ying wrote:
> >>>>>> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
> >>>>>>> Hi Ying,
> >>>>>>>   would you please tell me how this report relate to this patch?
> >>>>>>>
> >>>>>>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
> >>>>>>>
> >>>>>>>   Could you tell me why this PME was being flipped back and forth now?
> >>>>>>> Actually, does that make finally some sense to you, pci/acpi devs?
> >>>>
> >>>> Can you please test this patch:
> >>>>
> >>>> https://patchwork.kernel.org/patch/2359611/
> >>>>
> >>>> and report back as I asked you?
> >>>
> >>> Sorry for the delay I just had to sort out what belongs under what thread
> >>> and the patch was under the other. But I agree its testing with this
> >>> particular eSATA/ExpressCardSlot/PM fits better here.
> >>>
> >>>
> >>> The good news is that the eSATA card hotplug works almost perfectly with the patch.
> >>> I cold booted as always with the card in the slot already loaded, same kernel
> >>> .config and commandline options as described under this thread. But the kernel
> >>> was 3.8.3! Not 3.9-rc1.
> >>
> >> Good.  The goal was to fix the problem with eSATA hotplug.
> > 
> > I thought that was aimed at the XHCI dead port issue. ;-)
> 
> Hi,
>   first of all, a big fat note. The tests with 3.8.2 and 3.8.2 I always did with aciphp
> and pcie_aspm=off. I somehow forgot about that and yesterday after testing the
> patch from Huang Ying when it turned out the patch actually not only helps with the
> dead xHCI port due to suspend but incidentally also fixes the eSATA card hotplug ...

Which patch you're talking about?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
