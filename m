Return-Path: <SRS0=oV7/=BA=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=oV7/=BA=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1506737526-94266-1-git-send-email-zhengqiang10@huawei.com>
References: <1506737526-94266-1-git-send-email-zhengqiang10@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Oct 2017 02:45:11 +0200
Message-ID: <CAJZ5v0ikH=FVcLoLHfiO_7ejx-7Ya-3xKznhzD5fDMS3HWgSBg@mail.gmail.com>
Subject: Re: [PATCH V2] Bug fix for PME interrupt handler, add Root Status check
To: Qiang Zheng <zhengqiang10@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 30, 2017 at 4:12 AM, Qiang Zheng <zhengqiang10@huawei.com> wrote:
> PCIe PME and hot plug share same interrupt number. In some special case,
> Link down event cause hot plug interrupt, devices is not disconnected,
> But read config will return 0xff.
>
> In that case, PME work function will run and not return Because
> Root Status PME bit always 1 and can not be cleared.
>
> This patch add Root Status check in PME interrupt handler,
> Just do same as pciehp isr Slot status check.
>
> Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
> ---
>  drivers/pci/pcie/pme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index fafdb16..2ff2e57 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>         spin_lock_irqsave(&data->lock, flags);
>         pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>
> -       if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +       if (rtsta == U32_MAX || !(rtsta & PCI_EXP_RTSTA_PME)) {
>                 spin_unlock_irqrestore(&data->lock, flags);
>                 return IRQ_NONE;
>         }
> --

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
