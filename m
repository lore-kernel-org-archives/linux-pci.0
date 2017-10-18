Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 18 Oct 2017 10:18:22 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 2/2] vgaarb: Factor out EFI and fallback default
 device selection
Message-ID: <20171018081822.pqmkj2xfgg6kb6xa@phenom.ffwll.local>
References: <20171013034338.14630.4766.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171013034729.14630.30419.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <871sm2y1h9.fsf@linkitivity.dja.id.au>
 <20171017120506.ervbnyjue55zn67b@phenom.ffwll.local>
 <878tg9i9pw.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
In-Reply-To: <878tg9i9pw.fsf@linkitivity.dja.id.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Dave Airlie <airlied@redhat.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Rongrong Zou <zourongrong@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 11:24:43AM +1100, Daniel Axtens wrote:
> Hi Daniel,
> 
> >> Initially I wondered if this info printk could be moved into
> >> vga_arbiter_check_bridge_sharing(), but it's been separated out since
> >> 3448a19da479b ("vgaarb: use bridges to control VGA routing where
> >> possible."), and upon closer examination, it seems you can't be sure a
> >> device doesn't share a bridge until the end of the process, so this is
> >> indeed correct.
> >> 
> >> Everything else also looks good to me.
> >> 
> >> Reviewed-by: Daniel Axtens <dja@axtens.net>
> >
> > R-b for both patches? And ok with everyone if I pull this into drm-misc
> > for 4.15 (deadline is end of this week for feature-y stuff)?
> 
> I had only intended it for patch 2, but I've now read over patch 1 to my
> satisfaction, so it too is:
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Both applied for 4.15, thanks.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
