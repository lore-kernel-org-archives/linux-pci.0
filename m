Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <5887532B.3070506@linaro.org>
Date: Tue, 24 Jan 2017 21:14:19 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
 <20170124123711.GA11996@red-moon>
In-Reply-To: <20170124123711.GA11996@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, Tomasz Nowicki <tn@semihalf.com>, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Sricharan,

On 01/24/2017 08:37 PM, Lorenzo Pieralisi wrote:
> [+hanjun, tomasz, sinan]
>
> It is quite a key patchset, I would be glad if they can test on their
> respective platforms with IORT.

ACPI patches are conflict with my acpi platform msi patches (I need
them to enable devices on my ARM64 platform then test this patch set),
I will fix the conflict and test it tomorrow (out of office now and
can't reach the test machines) :)

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
