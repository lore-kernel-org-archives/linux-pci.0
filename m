Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Jun 2018 00:39:03 +0300
Message-ID: <CAHp75VcSapu6Q-eNhbbSQ6hSV=OF0pS=mXsdHZxascst5OLxCQ@mail.gmail.com>
Subject: Re: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Keith Busch <keith.busch@intel.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 10:31 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> If a bridge supports hotplug and observes a PCIe fatal error, the following
> events happen:
>
> 1. AER driver removes the devices from PCI tree on fatal error
> 2. AER driver brings down the link by issuing a secondary bus reset waits
> for the link to come up.
> 3. Hotplug driver observes a link down interrupt
> 4. Hotplug driver tries to remove the devices waiting for the rescan lock
> but devices are already removed by the AER driver and AER driver is waiting
> for the link to come back up.
> 5. AER driver tries to re-enumerate devices after polling for the link
> state to go up.
> 6. Hotplug driver obtains the lock and tries to remove the devices again.
>
> If a bridge is a hotplug capable bridge, bounce the error handling to the
> hotplug driver so that hotplug driver can mask link up/down interrupts
> while performing a secondary bus reset.

> +static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
> +{
> +       struct pcie_device *pciedev;
> +       struct controller *ctrl;
> +       struct device *devhp;
> +       struct slot *slot;
> +       int rc;
> +
> +       devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
> +       pciedev = to_pcie_device(devhp);
> +       ctrl = get_service_data(pciedev);
> +       slot = ctrl->slot;
> +
> +       rc = reset_slot(slot->hotplug_slot, 0);
> +
> +       return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;

Would it be better to

return rc ? ..._DISCONNECT : ..._RECOVERED; ?

> +}



-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
