Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDB421A0E
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474659; cv=none; b=f8DlqyWpHEk+dlf3K3RhXVtSX1JAAOGq5bxEj1jMOjqncVm7J8vrgtaA7vx1/syUa9Tk/qhykPhL/kieQlYzRccWfKQyNGvUYgmlbaJVXZd6doQVmieOfqvi15gz/f+Oh0jGZaSwmge0W/EObxdMlpoSTCVqzHXMK/YFWYeVzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474659; c=relaxed/simple;
	bh=tF2FaWneYEmFFF/IQ22hTJm5HIDf561GeRLMBG+fcuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3zJ3M3OMWDdvvLELmmUQqEnJdfCl3FwRvNMghVp2T+KIXdKhxCY+tZ1Zxdl5dvIsp1MHothGkYNcPQD9+1bpiEOwiImPBjI2RT6SduPNvvUZN7qqcvRkMzuh1jmaA9g12hn3bgCPjKPWyo/WGBdcv7QY1dSDZxUdhtWxXOuxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEade97q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqio4hxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEade97q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqio4hxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780474653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0AlItNxXiGV6RS1ByWxHfhOT6pRKzYrf5OdpGDcNfc=;
	b=PEade97qDLXz/VRdLyqPNk3cQ6J9cEhJmpq9KZjSOm25GFWxDcnVC85rMMAW15T0Tuj202
	8NAjMxdXABzX0dN3yvrv5oQyeNwUR4C5Jva/FkZHRuDCtDgLfh4EFJHY7l0Pbx/zpG2U+q
	n0WfbCsJYH7K99i3xmf6fIow+8a0kRI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-gY6grE36OyKaJMspeZ1P5g-1; Wed, 03 Jun 2026 04:17:31 -0400
X-MC-Unique: gY6grE36OyKaJMspeZ1P5g-1
X-Mimecast-MFC-AGG-ID: gY6grE36OyKaJMspeZ1P5g_1780474651
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-460163035e3so1537633f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780474650; x=1781079450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x0AlItNxXiGV6RS1ByWxHfhOT6pRKzYrf5OdpGDcNfc=;
        b=aqio4hxJcmv8wrtmFqkc/PY2dvEm1lqS8Ami6ocHcC2BB9o64M0f2cfP9Wpj9WkZxv
         Y0q7FcSxErXbP7YAP5476Yf8l8s2T1bL+2ssz4zqkxtTnlpU0leJ5N33aRJI3TaCSJtq
         mP4duH+3QE2fBPyETelG1fFyyJNtiSoLEp9xG1gdBcZKUKR+Leq+F+KkurBJSZgcU3O+
         R6XquayidFM/KqIcuFFwSoPQn9D1/OtLXxGqeT6PHHpHutY3WCCsQfb+qiBNreh+GuL7
         oWC3Dj//tK/5e/VnpmS5+0J+xO3mM5X2kFmvfuWO2Rcdl42FQ6Y9P6lJyZsybuh6Ljft
         mWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474650; x=1781079450;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0AlItNxXiGV6RS1ByWxHfhOT6pRKzYrf5OdpGDcNfc=;
        b=mWZa+BUoNWoi3Rs0msvRUyPvMRHsVQUfORbPuzogFboZmJuVvYc9yHySeMZ4j6mclr
         TPnshu1NmawbTHfDhkYLzQ8xFBeVBMtDY0JjcFHb8ZugkSA2Y22C3bHXobzthedlRhKz
         O12efIJKmhvMa8twR8XF7uFbcgONuRex729RvXDrJovbsifGTGCFYFhZaOUYmKNooCKj
         7Oz1F8rUpanzabyku7FhMdwI8A6n1g9gZYao18qHg8fR8/AIL9o1TkSPpgikfsbKq8Ck
         NwZKR/QAjyFMQrvOBaoLgKCKZrDbHc6cb2ctsvBPv22W+hIEfMLSspQgEt3R1Wk9UPLD
         NQZg==
X-Forwarded-Encrypted: i=1; AFNElJ/7r4FYne6ugnwkBL6mhuH/NR3C/cU4rRMBMEzp7TDbZpX6rUkHZuYesdcinKX8Z6DFKZmvqdKLwwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDnU7CoAz9xjdnrBr0d4RLHscR8brcsqXTOMn1tjIhRLCaOSG
	cONFhqNImJAZ+HIMR+Dd/lltSmQAQireK/7nNamm4Z2xYdbw/xXrFlF4dAVWfb3HMxnNgK9494u
	NYEtsjwiZZLZD9V7A8sDyKOhfVpS9y0YmS4U15lWdw4n+l0P9NiH1Jvb2AExX4A==
X-Gm-Gg: Acq92OEw2K58p1jgtoTQcYIvLhFIBXIX7KQBze4Py7E/DYDUfZLhuzrmyVpED05x6HG
	z7UIQGjhVuOB581mxKqEQqrxHYpScsUBPXh2OU7dF/0GUum42k9kp3TMOeProR0+dsHSYEhTOUC
	cqx7B/ms5LqNaikL814+st7FNlv/10Dt/DQfNoKwZOQUHTczT4VEi3hHidDG+KLDgGCAXP/2rj5
	4LJzSGLe3EVMEVLcMNPcSPsyEH6dN94tih4TmhMNGKE5aDIe6AwV5dnXgfDb906YQjRSwxbljx3
	2cCr/135nOD/TKA6FPLbIi5+rneGkCQrvvFoJmnr8XQA03gaSO0e20zI+cu1f8vmQTBrG8cDs5F
	qi/IH27ANdM+vzvO3m7MwEWO4QsqftCta8YzmYrI6fBIw6h7X9Lsya0snvepXcPq4WATMSwY=
X-Received: by 2002:a05:600c:5288:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-490b5ec3ae6mr36039515e9.17.1780474650347;
        Wed, 03 Jun 2026 01:17:30 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-490b5ec3ae6mr36038855e9.17.1780474649867;
        Wed, 03 Jun 2026 01:17:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c? ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d810dsm45640205e9.9.2026.06.03.01.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 01:17:29 -0700 (PDT)
Message-ID: <ad24ef7e-9e2c-42af-b2c7-8b72031ebf0f@redhat.com>
Date: Wed, 3 Jun 2026 10:17:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
To: Ankit Agrawal <ankita@nvidia.com>, alex@shazbot.org, kvm@vger.kernel.org
Cc: jgg@ziepe.ca, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260602063015.3915-1-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Ankit,

On 6/2/26 08:30, Ankit Agrawal wrote:
> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. The CXL Device DVSEC offset is
> discovered at probe time. Probe, fault and read/write paths then branch
> on that to use either the legacy BAR0 polling or the CXL DVSEC polling.
> 
> The CXL path polls Memory_Active, requiring MEM_INFO_VALID within 1s and
> MEM_ACTIVE within Memory_Active_Timeout (up to 256s) as per CXL spec r4.0
> sec 8.1.3.8.2. Given the long worst-case wait, the CXL poll runs outside
> memory_lock with only a quick readiness check is done under the lock.
> 
> The poll loops sleep with schedule_timeout_killable() and return -EINTR
> on a fatal signal. This avoids hung-task panics during the long
> uninterruptible wait. Extend this to the legacy based wait as well for
> improvement.
> 
> In the fault handler the wait runs locklessly before memory_lock. If a
> reset races in, the in-lock recheck returns -EAGAIN and the wait is
> retried rather than returning a spurious VM_FAULT_SIGBUS.
> 
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout field.
> 
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   drivers/vfio/pci/nvgrace-gpu/main.c | 162 +++++++++++++++++++++++++---
>   include/uapi/linux/pci_regs.h       |   1 +
>   2 files changed, 151 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..4829ae29cff0 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -3,10 +3,13 @@
>    * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/sizes.h>
> +#include <linux/time64.h>
>   #include <linux/vfio_pci_core.h>
>   #include <linux/delay.h>
>   #include <linux/jiffies.h>
> +#include <linux/sched.h>
>   #include <linux/pci-p2pdma.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/memory-failure.h>
> @@ -64,6 +67,8 @@ struct nvgrace_gpu_pci_core_device {
>   	bool has_mig_hw_bug;
>   	/* GPU has just been reset */
>   	bool reset_done;
> +	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
> +	int cxl_dvsec;
>   };
>   
>   static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
> @@ -242,7 +247,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
>   	vfio_pci_core_close_device(core_vdev);
>   }
>   
> -static int nvgrace_gpu_wait_device_ready(void __iomem *io)
> +static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
>   {
>   	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
>   
> @@ -250,16 +255,97 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
>   		if ((ioread32(io + C2C_LINK_BAR0_OFFSET) == STATUS_READY) &&
>   		    (ioread32(io + HBM_TRAINING_BAR0_OFFSET) == STATUS_READY))
>   			return 0;
> -		msleep(POLL_QUANTUM_MS);
> +		if (schedule_timeout_killable(msecs_to_jiffies(POLL_QUANTUM_MS)))
> +			return -EINTR;
>   	} while (!time_after(jiffies, timeout));
>   
>   	return -ETIME;
>   }
>   
> +/*
> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
> + * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
> + * 101b-111b = reserved (clamped to 256s).
> + */
> +static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)
> +{
> +	return MSEC_PER_SEC << (2 * min_t(u8, timeout, 4));
> +}
> +
> +/*
> + * Check if CXL DVSEC reports memory as valid and active.
> + */
> +static inline bool cxl_dvsec_mem_is_active(u32 status)
> +{
> +	return (status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
> +	       (status & PCI_DVSEC_CXL_MEM_ACTIVE);
> +}
> +
> +static int nvgrace_gpu_test_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev,
> +					     u32 *status)
> +{
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
> +	int cxl_dvsec = nvdev->cxl_dvsec;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev,
> +			      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +			      &val);
> +
> +	if (val == ~0U)
> +		return -ENODEV;
> +
> +	if (status)
> +		*status = val;
> +
> +	if (cxl_dvsec_mem_is_active(val))
> +		return 0;
> +
> +	return -EAGAIN;
> +}
> +
> +/*
> + * As per CXL spec r4.0 sec 8.1.3.8.2, MEM_INFO_VALID needs to be set
> + * within 1s and MEM_ACTIVE within Memory_Active_Timeout (up to ~256s)
> + * after reset and bootup.
> + */
> +static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
> +	bool active_phase = false;
> +	u32 status;
> +	int ret;
> +
> +	for (;;) {
> +		ret = nvgrace_gpu_test_device_ready_cxl(nvdev, &status);
> +		if (ret != -EAGAIN)
> +			return ret;
> +
> +		if (!active_phase && (status & PCI_DVSEC_CXL_MEM_INFO_VALID)) {
> +			u8 t = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT, status);
> +
> +			deadline = jiffies +
> +				   msecs_to_jiffies(cxl_mem_active_timeout_ms(t));
> +			active_phase = true;
> +		}
> +
> +		if (time_after(jiffies, deadline))
> +			return -ETIME;
> +
> +		if (schedule_timeout_killable(msecs_to_jiffies(POLL_QUANTUM_MS)))
> +			return -EINTR;
> +	}
> +}
> +
>   /*
>    * If the GPU memory is accessed by the CPU while the GPU is not ready
>    * after reset, it can cause harmless corrected RAS events to be logged.
>    * Make sure the GPU is ready before establishing the mappings.
> + *
> + * Since the CXL polling wait could take 256s, it happens outside
> + * memory_lock. Only do quick readiness check under the lock. Legacy
> + * keeps the in-lock poll.
>    */
>   static int
>   nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
> @@ -275,7 +361,10 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>   	if (!__vfio_pci_memory_enabled(vdev))
>   		return -EIO;
>   
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	if (nvdev->cxl_dvsec)
> +		ret = nvgrace_gpu_test_device_ready_cxl(nvdev, NULL);
> +	else
> +		ret = nvgrace_gpu_wait_device_ready_legacy(vdev->barmap[0]);
>   	if (ret)
>   		return ret;
>   
> @@ -313,9 +402,33 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(struct vm_fault *vmf,
>   	pfn = PHYS_PFN(memregion->memphys) + addr_to_pgoff(vma, addr);
>   
>   	if (is_aligned_for_order(vma, addr, pfn, order)) {
> +		/*
> +		 * Exit early under memory_lock to avoid a potentially lengthy
> +		 * device readiness wait on a runtime-suspended device. Any
> +		 * race after the lock is dropped is benign as the re-check
> +		 * inside the scoped guard below catches it.
> +		 */
> +		scoped_guard(rwsem_read, &vdev->memory_lock) {
> +			if (vdev->pm_runtime_engaged)
> +				return VM_FAULT_SIGBUS;
> +		}
> +
> +retry:
> +		if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
> +		    nvgrace_gpu_wait_device_ready_cxl(nvdev))
> +			return VM_FAULT_SIGBUS;
> +
>   		scoped_guard(rwsem_read, &vdev->memory_lock) {
> -			if (vdev->pm_runtime_engaged ||
> -			    nvgrace_gpu_check_device_ready(nvdev))
> +			int rc;
> +
> +			if (vdev->pm_runtime_engaged)
> +				return VM_FAULT_SIGBUS;
> +
> +			/* Re-run the wait if a reset raced us, not SIGBUS. */
> +			rc = nvgrace_gpu_check_device_ready(nvdev);
> +			if (rc == -EAGAIN)
> +				goto retry;
> +			if (rc)
>   				return VM_FAULT_SIGBUS;
>   
>   			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
> @@ -712,6 +825,12 @@ nvgrace_gpu_read_mem(struct nvgrace_gpu_pci_core_device *nvdev,
>   	else
>   		mem_count = min(count, memregion->memlength - (size_t)offset);
>   
> +	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
> +		ret = nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>   		ret = nvgrace_gpu_check_device_ready(nvdev);
>   		if (ret)
> @@ -846,6 +965,12 @@ nvgrace_gpu_write_mem(struct nvgrace_gpu_pci_core_device *nvdev,
>   	 */
>   	mem_count = min(count, memregion->memlength - (size_t)offset);
>   
> +	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
> +		ret = nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>   		ret = nvgrace_gpu_check_device_ready(nvdev);
>   		if (ret)
> @@ -1143,14 +1268,24 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
>    * is beneficial to make the check to ensure the device is in an
>    * expected state.
>    *
> - * Ensure that the BAR0 region is enabled before accessing the
> + * On Blackwell-Next systems, memory readiness is determined via the
> + * CXL Device DVSEC in PCI config space and does not require BAR0.
> + * For the legacy path, ensure BAR0 is enabled before accessing the
>    * registers.
>    */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>   {
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
>   	void __iomem *io;
>   	int ret;
>   
> +	/*
> +	 * Note that the worst-case wait here is ~256s (vs ~30s on the
> +	 * legacy path) and may block device unbind/sysfs for the duration.
> +	 */
> +	if (nvdev->cxl_dvsec)
> +		return nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +
>   	ret = pci_enable_device(pdev);
>   	if (ret)
>   		return ret;
> @@ -1165,7 +1300,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
>   		goto iomap_exit;
>   	}
>   
> -	ret = nvgrace_gpu_wait_device_ready(io);
> +	ret = nvgrace_gpu_wait_device_ready_legacy(io);
>   
>   	pci_iounmap(pdev, io);
>   iomap_exit:
> @@ -1183,10 +1318,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>   	u64 memphys, memlength;
>   	int ret;
>   
> -	ret = nvgrace_gpu_probe_check_device_ready(pdev);
> -	if (ret)
> -		return ret;
> -
>   	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
>   	if (!ret)
>   		ops = &nvgrace_gpu_pci_ops;
> @@ -1196,6 +1327,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>   	if (IS_ERR(nvdev))
>   		return PTR_ERR(nvdev);
>   
> +	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						     PCI_DVSEC_CXL_DEVICE);
> +
> +	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
> +	if (ret)
> +		goto out_put_vdev;
> +
>   	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
>   
>   	if (ops == &nvgrace_gpu_pci_ops) {

Shouldn't an update be made to nvgrace_gpu_vfio_pci_table?

Thanks,

C.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>   #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
>   #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>   #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>   #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))


