Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3531352B;
	Wed,  5 Aug 2026 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893314; cv=none; b=mFTQ2x6ECSiftYv1tafpf5GleJioWfSqxo8i/lT+sqS/kIkuxJU6gybdBvbI55dYvAk2NY4mJlyH7T2GI1uTBRmeOkAQbACLK8vdvRcnbA7GK3YpAl+LrQUDDF7vKs6oYAnPv0MBwPTHfqBwj5R9mvt/V+DHf1EnS9D/hTv0ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893314; c=relaxed/simple;
	bh=2m0XReK9P0niwnml0pT7CnSP4s7ImV/YPIm7ItRz0KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=stBS4ozH/N7hX9PBNrD8V1f1NzL0fC/cjY/kIDUT4JVF6lbky6/mBkn97TCJSxJE3qz+1rDHyeWmxUPAhNpQMYEqDXK8tPxZTtNCt7Cu8rOM0683tEWP9hbboqi/E/zz4jp78NcsaH6G7VbrWy49ct3V/Nc6VadfKxSq1hvQEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f495afd0906c11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f4f64527-23c1-4f63-a712-efcd1f480d4e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c68affb801e85be353d472ff5c515d89,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f495afd0906c11f1aa26b74ffac11d73-20260805
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1627030330; Wed, 05 Aug 2026 09:28:25 +0800
Message-ID: <1b8d6927-68d5-4ab1-bd09-959a90cc3c72@kylinos.cn>
Date: Wed, 5 Aug 2026 09:28:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
To: Logan Gunthorpe <logang@deltatee.com>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
 <a619d2d6-5a6e-4173-9342-8186cce0eef1@deltatee.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <a619d2d6-5a6e-4173-9342-8186cce0eef1@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/5 03:48, Logan Gunthorpe 写道:
> 
> 
> On 2026-08-03 21:24, Pei Xiao wrote:
>> In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
>> &stdev->link_event_work is bound with link_event_work. The IRQ handlers
>> switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
>> on system_wq (via schedule_work() in the ISRs and via
>> check_link_state_events()).
>>
>> If we remove the device, switchtec_pci_remove makes cleanup and the
>> memory allocated for stdev is released by put_device() ->
>> stdev_release() -> kfree(stdev), while the works mentioned above may
>> still be pending or running. The sequence of operations that may lead
>> to a UAF bug is as follows:
>>
>> CPU0                                      CPU1
>>
>>                                           | switchtec_event_isr
>>                                           | schedule_work(&stdev->mrpc_work)
>> switchtec_pci_remove                      |
>> cdev_device_del(&stdev->cdev,             |
>>                 &stdev->dev)              |
>> stdev_kill(stdev)                         |
>> switchtec_exit_pci(stdev)                 |
>> pci_dev_put(stdev->pdev)                  |
>> put_device(&stdev->dev)                   |
>> // stdev_release -> kfree(stdev)          |
>>                                           | mrpc_event_work
>>                                           | // use stdev (use-after-free)
>>
>> Fix it by canceling the works after the sources that can schedule them
>> have been stopped: stdev_kill() first clears PCI bus mastering, which
>> prevents the MSI/MSI-X based IRQ handlers from firing and scheduling
>> new works, and the works are then canceled before the remaining
>> cleanup and the release of stdev. This also covers the probe error
>> path, which calls stdev_kill().
>>
>> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
>> Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
>> Assisted-by: Codex:deepseek-v4-flash
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/pci/switch/switchtec.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 5711aaa5df11..f339ea54aa38 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -1319,6 +1319,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
>>  	pci_clear_master(stdev->pdev);
>>  
>>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
>> +	cancel_work_sync(&stdev->mrpc_work);
>> +	cancel_work_sync(&stdev->link_event_work);
> 
> I'm wondering if these should come before the mrpc_timeout sync.
> Otherwise, hypothetically, new work could be added and another timeout
> could be in progress.
> 
yes,
  	
+	cancel_work_sync(&stdev->mrpc_work);
+	cancel_work_sync(&stdev->link_event_work);
	cancel_delayed_work_sync(&stdev->mrpc_timeout);

> Also, I'm not sure, but seems like the interrupt should be disabled
> before this as well?
I looked it up and it appears that pci_clear_master cannot disable
interrupt enabling. Should I use devm_free_irq?

Thanks！
Pei.
> 
> Thanks!
> 
> Logan

