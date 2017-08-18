Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <5996A626.5040303@rock-chips.com>
Date: Fri, 18 Aug 2017 16:32:38 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <5e3accf1-6f84-861f-f647-628322bb7841@rock-chips.com>
In-Reply-To: <5e3accf1-6f84-861f-f647-628322bb7841@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 briannorris@chromium.org, linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On 08/18/2017 03:23 PM, Shawn Lin wrote:
>>
>> @@ -1524,6 +1532,9 @@ static int rockchip_pcie_remove(struct
>> platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +    dev_pm_clear_wake_irq(dev);
>> +    device_init_wakeup(dev, false);
>> +
>
> Looks good overall but I think we need this on the
> error handling path of rockchip_pcie_probe as well?

hmm, right, will fix it, thanks.

and i also notice some other missing error handling, will fix them too:)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
