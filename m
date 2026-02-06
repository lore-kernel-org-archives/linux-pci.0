Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC8352FB7;
	Fri,  6 Feb 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389024; cv=none; b=o/weQxKXbHoD4f/0JXS3pXwn35+VyAnM9xYeGXnz85ucBJQueEUrSmVRrfyf2ae8+NvpLbCV13bP//bpZayE6w7LFuS2OXp0AQGsyJIal43VG7VRCcrxZmHg1ZQ+liF3xyrsSkiogNCSAMVb3EdQB7ca1ACItsoVqr7dF4iJ7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389024; c=relaxed/simple;
	bh=GFuWSG36I5GtuNifghQ4OLhVGbkv6zmOaLvNz+QlQUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdMGe69Nnuw+B3bkmfuWnYexA+llrK6Od1/OHx2miAijMk/pkixjJ8EsRqO4nXNXvtaxNgmsKeBd/Ggp2QVBEbzvRZHI0ulLMHMfxU35ulxgZix/iurOBi+Ygv7QyAWe8Tbmsyw+j4XR/85jvcCyALtO2I4a9HsWA2p2sBbuHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914C1339;
	Fri,  6 Feb 2026 06:43:36 -0800 (PST)
Received: from [10.57.54.83] (unknown [10.57.54.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DBB43F632;
	Fri,  6 Feb 2026 06:43:39 -0800 (PST)
Message-ID: <057c05cb-40b9-41e3-987a-3ccbac506324@arm.com>
Date: Fri, 6 Feb 2026 14:43:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
To: Jason Gunthorpe <jgg@ziepe.ca>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
 Xingang Wang <wangxingang5@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alex Williamson <alex@shazbot.org>,
 James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20260102-pci_acs-v3-3-72280b94d288@oss.qualcomm.com>
 <20260205233920.GA17083@bhelgaas>
 <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>
 <20260206143014.GH943673@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260206143014.GH943673@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-06 2:30 pm, Jason Gunthorpe wrote:
> On Fri, Feb 06, 2026 at 02:41:36PM +0530, Manivannan Sadhasivam wrote:
>>> It'd be worth expanding on this and what the effect of avoiding ACS SV
>>> is.  Does this change which devices can be safely passed through to
>>> virtual guests?  Does it give up isolation that users expect?
>>>
>>
>> IMO, ACS SV is somewhat broken on this switch. But we can still passthrough the
>> downstream devices to the guests. There won't be ACS SV apparently, but that's
>> what users will get with broken hw.
> 
> I agree with this, the HW is very broken, let's have it at least work
> properly in Linux on bare metal out of the box.
> 
> If someone really insists they need virtualization with narrow groups
> on this HW then they need to come with a more complete fix. Using VFIO
> is going to open up the reset flows that are problematic with the
> current solution, so it isn't like that is already working fully.
> 
> Somehow I suspect nobody would use this switch for virtualization :)

And it's fine on Juno, since due to the (lack of) SMMU StreamIDs you can 
only assign the entire root complex as a single iommu_group anyway :D

Cheers,
Robin.
