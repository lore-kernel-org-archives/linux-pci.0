Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbaBTMN0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 07:13:26 -0500
Message-ID: <5305F154.8020507@ti.com>
Date: Thu, 20 Feb 2014 17:43:08 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"jg1.han@samsung.com" <jg1.han@samsung.com>
CC: Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Bjorn Helgaas <bhelgass@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
References: <1392873774-22249-1-git-send-email-mohit.kumar@st.com> <1392873774-22249-2-git-send-email-mohit.kumar@st.com> <5305E928.5070505@ti.com> <2CC2A0A4A178534D93D5159BF3BCB66189FD40D8B3@EAPEX1MAIL1.st.com>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189FD40D8B3@EAPEX1MAIL1.st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mohit,

On Thursday 20 February 2014 05:28 PM, Mohit KUMAR DCG wrote:
> Hello Kishon,
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>> Sent: Thursday, February 20, 2014 5:08 PM
>> To: Mohit KUMAR DCG; jg1.han@samsung.com
>> Cc: Ajay KHANDELWAL; Bjorn Helgaas; spear-devel; linux-
>> pci@vger.kernel.org
>> Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
>> and mem viewport
>>
>> Hi,
>>
>> On Thursday 20 February 2014 10:52 AM, Mohit Kumar wrote:
>>> This patch correct iATU programming for cfg1, io and mem viewport.
>>> Enable ATU only after configuring it.
>>
>> Does this patch actually fixes device enumeration behind a PCIe-pci bridge or
>> this is more of cleaning up the sequence?
>>
> - This patch corrects ATU programming sequence. I am not aware of any such issue with
> current driver. Pls specify  which bridge do you use in your setup and what is the problem?

I tried with card [1], it had a PLX bridge chip. It couldn't read the
configuration space of the device connected to the PCIe-PCI bridge.

Thanks
Kishon

[1] -> http://ratetorate.in/products/Wiretech-PCIe%252dto%252dPCI-Bridge-Card.

> 
> Regards
> Mohit
> 

