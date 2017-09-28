Return-Path: <SRS0=vzkP=A5=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=vzkP=A5=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1506570874-136126-1-git-send-email-zhengqiang10@huawei.com>
References: <1506570874-136126-1-git-send-email-zhengqiang10@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Sep 2017 01:13:02 +0200
Message-ID: <CAJZ5v0izo1xeCMqDx2wmn+aC=CntWEV6f9kDupXx=Rgx9uZVPw@mail.gmail.com>
Subject: Re: [PATCH] Bug fix for PME interrupt handler, add Root Status check
To: Qiang <zhengqiang10@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 5:54 AM, Qiang <zhengqiang10@huawei.com> wrote:
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
> index fafdb16..67144f5 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>         spin_lock_irqsave(&data->lock, flags);
>         pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>
> -       if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +       if (rtsta == (u32)(~0) || !(rtsta & PCI_EXP_RTSTA_PME)) {
>                 spin_unlock_irqrestore(&data->lock, flags);
>                 return IRQ_NONE;
>         }

OK, but isn't there a symbol for all ones in u32?  And if there isn't,
what about adding it?

Thanks,
Rafael
