Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46991 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756793Ab3C2VYN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Mar 2013 17:24:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
Date: Fri, 29 Mar 2013 22:31:42 +0100
Message-ID: <5381191.45N5KLLmWJ@vostro.rjw.lan>
In-Reply-To: <5155A101.2090705@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz> <1364545211.1817.228.camel@yhuang-dev> <5155A101.2090705@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 29, 2013 03:11:13 PM Martin Mokrejs wrote:
> Hi Ying,
>   thank you for the patch. Here are the results.
> 
> Huang Ying wrote:
> > On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
> >> Hi Ying,
> >>   would you please tell me how this report relate to this patch?
> >>
> >> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
> >>
> >>   Could you tell me why this PME was being flipped back and forth now?
> >> Actually, does that make finally some sense to you, pci/acpi devs?

Can you please test this patch:

https://patchwork.kernel.org/patch/2359611/

and report back as I asked you?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
