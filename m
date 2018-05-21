Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 05/40] iommu/sva: Track mm changes with an MMU notifier
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
        will.deacon@arm.com, okaya@codeaurora.org, linux-mm@kvack.org,
        ashok.raj@intel.com, bharatku@xilinx.com,
        linux-acpi@vger.kernel.org, rfranz@cavium.com,
        devicetree@vger.kernel.org, rgummal@xilinx.com,
        linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org,
        ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
        christian.koenig@amd.com
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-6-jean-philippe.brucker@arm.com>
 <20180517152514.00004247@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <73fc27e8-9d20-b996-908d-cf3459acf372@arm.com>
Date: Mon, 21 May 2018 15:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180517152514.00004247@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/05/18 15:25, Jonathan Cameron wrote:
>> +		 * already have been removed from the list. Check is someone is
> 
> Check if someone...

Ok

Thanks,
Jean

