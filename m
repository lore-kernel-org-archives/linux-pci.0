Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F1547061;
	Tue,  6 Oct 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306804; cv=none; b=mkWwT3ySrKYza/MkeBUPnLgg/LO6fIQTplTAtL4l9llbGMNlN8KZ5v4X7QPrMMtAoHQOxCJE3vHpdGwbRp/rVSKs74i5Z+WVUTSNzFJjI/wqFPp6Y0i70yy7uY58zj2uumgZqmEDKJfpN5RBb/P7k2HeJZej9mK/JUpBi0baJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306804; c=relaxed/simple;
	bh=6hTp7abrUCBANrVeUZr7+9orxPXfXbaltmosY1LJSGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/n6s5IIZaSNLwAWD9/TYXqsgyRWt2SzhWDWHPidzSj6aGAcPG8vSa7Wyhtu72fE50kMnXoybYKz4W+iUy2oLfZZo+3gKYtiRZrJzduxVfLIhnEtPIxw3exeXMMoohrrEsysxXpSt7h0aOk5uoC5xjQsiTbcqWzCFwreFZZ7Llo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1RELe0X; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1RELe0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791306803; x=1822842803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6hTp7abrUCBANrVeUZr7+9orxPXfXbaltmosY1LJSGE=;
  b=K1RELe0X28oVhIB/ZjKusaN+p11u/S4aXkKx4jF1A+1AAbsmeXLBmXBS
   zP/nyvI0zgTDgBT+R9X4VmbAqIoP7zmk49g5YTPsahtKS58oBxwANOmcR
   SoWRm9POg3LDvaGLLzEZLcSSYrsRycMxS4eSQc7ivACJ97khb0nuDE+mm
   G7EMbcwJHyQFVoRDbUEgwRzW3y+SMONbCv1oC+7rYFN72jp0rwHrWt964
   XM27ANpU2bohiJR//Af+HzDRRXi62AxRU3Tal+JhWhCOgn/5cDixfhMTB
   ltbBDw/gDW2yixgAFHbHpMPJH7JqciFS7fxdTwQ2ycJLHo1lHjH4RJV2y
   A==;
X-CSE-ConnectionGUID: 47gXiDwqRsSl0oH4k7vhhg==
X-CSE-MsgGUID: kNbl7PwNS9CbwxvOFVCKtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117526832"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="117526832"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:13:21 -0700
X-CSE-ConnectionGUID: RISsF7C2Tba5ZlFsLqWc9g==
X-CSE-MsgGUID: 0BJZiU5xQMqTmvD1a68euw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="274994321"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:13:21 -0700
Message-ID: <eec2107f-2c08-44ad-98c8-2c92f7a31fd3@linux.intel.com>
Date: Tue, 6 Oct 2026 10:13:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI/AER: Document that aer_recover_queue() takes
 ownership of aer_regs
To: Priyank Rathod <rathodpriyank@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
 <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/2026 10:40 AM, Priyank Rathod wrote:
> ghes_handle_aer() allocates the AER register snapshot that it passes to
> aer_recover_queue() from ghes_estatus_pool.  aer_recover_queue() returns
> void, so the caller cannot tell whether the record was queued, and the
> AER code owns the buffer from then on and must free it on every path.
> 
> None of this is documented at the definition of this exported function.
> With GHES enabled, a new caller that passed a buffer from any other
> allocator would hit the BUG() in gen_pool_free_owner() when the AER code
> returns the buffer to ghes_estatus_pool, and a caller that freed the
> buffer itself would cause a double free.
> 
> Add a kernel-doc comment that describes the parameters and states that
> aer_recover_queue() takes ownership of @aer_regs, which must have been
> allocated from ghes_estatus_pool.
> 
> No functional change.
> 

Thanks, this matches what I had in mind. 

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Bjorn, I see you already applied the series to pci/aer. Feel free to
pick up the tag if it is still convenient.

> Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Link: https://lore.kernel.org/r/4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linux.intel.com
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
>  drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a6600801af6e..a58244e00bc4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1404,6 +1404,24 @@ static void aer_recover_work_func(struct work_struct *work)
>  static DEFINE_SPINLOCK(aer_recover_ring_lock);
>  static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
>  
> +/**
> + * aer_recover_queue - queue an AER error record reported by firmware
> + * @domain: PCI domain (segment) of the device that reported the error
> + * @bus: bus number of the device that reported the error
> + * @devfn: encoded device and function number, as returned by PCI_DEVFN()
> + * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
> + * @aer_regs: snapshot of the device's AER Capability registers
> + *
> + * Queue an error record received from firmware through APEI GHES.  The
> + * record is processed later from a workqueue, which logs the error and,
> + * for uncorrectable errors, attempts recovery of the device.
> + *
> + * Takes ownership of @aer_regs, which must have been allocated from
> + * ghes_estatus_pool with a size of sizeof(struct aer_capability_regs).
> + * The buffer is freed with ghes_estatus_pool_region_free() by the work
> + * item that processes the record, or immediately if the queue is full.
> + * The caller must not access or free @aer_regs after this call.
> + */
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs)
>  {
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

