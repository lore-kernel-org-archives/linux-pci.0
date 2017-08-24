Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 08:57:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
Message-ID: <20170824135721.GB31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170821105300.GB23287@e107981-lin.cambridge.arm.com>
 <20170822221928.GL6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu-FCkV9Dv=yn_CNC9orj8Roiabb75jX34w3mMziWVZaeA@mail.gmail.com>
 <20170823135734.GB8498@bhelgaas-glaptop.roam.corp.google.com>
 <CAPM=9tzhzGEY_-FhGNECQ8QkxPtXxhojwPeVQT43Rcgf6X0Lww@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPM=9tzhzGEY_-FhGNECQ8QkxPtXxhojwPeVQT43Rcgf6X0Lww@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
 Zou Rongrong <zourongrong@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Vetter, Daniel" <daniel.vetter@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 10:57:26AM +1000, Dave Airlie wrote:
> > Yeah, maybe it's time to disconnect the "default display device" idea
> > from the VGA arbiter.  I have no idea what (if any) dependencies X has
> > on the legacy VGA resources.  I assume X works fine on power, where it
> > sounds like those resources are rarely or never available.
> 
> The question on non-x86 archs, is what is the correct device to default to.
> 
> On x86 we use the legacy VGA resources as a pointer, as this is the device
> the BIOS appeared on at boot so hopefully should be one you can see stuff on.
> 
> On non-x86 I've no idea how to decide if there are multiple devices, maybe the
> firmware needs to tag something for the kernel if there are. Otherwise
> you'd just
> be picking something in probe order.
> 
> I think the idea of these patches is to separate default display
> device from the arbiter.
> 
> X uses the arbiter on x86 if required (it's horrible, and it's rare we
> have to nowadays),
> but for finding the default device it justs uses the sysfs boot_vga flag.

The sysfs boot_vga thing comes from PCI.  The name suggests that it's
a VGA device and can use the legacy VGA resources.

If we want to indicate a general default display device that need not
be "VGA", it'd be really nice if we could pick a name that did not
include "vga".

Even if we could only do it inside the kernel, I think it would reduce
confusion if we could separate out the "VGA"-specific stuff like the
arbiter and names like "vga_set_default_device()" so that systems with
a non-legacy VGA default display device didn't have to use "VGA"
interfaces that don't make sense for them.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
