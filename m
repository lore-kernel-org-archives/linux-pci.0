Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324E3C4B93
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311634; cv=none; b=iFK4BPgKmFlYvxY1kWQE+IHTFIVLGkR6GlcwlcI1YR+Qm0nXf9XNK5NtRGEmQH53VVj3eRVJwdKvDtsAzPAYd273HDymgBy5nRzbBAAuLPvgnoO2JOPp1ULTL/5nF4n8kuTQKSgSqjBtJ5J124MOUIjqVyKhSeWjh65qTKl2YZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311634; c=relaxed/simple;
	bh=jh8C5ShYQXr3viaQ/Mi2fvp0GqNzxRBy1mECrQ4hGaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/deltwXektpEdYmN1BWj26yOHPcicX4i+GjOpJ25l9fMbldybnYaXBTUe/KWcC052S9HbVTlW48vbqVoIdPNR3I6S9QQ53SldwM7Bk6ptFf8ktMLy/4EvZlhWrmsmmeB1QfaWquwE7yNP1ffgHKj2LpF7WA3+CaLAiB0fuMDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCNIHfma; arc=none smtp.client-ip=95.215.58.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCNIHfma"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jh8C5ShYQXr3viaQ/Mi2fvp0GqNzxRBy1mECrQ4hGaU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790311630; v=1; x=1790916430;
 b=FCNIHfma3LS/3JaA2BJJYgDvh1b5rgyweLTodShdjDg10c9sNGQLzo2UvkvnwLTdJtjoIrS7
 mMXE2rZi3p1dVlTJpgMILbaFwI/JbzCqyKkox75GhQxTTxTX2sEMVAnja/huZQTORQDsTLPa2mX
 vlIlxjfm+N/2uTk4OrJ46b9c=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f70f5b72ae709b91;
	Fri, 25 Sep 2026 04:47:10 +0000
X-Mizu-Trace-ID: f70f5b72ae709b91
X-Migadu-Flow: FLOW_OUT
Message-ID: <b1a845c3-3720-4ef6-8c97-8a40ee7bd286@linux.dev>
Date: Thu, 24 Sep 2026 21:47:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live
 Update
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260918200640.887030-1-dmatlack@google.com>
 <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
 <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/22 11:53, David Matlack 写道:
> On Tue, Sep 22, 2026 at 11:36 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2026/9/18 13:06, David Matlack 写道:
>>> Future Work
>>> -----------
>>>
>>> Following this series, we expect to make further improvements to the PCI
>>> core support for Live Update:
>>>
>>>     - Allow P2P across Live Update by avoiding resizing or moving
>>>       preserved device BARs and preserving all upstream bridge windows.
>>>
>>>     - Support preserving Virtual Functions by preserving SR-IOV
>>>       configuration on PFs and enumerating VFs after Live Update.
>> Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
>> kexec is a foundational step for minimizing downtime.
>>
>> As we look toward complete end-to-end support for DMA preservation
>> across Live Update—especially for VFIO device passthrough and dma-buf
>> sharing scenarios—IOMMU table/domain preservation becomes crucial to
>> prevent IOMMU page faults when devices continue performing DMA during kexec.
>>
>> I would like to ask about the current status and roadmap regarding IOMMU
>> Live Update / KHO (Kexec Handover) support:
>>
>> Is there an ongoing effort or RFC series for IOMMU handover / page-table
>> preservation currently in development or under discussion?
>>
>> How is the coordination between the PCI core Live Update mechanisms and
>> the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
>> restoring domains or handing over root tables)?
>>
>> Any pointers to active discussion threads, RFCs, or future plans
>> regarding IOMMU participation in Live Update would be greatly appreciated.
> The first IOMMU series to support Live update, can be found here:
>
>    https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/

After cloning the source code from samikhawaja/linux, branch 
iommu/phase1-v5, I tested the VFIO live update functionality in my local 
KVM environment and encountered the following issue.

When I run the following commands to verify that VFIO live update works 
correctly, I get the output shown below.

I am currently testing with VFIO v5 and PCI core v9, and I am not sure 
whether this behavior is expected.

Interestingly, when I revert the following commit:

vfio/pci: Preserve the iommufd state of the vfio cdev

the issue disappears.

Could you please let me know whether this is expected behavior, or 
whether it indicates a problem with the current VFIO live update 
implementation?

"

echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override

echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
Preserving device in session
vfio_pci_liveupdate_kexec_test.c:122: Assertion Failure

   Expression: ret == 0
   Observed: 0xffffffffffffffea == 0
   [errno: 22 - Invalid argument]
"

Thanks a lot.

Yanjun Zhu

>
> The IOMMU series builds on top of the PCI core support (this series)
> and the VFIO series linked further up in the cover letter.

-- 
Best Regards,
Yanjun.Zhu

