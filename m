Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42690 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab2DZCzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 22:55:36 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 71E0C3EE0BC
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 11:55:34 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5980245DEAD
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 11:55:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4357A45DE9E
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 11:55:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 350611DB8040
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 11:55:34 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E2FED1DB803B
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 11:55:33 +0900 (JST)
From: "Taku Izumi" <izumi.taku@jp.fujitsu.com>
To: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Jiang Liu'" <liuj97@gmail.com>
Cc: "'Kenji Kaneshige'" <kaneshige.kenji@jp.fujitsu.com>,
	<linux-pci@vger.kernel.org>
References: <20120406115948.3536e6c8.izumi.taku@jp.fujitsu.com> <4F7E8DDD.7020603@jp.fujitsu.com> <20120406201628.1621752c.izumi.taku@jp.fujitsu.com> <4F805B32.1080401@gmail.com> <CAErSpo4tibFpTSr+KaUJtFt=S5zGm=s5-p42_wW0yUcGu9JzWg@mail.gmail.com>
In-Reply-To: <CAErSpo4tibFpTSr+KaUJtFt=S5zGm=s5-p42_wW0yUcGu9JzWg@mail.gmail.com>
Subject: RE: [PATCH] [RFC] PCI, ACPI, x86: MMCFG support for hotpluggable PCI hostbridges on x86, x86_64
Date: Thu, 26 Apr 2012 11:55:24 +0900
Message-ID: <09a201cd2358$06ce4cd0$146ae670$@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, April 26, 2012 2:14 AM
> To: Jiang Liu
> Cc: Taku Izumi; Kenji Kaneshige; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] [RFC] PCI, ACPI, x86: MMCFG support for hotpluggable PCI hostbridges on x86, x86_64
> 
> On Sat, Apr 7, 2012 at 9:20 AM, Jiang Liu <liuj97@gmail.com> wrote:
> > On 04/06/2012 07:16 PM, Taku Izumi wrote:
> >>
> >> This patch introduces the configuration for the base address of
> >> the memory mapped configuration space (MMCFG) for hotpluggable PCI
> >> hostbridges on x86 and x86_64.
> >>
> >> The MMCFG for hotpluggable host bridges must be described by using
> >> ACPI _CBA method. This patch adds implementation for _CBA method
> >> on ACPI pci_root driver and MMCFG manipulating functons for x86 and
> >> x86_64.
> >>
> >> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> >> ---
> >>  arch/x86/pci/mmconfig-shared.c |   61 ++++++++++++++++++++++++++++++++++-------
> >>  drivers/acpi/pci_root.c        |   28 ++++++++++++++++++
> >>  drivers/pci/pci.c              |   31 ++++++++++++++++++++
> >>  include/acpi/acnames.h         |    1
> >>  include/linux/pci.h            |    3 ++
> >>  5 files changed, 113 insertions(+), 11 deletions(-)
> 
> Taku, I'm ignoring this patch for now because I assume that Jiang
> Liu's series "[PATCH V4 0/6] PCI, x86: update MMCFG information when
> hot-plugging PCI host bridges" includes the same functionality.
> 
> If my assumption is wrong, please let me know.

 Hi Bjorn,
 Yes, you are right. Please ignore my former patch.
 I'm re-creating new patchset based on Liu's series.

 Best regarads,
 Taku Izumi



