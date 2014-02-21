Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:53131 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752141AbaBUDyd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 22:54:33 -0500
Date: Fri, 21 Feb 2014 09:24:18 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"jg1.han@samsung.com" <jg1.han@samsung.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Bjorn Helgaas <bhelgass@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io and
 mem viewport
Message-ID: <20140221035418.GB2295@pratyush-vbox>
References: <1392873774-22249-1-git-send-email-mohit.kumar@st.com>
 <1392873774-22249-2-git-send-email-mohit.kumar@st.com>
 <5305E928.5070505@ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FD40D8B3@EAPEX1MAIL1.st.com>
 <5305F154.8020507@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5305F154.8020507@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 08:13:08PM +0800, Kishon Vijay Abraham I wrote:
> Hi Mohit,
> 
> On Thursday 20 February 2014 05:28 PM, Mohit KUMAR DCG wrote:
> > Hello Kishon,
> > 
> >> -----Original Message-----
> >> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
> >> Sent: Thursday, February 20, 2014 5:08 PM
> >> To: Mohit KUMAR DCG; jg1.han@samsung.com
> >> Cc: Ajay KHANDELWAL; Bjorn Helgaas; spear-devel; linux-
> >> pci@vger.kernel.org
> >> Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
> >> and mem viewport
> >>
> >> Hi,
> >>
> >> On Thursday 20 February 2014 10:52 AM, Mohit Kumar wrote:
> >>> This patch correct iATU programming for cfg1, io and mem viewport.
> >>> Enable ATU only after configuring it.
> >>
> >> Does this patch actually fixes device enumeration behind a PCIe-pci bridge or
> >> this is more of cleaning up the sequence?
> >>
> > - This patch corrects ATU programming sequence. I am not aware of any such issue with
> > current driver. Pls specify  which bridge do you use in your setup and what is the problem?
> 
> I tried with card [1], it had a PLX bridge chip. It couldn't read the
> configuration space of the device connected to the PCIe-PCI bridge.

So do you see abort while reading config space of device connected to
the PCIe-PCI bridge?

Do you see "received master abort" bit set in your RC's cfg register
after you try to read?

Regards
Pratyush

> 
> Thanks
> Kishon
> 
> [1] -> http://ratetorate.in/products/Wiretech-PCIe%252dto%252dPCI-Bridge-Card.
> 
> > 
> > Regards
> > Mohit
> > 
> 
