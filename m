Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6B1A3166;
	Wed, 25 Mar 2026 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402482; cv=none; b=DNPEghm9dd0zHYaNyO+gCmZHUp71yLHxWDStx0XB9Kymi00EwvR+eur5vLepL7I01hjs4KiW0cbsU78GTkicWnL0nNdaWuZdtd1EPbYVG8NZ0IWEiOObsFUcsnJRTvsTmLaYaKDhUo2+w2wPLBU3S4CliUc5OiTJrJzWOb2pZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402482; c=relaxed/simple;
	bh=6462XqMzaibC/9kJU/+OPRqbqP4jIPJMtJOAWnyCaNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMgOtzU/pcixweoNcAyYk4nF42SKoJyoTS1LNp6WWds0N/D8r2zcE5p+Z50xtkpwP7eI77iCNZOSnSZUi9VEL3hSC4KIbaDw62jHG8636V+TOnjzFGVfcy30AmrSBwJ4xSMHodoae4kzPqaiB/Jgqvaq0n9jeSp1cAWN2YXt9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=annRI8mn; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="annRI8mn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774402477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1r+d4W6rUQnEFqGT4UmokDhMfcE0xKp+eh+D0oUtieU=;
	b=annRI8mnP7me7hIGn34kbPGQLja+GA2lfNQ8k7D283LFIMqM3zB7573ji+5SsjTNpFJ0q3OxlNKrkq16IIMvu23nIRG0B42ED2uwQN93YzrlQrFE+yvWG8+tnLvs4wbnYdDxk7USFxD2vBmflQUQ/1ya63BBr4UpggKiGhV+UWA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.fos0F_1774402475;
Received: from 30.178.66.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.fos0F_1774402475 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 09:34:36 +0800
Message-ID: <fe47586d-688f-409c-95b5-d2cc54871f3a@linux.alibaba.com>
Date: Wed, 25 Mar 2026 09:34:35 +0800
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
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <87mrzxgwfs.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/24 21:59, Thomas Gleixner 写道:
> On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
>> After the upper-layer driver removes the device and before the next
>> probe, events such as firmware updates may increase the number of
>> interrupts supported by the device. However, the irq_domain still
>> retains the old hwsize, which causes subsequent interrupt allocation
>> failures. Update hwsize during MSI-X device domain setup to fix this
>> issue.
> When a device is removed then the corresponding struct device is torn
> down, which implies that the device domain is freed as well. So how can
> this end up with the old state on the next probe?
>
> Thanks,
>
>          tglx
Hi, My description was a bit ambiguous. The msi_device_data_release()
path to remove the irq_domain is only triggered when the device is
removed at the PCI layer. If only the upper-layer driver unbinds,
this path will not be reached.

Best Regards,
Guixin Liu

