Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
Date: Fri, 5 Jun 2015 12:06:06 +0900
Message-ID: <CA+Ln22Euot24co7qKLTej43j3Z2BS-p5WhjRq9WgRb-+U=Tyqw@mail.gmail.com>
Subject: Re: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
From: Tomasz Figa <tomasz.figa@gmail.com>
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alessandro Rubini <rubini@unipv.it>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
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
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Barry Song <Baohua.Song@csr.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@stlinux.com,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

2015-06-04 13:13 GMT+09:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c    |    2 +-
>  drivers/pinctrl/intel/pinctrl-intel.c         |    2 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c     |   12 +++++-------
>  drivers/pinctrl/pinctrl-amd.c                 |    2 +-
>  drivers/pinctrl/pinctrl-at91.c                |    2 +-
>  drivers/pinctrl/pinctrl-coh901.c              |    4 ++--
>  drivers/pinctrl/pinctrl-rockchip.c            |    4 ++--
>  drivers/pinctrl/pinctrl-single.c              |    2 +-
>  drivers/pinctrl/pinctrl-st.c                  |    6 +++---
>  drivers/pinctrl/qcom/pinctrl-msm.c            |    2 +-
>  drivers/pinctrl/samsung/pinctrl-exynos.c      |    8 ++++----
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |   18 +++++++++---------
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |   22 ++++++++++------------

For Samsung stuff:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
