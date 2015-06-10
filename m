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
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alessandro Rubini <rubini@unipv.it>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Barry Song <baohua@kernel.org>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Hongzhou Yang <hongzhou.yang@mediatek.com>,
	Maoguang Meng <maoguang.meng@mediatek.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Axel Lin <axel.lin@ingics.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Bin Shi <Bin.Shi@csr.com>,
	Fan Wu <fwu@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@stlinux.com,
	linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com
Subject: Re: [RFT v2 44/48] genirq, pinctrl: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 10 Jun 2015 10:40:09 +0200
Message-ID: <29876063.DDhUqa5fWz@diego>
In-Reply-To: <1433391238-19471-45-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-45-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 4. Juni 2015, 12:13:54 schrieb Jiang Liu:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
> 
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---

>  drivers/pinctrl/pinctrl-rockchip.c            |    2 +-

For Rockchip
Acked-by: Heiko Stuebner <heiko@sntech.de>

