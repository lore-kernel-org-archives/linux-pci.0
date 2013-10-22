Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3JVOUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Oct 2013 10:20:10 -0400
Message-ID: <52668991.1020208@ti.com>
Date: Tue, 22 Oct 2013 19:50:01 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: <linux-pci@vger.kernel.org>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR'" <mohit.kumar@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>
Subject: Re: [QUERY] Number of address translation regions in designware
References: <52652BF1.4040507@ti.com> <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com>
In-Reply-To: <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush, Jingoo,

On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
> On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
>>
>> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
>> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
>> know if in your platform, do you have only 2 address translation regions? In
>> DRA7xx we have 16 outbound regions and 4 inbound regions.
> 
> In Exynos, there are only 2 inbound and 2 outbound viewpoints.
> 
>> Also the same designware IP can be used as a EP also no? Shouldn't we move it
>> out of drivers/pci/host and allow it to be configured as EP also?
> 
> Currently, Exynos PCIe IP does not support EP mode.

Thanks for the information. I think we can do some optimization w.r.t address
translation regions. Will post a RFC soon.

One more query.
In dw_pcie_prog_viewport_cfg0/dw_pcie_prog_viewport_cfg1 functions, the *lower
target* is programmed to busdev. Is it for any specific reason?
I mean doing that will leave lot of holes in the PCIe address space.
IIUC, if we don't set that to busdev, consecutive pcie address space will be
used for each function no?

Thanks
Kishon
