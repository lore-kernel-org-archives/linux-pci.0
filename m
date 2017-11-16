Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 16 Nov 2017 14:17:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
Message-ID: <20171116201745.GB7266@bhelgaas-glaptop.roam.corp.google.com>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-arm-kernel@lists.infradead.org,
 Dongdong Liu <liudongdong3@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 16, 2017 at 09:03:37AM -0500, Sinan Kaya wrote:
> On 11/15/2017 4:14 PM, Bjorn Helgaas wrote:
> >> +	if (pcie_port_query_uptream_service(dev, PCIE_PORT_SERVICE_DPC)) {
> >> +		dev_info(&dev->dev, "AER: Device recovery to be done by DPC\n");
> >> +		return;
> >> +	}
> > What happens without this test?
> > 
> > Does AER read registers from the now-disabled device and get ~0 data?
> > Or is AER reading registers from the port upstream from the disabled
> > device and trying to reset the device?
> > 
> > It looks like get_device_error_info() reads registers and doesn't
> > check to see whether it gets ~0 back.  I'm wondering if we *should* be
> > checking there and whether doing that would help mitigate the issue
> > here.
> 
> The issue is two independent software entities are trying to recover
> the PCIe link simultaneously. AER and DPC have two different
> approaches to link recovery.
> 
> AER makes a callback into the endpoint drivers for non-fatal errors
> and hope that endpoint driver can recover the link. AER also makes a
> callback in the fatal error case but resets the link via secondary
> bus reset.
> 
> The DPC on the other hand stops the drivers immediately since HW
> took care of link disable. (Endpoint register reads return ~0 at
> this point.) DPC driver clears the interrupt from the DPC capability
> and brings the link up at the end. Full enumeration/rescan follows
> this procedure to go back to functioning state. 
> 
> If we don't have this AER-DPC coordination, the endpoint driver gets
> confused since it receives a stop command as well as a recover
> command at about the same time depending on the timing.
> 
> Whether the AER driver reads ~0 or not really depends on timing. The
> link may come up from the DPC driver by the time AER driver reaches
> here as an example.
> 
> Bad things do happen. We have seen this with e1000e driver.

I don't doubt that bad things happen.  I'm just trying to understand
exactly *what* bad things happen and how, so we can fix them cleanly.

I don't know exactly what you mean by "DPC stops the drivers
immediately".  Since the DPC hardware disables the Link, I *think*
you probably mean that driver accesses to the device start failing
(whether the driver notices this is a whole different question).

When the DPC hardware disables the Link, it causes a hot reset for
downstream components.  The DPC interrupt_event_handler() doesn't do
much except remove the device (which detaches the driver) and clear
the DPC Trigger Status bit (which allows hardware to try to retrain
the Link).

So the "stop" and "recover" commands you mention must be related to
AER.  I guess these would be some of the driver callbacks
(error_detected(), mmio_enabled(), slot_reset(), reset_prepare(),
reset_done(), resume())?

In any case, I agree that it probably doesn't make sense to call any
of these callbacks if the DPC driver has already detached the driver
and re-attached it.  The device state is gone because of the hot reset
and the driver state is gone because of the detach/re-attach.

However, I'm not so sure about the period *before* the DPC driver
detaches the driver.  The description of error_detected() says it
cannot assume the device is accessible, so I think there might be an
argument that AER *should* call this for DPC events so the driver has
a chance to clean up before being unceremoniously detached.

I suspect this all probably requires tighter integration between DPC
and AER, and I'm totally fine with that.  I think the current
separation as separate "drivers" is pretty artificial anyway.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
