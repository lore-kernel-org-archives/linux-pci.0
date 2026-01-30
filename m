Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B92E88BD;
	Fri, 30 Jan 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768742; cv=none; b=JAQ4dT63Z5uzNcRcsyl8L15x62AZdvK1WwkSWmkNyLSC+NWSwxcKCXBGstPTS70TbtosXjaNxKP+avkjf61uqt4Y7jXH9vX7CfOHXIKoF9DiP/3uJedUScJfXXQznudpMCwL3uLtog5DgWB8JgwV6cmB02TQRFQwOHBlFFoLY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768742; c=relaxed/simple;
	bh=fyIdeBQkoTfBgBc7z6HxcAJSXurpaMjD5jpuxykpbTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNeUao3xN9veQbUmMFdctvA8g99Tjxn2QFCrq4U/DYgp0rn71vch755Ku9kNwzJQCFmLfqt3ilTjaRA/Yg6j8U3FJX9ZCZJTvbCWA0NoY5N3GFs0W0UZnlpCkP0py5eD9gxParzu4eetbV0txsh80LeC1SX9pZekgEDc9yiPonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIEIFP0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIEIFP0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8D5C4CEF7;
	Fri, 30 Jan 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769768742;
	bh=fyIdeBQkoTfBgBc7z6HxcAJSXurpaMjD5jpuxykpbTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIEIFP0n4kVx8X9ZQZp5aSbmwvq0pB1tv0bXh4mz1nxhm0XCpysMsqZpqfCpNJ9eN
	 l5Yh0P47szslYh5KI7TgFUjt6JZ/PmHrltu+nwjq+kSGidkskEbtpxDTY8spztN9ym
	 dTXG+LXUrtUHOf4ZSH9JpckUS4gC/KVXsN+WEWVC1Q5eJsZ/jvrZGqMCGrCsogVxvy
	 j0nsmwjyAVzCJ8pt09vkhjXuPMb4TVbdtRHvDFGHPeBo9HXxoBXVMVDIp35zZL5ysh
	 ShtYsSD9DM89b3+cEijTD3v4v5k/9Z1Q9AxkVfOlpI+ANrZQmdbQ2A1tPahaiuYafy
	 +UXOD5gxOcCKw==
Date: Fri, 30 Jan 2026 11:25:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Grimmauld <grimmauld@grimmauld.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <aXyHITrZ89Mmn8_J@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>

Hello Grimmauld,

On Thu, Jan 29, 2026 at 03:06:59PM +0100, Grimmauld wrote:
> Hello Anand,
> 
> I have tested this patch.
> Hardware/Kernel information:
> - radxa rock 5c lite
> - rk3588s CPU, arm64
> - defconfig NixOS kernel
> - picked onto 6.18.7
> - DT: rockchip/rk3588s-rock-5c.dtb
> - tested both uboot (mainline) and edk2 (vendor)
> 
> On Fri, Aug 09, 2024 at 01:06:09PM +0530, Anand Moon wrote:
> > Rockchip DWC PCIe driver currently waits for the combo PHY link
> > (PCIe 3.0, PCIe 2.0, and SATA 3.0) to be established link training
> > during boot, it also waits for the link to be up, which could consume
> > several milliseconds during boot.
> 
> I found that without this patch, USB 3 ports as well as the PCIe connector seemingly stay uninitialized during boot on my hardware. 
> This manifests in a bootable USB flash drive loading initrd from bootloader (both uboot and edk2) perfectly, but then fails to mount the rootfs from the drive.
> In effect, boot is not just slower than it should be, it just does not boot all the way at all.
> In that scenario, the devfs entries corresponding to the flash drive are simply missing, same for the sysfs where i would expect the USB device listed.
> Replugging the USB flash drive during initrd does seem to fix that, but is tedious and not viable for a server.
> Similarly, booting from m.2 SSD attached via PCIe fails the same way, with rootfs timing out despite the bootloader correctly reading initrd on the same drive.
> Fwiw, replugging the SSD does not work like it does for USB flash drives, and is even worse of an idea.
> USB 2 ports as well as SD card boots correctly, even without your patch.
> Without your patch, i am seeing "deferred probe pending" in dmesg before boot gets stuck, which was the hint which made me find your patch.
> I am not sure whether that is the actual cause or just a symptom for why drives are not recognized during boot, and am not quite sure how to debug this further.
> 
> > To optimize boot time, this commit allows asynchronous probing.
> > This change enables the PCIe link establishment to occur in the
> > background while other devices are being probed.
> 
> With this patch, booting from SSD or USB 3 port works flawlessly, and i have not seen any regressions with SD card or USB 2 boot, nor any other hardware component.
> This setup has worked for multiple boots without fail, both with traditional ext4 and zfs rootfs being loaded from USB 3 and PCIe.
> Because i require this patch to run my rock 5c from SSD, i am currently running a custom patched kernel, but would highly appreciate this patch making its way to mainline eventually.
> There might well be something else going on here. The proposed patch may not be the "proper" fix to the issues i am seeing, but it does at least work.
> 
> I have NOT tested boot from eMMC (either with or without this patch), though i have no reason to believe it would be impacted.
> 
> I am happy to provide more info as needed. First time posting to the LKML, i hope i am doing this right...
> 
> Tested-by: Grimmauld <grimmauld@grimmauld.de>

I tested this patch again on the latest kernel, and it still results in
the "requesting loading a module with wait allowed while being called from
async context can result in a deadlock" warning from the modules code.
(With the calling code being phylib.)
See the phylib splat that I previously reported in this thread.

Note that I've built the network PHY driver that phylib wants to load
(CONFIG_REALTEK_PHY=y) as built-in. As long as the PHY driver is built
as built-in, I don't think that the problem the modules code is warning
about can happen. (But I also don't understand why it is trying to load
a module when the driver is built as built-in in the first place...)

Anyway, my networking is working perfectly fine even with the splat.


Having async probing for the Rockchip PCIe controller driver, which is
used a LOT of rockchip based SoCs, is a good thing, so I don't think it
is right to avoid enabling async probing just because it results in a
splat on a single rockchip based board (rock5b).


Kind regards,
Niklas
