Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V2 09/29] drm/i915: deprecate pci_get_bus_and_slot()
To: linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-10-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4c12bca7-3827-c85a-56d5-d5d10890d40d@codeaurora.org>
Date: Wed, 22 Nov 2017 18:25:02 -0500
MIME-Version: 1.0
In-Reply-To: <1511390964-9979-10-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 5:49 PM, Sinan Kaya wrote:
>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>  {
> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	u32 domain = pci_domain_nr(dev_priv->drm.pdev->bus);

I'll convert domain type to int on the next version across the series.

I tried to convert most of the drivers to use pci_domain_nr() per feedback
from Greg KH. I'll hold onto posting a new version until I gather feedback
with the approach I have taken.

I just did a build test with the series.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
