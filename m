Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 19:48:05 +0300
Message-ID: <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2018 at 12:07 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.

> -               res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +               res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
>                 if (!res) {
>                         err = -ENOMEM;
> -                       goto parse_failed;
> +                       goto failed;
>                 }
>
>                 err = of_pci_range_to_resource(&range, dev_node, res);
>                 if (err) {
> -                       kfree(res);
> +                       devm_kfree(dev, res);
>                         continue;
>                 }

Can't you rather make it better, i.e.

struct resource tmp;
...

err = of_pci_range_to_resource(&range, dev_node, &tmp);
if (err)
   continue;

res = devm_kmemdump();
if (!res) {
 ret = -ENOMEM;
 goto failed;
}

?

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
