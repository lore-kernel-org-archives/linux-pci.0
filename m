Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33814EC73
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948085; cv=none; b=HbnN493xWAUmp9W/sRRPwls/t4EEnjYPhnT0UuslhlKlMgbmhNqWvcrQswo+2+vrJAAW/qY5YtgjjnxFOv/zwk50fVFxehVG5m40sh47ka/Z44F5OnECrNp6qVe/lJpkVlGOhGFnQLvX4RSnBtapnuuqaV/nOcQuN90ase0iX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948085; c=relaxed/simple;
	bh=GxFMKMG5BaYGnBHPQ9NdLv7x7Jk4ldX/2/G5hesuDis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heW9rWFlwgQXVDvV09hqYspjMHdTGVZbRB2KxK9zp1m6r3KALyu8J5Cb1nPKll+aD28LIF11FrWNWeZL4et4EDew3Yxife+whucLA1jaZI5AP/6NkFp+aT/6Edwklt2xFdrgdmMGhUDv7RcmrbbkWJ2RgXfX/07XIFRN4EoiC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c90c91349a0411f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1a2aa87e-72ad-4133-9cfe-7d3ff8a7043a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a128bd6564e3e9ad7260057e1b0ecea2,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c90c91349a0411f19a56ed5b684f684d-20260817
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 271802368; Mon, 17 Aug 2026 14:27:56 +0800
Message-ID: <cefafece-f449-4527-bf2e-6e3d7ea05ee9@kylinos.cn>
Date: Mon, 17 Aug 2026 14:27:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
 kurt.schwemmer@microsemi.com, bhelgaas@google.com
References: <4cebfe41ee3985bc4f38beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn>
 <20260817055336.8C4C91F000E9@smtp.kernel.org>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20260817055336.8C4C91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/17 13:53, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free window in the `switchtec_pci_probe()` error path due to premature freeing of `stdev` while `event_irq` is active.
> - [High] Use-After-Free via TOCTOU race in `switchtec_dev_write` due to incorrect teardown ordering in `stdev_kill()`.
> --
> 
> --- Patch [1]: [PATCH v3] PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race condition ---
> commit a18ebaceba03ea5f94a521c5ced89b052f121ea9
> Author: Pei Xiao <xiaopei01@kylinos.cn>
> Subject: PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race condition
> 
> This patch attempts to fix a use-after-free bug during device removal by
> quiescing interrupt sources before canceling pending work items. It adds
> logic to stdev_kill() to explicitly free IRQs and cancel work structures.
> It also stores the IRQ numbers explicitly in the switchtec_dev structure.
> 
> Link: https://lore.kernel.org/lkml/5ce42824-488e-4040-8531-0acc8b01b13a@deltatee.com/#t
> 
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 41fc4b5127081..91d44acfe1193 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
> 
> [ ... ]
> 
>> @@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
>>  
>>  	pci_clear_master(stdev->pdev);
>>  
>> +	if (stdev->event_irq)
>> +		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
>> +	if (stdev->dma_mrpc_irq)
>> +		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
>> +
>> +	cancel_work_sync(&stdev->mrpc_work);
>> +	cancel_work_sync(&stdev->link_event_work);
>>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
> [Severity: High]
> This is a pre-existing issue, but does canceling this delayed work before
> setting the alive flag allow it to be re-armed?
> 
> If userspace performs a concurrent write during device removal, it can call
> switchtec_dev_write(), which does:
> 
> drivers/pci/switch/switchtec.c:switchtec_dev_write() {
>     ...
>     rc = lock_mutex_and_test_alive(stdev);
>     if (rc)
>         return rc;
>     ...
>     rc = mrpc_queue_cmd(stuser);
>     ...
> }
> 
> Because cancel_delayed_work_sync() executes outside of mrpc_mutex and before
> stdev->alive is set to false, mrpc_queue_cmd() could successfully re-arm
> stdev->mrpc_timeout after it was just canceled.
> 
> When stdev is subsequently freed, could this newly armed delayed work execute
> on freed memory?
I have send this patch for this bug:
https://lore.kernel.org/lkml/e640c79072065c1a347ed25f7ce0fe1ba565f4fe.1786017236.git.xiaopei01@kylinos.cn/
> 
>>  
>>  	/* Mark the hardware as unavailable and complete all completions */
> 
> [ ... ]
> 
>> @@ -1513,6 +1522,7 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
>>  
>>  	if (rc)
>>  		return rc;
>> +	stdev->event_irq = event_irq;
> [Severity: High]
> This is a pre-existing issue, but is there a use-after-free window in the
> probe error path?
> 
> When switchtec_init_isr() requests event_irq, it uses devm_request_irq()
> bound to the PCI device:
> 
> drivers/pci/switch/switchtec.c:switchtec_init_isr() {
>     ...
>     rc = devm_request_irq(&stdev->pdev->dev, event_irq,
>                           switchtec_event_isr, 0, KBUILD_MODNAME, stdev);
>     ...
> }
> 
> If a subsequent initialization step fails during switchtec_pci_probe(),
> the err_put path will free the stdev structure:
> 
> drivers/pci/switch/switchtec.c:switchtec_pci_probe() {
>     ...
> err_put:
>     ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>     put_device(&stdev->dev);
>     return rc;
> }
> 
> Since put_device() immediately frees stdev without explicitly freeing the IRQ,
> and devres cleanup doesn't run until the probe function returns, could an
> interrupt fire during this window and cause switchtec_event_isr() to
> dereference the already freed stdev?
> 
>>  
>>  	if (!stdev->dma_mrpc)
>>  		return rc;
> 
> [ ... ]
> 

