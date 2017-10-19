Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <59E88A5D.8060309@rock-chips.com>
Date: Thu, 19 Oct 2017 19:19:57 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
 Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v6 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
 <20171013195059.23865-2-jeffy.chen@rock-chips.com>
 <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171018010312.GB65743@google.com>
 <20171018132936.GP5641@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171018132936.GP5641@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

On 10/18/2017 09:29 PM, Bjorn Helgaas wrote:
>> >
>> >I guess it could work to look into pci_create_root_bus(), and
>> >do something like the following?
>> >
>> >	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node)
>> >		... do OF parsing for generic features like WAKE# ...
> That's exactly the sort of thing I was thinking.
>
i was looking at that too, but i'm not very clear about how to handle 
the platform_ops's set_wakeup...




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
