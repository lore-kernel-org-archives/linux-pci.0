Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952940DFB8;
	Tue, 10 Mar 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150121; cv=none; b=LJTL9PRb05N4E8rcJZ+qGyaV4BRB54/kWJ1T6ERLTmY0enOxz6eTvLuKm+HznUVw5ZYuiluy158dePP9ru6FU04RiPr+dFuoml7R/KZaIgtLtlZr46SvR5aG4332WjCGrHh9rxqR5QbEc+YZaeRpufa6Y4Y1ju558rU+Z96EdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150121; c=relaxed/simple;
	bh=jsFoQKs/PMHOG6cQ3a8++hIBRpXtQqqlmyHFLdSwE74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0IRd6WyY8f+5HNs64QLOwXtAN0iVYYOZq78eZ7Op76FktW8/jcLV4L0KawnBX0aw2xDe+oFWKPGtxwo0J6idPXdkyqyuybUPJeWidsEQMRXRsk0C8tT76uGhl+Akh+LFggllwUuqJIt3N+p2F0t9GK/ybSkHEVriBxwlHbEl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6250916A3;
	Tue, 10 Mar 2026 06:41:53 -0700 (PDT)
Received: from [10.57.59.166] (unknown [10.57.59.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1BBE3F73B;
	Tue, 10 Mar 2026 06:41:56 -0700 (PDT)
Message-ID: <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
Date: Tue, 10 Mar 2026 13:41:56 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Cc: Grimmauld <grimmauld@grimmauld.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mani,

On 2026-03-04 6:48 am, Manivannan Sadhasivam wrote:
> 
> On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
>> Rockchip DWC PCIe driver currently performs synchronous link training for
>> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
>> the link to be fully established, adding several milliseconds to the boot
>> sequence. To optimize boot time, this change enables asynchronous probing,
>> allowing link establishment to proceed in the background while the kernel
>> continues probing other devices.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: dw-rockchip: Enable async probe by default
>        commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a

This appears to have the side-effect that calling pci_host_probe() from
async context can effectively force async probe for the endpoint drivers
as well, but some drivers are not OK with that, as our CI has just
flagged up.

(And as for that particular warning, ISTR last time I looked into it
another context, the opinion of the MDIO/phy maintainers seemed to be
"don't force async probe".)

Thanks,
Robin.


1467 00:47:33.141229  <4>[   18.243373] ------------[ cut here ]------------
1468 00:47:33.141490  <4>[   18.243803] WARNING: kernel/module/kmod.c:144 at __request_module+0x198/0x200, CPU#4: kworker/u32:5/101
1469 00:47:33.142056  <4>[   18.244653] Modules linked in: r8169 snd_soc_hdmi_codec rfkill_gpio rfkill pwm_fan display_connector snd_soc_simple_card rtc_hym8563 rk805_pwrkey snd_soc_es8316 industrialio_triggered_buffer typec phy_rockchip_samsung_hdptx rockchip_thermal kfifo_buf phy_rockchip_naneng_combphy spi_rockchip_sfc rockchip_dfi synopsys_hdmirx v4l2_dv_timings snd_soc_rockchip_i2s_tdm hantro_vpu v4l2_vp9 v4l2_h264 v4l2_jpeg videobuf2_dma_contig rockchip_rga videobuf2_dma_sg v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc pci_endpoint_test rockchipdrm dw_hdmi_qp analogix_dp inno_hdmi dw_dp dw_mipi_dsi drm_dp_aux_bus dw_hdmi panthor drm_display_helper drm_gpuvm drm_exec cec drm_shmem_helper drm_client_lib gpu_sched drm_dma_helper drm_kms_helper snd_soc_audio_graph_card snd_soc_simple_card_utils snd_soc_core snd_compress snd_pcm_dmaengine snd_pcm drm snd_timer snd backlight soundcore dm_mod ipv6
1470 00:47:33.142376  <4>[   18.251632] CPU: 4 UID: 0 PID: 101 Comm: kworker/u32:5 Not tainted 7.0.0-rc3-next-20260309 #1 PREEMPT
1471 00:47:33.142648  <4>[   18.252465] Hardware name: Radxa ROCK 5B (DT)
1472 00:47:33.142915  <4>[   18.252866] Workqueue: async async_run_entry_fn
1473 00:47:33.143182  <4>[   18.253291] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
1474 00:47:33.143450  <4>[   18.253920] pc : __request_module+0x198/0x200
1475 00:47:33.143714  <4>[   18.254325] lr : __request_module+0x190/0x200
1476 00:47:33.143979  <4>[   18.254730] sp : ffff800084233420
1477 00:47:33.144239  <4>[   18.255042] x29: ffff800084233420 x28: ffff000116886000 x27: ffff000116887000
1478 00:47:33.144524  <4>[   18.255687] x26: ffff0001168870d0 x25: ffff80007b6c1738 x24: 0000000000000000
1479 00:47:33.172973  <4>[   18.256333] x23: ffff000116886000 x22: 0000000000000000 x21: ffff00011b80f800
1480 00:47:33.173352  <4>[   18.256979] x20: 0000000000000001 x19: ffff800081e2bfd8 x18: 0000000000000002
1481 00:47:33.173658  <4>[   18.257625] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
1482 00:47:33.173946  <4>[   18.258270] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000000
1483 00:47:33.174228  <4>[   18.258916] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
1484 00:47:33.174507  <4>[   18.259561] x8 : ffff8000842334c8 x7 : 0000000000000000 x6 : 0000000000000000
1485 00:47:33.174779  <4>[   18.260206] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000030
1486 00:47:33.175050  <4>[   18.260851] x2 : 0000000000000008 x1 : ffff8000800df110 x0 : 0000000000000001
1487 00:47:33.175318  <4>[   18.261497] Call trace:
1488 00:47:33.175584  <4>[   18.261735]  __request_module+0x198/0x200 (P)
1489 00:47:33.175851  <4>[   18.262141]  phy_request_driver_module+0x11c/0x17c
1490 00:47:33.176116  <4>[   18.262584]  phy_device_create+0x234/0x260
1491 00:47:33.176381  <4>[   18.262967]  get_phy_device+0x74/0x150
1492 00:47:33.176674  <4>[   18.263319]  mdiobus_scan+0x34/0x114
1493 00:47:33.176938  <4>[   18.263657]  __mdiobus_register+0x1e4/0x430
1494 00:47:33.177201  <4>[   18.264047]  __devm_mdiobus_register+0x70/0xe8
1495 00:47:33.177465  <4>[   18.264460]  rtl_init_one+0x95c/0x1040 [r8169]
1496 00:47:33.177730  <4>[   18.264884]  local_pci_probe+0x40/0xa8
1497 00:47:33.177993  <4>[   18.265239]  pci_device_probe+0xd0/0x21c
1498 00:47:33.178255  <4>[   18.265609]  really_probe+0xbc/0x298
1499 00:47:33.178516  <4>[   18.265948]  __driver_probe_device+0x78/0x12c
1500 00:47:33.178778  <4>[   18.266353]  driver_probe_device+0x3c/0x15c
1501 00:47:33.179040  <4>[   18.266742]  __device_attach_driver+0xb8/0x134
1502 00:47:33.179302  <4>[   18.267155]  bus_for_each_drv+0x84/0xe0
1503 00:47:33.179561  <4>[   18.267514]  __device_attach+0x9c/0x188
1504 00:47:33.179821  <4>[   18.267874]  device_initial_probe+0x50/0x54
1505 00:47:33.180082  <4>[   18.268264]  pci_bus_add_device+0x74/0x100
1506 00:47:33.180343  <4>[   18.268647]  pci_bus_add_devices+0x38/0x84
1507 00:47:33.180623  <4>[   18.269030]  pci_bus_add_devices+0x64/0x84
1508 00:47:33.180883  <4>[   18.269412]  pci_host_probe+0x90/0x108
1509 00:47:33.181145  <4>[   18.269766]  dw_pcie_host_init+0x3fc/0x5bc
1510 00:47:33.181407  <4>[   18.270148]  rockchip_pcie_probe+0x354/0x380
1511 00:47:33.181668  <4>[   18.270546]  platform_probe+0x5c/0x98
1512 00:47:33.181933  <4>[   18.270892]  really_probe+0xbc/0x298
1513 00:47:33.182197  <4>[   18.271229]  __driver_probe_device+0x78/0x12c
1514 00:47:33.182460  <4>[   18.271634]  driver_probe_device+0x3c/0x15c
1515 00:47:33.182721  <4>[   18.272025]  __device_attach_driver+0xb8/0x134
1516 00:47:33.182981  <4>[   18.272438]  bus_for_each_drv+0x84/0xe0
1517 00:47:33.183241  <4>[   18.272798]  __device_attach_async_helper+0xac/0xd0
1518 00:47:33.183502  <4>[   18.273247]  async_run_entry_fn+0x34/0xe0
1519 00:47:33.183763  <4>[   18.273622]  process_one_work+0x158/0x29c
1520 00:47:33.184023  <4>[   18.273997]  worker_thread+0x184/0x300
1521 00:47:33.184284  <4>[   18.274348]  kthread+0x11c/0x128
1522 00:47:33.184560  <4>[   18.274656]  ret_from_fork+0x10/0x20
1523 00:47:33.184823  <4>[   18.274995] ---[ end trace 0000000000000000 ]---
