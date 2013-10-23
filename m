Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:55170 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870Ab3JWFB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 01:01:58 -0400
Date: Wed, 23 Oct 2013 10:06:10 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Message-ID: <20131023043610.GA5521@pratyush-vbox>
References: <52652BF1.4040507@ti.com>
 <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com>
 <52668991.1020208@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <52668991.1020208@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On Tue, Oct 22, 2013 at 10:20:01PM +0800, Kishon Vijay Abraham I wrote:
> Hi Pratyush, Jingoo,
> 
> On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
> > On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
> >>
> >> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
> >> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
> >> know if in your platform, do you have only 2 address translation regions? In
> >> DRA7xx we have 16 outbound regions and 4 inbound regions.
> > 
> > In Exynos, there are only 2 inbound and 2 outbound viewpoints.
> > 
> >> Also the same designware IP can be used as a EP also no? Shouldn't we move it
> >> out of drivers/pci/host and allow it to be configured as EP also?
> > 
> > Currently, Exynos PCIe IP does not support EP mode.
> 
> Thanks for the information. I think we can do some optimization w.r.t address
> translation regions. Will post a RFC soon.
> 
> One more query.
> In dw_pcie_prog_viewport_cfg0/dw_pcie_prog_viewport_cfg1 functions, the *lower
> target* is programmed to busdev. Is it for any specific reason?
> I mean doing that will leave lot of holes in the PCIe address space.
> IIUC, if we don't set that to busdev, consecutive pcie address space will be
> used for each function no?

Yes, I think even if CX_ATU_MIN_REGION_SIZE is 64KB in any controller,
bus, dev and function number can be used to define target address.

So you are trying to allocate statically a separate viewport for each
function's cfg0 transfer (whereever sufficient number of viewport is
avilable)?

If viewport is programmed dynamically at each cfg transfer, then
whether you use bus and dev only or function also, will it really make
any difference in saving of address space?

Regards
Pratyush

> 
> Thanks
> Kishon
