Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 00/16] ACPI IORT ARM SMMU support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <af1d9b6c-1229-4e2c-918c-423ae5a48afd@linaro.org>
Date: Tue, 29 Nov 2016 19:11:45 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, Eric Auger <eric.auger@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jon Masters <jcm@redhat.com>,
 Dennis Chen <dennis.chen@arm.com>, Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> This patch series is v9 of a previous posting:
>
> https://lkml.org/lkml/2016/11/16/386
>
> v8 -> v9
> 	- Updated bypass flag handling in ARM SMMU v3 according to
> 	  reviews
> 	- Removed SMMUv1/v2 configuration interrupt handling
> 	- Rebased against v4.9-rc5
> 	- Updated tags

I rebased on top of latest 4.9-rc7 (can apply cleanly), and tested on
Hisilicon D03, the SMMUv3 works fine as previous version.

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
