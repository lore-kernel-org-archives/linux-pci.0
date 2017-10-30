Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <59F68B40.8050506@rock-chips.com>
Date: Mon, 30 Oct 2017 10:15:28 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v10 0/7] PCI: rockchip: Move PCIe WAKE# handling into
 pci core
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <1872710.P2f02irZl9@aspire.rjw.lan>
In-Reply-To: <1872710.P2f02irZl9@aspire.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 tony@atomide.com, linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 Will Deacon <will.deacon@arm.com>, Amitkumar Karwar <amitkarwar@gmail.com>,
 dianders@chromium.org, Klaus Goger <klaus.goger@theobroma-systems.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-rockchip@lists.infradead.org,
 briannorris@chromium.org, linux-acpi@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Xinming Hu <huxm@marvell.com>,
 linux-pm@vger.kernel.org, Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, bhelgaas@google.com,
 Kalle Valo <kvalo@codeaurora.org>, Ganapathi Bhat <gbhat@marvell.com>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

thanks for your reply.

On 10/28/2017 05:07 PM, Rafael J. Wysocki wrote:
> Overall, I don't quite like the direction this is going into, but I need to
> have a deeper look.  Which may take some time, so please bear with me.
>
ok, i'll wait for your comments, thanks :)

> Thanks,
> Rafael



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
