Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34800 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbaFYEMk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 00:12:40 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so1106306pdj.33
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 21:12:40 -0700 (PDT)
Message-ID: <53AA4C32.7060004@ozlabs.ru>
Date: Wed, 25 Jun 2014 14:12:34 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	gwshan@linux.vnet.ibm.com, yan@linux.vnet.ibm.com,
	qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com> <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com> <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
In-Reply-To: <20140625011211.GA5785@richard>
Content-Type: text/plain; charset=KOI8-R
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/25/2014 11:12 AM, Wei Yang wrote:
> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>> Current iommu_table of a PE is a static field. This will have a problem when
>>> iommu_free_table is called.
>>
>> What kind of problem? This table is per PE and PE is not going anywhere.
>>
> 
> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
> they could be released on the fly. When they are released, so do the iommu
> table for the PE.

iommu_table is a part of PE struct. When PE is released, iommu_table will
go with it as well. Why to make is a pointer? I would understand it if you
added reference counting there but no - iommu_table's lifetime is equal to
PE lifetime.



-- 
Alexey
