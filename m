Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075B28690;
	Wed,  4 Mar 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605979; cv=none; b=ksZo7WPg+PaE5xokW4FMa6NbTMnef8lFrdh+86OJDRfZYozqAW5hDigyc6Crklqk6pwtdz2+loFNb12Z84Z4U7U+601ck6VwvjaCaOS3msuRfNoeir7PxT5E9CA3wPCiFlCQoao2+FuP1LfUtFI5vMasHjz0ez73J3k078TPdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605979; c=relaxed/simple;
	bh=KLX+r/cNJoWvojZCxYtKCgW5FIWCy3S0O4lMxQZnvbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW+gg0yCokER2KCOLAo7nzqj6MZqU5JpcRZHIVtY50KEK+7pFKHdAdNknCVtzgD7P2ReoH5Bxm9vPeKTZNkU/RHQoR1ggiwIX9MEXpQdB0a06uaCATosGVBTxNMIZ92YkX1EhIRPDGO//IwPtWZ6VTKerjucSHoarg4VK/Q79Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYi/RgHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYi/RgHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C3AC19423;
	Wed,  4 Mar 2026 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772605979;
	bh=KLX+r/cNJoWvojZCxYtKCgW5FIWCy3S0O4lMxQZnvbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYi/RgHc/O9GuaYVlzO1gnR6pZKx0lkv+TjVM4lUDJqV977f7X2JTyAP1pDVDDPf3
	 f1frd7YUMnSfCSR5AFvoA2ZNpZpDNkL8BugfgxktUoEHMswgkIueG8fYCGUTVEDopW
	 4QO9lGcOS1G3SKsfgrEfI0Lv+6XdSfQjN8D6X7emLQzL2fyG394bj0iLQywVgxMjMZ
	 h5uZFBu6MJL6YFZeh5RdYlqTz7qGNzvGGg54+KHpW4bgq9Ijf4PaPgqx3/qlQnLeY7
	 MANj0hBh9vU2Da5exkV6COy6kMRcWXf1MewqsfdtIRaZL4BFKFnGMiWwmSaAQYlxlx
	 OkDEhwoFhW/Xg==
Date: Wed, 4 Mar 2026 12:02:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: i.MX8M Plus PCIe link regression
Message-ID: <2qto2ddqmtks37wxtklxo4ctvxyezmgtjcuprnk6crant5fvsu@vdbmqomrcqt3>
References: <23024521.EfDdHjke4D@steina-w>
 <ac24flkmrooacnpt53swuurkbxvorbjx2yb4s3zdevqua6ddls@wjc3bcsl7zif>
 <AS8PR04MB88332979F06EDE29E751BCE18C7CA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88332979F06EDE29E751BCE18C7CA@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Wed, Mar 04, 2026 at 02:55:51AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: 2026年3月4日 0:42
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Alexander Stein
> > <alexander.stein@ew.tq-group.com>
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev
> > Subject: Re: i.MX8M Plus PCIe link regression
> > 
> > On Tue, Mar 03, 2026 at 01:38:13PM +0100, Alexander Stein wrote:
> > > Hi,
> > >
> > > these days I noticed that there is a PCIe link regression on my
> > > i.MX8MP platform (TQMa8MPxL) running next-20260227.
> > > I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip link
> > > up workaround for newer platforms"). I always get the following errors:
> > >
> > > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
> > > CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
> > > imx6q-pcie failed with error -110
> > >
> > > Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2
> > > device is detected without issues.
> > >
> > > Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
> > > b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both
> > Gen
> > > 1 and Gen 2 devices are detect. Commit
> > > 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc is only required for conflict
> > free revert.
> > >
> > > Here is a summary with outputs:
> > > Gen 1 device
> > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev
> > > > 01)
> > >
> > > Gen 2 device
> > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe
> > > > SATA 6 Gb/s RAID controller (rev 20)
> > >
> > > output of "dmesg | grep imx6q-pcie". Common part for all tests:
> > > > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > > > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > > > 0x0000000000
> > > > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > > > 0x0018000000
> > > > imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 == cpu 0x1ff00000
> > > > imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K,
> > > > limit 16G
> > >
> > > next-20260227
> > > Gen 1
> > > > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
> > > > CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
> > > > imx6q-pcie failed with error -110
> > >
> > > Gen 2
> > > > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie
> > > > 33800000.pcie: PCI host bridge to bus 0000:00
> > >
> > > next-20260227 + reverts
> > > Gen 1
> > > > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
> > > > 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie 33800000.pcie: PCI
> > > > host bridge to bus 0000:00
> > >
> > > Gen 2
> > > > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
> > > > 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie 33800000.pcie: PCI
> > > > host bridge to bus 0000:00
> > >
> > > What can we do here? I'm wondering why Gen 2 trains correctly, while
> > > Gen 1 doesn't.
> > >
> > 
> > Thanks for the report and sorry for the breakage. Commit 9c03e30e3ade3,
> > mentions that the workaround is only needed for the i.MX6 platforms. So
> > I'm not sure why the patch breaks i.MX8M and that too only for Gen 1
> > speed.
> > 
> > Also, before 9c03e30e3ade3, LTSSM was always started in Gen 1, but as per
> > your finding, only Gen 1 devices fail to work. So the code till
> > imx_pcie_wait_for_speed_change() shouldn't have an impact. Maybe the
> > issue is due to skipping imx_pcie_wait_for_speed_change()?
> > 
> > Richard, thoughts?
> Hi Maini:
> Prior to calling imx_pcie_wait_for_speed_change(), the PCIe link must
>  already be established. Before commit 9c03e30e3ade3, the speed change
>  procedure was only initiated after the initial Gen1 link was successfully
>  brought up.
> 
> Hi Alexander:
> Sorry for the breakage.
> Before commit 9c03e30e3ade3, i.MX8MP PCIe forced Gen1 link training
>  initially, then switched to Gen3 after link-up by triggering a speed
>  change. After commit 9c03e30e3ade3, link training starts directly at
>  the Gen3 capability level.
> 
> The two link training methods differ only in the i.MX8MP Root Complex (RC)
>  link capability configuration prior to link training: one method forces
>  Gen1 speed, while the other retains the default Gen3 setting in your tests.
> 

I still don't understand why the link fails to train at Gen 1.

- Mani

> Fortunately, I also have a RTL8168E Gigabit network card on hand.
> Based on v7.0-rc1, here is the tests log on my i.MX8MP EVK board and one M.2
> Key E to PCIe standard slot exchange adaptor.
> 
> Logs:
> root@imx8mpevk:~# dmesg | grep pci
> [    2.172420] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> [    2.172516] imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
> [    2.172545] imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
> [    2.172631] imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 == cpu 0x1ff00000
> [    2.380065] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
> [    2.579604] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [    2.580020] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> <snipped>
> [    2.583653] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoint
> [    2.583858] pci 0000:01:00.0: BAR 0 [io  0x0000-0x00ff]
> [    2.583885] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
> [    2.583902] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit pref]
> [    2.583914] pci 0000:01:00.0: ROM [mem 0x00000000-0x0001ffff pref]
> [    2.584280] pci 0000:01:00.0: supports D1 D2
> [    2.584320] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    2.595615] pci 0000:01:00.0: ASPM: default states L0s L1
> root@imx8mpevk:~#
> root@imx8mpevk:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> 
> Best Regards
> Richard
> > 
> > - Mani
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
