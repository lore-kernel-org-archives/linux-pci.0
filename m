Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
Date: Wed, 10 Jun 2015 12:29:42 +0200
Message-ID: <CABuKBeLs21NZ_uTUJ=P6TwX-jAiCaJO--ZnV7O2MZy-TfV6sNw@mail.gmail.com>
Subject: Re: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Rubini <rubini@unipv.it>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Barry Song <baohua@kernel.org>,
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Barry Song <Baohua.Song@csr.com>, linux-gpio@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC..."
	<linux-mediatek@lists.infradead.org>,
	linux-rockchip@lists.infradead.org, kernel@stlinux.com,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-06-04 6:13 GMT+02:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
[...]
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--

For the changes in pinctrl-mtk-common.c:

Acked-by: Matthias Brugger <matthias.brugger@gmail.com>
