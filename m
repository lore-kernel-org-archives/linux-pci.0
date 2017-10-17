Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Trent Piepho <tpiepho@impinj.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: imx6: Check for link training status in link up
 check
Date: Tue, 17 Oct 2017 17:37:49 +0000
Message-ID: <1508261868.110408.5.camel@impinj.com>
References: <20171017001159.109152-1-tpiepho@impinj.com>
 <20171017001159.109152-2-tpiepho@impinj.com>
 <1508229842.2146.4.camel@pengutronix.de>
In-Reply-To: <1508229842.2146.4.camel@pengutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-10-17 at 10:44 +0200, Lucas Stach wrote:
> Am Montag, den 16.10.2017, 17:11 -0700 schrieb Trent Piepho:
> > 
> > 
> > There result is no link training check.
> > 
> > Then commit dac29e6c5460 ("PCI: designware: Add default link up check if
> > sub-driver doesn't override")
> 
> I think you meant 01c076732e82 (PCI: designware: Check LTSSM training
> bit before deciding link is up) here.
> 
> >  added a link training check to the default
> > version of dw_pcie_link_up(), but since imx6 uses imx6_pcie_link_up() it
> > does not use the default version with this fix.

It was really the combination of both commits.  'dac added the common
link up check, which imx6 didn't use, and then '01c added the training
check to it.  It appears I've attributed both changes to 'dac in my
message and forgot '01c.  I'll fix.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
