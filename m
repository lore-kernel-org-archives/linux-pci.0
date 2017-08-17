Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 17 Aug 2017 07:00:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jan Glauber <jglauber@cavium.com>
Subject: Re: [PATCH v2 3/3] vfio/pci: Don't probe devices that can't be reset
Message-ID: <20170817070017.1e9c9456@w520.home>
In-Reply-To: <1502957663-5527-4-git-send-email-jglauber@cavium.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
 <1502957663-5527-4-git-send-email-jglauber@cavium.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 17 Aug 2017 10:14:23 +0200
Jan Glauber <jglauber@cavium.com> wrote:

> If a PCI device supports neither function-level reset, nor slot
> or bus reset then refuse to probe it. A line is printed to inform
> the user.

But that's not what this does, this requires that the device is on a
reset-able bus.  This is a massive regression.  With this we could no
longer assign devices on the root complex or any device which doesn't
return from bus reset and currently makes use of the NO_BUS_RESET flag
and works happily otherwise.  Full NAK.  Thanks,

Alex
 
> Without this change starting qemu with a vfio-pci device can lead to
> a kernel panic on some Cavium cn8xxx systems, depending on the used
> device.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 063c1ce..029ba13 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1196,6 +1196,12 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>  		return -EINVAL;
>  
> +	ret = pci_probe_reset_bus(pdev->bus);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Refusing to probe because reset is not possible.\n");
> +		return ret;
> +	}
> +
>  	group = vfio_iommu_group_get(&pdev->dev);
>  	if (!group)
>  		return -EINVAL;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
