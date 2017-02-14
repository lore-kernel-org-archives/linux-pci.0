Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 14 Feb 2017 17:55:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/37] PCI: Support for configurable PCI endpoint
Message-ID: <20170214235501.GD19040@bhelgaas-glaptop.roam.corp.google.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <5891D53E.5050409@ti.com>
MIME-Version: 1.0
In-Reply-To: <5891D53E.5050409@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 01, 2017 at 06:01:58PM +0530, Kishon Vijay Abraham I wrote:
> - list
> 
> Hi Bjorn,
> 
> How do you want to handle this series? I'll send one more version of the series
> including the directory restructuring in the same series. Should it be based on
> your -next?

I think if you base it on my pci/host-designware branch, it should
work pretty well.  I haven't merged that into -next yet, but I will
soon.

I'm not sure there was consensus on all the patches yet, but if you
can group the easy ones at the beginning, I should be able to at least
get quite a few out of the way.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
