Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:33152 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422762Ab2JaLYq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 07:24:46 -0400
Message-ID: <50910A70.7050209@st.com>
Date: Wed, 31 Oct 2012 16:54:32 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: viresh kumar <viresh.kumar@linaro.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH 03/15] SPEAr13xx: Add mach/io.h
References: <cover.1351492562.git.pratyush.anand@st.com> <CAOh2x==1McRP4eNFZa8qH4hjnOr003Ozb6J3XP8B87E9yZB4zw@mail.gmail.com> <508E3A2E.3000204@st.com> <201210302145.47011.arnd@arndb.de>
In-Reply-To: <201210302145.47011.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 3:15 AM, Arnd Bergmann wrote:
> On Monday 29 October 2012, Pratyush Anand wrote:
>> Any transaction between 0x80000000 to 0x8FFFFFFF can only be used for
>> any type(IO/MEM/CFG0/CFG1) of PCIe transaction. Therefore , we need to
>> have this mapping in io.h.
>
> No you don't.
>
> The I/O space window will only be in one place on a given system, so you
> should register that window using pci_ioremap_io() as all the other

Sorry, I could not find pci_ioremap_io function. May be you wanted to 
refer something else.

In case of SPEAr too , we can reserve first 32Kb per controller as PCIe 
IO space. So, lets say I fixed address 0x80000000--0x80007FFF for IO 
transaction. I need to register address range of this window somehow.

But, issue which faced was that I was not able to successfully 
request_resource(&ioport_resource, &res]) with res.start = 0x80000000 
and res.end = 0x80007fff.

So, I though first to change IO_SPACE_LIMIT. But I found it not a 
correct way.

May be I am missing something and not able to get how can I use 
pci_ioremap_io or something else to register 0x80000000--0x80007FFF 
window. A reference will help.


Regards
Pratyush
> modern platforms. There is no excuse for having a per-platform mach/io.h
> any more and that would prevent you from enabling spear in a multiplatform
> configuration.
>
> 	Arnd
> .
>


