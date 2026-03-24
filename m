Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6E48CFC;
	Tue, 24 Mar 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316989; cv=none; b=b2Yak6gNJCLJr0px3F4j+F/7WnNF6jRj/tEroWPpK6La6ociY6A6FGOR5HXzGMtZ8fJ2OU02p9lYDJ1j8eOxZO4R1y4M7+eCLbruumFiGYLu9bNJllT81/oVPkZ91aferWyeA4r72japR8BQYt9Pp3SZO2vM8OF1ZKP7KVBuP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316989; c=relaxed/simple;
	bh=pEpU2SbnOf8Bf8T/x3CY5UiRspP+7EEpszDaGsONM00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WF5UPT/Hl1KxwksBVdI/d0Ed+VgF+/ZaOBUh58uSAJv1Yt28+ofZqyp7S+Temz6LlfnT+P4Manzm3vI5dodm+Wr1I4aeYKSfmGkFaCS9FBFMY5QRrvRA0eyUGtLyJnW8K2aAQavG2Kx4jb1uAgOXu3LcWvWMH5ZbohMoeVCKy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EN+ephv/; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EN+ephv/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774316984; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=wOkSPCq22SnhiamObwij06PONh2OoYn/4Hou1YdDKlQ=;
	b=EN+ephv/dVixFKkBEjKltIBfeA7uAhBsnjoIJjeTVUTkStcBoqrDZl7jfRcmILwsnOADDNMRyYeYhZj+6xWv5CJ/GnhCxfexeccTyLs4Ni58XJRewncPA+3UAkoNwcldHHhshrExWPc8mJ1fPsj4Gx+ccK8gcOp+i79mFf1Kk/M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.cs40E_1774316983;
Received: from 30.178.68.7(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.cs40E_1774316983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 09:49:44 +0800
Message-ID: <1b26c144-2bf8-4f61-818c-e6d05101aa93@linux.alibaba.com>
Date: Tue, 24 Mar 2026 09:49:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Update MSI-X irq domain hwsize
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260324014707.4236-1-kanie@linux.alibaba.com>
In-Reply-To: <20260324014707.4236-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Wrong sending, please ignore~

在 2026/3/24 09:47, Guixin Liu 写道:
> Hi,
>    These two patches provide the ability to update hwsize during re-probe.
> All comments are welcome.
>
> Guixin Liu (2):
>    genirq/msi: Introduce update hwsize helper
>    PCI/MSI: Update MSI-X irq domain hwsize
>
>   drivers/pci/msi/irqdomain.c |  5 ++++-
>   include/linux/msi.h         |  3 +++
>   kernel/irq/msi.c            | 22 ++++++++++++++++++++++
>   3 files changed, 29 insertions(+), 1 deletion(-)
>

