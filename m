Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:59597 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752656Ab3DAMGr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 08:06:47 -0400
Message-ID: <51597852.2090404@fold.natur.cuni.cz>
Date: Mon, 01 Apr 2013 14:06:42 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <515813CB.8020001@fold.natur.cuni.cz> <5158C400.1030307@fold.natur.cuni.cz> <1470228.eBkmnakpna@vostro.rjw.lan>
In-Reply-To: <1470228.eBkmnakpna@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Rafael J. Wysocki wrote:
> On Monday, April 01, 2013 01:17:20 AM Martin Mokrejs wrote:
>> [ also +Len Brown -- would you please comment what the ACPI-related bug in BIOS
>>  could be causing? Should be the message be logged also under 3.8.3? It does
>>  NOT happen! ]
> 
> What BIOS bug are you talking about?

ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130117/hwxface-568)

> 
> Man, it is *so* *hard* to find useful information in your posting.  Can you
> please try to be less chaotic?

I am trying to do my best but testing 2 kernel versions, 3 patches, two functional issues:
1) XHCI port dead 2) express card hotplug
Don't be surprised there are multiple threads. Feel free to close the whole story
if you come up with a big debug patch covering whatever appeared like a potential
bug in my reports. Or where a bug seems to manifest. Just improve debug kernel info.
Then it will be easier I am sure. For me it is also not easy to test all of this.
Just comment my findings in the emails.

Martin
