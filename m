Return-Path: <SRS0=qZdo=3F=gmail.com=htejun@kernel.org>
Return-Path: <SRS0=qZdo=3F=gmail.com=htejun@kernel.org>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Mar 2017 11:55:12 -0400
From: Tejun Heo <tj@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	John Garry <john.garry@huawei.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Jon Mason <jonmason@broadcom.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 08/22] lib: implement Devres ioremap_nopost() interface
Message-ID: <20170328155512.GA28157@htj.duckdns.org>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-9-lorenzo.pieralisi@arm.com>
 <20170328014129.GJ25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328145003.GB18046@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170328145003.GB18046@red-moon>
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, Mar 28, 2017 at 03:50:03PM +0100, Lorenzo Pieralisi wrote:
> > I know this comment was just copied from other devm_ioremap*()
> > interfaces, but I think it's slightly misleading to call this the "BUS
> > offset".  That suggests this is a bus address, but it is not.  Maybe
> > it should be "resource address" or similar?
> > 
> > I propose a separate patch to update the existing comments, followed
> > by this patch to add this new one.
> 
> I agree with you, maybe Tejun has more context on why that parameter
> is called BUS offset ? Anyway, I can easily do what you suggest above,
> just asking Tejun if there is something I am missing.

I'm pretty sure I copied it from somewhere without thinking much about
it.  Please feel free to change.

Thanks.

-- 
tejun
