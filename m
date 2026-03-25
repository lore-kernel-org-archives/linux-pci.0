Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AA322B6D;
	Wed, 25 Mar 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428069; cv=none; b=re/Nra/PDjqv0lxp7p/jrylWEO1pEZ7uDM8Lco7yT+uIFtKHgvWjIfawxwjhhXp9Etb8hngOo1jd3PWW8oLyNbsbc6XxF7UdMC243CWihWIcXfRRw2PmqojgROcJi1TkQulR74X4lHHtH/Oi0b+NzXl9+KKfSP5BFcVDPpCRNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428069; c=relaxed/simple;
	bh=6fIaSRgI/UKCQNn6dm2hPf9jgeTb152hGJQb3krix2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fqm6n/lussgjylQXdYUv8fvhKd77V5DvuYtwXwLUvBuu2nEtrR11RHvWr0GHZajVEfSgU86L6fDM066KGnMUoa0QOPxBdGZcZryFs7193kHFa332sT4P/Su4UuZ4FzzzfB8U6nbYN3kwWgQVx8VcTAu3q5LqgsgYmCflvjbfm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GBSzjTwY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GBSzjTwY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774428061; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fL1kmcxjs5DU657vQuJVn293nj/OcuTXb/UCoYe16TI=;
	b=GBSzjTwYMsfztPvBS8pINJk6lcRhKuUae+gXYovez4QfH9bv8PAdKmd5jUynhlZmG+Q8JeiSNDZnBwiO8yN2WlQtDjSkHKKjo7IsNSh+AcHeroskf9ztus1Ft9Et+WULGqHw4J9qZh50pryM6nY/9uu6zLxNswrnSHVzu2NDFi8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.h0GTa_1774428059;
Received: from 30.178.66.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.h0GTa_1774428059 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 16:41:00 +0800
Message-ID: <d57bf449-cd26-4fbd-891e-77534124e997@linux.alibaba.com>
Date: Wed, 25 Mar 2026 16:40:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize
To: Thomas Gleixner <tglx@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-3-kanie@linux.alibaba.com> <87mrzxgwfs.ffs@tglx>
 <fe47586d-688f-409c-95b5-d2cc54871f3a@linux.alibaba.com>
 <87mrzwfj7z.ffs@tglx>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <87mrzwfj7z.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/25 15:42, Thomas Gleixner 写道:
> On Wed, Mar 25 2026 at 09:34, Guixin Liu wrote:
>> 在 2026/3/24 21:59, Thomas Gleixner 写道:
>>> On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
>>>> After the upper-layer driver removes the device and before the next
>>>> probe, events such as firmware updates may increase the number of
>>>> interrupts supported by the device. However, the irq_domain still
>>>> retains the old hwsize, which causes subsequent interrupt allocation
>>>> failures. Update hwsize during MSI-X device domain setup to fix this
>>>> issue.
>>> When a device is removed then the corresponding struct device is torn
>>> down, which implies that the device domain is freed as well. So how can
>>> this end up with the old state on the next probe?
>> Hi, My description was a bit ambiguous. The msi_device_data_release()
>> path to remove the irq_domain is only triggered when the device is
>> removed at the PCI layer. If only the upper-layer driver unbinds,
>> this path will not be reached.
> What's an upper-layer driver? Please be precise.
>
> I assume you are talking about the device driver itself.
Sorry, My description is not very accurate, yes, it's device driver.
> Right, the
> unbind of the driver won't remove the domain. But there is no real good
> reason for keeping it around at that point.
>
> So the straight forward solution is to free the MSI domain when the
> driver shuts down and tears the MSI interrupts down.
Yes, I had also considered this aspect before, I will change the scheme 
to this,
and send another patch, thanks.

Best Regards,
Guixin Liu
>
> Thanks,
>
>          tglx
>

