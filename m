Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 20 Jun 2018 08:42:23 +0800
Message-ID: <CAGb2v67s29mYa+hcYFWCokmzLwi7aYyeBwDnQiTJQYxT0GxPNA@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] devicetree: fix a series of wrong file references
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org,
 Binghui Wang <wangbinghui@hisilicon.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Mark Brown <broonie@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2018 at 12:09 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files got renamed, their references broke.
>
> Manually fix a series of broken refs at the DT bindings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
