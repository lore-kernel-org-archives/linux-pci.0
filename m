Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694213;
	b=F98zzcUHs6yiZIopICMbmMuCyd9rhNRWNns8kN8f8Q0FFnb4wapxlX+35/RCbwpdVz92
	 7ATOQ1dSJ7s8xKEGuTCKPNxG7v8KlVMXV5M9Bsh/Ehcy43WD9VT/CvJmQwjm/kE5jgaVR
	 YiHzHjrE9Kp9K4MsPyu7hDJPvsVcZYIVKFt1kh0SXrjYlZxz5OdU1BZM1iWnesQ9tytwT
	 Sq5rRM2yqFWYDMi3bDy89E8LHCPlU7QKUSTAQVZ8Du94p9kVJKzuduvcaWJdxYtC5nBqD
	 PwhvSk5k2chti8CJUZTNYpzEG5embBg9xkyl/lJDU4ZMc/2jrmWJpt8+7bEXnXlsOUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694213;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rnp9x/iKkvmTWJnyUgHpkKblZzqwUu/F3hmLLdm2yXY=;
	b=r9WiTIQoy3hZEZt6Cbp8qfii83GqHsnTpU8Twn/1NaO3dcYtrRBA51wfrxuQ9YNIYSSZ
	 kB24LiT1UrmhBI5+ztd60NktxHOkzjSP8yJ0Naw64XoCA5KN4FtS58epz+xN707tl1hj7
	 q/r2q3GM+SHcDTgOtvRWVg7MuX25LImmCnsTLSgz8HgzZ4C3HCJGHm7EDKlyP9xhUaQEV
	 /UI9aEuWitY2JIV+noi2skKMurdJp+ctNEJDFU/Xq9viIo83XDdNEauaqTykXKdltr4+S
	 Nr5fSdwrWALfaskYpAz8PHjq3GHo/1PGmOE9OHWpiAX2otTKl+GOwRbvcLJyJBXWcyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyX3pu+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57A606A31C;
	Thu, 26 Nov 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyX3pu+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFB81F000CA;
	Thu, 26 Nov 2026 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694212;
	bh=rnp9x/iKkvmTWJnyUgHpkKblZzqwUu/F3hmLLdm2yXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyX3pu+GMCg4pbhj5F51z6yg9ypFJEnWkcr3awheE/X4O2UNxy+6sYXXIdjJYt8oe
	 hdBecQzxO5wVTBvHQQzkA2Ft/xJJcaBEILLgOTUh47Wth7x9G+jCsI5lhov8Z+t3ck
	 2jh5n96hhStH9ALN4paMyJ9tta84nAX7GPI4BJR0rBQOZdvr4L63Sc9KP/IKOldvYu
	 6S9rzXJCu7ShI5sNEmxOW29f6ys6zXQlLGsnrUmjTg7z0y65SOKLqPYuIWXbkyMvVp
	 R1UDulbX2YIWQSXTDpnRqQMdh4nVttO5IBsoKvjc5ZTYGwrRqVjhqOi9Lgn6coEAip
	 sJXK1BKrg1e4g==
Date: Thu, 26 Nov 2026 12:56:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awgegQfp969zHL2m@ryzen>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfwUC5vomjlih2U@ryzen>
 <awgR92kRQdrjUdBC@U-2FWC9VHC-2323.local>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awgR92kRQdrjUdBC@U-2FWC9VHC-2323.local>

On Thu, Nov 26, 2026 at 07:03:19PM +0800, Feng Tang wrote:
> Hi Niklas,
> 
> On Thu, Nov 26, 2026 at 09:39:44AM +0100, Niklas Cassel wrote:
> > On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> > > During stability test, there was a bug that running 'mount' on a type
> > > of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> > > error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> > > cmdline parameter.
> > > 
> > > The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> > > its corresponding root port is capable of 512 bytes. When enabling
> > > PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> > > both set to 256, while the root port's are both set to 512. But the
> > > NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
> > 
> > I assume that you are using pcie_bus_perf rather than the default strategy,
> > because with the default strategy never raises the Root Port above what
> > firmware programmed, which may be only 128 bytes.
> 
> Right, only the 'pcie_bus_perf' mode can reproducde this issue. The
> default mode works just fine.
> 
> We reproucded it on one arm64 server and one Intel server, the MPS for
> the NVME device and root port are both set to 256 bytes in default mode
> (no pcie_bus_perf parameter).
> 
> > pcie_bus_perf gives a Root Port its own maximum MPS without looking at
> > the devices below it, and relies on MRRS to keep Completions within the
> > endpoint's MPS, so a device that ignores its MRRS gets Completions
> > larger than its MPS.
> > 
> > My series [1] avoids this without pcie_bus_perf: with the default strategy,
> > it sets each Root Port hierarchy to the largest MPS that all of its devices
> > support, i.e. 256 bytes for both your Root Port and the NVMe. Since a
> > Function must not generate TLPs larger than its own Max_Payload_Size, the
> > Root Port then returns Completions of at most 256 bytes, even for the
> > 512-byte reads your NVMe issues. The NVMe also gets the same 256-byte
> > payloads as with pcie_bus_perf, so nothing is lost by dropping it: the Root
> > Port's 512 bytes don't help a link whose only device supports 256.
> > 
> > Would you be able to test the series on that server, without
> > pci=pcie_bus_perf?
> 
> I can give it a try after the quirk work suggested by Christoph Hellwig.
> 
> I haven't read through you patch, one question is, since current kernel
> already works fine without 'pci=pcie_bus_perf', what' the intention of
> this test? 

For this NVMe drive, it won't change anything.

My series matters where the default strategy currently leaves the MPS
lower than what a device and its Root Port support, because it never
raises a Root Port above what firmware programmed. Which is normally
the reason why people use pcie_bus_perf. But unlink my series,
pcie_bus_perf does not reduce the Root Port's MPS to that of the max
supported by the endpoint, after the the MPS has been raised above
what the firmware programmed.

But if you get 256 bytes with the default strategy, which is the limit
of your NVMe device, why are you using pcie_bus_perf?

Perhaps you are using pcie_bus_perf to get a larger MPS for other devices
(other than the NVMe) on these servers. If that is the case, using my
series would allow you to still change to the default policy, and still
get the benefit of pcie_bus_perf (without the downsides of pcie_bus_perf).


Kind regards,
Niklas
