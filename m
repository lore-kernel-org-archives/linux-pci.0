Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177538;
	b=fZs9cRLlD+32Q3uf2L60mI4m5YIA9EI2p4cl5aLOVyVELMYY1gtsN0w6walzjZRc1CMH
	 qLk5lXf3YxZnStn2Dwdmh/IMyHmv1H1zwAVSnH8hPoPg07qs+G/zng9y423OIzk+Ru2LX
	 ZAw8IF4r6pKGJxlSBM1rr6aokK/hVtxMQYmAaq6LLsDdakLpQoOMZD27ch5rZGbxjFCwv
	 tpB7KyWN7cPnkO85tb7tVgi82uYIn1aRZHhDi5LMmhET4rxZSxKmPR+S8lzkX3ZSK4v7a
	 F7358+zRJBNFIEUXb4Kj1Hn4SSrGVPSBN+E9Fqw+mgAMeWmUGmhPrFARTsgI7X/WsDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177538;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:
	 References:CC:From:Message-ID:Date:User-Agent:MIME-Version:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=8xJ1qfFqAUWbXLTRDaZwau1M0CTMuI6HGe/uX0eO0b0=;
	b=w70DhAvy3+kWJxmihvoFr0vQAdWOhhUSt94d0N4Ka4fiWSoRWjGidXETDLlgTW+/JgwS
	 Q3S1Oh6KER+1DshghuQ5FORHf6Fs1dR06j84yiRgV+kRvcRiv3Dy+o5EGUv+uvVmingjP
	 JEC5NOR4BcCEGHgWNXZz2VaSRNzQ7s79U+FxgISzLF44PTrmEhNncCRri1M1VON7IZrmN
	 QSTRA5rgDtGY9JfiF94FlhJBCrdkscAHDgt66RgwrO7Nd+L6PUm6t86KFcCsgdMFxDEGG
	 zlCOIGSGYZVZTcF9xGYHcfqNtD2+iia5rcKHDJcq4yKB4gU4o1FsRtdBFPLgg4qD4yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O5CaaKYk;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B812606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 08:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B812606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O5CaaKYk
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8xJ1qfFqAUWbXLTRDaZwau1M0CTMuI6HGe/uX0eO0b0=;
	b=O5CaaKYkfqHftKjunFQB9pdQFegQym6RKWc56fjKARH+zoQe4+2j3UuyzNr48Wm3e/WPnhZFl
	0OVNF2pjzNu9WEnEnziwyT3NeDN+sJCtgbZS8zkzD2P+uEbz5M6v3vT0AEyoxxcvHDjEb0buSV9
	El0wVVO5oGODHLSwX5hrYn0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jF1M13NSpz1T4Lc;
	Wed, 28 Oct 2026 16:51:57 +0800 (CST)
Received: from kwepemf200011.china.huawei.com (unknown [7.202.181.237])
	by mail.maildlp.com (Postfix) with ESMTPS id 22BB14056E;
	Wed, 28 Oct 2026 16:52:07 +0800 (CST)
Received: from [10.67.120.87] (10.67.120.87) by kwepemf200011.china.huawei.com
 (7.202.181.237) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 28 Oct
 2026 16:52:06 +0800
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
To: "Laguna, Lukasz" <lukasz.laguna@intel.com>,
	<sashiko-reviews@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-5-lukasz.laguna@intel.com>
 <sashiko-outbox-186926@kernel.org>
 <0576e676-b9b5-422b-8bbf-0643065c1bd5@intel.com>
CC: <michal.winiarski@intel.com>, <bhelgaas@google.com>, <alex@shazbot.org>,
	<kevin.tian@intel.com>
From: Weili Qian <qianweili@huawei.com>
Message-ID: <3464fe3b-8a9a-cbe0-c96b-e4929ec46264@huawei.com>
Date: Wed, 28 Oct 2026 16:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <0576e676-b9b5-422b-8bbf-0643065c1bd5@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200011.china.huawei.com (7.202.181.237)


Thanks for adding us.

We've reviewed the series and confirmed that it conflicts with QM's 
existing PF↔VF reset coordination. QM currently handles PF FLR through 
driver-specific mechanisms: the PF notifies all VFs before reset an each 
VF stops itself and acknowledges back. The new 
reset_prepare()/reset_done() calls on each VF before the PF's introduce 
a second path that contends with QM's QM_RESETTING bit lock across 
reset_prepare/reset_done, causing timeouts on both host-side VFs (QM 
driver) and passthrough VFs (hisi-acc-vfio-pci driver).

We support the direction of this series and will adapt QM and 
hisi-acc-vfio-pci to work with the PCI core's unified VF handling.

Additionally, we notice that passthrough VFs bound to generic vfio-pci 
do not receive reset_prepare/reset_done notification. We're wondering 
whether there's a way to uniformly cover both host-side and passthrough 
VFs in the PCI core.

Thanks,
Weili

On 2026/10/28 0:51, Laguna, Lukasz wrote:
>
>
> Adding HiSilicon QM and hisi-acc-vfio-pci maintainers.
>
> Hi Zhou, Weili, Longfang,
>
> The series [1] adds generic handling of VFs across a PF reset in the 
> PCI core. On PF reset, the core now saves / restores all subordinate 
> VFs config state, and notify their drivers via .reset_prepare() / 
> .reset_done(), as VF state is lost on PF reset anyway.
>
> Sashiko points out above [2], that this conflicts with the 
> driver-specific VF handling in HiSilicon QM and hisi-acc-vfio-pci. It 
> seems to be a valid point.
>
> Could you please take a look and share your thoughts?
>
> [1] 
> https://lore.kernel.org/linux-pci/20261027160446.858300-1-lukasz.laguna@intel.com/
> [2] https://lore.kernel.org/linux-pci/sashiko-outbox-186926@kernel.org/
>
> Thanks,
> Lukasz
>
> On 10/27/2026 17:34, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [High] PCI/IOV: calling VF reset_prepare() before PF breaks hisi_qm 
>> PF FLR
>> -- 
>>
>> commit b82e20ef0c7a057bbb242268e11b3dd9218fd7d8
>> Author: Michał Winiarski <michal.winiarski@intel.com>
>>
>> PCI/IOV: Allow VF drivers to handle resets
>>
>> This commit updates PCI function, bus, and slot reset handling to lock
>> enabled VFs, notify VF drivers via .reset_prepare() and 
>> .reset_done(), and
>> save and restore VF configuration state across PF resets.
>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index d8e7c7d8e4021..d088302547c34 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>> [ ... ]
>>
>>> @@ -5171,6 +5202,17 @@ static void pci_dev_save_and_disable(struct 
>>> pci_dev *dev)
>>>           return;
>>>         pci_save_state(dev);
>>> +}
>>> +
>>> +static void pci_dev_save_and_disable(struct pci_dev *dev)
>>> +{
>>> +    struct pci_dev *vf;
>>> +
>>> +    for_each_pci_vf(dev, vf)
>>> +        pci_dev_reset_prepare_and_save(vf);
>>> +
>>> +    pci_dev_reset_prepare_and_save(dev);
>> [Severity: High]
>> Does calling .reset_prepare() on each VF before the PF here cause a
>> self-blocking timeout and reset failure on HiSilicon QM devices
>> (hisi_hpre, hisi_sec2, hisi_zip, and hisi_acc_vfio_pci) when 
>> resetting a PF
>> with enabled VFs?
>>
>> In pci_dev_save_and_disable(), pci_dev_reset_prepare_and_save(vf) 
>> runs for
>> every VF and then pci_dev_reset_prepare_and_save(dev) runs for the PF 
>> in the
>> same thread before any .reset_done() callback is invoked in
>> pci_dev_restore().
>>
>> When VFs are bound to hisi_acc_vfio_pci (where hisi_acc_vdev->pf_qm 
>> points
>> to the PF's struct hisi_qm), the first VF's .reset_prepare() sets the 
>> reset
>> bit on the shared PF qm->misc_ctl and holds it until .reset_done():
>>
>> drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:
>> hisi_acc_vf_pci_reset_prepare() {
>>     struct hisi_acc_vf_core_device *hisi_acc_vdev = 
>> hisi_acc_drvdata(pdev);
>>     struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
>>     ...
>>     while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
>>         msleep(1);
>>         if (++delay > QM_RESET_WAIT_TIMEOUT) {
>>             dev_err(dev, "reset prepare failed\n");
>>             return;
>>         }
>>     }
>> }
>>
>> Similarly, when VFs are bound to hisi_hpre, hisi_sec2, or hisi_zip on
>> Kunpeng920, hisi_qm_reset_prepare() -> qm_reset_prepare_ready() 
>> acquires the
>> same bit on pf_qm->misc_ctl via qm_wait_reset_finish(pf_qm) and only 
>> clears
>> it in hisi_qm_reset_done() -> qm_reset_bit_clear():
>>
>> drivers/crypto/hisilicon/qm.c:
>> qm_reset_prepare_ready() {
>>     struct pci_dev *pdev = qm->pdev;
>>     struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
>>
>>     if (qm->ver < QM_HW_V3)
>>         return qm_wait_reset_finish(pf_qm);
>>
>>     return qm_wait_reset_finish(qm);
>> }
>>
>> Because the first VF's .reset_done() has not run yet, every 
>> subsequent VF's
>> .reset_prepare() and the PF's own hisi_qm_reset_prepare() will spin 
>> waiting
>> for that bit on pf_qm->misc_ctl until the timeout expires, log an 
>> error, and
>> return early without stopping the remaining VFs or the PF prior to the
>> hardware reset.
>>
>> On Kunpeng930 (where qm->ver >= QM_HW_V3) with host-bound VFs, each VF's
>> hisi_qm_reset_prepare() sets the bit on its own vf_qm->misc_ctl. When 
>> the PF
>> subsequently runs hisi_qm_reset_prepare(), it notifies VFs via 
>> mailbox and
>> waits for them:
>>
>> drivers/crypto/hisilicon/qm.c:
>> hisi_qm_reset_prepare()
>>    -> qm_try_stop_vfs()
>>         -> qm_ping_all_vfs()
>>         -> qm_wait_vf_prepare_finish()
>>
>> Each VF's mailbox work handler (qm_pf_reset_vf_process() ->
>> qm_pf_reset_vf_prepare() -> qm_reset_prepare_ready(vf_qm)) then tries to
>> acquire the bit on vf_qm->misc_ctl that is already held by that VF's own
>> .reset_prepare(), timing out and causing the PF reset preparation to 
>> fail as
>> well.
>>
>
> .
>

