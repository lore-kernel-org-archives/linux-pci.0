Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 10:37:34 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Message-ID: <20160407103734.55e72da7@xhacker>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
	<EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On Wed, 6 Apr 2016 14:50:29 +0000 Gabriele Paoloni wrote:

> Hi, sorry to be late on this
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Jisheng Zhang
> > Sent: 16 March 2016 11:41
> > To: jingoohan1@gmail.com; pratyush.anand@gmail.com; bhelgaas@google.com
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Jisheng Zhang
> > Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
> > dw_pcie_setup_rc()
> > 
> > dw_pcie_setup_rc(), as its name indicates, setups the RC. But current
> > dw_pcie_host_init() also contains some necessary rc setup code.
> > 
> > Another reason: the host may lost power during suspend to ram, the RC
> > need to be re-setup after resume. The rc can't be correctly resumed
> > without the rc setup code in dw_pcie_host_init().
> > 
> > So this patch moves the code to dw_pcie_setup_rc() to address the above
> > two issues. After this patch, each pcie designware driver users could
> > call dw_pcie_setup_rc() to re-setup rc when resume back.  
> 
> I think this patch breaks the Hisilicon driver...
> 
> Our driver performs linkup setup in UEFI therefore we do not call
> dw_pcie_setup_rc(), we only call dw_pcie_host_init().

Thanks for the information. So pcie-hisi rely on UEFI to do something similar
in dw_pcie_setup_rc(), this comes to a common driver implement question: should
linux device driver rely on bootloader to configure HW device?

Is it acceptable that pcie-hisi adds a call to dw_pcie_setup_rc() in
hisi_add_pcie_port()?

Thanks,
Jisheng

> 
> Maybe better to group the part of code to be moved in as separate
> function...
> 
> Thanks and sorry for late reply.
> 
> Gab
> 
> 
