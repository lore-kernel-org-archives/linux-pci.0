Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH] PCI: designware: add host_init() error handling
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
 <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d416f9b3-20d9-0339-a4d2-9a4ba0669633@linaro.org>
Date: Fri, 2 Dec 2016 11:51:26 +0000
MIME-Version: 1.0
In-Reply-To: <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, linuxppc-dev@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, Minghuan Lian <minghuan.Lian@freescale.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 Richard Zhu <Richard.Zhu@freescale.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>,
 linux-arm-msm@vger.kernel.org, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-omap@vger.kernel.org, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 02/12/16 10:32, Joao Pinto wrote:
>
> Hi Srinivas,
>
> =C0s 11:51 AM de 12/1/2016, Srinivas Kandagatla escreveu:
>>  drivers/pci/host/pci-dra7xx.c           |  4 +++-
>>  drivers/pci/host/pci-exynos.c           |  4 +++-
>>  drivers/pci/host/pci-imx6.c             |  4 +++-
>>  drivers/pci/host/pci-keystone.c         |  4 +++-
>>  drivers/pci/host/pci-layerscape.c       | 12 ++++++++----
>>  drivers/pci/host/pcie-armada8k.c        |  4 +++-
>>  drivers/pci/host/pcie-designware-plat.c |  4 +++-
>>  drivers/pci/host/pcie-designware.c      |  4 +++-
>>  drivers/pci/host/pcie-designware.h      |  2 +-
>>  drivers/pci/host/pcie-qcom.c            |  6 ++++--
>>  drivers/pci/host/pcie-spear13xx.c       |  4 +++-
>>  11 files changed, 37 insertions(+), 15 deletions(-)
>>
>
> Thanks for the patch!
>
> In my opinion your idea is good but only qcom driver is able to detect fa=
ilure
> in the specific host init routine, all others have a 'return 0' even if
> something not well init. I would recomend that we take this issue a bit f=
urther
> and add the error checking to all specific pci drivers in order to make t=
hem as
> robust as qcom'.
I totally agree with you, I can give this a go in next version.

Thanks,
srini

>
> Thanks,
> Joao
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
