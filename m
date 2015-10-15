Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbbJOQBy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 12:01:54 -0400
Message-ID: <561FCDC0.3080109@ti.com>
Date: Thu, 15 Oct 2015 12:01:04 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: WingMan Kwok <w-kwok2@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <bhelgaas@google.com>,
	<ssantosh@kernel.org>, <linux@arm.linux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and
 pcie
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <1444919145-30845-2-git-send-email-w-kwok2@ti.com> <5192855.p6QLDWTiVi@wuerfel>
In-Reply-To: <5192855.p6QLDWTiVi@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/15/2015 10:51 AM, Arnd Bergmann wrote:
> On Thursday 15 October 2015 10:25:44 WingMan Kwok wrote:
>> On TI's Keystone platforms, several peripherals such as the
>> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
>> require the use of a SerDes for converting SoC parallel data into
>> serialized data that can be output over a high-speed electrical
>> interface, and also converting high-speed serial input data
>> into parallel data that can be processed by the SoC.  The
>> SerDeses used by those peripherals, though they may be different,
>> are largely similar in functionality and setup.
>>
>> This patch provides a SerDes phy driver implementation that can be
>> used by the above mentioned peripheral drivers to configure their
>> respective SerDeses.
>>
>> v1:

--------cut-------------------------------------------------------------

>> + * Redistributions in binary form must reproduce the above copyright
>> + * notice, this list of conditions and the following disclaimer in the
>> + * documentation and/or other materials provided with the
>> + * distribution.
>
> The current code does not do this when compiled, which might be a
> problem for distributors. Can you clarify the license?
>
Arnd,

Can you elaborate on this? I did a grep on the string "Redistributions 
in binary form must reproduce the above copyright" and I could find 
several instance of this. So I am not sure what you mean by "The current 
code does not do this when compiled".

Thanks
-- 
Murali Karicheri
Linux Kernel, Keystone
