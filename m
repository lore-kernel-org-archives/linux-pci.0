Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129213955.15663.21173.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <d7e1adbe-91a2-1a76-93b3-c880f9635e5e@jonmasters.org>
Date: Tue, 13 Dec 2016 04:09:39 -0500
MIME-Version: 1.0
In-Reply-To: <20161129213955.15663.21173.stgit@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
 linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
 linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/29/2016 04:39 PM, Bjorn Helgaas wrote:

> +New architectures should be able to use "Consumer" Extended Address Space
> +descriptors in the PNP0A03 device for bridge registers, including ECAM,
> +although a strict interpretation of [6] might prohibit this.  Old x86 and
> +ia64 kernels assume all address space descriptors, including "Consumer"
> +Extended Address Space ones, are windows, so it would not be safe to
> +describe bridge registers this way on those architectures.

<snip>

> +[6] PCI Firmware 3.0, sec 4.1.2:

<snip>

Thanks for the revised writeup, Bjorn. It's great. I'm trying to get the
above clarified explicitly in terms of the spec, and in terms of what
other Operating Systems would like to see as general preference.

To your point about second generation ARM (server) systems: we're actually
on generation 3+ now and finally getting to the point where people are
listening. A great many times over the past few years, people have had
to be sat on until they did what was needed. Fortunately, we are going
to finally have upstream kernels (and distros based upon them) that
boot out of the box on compliant hardware and will be able to point
people at the usual "upstream first" messaging we've been pushing.

I had originally fallen for the SoC koolaid that PCIe was not essential,
and was convinced fairly early that this was nonsense. But it has taken
a few years for everyone else to get onto that bandwagon. First you give
them exactly what they know and love (a 1-2 socket Xeon class machine
with lots of PCIe lanes), then you go and fix the design to give them
what they actually need (which logically enumerates as PCIe but isn't) ;)

Jon.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
