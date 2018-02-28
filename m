Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Feb 2018 16:20:45 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Message-ID: <f3de53ca-0c3f-47f4-d77b-cf3d9bfd3da6@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
 <b3c190e7-1a33-971e-b86c-a9725118ba05@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191003B1B@SHSMSX101.ccr.corp.intel.com>
 <0b579768-3090-dd50-58b1-3385be92ef21@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19101C8A7@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19101C8A7@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Will Deacon <Will.Deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 27/02/18 06:21, Tian, Kevin wrote:
[...]
>> Technically nothing prevents it, but now the resv problem discussed on
>> patch 2/37 stands out. For example on x86 you'd probably need to carve
>> the
>> IOAPIC MSI range out of the process address space. On Arm you'd need to
>> create a write-only mapping for MSIs (IOMMU translates it to the IRQ chip
>> address, but thankfully accessing the doorbell from CPU side doesn't
>> trigger an MSI.)
> 
> so if overlap already exists when binding a process address space
> (since binding may happen much later than creating the process),
> I assume the call will simply fail since carve out at this point is not
> possible?

Yes in this case I think it's safer to abort the bind() call

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
