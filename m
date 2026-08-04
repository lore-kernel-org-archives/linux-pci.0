Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9555DDA9;
	Tue,  4 Aug 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872923; cv=none; b=TlL358jHUNRG9ply2QDFqeNKxzoUhQxl66LjsA24XCvrsMsITI90RBrezQVBAZWkbeHIx9OIenbOAnf/idvy11xCDBbUOzUDhfkz/Nuz2yWoL7u5vH8HQgapTojPUWa1ljDfS8VP0v+HKKUyka8+/MjWoVLwcDo4Q1vtbPxknEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872923; c=relaxed/simple;
	bh=2X9+9e+touMKxvGwVexLbuExPMjfwhPrmfG6ISa0Kuc=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=B75SzvnNvphMYA32NRnE8BrsytCvLZ3lFrE0ANr/u4DYiTk55M1MiaySZMu37vDOBbAngPJrWUbtN/hROQj9JqZZ8q8ssek8uRKyUlElhb9xr6Ii9q340wLMoNuyElpet/nug1B7mIBSha5fntypvIQfTh+wFD3oUQOgyfGet70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=gdJtIxAx; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="gdJtIxAx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=SIweWhV/tAxWJHuUbt3e32uO5CVnDWITQnVjU/T358s=; b=gdJtIxAxZWh9VdUhGa9PlKc91g
	n3Gaj79MLChmcy70c5Dw06BD6Pe2hFZ++nhrI7uYh0qJEypfl2OMvTcyZXrjdJQOllAfZA9cEBcZT
	9qVQDKPO21ry1lrUlZvk/cqyHBl2wYJv8VuSKVKGWOhtSS4OdVXYvHxV6E0PgORxyAkniX76kBQ2Z
	G4fkLGbqz5VInpUspbni3hSEb9R1SrUDLq3WSG61RLXc+f9/aadCv9gN+curimy/tcIMwNZLHstO7
	wMO44LZgK3FXvEeqnbltFoiGF6I/mY7AoNICAL0Uu7UUGTxUkzJhqRNjR8SmmczpCVevDWf1VRcUz
	sDJrzoDw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrL7w-000000000cw-2UGB;
	Tue, 04 Aug 2026 13:48:41 -0600
Message-ID: <a619d2d6-5a6e-4173-9342-8186cce0eef1@deltatee.com>
Date: Tue, 4 Aug 2026 13:48:34 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: xiaopei01@kylinos.cn, kurt.schwemmer@microsemi.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-03 21:24, Pei Xiao wrote:
> In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
> &stdev->link_event_work is bound with link_event_work. The IRQ handlers
> switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
> on system_wq (via schedule_work() in the ISRs and via
> check_link_state_events()).
> 
> If we remove the device, switchtec_pci_remove makes cleanup and the
> memory allocated for stdev is released by put_device() ->
> stdev_release() -> kfree(stdev), while the works mentioned above may
> still be pending or running. The sequence of operations that may lead
> to a UAF bug is as follows:
> 
> CPU0                                      CPU1
> 
>                                           | switchtec_event_isr
>                                           | schedule_work(&stdev->mrpc_work)
> switchtec_pci_remove                      |
> cdev_device_del(&stdev->cdev,             |
>                 &stdev->dev)              |
> stdev_kill(stdev)                         |
> switchtec_exit_pci(stdev)                 |
> pci_dev_put(stdev->pdev)                  |
> put_device(&stdev->dev)                   |
> // stdev_release -> kfree(stdev)          |
>                                           | mrpc_event_work
>                                           | // use stdev (use-after-free)
> 
> Fix it by canceling the works after the sources that can schedule them
> have been stopped: stdev_kill() first clears PCI bus mastering, which
> prevents the MSI/MSI-X based IRQ handlers from firing and scheduling
> new works, and the works are then canceled before the remaining
> cleanup and the release of stdev. This also covers the probe error
> path, which calls stdev_kill().
> 
> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
> Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/pci/switch/switchtec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5711aaa5df11..f339ea54aa38 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1319,6 +1319,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
>  	pci_clear_master(stdev->pdev);
>  
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);

I'm wondering if these should come before the mrpc_timeout sync.
Otherwise, hypothetically, new work could be added and another timeout
could be in progress.

Also, I'm not sure, but seems like the interrupt should be disabled
before this as well?

Thanks!

Logan
