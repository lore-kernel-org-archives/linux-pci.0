Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388A285CA2;
	Tue,  7 Apr 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549475; cv=none; b=DJb2LYZd3idYEKqldGL6LDnjiOEY71R5yYgZNRH/HrtEmklFeYEaZjTHJ9OMdG0jVd8bh/Oz56wLGHLu8iBCduLFeF93nITaaPjOQhLPp6IBigQy2WtHpfg9FsD8XiT2UHcFvTxW/J+L92rqaxIr2PEqh+ln05hKa3/UXs9l5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549475; c=relaxed/simple;
	bh=pV4sIEElgQXozYDlUvfA0LBdiFSirI8R7EqO56XriPw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZkJuJk73DoUWx+fPLfqaqCIVcU+P6QKQlnmDTI9zvp8A+lsk4WErQ+lQJtRQsH8E0KmT8UwvWmsWwYY34Bxil9uJqgpT+9eRcKvX8aLbjjjjwVeCZB6NYfPQpMiZDqTMhUYEvUv6oHvUdgWm36OBYkIney4QOv5EPR91b9L54I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT3RtHD6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT3RtHD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775549474; x=1807085474;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pV4sIEElgQXozYDlUvfA0LBdiFSirI8R7EqO56XriPw=;
  b=QT3RtHD6K3DxvdBX3Fr4HDcIVJnpQjUQ2dbJTJrO4RW7DEg6/Zh5/ST9
   ID82b4ay/wNlWM04F1dejLZMqPyWQTnkJPBqgAHnsbALPSvn/8Y8O2osZ
   IJ3PjAVCiwtyWK2hC5fq23VuSEQoRhNruyWmZUx8l5rw98WoipBIUW9Ct
   rRJYRgxzz6IASXoI+iixjMY8v13tAbgtGcPtgr2lPVl0/vVUCUI0Mknf+
   D7HsmeO6wjkDiGa4LhKAcxM93N97ELEU0DGZxOcPI8Ts6MRZjr3LrsioJ
   65wcVXbOd5lh+xWPtw0yFJUw5ZLHi+kK8+YezI4SPT5EYXlUKFcKm4e9j
   w==;
X-CSE-ConnectionGUID: 7Eo6vstKQp+eXGdwAgZaIg==
X-CSE-MsgGUID: 9xEfy6llQASuIVcfbOMDrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="80099893"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="80099893"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 01:11:14 -0700
X-CSE-ConnectionGUID: 1iGP1VmARVilbwzve0byeQ==
X-CSE-MsgGUID: 9jQ+KrxLQwOCSRTex4y6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266085633"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 01:11:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 11:11:06 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Move pci_bus_speed2lnkctl2() to public
 header
In-Reply-To: <20260406104708.1218648-3-18255117159@163.com>
Message-ID: <d19c8a93-71ae-187d-4aa6-a22105edcde3@linux.intel.com>
References: <20260406104708.1218648-1-18255117159@163.com> <20260406104708.1218648-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Apr 2026, Hans Zhang wrote:

> Move the static array-based pci_bus_speed2lnkctl2() function from
> bwctrl.c to pci.h as a public inline function.
> 
> This provides efficient O(1) speed-to-LNKCTL2 value conversion using
> static array lookup, maintaining optimal performance while enabling
> code reuse by other PCIe drivers.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.h         | 17 +++++++++++++++++
>  drivers/pci/pcie/bwctrl.c | 17 -----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f0a082bfd6f1..db91878a86ac 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>  	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>  }
>  
> +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> +{
> +	static const u8 speed_conv[] = {
> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> +	};
> +
> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))

drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE() so you 
should add it.

-- 
 i.

