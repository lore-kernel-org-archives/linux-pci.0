Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Nov 2017 17:30:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [Intel-gfx] [PATCH V3 09/29] drm/i915: deprecate
 pci_get_bus_and_slot()
Message-ID: <20171128153051.GU10981@intel.com>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 11:57:46AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=3D0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> =

> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> =

> Extract the domain number from drm_device and pass it into
> pci_get_domain_bus_and_slot() function.
> =

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/gpu/drm/i915/i915_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_=
drv.c
> index 9f45cfe..5a8cb79 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -419,7 +419,10 @@ static int i915_getparam(struct drm_device *dev, voi=
d *data,
>  =

>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>  {
> -	dev_priv->bridge_dev =3D pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	int domain =3D pci_domain_nr(dev_priv->drm.pdev->bus);
> +
> +	dev_priv->bridge_dev =3D
> +		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 0));

Maybe just pci_get_slot(pdev->bus, PCI_DEVFN(0, 0)) ?

I guess if we want to be pedantic we could go for:

bus =3D pci_find_host_bridge(pdev->bus)->bus;
pci_get_slot(bus, PCI_DEVFN(0, 0))

but I think the GPU should always be on the root bus, so the simpler
form should be fine.

>  	if (!dev_priv->bridge_dev) {
>  		DRM_ERROR("bridge device not found\n");
>  		return -1;
> -- =

> 1.9.1
> =

> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- =

Ville Syrj=E4l=E4
Intel OTC

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
