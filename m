Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Jan 2017 16:02:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
MIME-Version: 1.0
In-Reply-To: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 linux-arm-kernel@lists.infradead.org,
 Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Uwe,

On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
> =

> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
> is enabled:
> =

> # dmesg | grep ath
> [    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state, cu=
rrently in D3
> [    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> =

> if however PCIEASPM is off, the driver probes correctly and the ath10k
> adapter works fine.
> =

> I wonder if someone has an idea what needs to be done to fix this
> problem. (OK, I could disable PCIEASPM, but I'd like to have a solution
> for a distribution kernel where I think PCIEASPM=3Dy is sensible in
> general.)

PCIEASPM=3Dy is definitely sensible and disabling ASPM is OK for a
workaround but is not a fix.

We have several open issues related to ASPM:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D102311 ASPM: ASMEDA asm1062=
 not working
  https://bugzilla.kernel.org/show_bug.cgi?id=3D187731 Null pointer derefer=
ence in ASPM
  https://bugzilla.kernel.org/show_bug.cgi?id=3D189951 Enabling ASPM causes=
 NIC performance issue
  https://bugzilla.kernel.org/show_bug.cgi?id=3D60111 NULL pointer deref in=
 ASPM alloc_pcie_link_state()

I don't recognize yours as being one of these.  Can you open a new
issue and attach the complete dmesg log and "lspci -vv" output?

Is this a regression?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
