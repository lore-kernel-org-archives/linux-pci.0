Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A851DCB24
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130393; cv=none; b=C5KoqybsMljzPbPnftwXglogjAhY99ep4qXVZVcAopV/cQsNo4uteRFrLRRQALZG3641hLvis5erHiCy4L/Mbm0f7kxvx+PlqPy66atNxft73wPL/kgxBG/XjHoYHfj4a2vazDy3Xtr0yvfcgeYGnal9pfMh7XQDum5Ryv4uwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130393; c=relaxed/simple;
	bh=7Z/27TDS+735Goazdq0fPlyYYiLCMrE4Tg4OceKZaU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DDf3yOgw4bRsy1F5N8vlRAaOLBrf6SY1zLTvRvbfmi6CpvAL+GWkV7c8huT0HwEUJWB1HMrIWFYl9W0JLgH1lC81sUJNs0wGEgWLJoA/Mw5PnF+ffactpGnlxHgwS8BAaG6tqizCmP1olD+XXQdC8qiLVvqgqEmtFaoKqIEdz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3yyRoQaC; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3yyRoQaC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=juBMV/bJXfIGc18yVwKLFg3gCzgeQ0XEAST6GnEV60w=;
	b=3yyRoQaCiVA5woWconU2+ZPznYx5eD3vthpp9G/ohVmOIV02S7fG4r7nHANb5VF6f3l/bzUkJ
	mTmU+u8bQuv8s4fQ/cvJOHCr7wjBm07nQp5X+Zf6mF+oKGUsj2zvLQ7gpkdTc9WVQtBEdaCtplJ
	edtzAcESg7/gRb8m8CfzcmY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fvmpC1hRYznTWM;
	Tue, 14 Apr 2026 09:26:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EE60F40571;
	Tue, 14 Apr 2026 09:33:01 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 09:33:01 +0800
Message-ID: <14d5ae84-5448-497b-9c9d-b1909570b964@huawei.com>
Date: Tue, 14 Apr 2026 09:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413133542.GA1233417@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260413133542.GA1233417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/13/2026 9:35 PM, Jason Gunthorpe wrote:
> On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:
> 
>> Background: The TPH Steering Tag is tightly coupled with both a PCIe
>> device (identified by its BDF) and a CPU core. It can only be
>> obtained in kernel mode. To allow user-space applications to fetch
>> and set this value securely and conveniently, we need a standard
>> kernel-to-user interface.
> 
> There is no reason for userspace to have this value outside VFIO.
> 
>> Proposed Solution: Add several sysfs attributes under each PCIe device's
>> sysfs directory:
>> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
>> device specific)
>> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
>> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
>> operations, e.g.:
>>    Read operation:
>>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>>    Write operation:
>>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st
> 
> NAK
> 
> This is all low level details controled exclusively by the kernel
> driver. Allowing userspace to mess it up will break drivers.
> 
> There is no justification to give userspace this kind of write access.

Thank you very much for your valuable feedback and candid insights.
I appreciate you raising the important concern about risks of
exposing low-level hardware controls to userspace. To help clarify
the proposal and facilitate constructive discussion, I'd like to
split the topic into two distinct points:

1. Functional Requirement: Userspace Need for ST Management
   Userspace requires access to Steering Tags in two valid scenarios:
   - For devices in TPH Device-Specific Mode with no standard ST table,
     userspace needs to read valid ST values from the kernel, which are
     acquired via ACPI _DSM (a kernel-only operation).
   - For devices using the spec-defined ST location, userspace may
     provide (index, cpu) associations for the kernel to program safely.

2. Implementation: Kernel-Userspace Communication Interface
   The second topic is how to transport ST information securely:
   - Proposed sysfs: universal, works for all frameworks (VFIO, UIO, UACCE)
   - VFIO-private ioctl: limited to VFIO-managed devices

My goal is to provide a secure, generic, non-disruptive interface
that addresses valid userspace needs without impacting kernel
managed devices or introducing stability risks. I welcome your
thoughts on both the requirements and the interface options.

Thank you again for your time and guidance.

> 
> Jason
> 

