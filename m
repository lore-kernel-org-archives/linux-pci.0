Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112737C0F5
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362757; cv=none; b=Y7+PpvOxCxV+9ekVTL1JRvaXZ5JuzWND9Wtyo/gOAljTOzvXmMBQRRZksQr2I6Xo4DlTEKZmZMmTJlc9zSaMu74+1cDi6aSxfAKZhW5PTqJv3AKsstncPiX2RHLoMQVkDDMBXe8g3GVxzgnZ5QaezYOmoKKCZLw6fu8PQdWFUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362757; c=relaxed/simple;
	bh=4pn8PEDtARUzteaCZc2M2V636q0Tc3MYo4DsXAYTX+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOyXH30xmdELmliqTuts37g977bmKVqdpDrnwwDELRu6wK2PFrVbeBPSzHp6pbbQoH87GVPH9zyzXt8rhJxNH67GOw0YbZdiGuP4P3ZPlvcVR5HGjoz4Lqb3+uv74wXTUZH3rJt07BunNGO+lPTrfUWEyGW4y7Vz5x9TflUPwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8jH9bye; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8jH9bye"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8facae850so9565ad.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790362755; x=1790967555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryWXjYMx77NDaQsPP9QlmEYj6eVxrasAG766hpzWjdA=;
        b=B8jH9byeOlr9pEaRfTGFnzaL9je9oIytbWkr6DjOQiO8b/dUsTUXV8hwuXGzM7bmrD
         CAS8XbsIOxHQSQTL+Q4BDdW+kOgxyLh3seBuXTi0ZxsqDjWhFal1SrGbjaAmIMV2Y7ip
         EGmx31Ik7NeJD4qphGzPoj9cK1c579e60gdTcUoO7p3ZyLb13JRzxunZMeMaUIz5XYMI
         IZC70mpvChev6BaUck6kcdS+jN13I4YlKPgjp4iS7FsdE7mmc/+0JxO/io1sL6u0gg4k
         WZiwbYshd8L5VC7d5c7J8f/jKJKuMymwv+aTluv0jVIWVzC6sp+qWQKTl7KkZMW5nRpd
         bwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362755; x=1790967555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ryWXjYMx77NDaQsPP9QlmEYj6eVxrasAG766hpzWjdA=;
        b=FqpTz1xU25a/0OahH2cCKxNwIvj0OwOmpsu0Wgqjp3OC8BISvXtbFj/f9InMdPUk6E
         55hcpXJBcTRs1jbYWqIVPVgX0cNkprUmnlKaWY+6i5r10p2cmfuyUIXz7WvS24XhZGsv
         yMsGpjfKsK9UT5qojUQX1EmsQ5J8Zf7CxDZiwi6pAGHonfcPBfgEu5rTnPWG0Ea3NlNN
         UIGkYzHOK7ba/0HMHSF1r3e6zuSBzrkZABkY5nD28Upq6PmA4Hg1GmG3BxhSavS51X55
         eV4+hJJTSn3JZmlywKalTPEkeWnXFSut+WEgPg9oRvqbJ8T1mFMWqGccI7HUpwbcpDKw
         9+tg==
X-Forwarded-Encrypted: i=1; AKwUvBzY7vgqj+BzuP2DTUSW6577voGbC6+RAtxZnrvk082I+YshnQ7g0qpVn1RrZRxdrZ1Tx64EPpbJWRk=@vger.kernel.org
X-Gm-Message-State: AFuF++lqXWkzbsANnLLLxepiVPb/EexDYPSNrqazoPZFx7ZxRnTVDtjc
	1AEDcjoCA9ATguC1eUFQNuFQ2Q1GfnZsEREVJ5gxAwG2k6miaxweM5GGWRzyM6jKHg==
X-Gm-Gg: AYBFou2sY4vxGqdoMmAfFCCFMt5lYzPNu3KVM/gadt2FxgaUBeSScbQ6d85ChrKGPYx
	TLEhwd+BE6QmZwKHvEydda3VLhHFOfiP4J2G323Osca8bhYiqYfQa7xXuLpFpYhsydR02kXAA43
	76KXh3UIh0AAzsyFpPYJJQB/1/EcFSkGqSSjkAEdbbt6Kt6kfPARSLl5uiaT2XMFAe+d7JnCko/
	bnBhgSuloNwpDL/uuVuLLWr7f4zC1ekj4QhbjC4ATSXomJUij3qwE6isnSb2ILHwzMCqHvBqfFo
	YJ4vM1CyccFFpJU+AuxnFt8/NUXCeHF8yz9KeiIMDpNbDaDL34Iv3w5iV0d03zPVvMonlN/4fRl
	X3G0Ym/JYgOAUOWegQCRAXXMJJCqvayElmZp0tFfF75mSv5HjbsbfMT3vr5PmYDVoOrE0XJiA4Z
	TbdfI717bYaQl6N0tiILbt61GbocuFwvLXIZ7NoGvggpQEnRsGg8130Od8eYLqM0WXruz3TgX+T
	Zf7Iz8glRXKHH2EcHLQA9mAKHLyrfqNtoMhjgL45hQKfy2A5KZFp0FCjBQgxJnllLgJpIXnQMS2
	jsBt
X-Received: by 2002:a17:902:868a:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2dfa649041dmr428155ad.5.1790362754409;
        Fri, 25 Sep 2026 11:59:14 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea18ebb7sm1635695b3a.18.2026.09.25.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:59:13 -0700 (PDT)
Date: Fri, 25 Sep 2026 18:59:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aratPy2p33MObulT@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
 <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
 <b1a845c3-3720-4ef6-8c97-8a40ee7bd286@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1a845c3-3720-4ef6-8c97-8a40ee7bd286@linux.dev>

On Thu, Sep 24, 2026 at 09:47:03PM -0700, Zhu Yanjun wrote:
>
>在 2026/9/22 11:53, David Matlack 写道:
>>On Tue, Sep 22, 2026 at 11:36 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>在 2026/9/18 13:06, David Matlack 写道:
>>>>Future Work
>>>>-----------
>>>>
>>>>Following this series, we expect to make further improvements to the PCI
>>>>core support for Live Update:
>>>>
>>>>    - Allow P2P across Live Update by avoiding resizing or moving
>>>>      preserved device BARs and preserving all upstream bridge windows.
>>>>
>>>>    - Support preserving Virtual Functions by preserving SR-IOV
>>>>      configuration on PFs and enumerating VFs after Live Update.
>>>Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
>>>kexec is a foundational step for minimizing downtime.
>>>
>>>As we look toward complete end-to-end support for DMA preservation
>>>across Live Update—especially for VFIO device passthrough and dma-buf
>>>sharing scenarios—IOMMU table/domain preservation becomes crucial to
>>>prevent IOMMU page faults when devices continue performing DMA during kexec.
>>>
>>>I would like to ask about the current status and roadmap regarding IOMMU
>>>Live Update / KHO (Kexec Handover) support:
>>>
>>>Is there an ongoing effort or RFC series for IOMMU handover / page-table
>>>preservation currently in development or under discussion?
>>>
>>>How is the coordination between the PCI core Live Update mechanisms and
>>>the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
>>>restoring domains or handing over root tables)?
>>>
>>>Any pointers to active discussion threads, RFCs, or future plans
>>>regarding IOMMU participation in Live Update would be greatly appreciated.
>>The first IOMMU series to support Live update, can be found here:
>>
>>   https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
>
>After cloning the source code from samikhawaja/linux, branch 
>iommu/phase1-v5, I tested the VFIO live update functionality in my 
>local KVM environment and encountered the following issue.
>
>When I run the following commands to verify that VFIO live update 
>works correctly, I get the output shown below.
>
>I am currently testing with VFIO v5 and PCI core v9, and I am not sure 
>whether this behavior is expected.
>
>Interestingly, when I revert the following commit:
>
>vfio/pci: Preserve the iommufd state of the vfio cdev
>
>the issue disappears.
>
>Could you please let me know whether this is expected behavior, or 
>whether it indicates a problem with the current VFIO live update 
>implementation?
>
>"
>
>echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
>
>echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
>Preserving device in session
>vfio_pci_liveupdate_kexec_test.c:122: Assertion Failure
>
>  Expression: ret == 0
>  Observed: 0xffffffffffffffea == 0
>  [errno: 22 - Invalid argument]
>"

Hi Yanjun,

Thanks for testing this.

This is expected. With "vfio/pci: Preserve the iommufd state of the vfio
cdev", preserving a vfio cdev depends on the preservation of its
associated iommufd. Since the vfio_pci_liveupdate_kexec_test does not
preserve the associated iommufd, it fails with -EINVAL.

Note that the IOMMU persistence series does not update the
vfio_pci_liveupdate_kexec_test, with those extra bits, as it would
regress after_kexec() part of the test because the retrieval of iommufd
is not supported in phase1.

Please use tools/testing/selftests/iommu/iommufd_liveupdate_kexec_test
added in the last patch of the series, it sets up the iommufd and HWPT
preservation before preserving the vfio cdev.

The wip phase2 can be found here if you are interested.
https://github.com/samikhawaja/linux/tree/iommu/phase2-v1-wip

Thanks,
Sami

>
>Thanks a lot.
>
>Yanjun Zhu
>
>>
>>The IOMMU series builds on top of the PCI core support (this series)
>>and the VFIO series linked further up in the cover letter.
>
>-- 
>Best Regards,
>Yanjun.Zhu
>
