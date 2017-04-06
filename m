Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V10 00/12] IOMMU probe deferral support
To: Rob Herring <robh+dt@kernel.org>, Sricharan R <sricharan@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58E68CEF.8090101@gmail.com>
Date: Thu, 6 Apr 2017 11:46:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Sinan Kaya <okaya@codeaurora.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <joro@8bytes.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Len Brown <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/17 18:23, Rob Herring wrote:
> On Tue, Apr 4, 2017 at 5:18 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
> 
> For patches 3, 4, 6, 7, 8:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> .
> 

And a few hours later, I had the opposite opinion on a couple of
patches, so there is some ongoing discussion working this out.

-Frank

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
