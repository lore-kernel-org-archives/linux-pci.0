Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Bin Shi <Bin.Shi@csr.com>, Fan Wu <fwu@marvell.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [RFT v2 34/48] pinctrl: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 10 Jun 2015 10:39:22 +0200
Message-ID: <4497677.ZpyibMJVfv@diego>
In-Reply-To: <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 4. Juni 2015, 12:13:44 schrieb Jiang Liu:
> Change irq flow handler to prepare for killing the first parameter 'irq'
> of irq_flow_handler_t.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c    |    4 ++--

For Rockchip
Acked-by: Heiko Stuebner <heiko@sntech.de>

