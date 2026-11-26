Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682389;
	b=ZvQv1D2Gr38gFrRH2Kb5dFCBsjrgWhruwS0nhI5c69LQQCg85bG320k6AtnGP6biIer7
	 bLI5JULpEUHDNFjIbOLk4e7UD+cD3vTv+pthqfwhPGMfj8YEt6dsadF49FjjsMgmkRjlS
	 HEo+LwnY3uEhdZ3kvn/TtHiUo/tyKVUZUBeUbG6kVjEFPhQ1hFbxjUuuKZ5Twcof5T0r7
	 ZXrKbCECGHsxfEIMKES/xR/xu8Ne9hjyd/TETEuC3D2iTPCZ0XQclhcjyfmu9UJJ5ENcS
	 oQM0+rAnjQ5DzafQbspVW/3kOGHoGhKB4EKOaXB3PtytjaC2gk1nISjqUWKuNSBee7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682389;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vixE8kSfmBY9XhK0Nz/XsFK0GfPBylCEEwcpcXeG1LY=;
	b=QMHQdFD2b7tIpXfXV4tTb73jkEvoWO8UN6MpdG5wWCMPFWqDs0IrAKsuCXI36Ae85alQ
	 ffTqQTj37tre2jGO8dnIOkAaC40R/+CDEk+d2aQTXl8qPtb95uczNeMUhAxzGU0CP/Cqn
	 k5ASa3mvsFKfQZZVWmmhDuZFW9zdmkqDeO7O6hguuMfVyAyVgHkIWmukXtxviRaEU8wfe
	 avSlqi9ZHqCRrDUD9guDV5/PJFRX6YH82hgTeVlavGoATLGzzUk+TFVEX6hZEKoZwq1wF
	 497J0mJhGrbDmu4WKhqf1+chhAXuuGuCRpXiShaKPVxYoi0Py6hHtioTBl2Zew2o0JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMUUCm2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29313606A31E;
	Thu, 26 Nov 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMUUCm2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4021F000CA;
	Thu, 26 Nov 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795682388;
	bh=vixE8kSfmBY9XhK0Nz/XsFK0GfPBylCEEwcpcXeG1LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMUUCm2vreLcwoDG/2l/R3mIgVFi7Qmce9g5zqcmiLziAHTB4mafF0MdjbP2HD5Ag
	 HZ+ApKQwZRJNhVvhDWAGS4bZnudK0KTKWspyDNLAdOfH9Mh/gxy81wzPT+3yIlnm8H
	 OzlztMTwJtisKLr75H0qRYMpEhbFFWctET2CLl8RRSaYihLAs6+DGKPc1zrh2moIV2
	 J6/YRDSzD/sFlNPgBeKgIZ+4dhOO8mZyKQNXAZXq0HGOXXm/UDjVkjFntoDgH7SlyM
	 Ky3fMEb/JhdeTw8zAJwfFpkef8Pq6qW+xFAO3zdMUe673x5E1SkZkJ49ElxbR9rgbI
	 9Wv6dqcJJ63DQ==
Date: Thu, 26 Nov 2026 09:39:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awfwUC5vomjlih2U@ryzen>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
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
In-Reply-To: <20261125155829.77269-1-feng.tang@linux.alibaba.com>

On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> During stability test, there was a bug that running 'mount' on a type
> of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> cmdline parameter.
> 
> The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> its corresponding root port is capable of 512 bytes. When enabling
> PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> both set to 256, while the root port's are both set to 512. But the
> NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:

I assume that you are using pcie_bus_perf rather than the default strategy,
because with the default strategy never raises the Root Port above what
firmware programmed, which may be only 128 bytes.

pcie_bus_perf gives a Root Port its own maximum MPS without looking at
the devices below it, and relies on MRRS to keep Completions within the
endpoint's MPS, so a device that ignores its MRRS gets Completions
larger than its MPS.

My series [1] avoids this without pcie_bus_perf: with the default strategy,
it sets each Root Port hierarchy to the largest MPS that all of its devices
support, i.e. 256 bytes for both your Root Port and the NVMe. Since a
Function must not generate TLPs larger than its own Max_Payload_Size, the
Root Port then returns Completions of at most 256 bytes, even for the
512-byte reads your NVMe issues. The NVMe also gets the same 256-byte
payloads as with pcie_bus_perf, so nothing is lost by dropping it: the Root
Port's 512 bytes don't help a link whose only device supports 256.

Would you be able to test the series on that server, without
pci=pcie_bus_perf?

[1] https://lore.kernel.org/linux-pci/20261020122854.1500883-5-cassel@kernel.org/

Kind regards,
Niklas
