Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 29 Nov 2017 10:36:39 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3 22/29] [media] atomisp: deprecate pci_get_bus_and_slot()
Message-ID: <20171129083639.meuue7eooybr5u7o@valkosipuli.retiisi.org.uk>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-23-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1511801886-6753-23-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 kbuild test robot <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Philippe Ombredanne <pombredanne@nexb.com>,
 "open list:MEDIA INPUT INFRASTRUCTURE \(V4L/DVB\)"
 <linux-media@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Avraham Shukron <avraham.shukron@gmail.com>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-msm@vger.kernel.org,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, intel-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Mon, Nov 27, 2017 at 11:57:59AM -0500, Sinan Kaya wrote:
> diff --git a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> index 4631b1d..51dcef57 100644
> --- a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> +++ b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
> @@ -39,7 +39,7 @@ static inline int platform_is(u8 model)
>  
>  static int intel_mid_msgbus_init(void)
>  {
> -	pci_root = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	pci_root = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>  	if (!pci_root) {
>  		pr_err("%s: Error: msgbus PCI handle NULL\n", __func__);
>  		return -ENODEV;

This file has been removed, I'm applying the rest of the patch.

Please use the media tree as the base in the future. Thanks.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
