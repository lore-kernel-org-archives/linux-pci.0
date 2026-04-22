Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13B377575
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847186; cv=none; b=IThGNOa8NIuIH5MI5PTyWu2bnOBL0l4CMQVUyXu9BRf7kFnD6BgoLI1zCeB3AGRXQ9f0TkzgkqWzsnF7NRKJRS/MNNVOHN0ex6NRTEH/BAcTDli0CLWeObvvJZZKZ+xOjFEKjMOkrl2TviTOpaT6lxXT45MGGifL5DrVp/wptOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847186; c=relaxed/simple;
	bh=yUNY2WJfRMKnvbtKN/j/UvADsxIjSpJls0F3U9Rux10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeabovX/wxN/YRsF308cCfKdiGaRXnpGj3BfGNtjIqq5GTjBg4ems+k2cXA/QKv5UEGwdi8biFKrpFG251pds4fuHcb2S/PJBhVPa6ygdbIzgxPuC/ISNUEXWHaI95CGJqIN4uhTy68hHnLVdU61Xla/36/JC2IunIF6jGVDOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g3S8Z4GC; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="g3S8Z4GC"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g0t1z2Z2Nz3yVZ;
	Wed, 22 Apr 2026 10:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776847175;
	bh=yUNY2WJfRMKnvbtKN/j/UvADsxIjSpJls0F3U9Rux10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g3S8Z4GC6aCNC+t29j/1QGZkgIt7qaTO+iQADn2aywvab/Ev8EjJuMreKxeleihQX
	 2hdKfdg+HuMkcRjd42bCVLxtYVK/pYNPjhtKZBTkIbN9CBpY4tZ8TIqLN+gY3S7Zc2
	 uL0t+O3FqDh7lspxKshvzyGOmKdjewuKGSX804Oo0ZDY9+CrX+pPoyPmzj8VBLk5iX
	 0eOlsua9Cwy80ts/Nh9KmaS6Jq9czu/I2UE3aVO4tKs4gTEnx1vcB5X6RxG777+oOi
	 4rRAUCE6mkWoex7wdG8eQHgHdDp+Q6kXFCQPyKcjRJvywyLQJcS9cnXpOz+0XPJdV4
	 vOY3S33AEgiQA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4g0t1k4b51z40Db;
	Wed, 22 Apr 2026 10:39:22 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g0t1j4MTwz8sZP;
	Wed, 22 Apr 2026 10:39:21 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 88904632AD;
	Wed, 22 Apr 2026 10:39:20 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0fe54399-1fb1-4f75-a60c-e171292415a6@leemhuis.info>
Date: Wed, 22 Apr 2026 10:39:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX8M Plus PCIe link regression
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Hongxing Zhu <hongxing.zhu@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <23024521.EfDdHjke4D@steina-w>
 <AS8PR04MB88332979F06EDE29E751BCE18C7CA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <2qto2ddqmtks37wxtklxo4ctvxyezmgtjcuprnk6crant5fvsu@vdbmqomrcqt3>
 <6102060.LvFx2qVVIh@steina-w>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <6102060.LvFx2qVVIh@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177684716089.1821918.1965836553222221611@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 88904632AD
X-NC-CID: pbQs2wGavMMtO1Lsg5Lqnthp6i0QkgfZ7gamkgUvglMNXJR6u80=

Lo! What happened to this regression? It looks like it was never
resolved. Is that something everybody can live with in some way? Or
something we have to live with, as reverting the culprit at this point
would create a regression and thus creates even more trouble then it solves?

Ciao, Thorsten

On 3/4/26 09:47, Alexander Stein wrote:
> 
> Am Mittwoch, 4. März 2026, 07:32:48 CET schrieb Manivannan Sadhasivam:
>> On Wed, Mar 04, 2026 at 02:55:51AM +0000, Hongxing Zhu wrote:
>>>> -----Original Message-----
>>>> From: Manivannan Sadhasivam <mani@kernel.org>
>>>> Sent: 2026年3月4日 0:42
>>>> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Alexander Stein
>>>> <alexander.stein@ew.tq-group.com>
>>>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> imx@lists.linux.dev
>>>> Subject: Re: i.MX8M Plus PCIe link regression
>>>>
>>>> On Tue, Mar 03, 2026 at 01:38:13PM +0100, Alexander Stein wrote:
>>>>> Hi,
>>>>>
>>>>> these days I noticed that there is a PCIe link regression on my
>>>>> i.MX8MP platform (TQMa8MPxL) running next-20260227.
>>>>> I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip link
>>>>> up workaround for newer platforms"). I always get the following errors:
>>>>>
>>>>> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
>>>>> CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
>>>>> imx6q-pcie failed with error -110
>>>>>
>>>>> Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2
>>>>> device is detected without issues.
>>>>>
>>>>> Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
>>>>> b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both
>>>> Gen
>>>>> 1 and Gen 2 devices are detect. Commit
>>>>> 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc is only required for conflict
>>>> free revert.
>>>>>
>>>>> Here is a summary with outputs:
>>>>> Gen 1 device
>>>>>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>>>>>> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>>>>>> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev
>>>>>> 01)
>>>>>
>>>>> Gen 2 device
>>>>>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>>>>>> 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe
>>>>>> SATA 6 Gb/s RAID controller (rev 20)
>>>>>
>>>>> output of "dmesg | grep imx6q-pcie". Common part for all tests:
>>>>>> imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
>>>>>> imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
>>>>>> 0x0000000000
>>>>>> imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
>>>>>> 0x0018000000
>>>>>> imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 == cpu 0x1ff00000
>>>>>> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K,
>>>>>> limit 16G
>>>>>
>>>>> next-20260227
>>>>> Gen 1
>>>>>> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
>>>>>> CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
>>>>>> imx6q-pcie failed with error -110
>>>>>
>>>>> Gen 2
>>>>>> imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie
>>>>>> 33800000.pcie: PCI host bridge to bus 0000:00
>>>>>
>>>>> next-20260227 + reverts
>>>>> Gen 1
>>>>>> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
>>>>>> 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie 33800000.pcie: PCI
>>>>>> host bridge to bus 0000:00
>>>>>
>>>>> Gen 2
>>>>>> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
>>>>>> 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie 33800000.pcie: PCI
>>>>>> host bridge to bus 0000:00
>>>>>
>>>>> What can we do here? I'm wondering why Gen 2 trains correctly, while
>>>>> Gen 1 doesn't.
>>>>>
>>>>
>>>> Thanks for the report and sorry for the breakage. Commit 9c03e30e3ade3,
>>>> mentions that the workaround is only needed for the i.MX6 platforms. So
>>>> I'm not sure why the patch breaks i.MX8M and that too only for Gen 1
>>>> speed.
>>>>
>>>> Also, before 9c03e30e3ade3, LTSSM was always started in Gen 1, but as per
>>>> your finding, only Gen 1 devices fail to work. So the code till
>>>> imx_pcie_wait_for_speed_change() shouldn't have an impact. Maybe the
>>>> issue is due to skipping imx_pcie_wait_for_speed_change()?
>>>>
>>>> Richard, thoughts?
>>> Hi Maini:
>>> Prior to calling imx_pcie_wait_for_speed_change(), the PCIe link must
>>>  already be established. Before commit 9c03e30e3ade3, the speed change
>>>  procedure was only initiated after the initial Gen1 link was successfully
>>>  brought up.
>>>
>>> Hi Alexander:
>>> Sorry for the breakage.
>>> Before commit 9c03e30e3ade3, i.MX8MP PCIe forced Gen1 link training
>>>  initially, then switched to Gen3 after link-up by triggering a speed
>>>  change. After commit 9c03e30e3ade3, link training starts directly at
>>>  the Gen3 capability level.
>>>
>>> The two link training methods differ only in the i.MX8MP Root Complex (RC)
>>>  link capability configuration prior to link training: one method forces
>>>  Gen1 speed, while the other retains the default Gen3 setting in your tests.
>>>
>>
>> I still don't understand why the link fails to train at Gen 1.
> 
> Independently from the configured maximum link speed, shouldn't the initial
> link be Gen1 anyway and upgraded to Gen 2 later on?
> 
> I added some debug output to dw_pcie_link_up()
> 
> imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link_speed: 3
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f704
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f722
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> 
> imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link_speed: 2
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> 
> imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link_speed: 1
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08000010
> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> 
> So for any maximum speed above Gen1 it seems that LTSSM is stuck at link
> training.
> Unfortunately only link training and link up bits are defined and RM doesn't
> show anything, so I don't know what the other bits are indicating.
> 
> For a Gen2 device the link training succeeds right away.
> 
> imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link_speed: 2
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
> imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08000010
> imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> 
> Best regards,
> Alexander

