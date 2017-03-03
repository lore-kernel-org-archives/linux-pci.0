Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 3 Mar 2017 09:05:51 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
Message-ID: <20170303170550.rj7awy4jjfiw6qgd@araj-mobl1>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
 <1488534044.6234.14.camel@infradead.org>
MIME-Version: 1.0
In-Reply-To: <1488534044.6234.14.camel@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>,
 Will Deacon <will.deacon@arm.com>, Harv Abdulhamid <harba@qti.qualcomm.com>,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

Good to hear back from you!


On Fri, Mar 03, 2017 at 09:40:44AM +0000, David Woodhouse wrote:
> 
> Intel slightly deviates from the "one PASID per process" vision too,
> because it currently has a PASID allocator idr per IOMMU. That wants
> making system-wide. And probably not Intel-specific.

Intel version is getting the system wide pasid. We are actively working on it
and should be out shortly.

> 
> Some other comments...
> 
> We also have SVM_FLAG_SUPERVISOR_MODE, which gives access to kernel
> address space. Yes, people use it.

There are some gaps with the current implementation, esp related to 
vmalloc. We have something internally, these will also be posted soon after
some testing. 

Cheers,
Ashok

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
