Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 Aug 2017 21:46:01 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v7 6/8] PCI: aardvark: Use PCI_NUM_INTX
Message-ID: <20170815214601.6913e004@windsurf>
In-Reply-To: <20170815190223.18807-7-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
 <20170815190223.18807-7-paul.burton@imgtec.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 15 Aug 2017 12:02:21 -0700, Paul Burton wrote:
> Switch from using a custom LEGACY_IRQ_NUM macro to the generic
> PCI_NUM_INTX definition for the number of INTx interrupts.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pci@vger.kernel.org

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
