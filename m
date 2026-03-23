Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE753E5569;
	Mon, 23 Mar 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298999; cv=none; b=BMZbanNxD/tY1NeQT09h1GDv1XQq3zGXWAbz4nmfJoHUyS1D/7epqHx4faODK56GYRdMYoWtudBGFO9q6X26AwHI8dG6x4Pw0nvAmUn6LAYVuFK3TIrzuMvfc8i8lvHFvBpdKq4GTBReNplM2rQGNVyOSXKM/Lr9FQQX032KAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298999; c=relaxed/simple;
	bh=N5dAdigcIJ9OJ8hoMxnKF1/5TA52Fc4LjFBNE2MWH08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cza5rNFAUQDiJpZk5Dg95RT/0nscGqyHyF6ddccleU6mzMLjnL8KeqliEyNPK6za1B1UVUw+rsvcr95CiHdgEQKQMMxFDwjNX+tsw5NT3iWKL7r/J4zsHf2H9CFQBUf4KtNMf8a0Um9GtKaY9x9VuggllnvNGywMs7shDt0+3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745ED14BF;
	Mon, 23 Mar 2026 13:49:42 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790B53F73B;
	Mon, 23 Mar 2026 13:49:43 -0700 (PDT)
Message-ID: <6c3b506e-8cc4-45ad-a801-326886c694c4@arm.com>
Date: Mon, 23 Mar 2026 20:49:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Juan Yescas <jyescas@google.com>, kernel-team@android.com
References: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <67b32e90-1f60-4bf5-b534-b4a901d5a796@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <67b32e90-1f60-4bf5-b534-b4a901d5a796@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/03/2026 5:18 pm, Tudor Ambarus wrote:
> Hi, Robin,
> 
> On 2/28/25 5:46 PM, Robin Murphy wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index a3b45b84f42b..1cec7074367a 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>>   	if (!dev_iommu_get(dev))
>>   		return -ENOMEM;
>>   	/*
>> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
>> -	 * instances with non-NULL fwnodes, and client devices should have been
>> -	 * identified with a fwspec by this point. Otherwise, we can currently
>> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
>> +	 * is buried in the bus dma_configure path. Properly unpicking that is
>> +	 * still a big job, so for now just invoke the whole thing. The device
>> +	 * already having a driver bound means dma_configure has already run and
>> +	 * either found no IOMMU to wait for, or we're in its replay call right
>> +	 * now, so either way there's no point calling it again.
>> +	 */
>> +	if (!dev->driver && dev->bus->dma_configure) {
>> +		mutex_unlock(&iommu_probe_device_lock);
>> +		dev->bus->dma_configure(dev);
>> +		mutex_lock(&iommu_probe_device_lock);
>> +	}
> 
> I was chasing the "something fishy" dev_WARN on a 6.19+ downstream
> android kernel and while looking at the IOMMU code I couldn't help
> myself and ask whether we shall prevent concurrent execution of
> dma_configure().
> 
> It seems to me that while the IOMMU subsystem is executing
> dma_configure(), the deferred probe workqueue can concurrently pick up
> the same device, enter really_probe(), set dev->driver, and execute
> dma_configure(). Is it worth protecting against this?

Yes, it's certainly still possible to hit a false-positive if thread A 
in iommu_device_register()->bus_iommu_probe() races against thread B 
attempting to bind, simply because thread B can set dev->driver long 
before it gets to any point where ends up serialising on 
iommu_probe_device_lock again, so thread A can observe that even while 
it is doing the IOMMU probe in the "correct" context. Other than the 
warning though, it's still functionally OK even if the "wrong" thread 
does end up finishing the probe, at least after 0c8e9c148e29 ("iommu: 
Avoid introducing more races").

> I can try to prove it if needed, using a downstream iommu driver (sigh).
> 
> Thanks!
> ta
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e61927b4d41f..5f0c1a8064b5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -461,9 +461,19 @@ static int iommu_init_device(struct device *dev)
>           * already having a driver bound means dma_configure has already run and
>           * found no IOMMU to wait for, so there's no point calling it again.
>           */
> -       if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
> +       if (!dev->iommu->fwspec && !READ_ONCE(dev->driver) &&
> +           dev->bus->dma_configure) {
>                  mutex_unlock(&iommu_probe_device_lock);
> -               dev->bus->dma_configure(dev);
> +
> +               /*
> +                * Serialize with really_probe(). Recheck dev->driver in case a
> +                * driver bound while we were waiting for the lock.
> +                */
> +               device_lock(dev);
> +               if (!dev->driver)
> +                       dev->bus->dma_configure(dev);
> +               device_unlock(dev);

Much as I can't wait to get rid of iommu_probe_device_lock, the main 
reason we still can't rely on device_lock() at the moment is not 
actually the remaining sketchy replay-dependers per the comment in 
__iommu_probe_device(), but more fundamentally that for most IOMMU 
drivers this will deadlock in that same 
iommu_device_register()->bus_iommu_probe() path, when the bus walk 
happens to stumble across the IOMMU device itself, which of course is 
already locked as it's still in the middle of its own driver bind. I 
couldn't see an easy, clean and reliable way to get around that, so that 
can got kicked down the road in order to get the "call of_xlate in the 
right order and make iommu_device_register() actually work" basics 
landed (and start shaking out all these other problems...)

Thanks,
Robin.

> +
>                  mutex_lock(&iommu_probe_device_lock);
>                  /* If another instance finished the job for us, skip it */
>                  if (!dev->iommu || dev->iommu_group)
> (END)

