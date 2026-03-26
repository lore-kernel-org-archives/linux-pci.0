Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29893191D0;
	Thu, 26 Mar 2026 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490116; cv=none; b=JUNj3sdM+pN20V4MDf1p4hDTlYObeugtWfcXprdDXZNxu4AuFDMGaOPw6Djmz+K9gZC0+pgvAYxk+1P3lYIp06bgnoPpZIWna2bR/F46jDO3lYEEhDPz0D7yq2eqVTCXjVQfP4vgU8IIWODhEbdirgB6fRa2RE2aFfRqkUNQbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490116; c=relaxed/simple;
	bh=F/WI36dL1ytDHcKxheiyO8rgiQ9nUJCVyeshxP/GLgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgnIRHTvzjtz/TQzIvUIzqA+yH6y2gEw/AqjJ7Pz7Xd83Z8PpibCOPrQTSAbUKve60EUPvtnWbk+1K1Anlmn7MyWbz0l2JlblCgquIV+kqlKFW5lHa2aHPHqQ/6ltLxTmrJN/f6AkgVo3zCnZn38jFHUlbpl0UHziBfjnKI2bto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I1D7H8pY; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I1D7H8pY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774490106; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YRfcQq71WsySCY7hit0/hQGSTlUQZX2idN/QywvSJ6A=;
	b=I1D7H8pYgTvA6RFKxEwZ8K+4G9wUMsame7JexcrTgQCtl843jq//HzV4I0ip0B84x+DpU2F45PUCnw0oxidmTwTF6DQlyeDSmilFPqpA9LQd/f4qEUZ+1mrWePNa/nhGKYOxoZcK1Xt9R5CblDdzc3V3izrnXVxlV7798ODdbs0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.jjynP_1774490104;
Received: from 30.178.67.121(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.jjynP_1774490104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Mar 2026 09:55:05 +0800
Message-ID: <eedd75d7-e6cd-400f-9e6f-8c1112f31083@linux.alibaba.com>
Date: Thu, 26 Mar 2026 09:55:02 +0800
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
 <d57bf449-cd26-4fbd-891e-77534124e997@linux.alibaba.com>
 <87h5q4f1sv.ffs@tglx>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <87h5q4f1sv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/25 21:58, Thomas Gleixner 写道:
> On Wed, Mar 25 2026 at 16:40, Guixin Liu wrote:
>> 在 2026/3/25 15:42, Thomas Gleixner 写道:
>>> So the straight forward solution is to free the MSI domain when the
>>> driver shuts down and tears the MSI interrupts down.
>> Yes, I had also considered this aspect before, I will change the scheme
>> to this, and send another patch, thanks.
> Actually none of that is required. When you update the firmware then
> just let the PCI core rescan the device. That makes way more sense as
> the new firmware might change other config entries as well not only the
> MSI ones.
>
> Thanks,
>
>          tglx
You are right, besides MSI, other attributes may also change.
Removing and then recanning the PCI device is the best approach.

Best Regards,
Guixin Liu

