Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B7286A4;
	Fri,  6 Mar 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812268; cv=none; b=IOeYQD+UzUAQfZcsYuCJ218UK5ZsBFPr+oVnTnF9oOwWRZF25ny68V54+YgRSG5AgCimnHpTLqUG5AUwktav/fh3qqZ6UrG0gkwis31x6eQyaCThNSRpqQd41qJgM7HNjmL9aHag+/n/NuS6dQ9CWIVSXgG6x3ulqm6uk0nvhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812268; c=relaxed/simple;
	bh=/avj3KXIk3a5KxpHccpaIIecRqXYDWkNDG1i8H3oeJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mo+53ZwuaHOtX17AG5yMUITKEHtw2Q5Cef6pYOdLebC38tEIZhds1i+4TTxt0qqo/tU2kkCYP7expzyVBzs+MH7UX4JJD2stau/w3lp0daYyteof1rk7okJAkzfxZ7+dNGIlVLOob22qBF8D6LSiGVqyGIOisBDMjiu9jedAkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hiWwtcaf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hiWwtcaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Sq5Qv3yg8QGYvAyDcjQYMbTuxuA+X5I3uxOwSuqBdH0=;
	b=hiWwtcafYeNBs89+L/Idx9+C+GGbvzyksS+xeLdz2FY895OYRWrSyLl5vZ3DVl
	rMBEqoGs8TGhtK4NTEiH9fJX9ptswahV2LZLKtJfp7JxnF0kwRJxJiChC18aezy9
	3MqTi9OGm5HbJdrgpH1KMh67z9+v5pECMWFVCt0C/Nz14=
Received: from [IPV6:240e:b8f:927e:1000:3542:2c51:dbe0:7121] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHj+W396pp6JaaPg--.3724S2;
	Fri, 06 Mar 2026 23:50:16 +0800 (CST)
Message-ID: <1c285b60-2658-4863-b3c9-0842df2156e7@163.com>
Date: Fri, 6 Mar 2026 23:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] PCI: Refactor PCIe speed validation and conversion
 functions
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102143206.111347-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251102143206.111347-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHj+W396pp6JaaPg--.3724S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykKFyDuF1kuw48WFWxWFg_yoW8XF4Dpa
	y3Ka1fArW8G3sxGan3Xa1jqFy5Wan3JrW8Jry3Jas5Zw13ZFn3tr1DKryFgr9rtrWxXr12
	9F1jva4DC3WjkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U83ktUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBgx1Gmq97iefgAA3V

Hi,

Gentle ping.

Best regards,
Hans

On 2025/11/2 22:32, Hans Zhang wrote:
> This series refactors PCIe speed validation and conversion logic to
> shared functions in the public header, eliminating code duplication
> and ensuring consistency across drivers.
> 
> ---
> Changes for v4:
> - Maintain O(1) array-based lookup for speed conversion (addressing
>    performance concerns from v3 feedback)
> - Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
> - Update dwc driver to use the shared functions
> - Rebase to v6.18-rc3.
> 
> This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
> on the v3 submission, ensuring no runtime performance regression while
> achieving code reuse.
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - Gentle ping.
> 
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>    PCI: Add public pcie_valid_speed() for shared validation
>    PCI: Move pci_bus_speed2lnkctl2() to public header
>    PCI: dwc: Use common speed conversion function
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++-------------
>   drivers/pci/pci.h                            | 22 ++++++++++++++++++++
>   drivers/pci/pcie/bwctrl.c                    | 22 --------------------
>   3 files changed, 25 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a

