Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091A37CD59;
	Tue,  3 Mar 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556132; cv=none; b=ooKfF9yFXJAGH575pfRmyUTsQy92tW6bc0E4bjkLmRdIeX85V8KXJF41io5bbKSfIbxvLPPq8P441d+xeegfWBCGeabjb3tnJTQMN/0fhltbaM1oblAv3YrFLc9CRRohQo63bECCR5PNaOrvEF4zCr36AwKZ9ZBdN0mScYMf8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556132; c=relaxed/simple;
	bh=W+8PidUEXESOH6dzGHWWec1+CrSIW7MIlvEsDcbatgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfPpyBjqgOAINvpkZVviDOaEgumXztydTnR3WAEe1PKMbniGIZhycRnU1ABEMzbjV6c0V08BF2n3YSq2YBwXD0eBnmsw+mb2M++TgwvOyuCIoP1XBvTysFA5ADQ0I2vvVCITA/YXEOjn34eLSajzxNq6vBGjKMzpnkXOVuZMeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrkcEQLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrkcEQLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F3C116C6;
	Tue,  3 Mar 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556132;
	bh=W+8PidUEXESOH6dzGHWWec1+CrSIW7MIlvEsDcbatgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrkcEQLwzTitTADAopFpz6Wg4ixT5ZNhAmOqz9s4pQvNaecsvaCaMkcquPDXJjCnh
	 uqjh8WWagZn6AaANcJi9qHeIAaWOR3H4SECpEotYfJiF+IOPQaq9LKUWZC1y4VEgIP
	 2KpGAC38/794p0Fp6JiTspiJRcmyKzrZcCtsmEessVrtjBqAo8x6ZCrkm8y6KsJXne
	 1bdP2URXGCQJVVtaN52lEKCslPaZH5pHuv04nQf6uUizy5V4pdp2YKna6e5kRzp7DS
	 Vcb6Pvx537FPyzBP8NS53GphF0QeG1A8+WdFWMLMXO9yyLy5tI2bINBx75rVpCtJ4U
	 c6JvIXGRw80tA==
Date: Tue, 3 Mar 2026 22:12:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev
Subject: Re: i.MX8M Plus PCIe link regression
Message-ID: <ac24flkmrooacnpt53swuurkbxvorbjx2yb4s3zdevqua6ddls@wjc3bcsl7zif>
References: <23024521.EfDdHjke4D@steina-w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23024521.EfDdHjke4D@steina-w>

On Tue, Mar 03, 2026 at 01:38:13PM +0100, Alexander Stein wrote:
> Hi,
> 
> these days I noticed that there is a PCIe link regression on my i.MX8MP
> platform (TQMa8MPxL) running next-20260227.
> I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip link up 
> workaround for newer platforms"). I always get the following errors:
> 
> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2 device is
> detected without issues.
> 
> Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
> b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both Gen 1 and
> Gen 2 devices are detect. Commit 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc is only
> required for conflict free revert.
> 
> Here is a summary with outputs:
> Gen 1 device
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 01)
> 
> Gen 2 device
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6
> > Gb/s RAID controller (rev 20)
> 
> output of "dmesg | grep imx6q-pcie". Common part for all tests:
> > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > 0x0000000000
> > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > 0x0018000000
> > imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 == cpu 0x1ff00000
> > imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
> 
> next-20260227
> Gen 1
> > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> > imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> Gen 2
> > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> 
> next-20260227 + reverts
> Gen 1
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> 
> Gen 2
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> 
> What can we do here? I'm wondering why Gen 2 trains correctly, while Gen 1
> doesn't.
> 

Thanks for the report and sorry for the breakage. Commit 9c03e30e3ade3, mentions
that the workaround is only needed for the i.MX6 platforms. So I'm not sure why
the patch breaks i.MX8M and that too only for Gen 1 speed.

Also, before 9c03e30e3ade3, LTSSM was always started in Gen 1, but as per your
finding, only Gen 1 devices fail to work. So the code till
imx_pcie_wait_for_speed_change() shouldn't have an impact. Maybe the issue is
due to skipping imx_pcie_wait_for_speed_change()?

Richard, thoughts?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
