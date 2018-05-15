Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 May 2018 15:16:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 16/40] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20180515141658.vivrgcyww2pxumye@armageddon.cambridge.arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-17-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20180511190641.23008-17-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: xieyisheng1@huawei.com, ilias.apalodimas@linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 will.deacon@arm.com, okaya@codeaurora.org, linux-mm@kvack.org,
 yi.l.liu@intel.com, ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org,
 robdclark@gmail.com, bharatku@xilinx.com, linux-acpi@vger.kernel.org,
 liudongdong3@huawei.com, rfranz@cavium.com, devicetree@vger.kernel.org,
 kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, jcrouse@codeaurora.org,
 rgummal@xilinx.com, thunder.leizhen@huawei.com,
 linux-arm-kernel@lists.infradead.org, shunyong.yang@hxt-semitech.com,
 dwmw2@infradead.org, liubo95@huawei.com, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,

On Fri, May 11, 2018 at 08:06:17PM +0100, Jean-Philippe Brucker wrote:
> +unsigned long mm_context_get(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid;
> +
> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	asid = atomic64_read(&mm->context.id);
> +
> +	if (mm->context.pinned) {
> +		mm->context.pinned++;
> +		asid &= ~ASID_MASK;
> +		goto out_unlock;
> +	}
> +
> +	if (nr_pinned_asids >= max_pinned_asids) {
> +		asid = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (!asid_gen_match(asid)) {
> +		/*
> +		 * We went through one or more rollover since that ASID was
> +		 * used. Ensure that it is still valid, or generate a new one.
> +		 * The cpu argument isn't used by new_context.
> +		 */
> +		asid = new_context(mm, 0);
> +		atomic64_set(&mm->context.id, asid);
> +	}
> +
> +	asid &= ~ASID_MASK;
> +
> +	nr_pinned_asids++;
> +	__set_bit(asid2idx(asid), pinned_asid_map);
> +	mm->context.pinned++;
> +
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +
> +	return asid;
> +}

With CONFIG_UNMAP_KERNEL_AT_EL0 (a.k.a. KPTI), the hardware ASID has bit
0 set automatically when entering user space (and cleared when getting
back to the kernel). If the returned asid value here is going to be used
as is in the calling code, you should probably set bit 0 when KPTI is
enabled.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
