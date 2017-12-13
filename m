Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <bd6c6365-c265-30f4-029b-3e19af3078f2@codeaurora.org>
 <1513087456.3809.17.camel@linux.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <055279d0-5e1b-621c-af8e-4c2704d54e8c@codeaurora.org>
Date: Tue, 12 Dec 2017 19:07:07 -0500
MIME-Version: 1.0
In-Reply-To: <1513087456.3809.17.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 12/12/2017 9:04 AM, Joonas Lahtinen wrote:
> Hi,
> 
> I sent this individual i915 patch to our CI, and it is passing on all platforms:
> 
> https://patchwork.freedesktop.org/series/34822/
> 
> Is it ok if I merge this to drm-tip already?

As long as you have this change in your tree, it should be safe.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/pci.h?id=7912af5c835bd86f2b0347a480e0f40e2fab30d0


> 
> Regards, Joonas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
