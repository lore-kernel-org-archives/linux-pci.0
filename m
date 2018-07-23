Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 23 Jul 2018 16:45:08 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180723224507.GA11656@localhost.localdomain>
References: <20180723221533.4371.90064.stgit@gimli.home>
 <20180723222431.4371.25962.stgit@gimli.home>
MIME-Version: 1.0
In-Reply-To: <20180723222431.4371.25962.stgit@gimli.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 23, 2018 at 04:24:31PM -0600, Alex Williamson wrote:
> Take advantage of NVMe devices using a standard interface to quiesce
> the controller prior to reset, including device specific delays before
> and after that reset.  This resolves several NVMe device assignment
> scenarios with two different vendors.  The Intel DC P3700 controller
> has been shown to only work as a VM boot device on the initial VM
> startup, failing after reset or reboot, and also fails to initialize
> after hot-plug into a VM.  Adding a delay after FLR resolves these
> cases.  The Samsung SM961/PM961 (960 EVO) sometimes fails to return
> from FLR with the PCI config space reading back as -1.  A reproducible
> instance of this behavior is resolved by clearing the enable bit in
> the configuration register and waiting for the ready status to clear
> (disabling the NVMe controller) prior to FLR.
> 
> As all NVMe devices make use of this standard interface and the NVMe
> specification also requires PCIe FLR support, we can apply this quirk
> to all devices with matching class code.

Shouldn't this go in the nvme driver's reset_prepare/reset_done callbacks?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
