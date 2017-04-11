Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1491952528.7236.26.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Wed, 12 Apr 2017 09:15:28 +1000
In-Reply-To: <20170411142456.GB6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
 <1491917928.7236.8.camel@kernel.crashing.org>
 <20170411142456.GB6821@red-moon>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-11 at 15:24 +0100, Lorenzo Pieralisi wrote:
> Ok, point taken. BTW, may I ask you guys to have a look into this
> please ?
> 
> https://lkml.org/lkml/2017/4/6/743
> 
> It is a side effect of this thread (v2), not sure why <asm/io.h>
> on powerpc has to include <linux/io.h>.

Not sure how we ended up with that... it's odd indeed.

Michael ? Any reason we can't just remove it ?

Cheers,
Ben.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
