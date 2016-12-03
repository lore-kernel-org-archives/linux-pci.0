Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161202153816.GA18290@red-moon>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-8-lorenzo.pieralisi@arm.com>
 <20161202153816.GA18290@red-moon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 3 Dec 2016 03:11:09 +0100
Message-ID: <CAJZ5v0jfwGBaHepToB9U3qQZ3KTB6XzoRDwEskV0B9fK7+OoDg@mail.gmail.com>
Subject: Re: [PATCH v9 07/16] drivers: acpi: implement acpi_dma_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Eric Auger <eric.auger@redhat.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Dennis Chen <dennis.chen@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Mark Salter <msalter@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Nate Watterson <nwatters@codeaurora.org>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 2, 2016 at 4:38 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Rafael, Mark, Suravee,
>
> On Mon, Nov 21, 2016 at 10:01:39AM +0000, Lorenzo Pieralisi wrote:
>> On DT based systems, the of_dma_configure() API implements DMA
>> configuration for a given device. On ACPI systems an API equivalent to
>> of_dma_configure() is missing which implies that it is currently not
>> possible to set-up DMA operations for devices through the ACPI generic
>> kernel layer.
>>
>> This patch fills the gap by introducing acpi_dma_configure/deconfigure()
>> calls that for now are just wrappers around arch_setup_dma_ops() and
>> arch_teardown_dma_ops() and also updates ACPI and PCI core code to use
>> the newly introduced acpi_dma_configure/acpi_dma_deconfigure functions.
>>
>> Since acpi_dma_configure() is used to configure DMA operations, the
>> function initializes the dma/coherent_dma masks to sane default values
>> if the current masks are uninitialized (also to keep the default values
>> consistent with DT systems) to make sure the device has a complete
>> default DMA set-up.
>
> I spotted a niggle that unfortunately was hard to spot (and should not
> be a problem per se but better safe than sorry) and I am not comfortable
> with it.
>
> Following commit d0562674838c ("ACPI / scan: Parse _CCA and setup
> device coherency") in acpi_bind_one() we check if the acpi_device
> associated with a device just added supports DMA, first it was
> done with acpi_check_dma() and then commit 1831eff876bd ("device
> property: ACPI: Make use of the new DMA Attribute APIs") changed
> it to acpi_get_dma_attr().
>
> The subsequent check (attr != DEV_DMA_NOT_SUPPORTED) is always true
> on _any_ acpi device we pass to acpi_bind_one() on x86, which was
> fine because we used it to call arch_setup_dma_ops(), which is a nop
> on x86. On ARM64 a _CCA method is required to define if a device
> supports DMA so (attr != DEV_DMA_NOT_SUPPORTED) may well be false.
>
> Now, acpi_bind_one() is used to bind an acpi_device to its physical
> node also for pseudo-devices like cpus and memory nodes. For those
> objects, on x86, attr will always be != DEV_DMA_NOT_SUPPORTED.
>
> So far so good, because on x86 arch_setup_dma_ops() is empty code.
>
> With this patch, I use the (attr != DEV_DMA_NOT_SUPPORTED) check
> to call acpi_dma_configure() which is basically a nop on x86 except
> that it sets up the dma_mask/coherent_dma_mask to a sane default value
> (after all we are setting up DMA for the device so it makes sense to
> initialize the masks there if they were unset since we are configuring
> DMA for the device in question) for the given device.
>
> Problem is, as per the explanation above, we are also setting the
> default dma masks for pseudo-devices (eg CPUs) that were previously
> untouched, it should not be a problem per-se but I am not comfortable
> with that, honestly it does not make much sense.
>
> An easy "fix" would be to move the default dma masks initialization out
> of acpi_dma_configure() (as it was in previous patch versions of this
> series - I moved it to acpi_dma_configure() just a consolidation point
> for initializing the masks instead of scattering them in every
> acpi_dma_configure caller) I can send this as a fix-up patch to Joerg if
> we think that's the right thing to do (or I can send it to Rafael later
> when the code is in the merged depending on the timing) just let me
> know please.

Why can't arch_setup_dma_ops() set those masks too?

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
