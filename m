Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.163.59.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357218;
	b=J7VnpmNNo8heQj3eKHu35XTNPQaICnMtXgpva1biPomtJX3pP11DmKufYRhkRflwJJTn
	 3pOZb9MMp0HndsWB9FWG5mayOtFS8s9DDM4P+uABqJGl2ERdZaGZIHNanTNCjkg9oSTau
	 YGuLYlDFY0iVLr897nFM/Scv7RYrKjFq+q+4qBsgbMh8/MzsT9BWdrQsP7bJjz+7elwcr
	 0z6LJkLTh23HRJXyDh6QybBGnBcrBo+SfIdm4zrmOxaxO2fwq/M1Fh/K5W+wYrnuXg6yj
	 DP30ro9pt35TR4/79DHeevAMs//tbJ4DskJwXqkDi6QwE1cJdMOnpmcQahD693ChRDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357218;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-C1DE0DAB:X-C8649E89:X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=aqncHlMLeBK9aRPR8mBo2bszB3jWM7nDG44QaoD1NsM=;
	b=XTbaPxZbinGTLkb0VZBEABMeH9TbdLH2+9gnOzY2T2LmMmbo8CbexD6Kwh5unWD9mrY4
	 3gDa6/5nigOxv5aUDIUSurqzLe6LF7sxrnPRyBosHFiuyNc8Z/zVEuVPIpFZYWmDd1djk
	 VhDYNd7Aoks+LVkjjfegnSB7j5WtbA/dryJgBem86x47cXW6rrjdtOh2g6CV+jIOD7vul
	 TR6H8RNmq+MzrQMovbkMkFsfs2uav6wxd5fAIKdx411wA0oVjzzLffyH8ecmbGY5na6hY
	 D6QHe3X/HxV6+cfHqIB09GL4dpeY1WhF5YYNvbxoAjQx5mfnvV6tOBPHRkP10AS3+Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=How0T8Ql;
	arc=none smtp.remote-ip=95.163.59.82
Received: from send243.i.mail.ru (send243.i.mail.ru [95.163.59.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF861606A31C;
	Wed, 11 Nov 2026 00:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF861606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=How0T8Ql
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=aqncHlMLeBK9aRPR8mBo2bszB3jWM7nDG44QaoD1NsM=; t=1794357216; x=1794447216; 
	b=How0T8QlzQAuYWk0g5LmUeMW7L9xgf1SowdMYqWKIuR/OnNR0YcPCb9RDBru5B2yB/txquabge+
	R3v034H453BO57D449L9r6Hdrin+4wzbLgc8t004/ALjQ+hT3MneZmAMLJpyTsY1PTDP+T49jsx+A
	AyZ/2i0A7Rv1Gg5IZqrOK+6ZJuZJN+7kzH2AMHdW1epNJhglSQQc9ThvbrWEVkFjddDy74dpcFwrS
	weZIoVb1T0p8sSZnwRkWL4zjDcWeVcGOY7dK9shLxBhUBWY6cYQXpbDjcKPe75HVxGgSonlIUfsrU
	x+mcg400JKU0Me5789Zawx3NPVvGSgvEoUrA==;
Received: by exim-smtp-5cc8b577fd-hcqcf with esmtpa (envelope-from <gvozd188@mail.ru>)
	id 1xQwHI-00000000Hj3-0TKU; Wed, 11 Nov 2026 03:33:28 +0300
From: Vladimir Nedoshivin <gvozd188@mail.ru>
To: szymon.durawa@linux.intel.com
Cc: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Nedoshivin <gvozd188@mail.ru>
Subject: Re: [PATCH v10 0/7] VMD add second root bus support
Date: Wed, 11 Nov 2026 04:32:49 +0400
Message-ID: <20261111003249.10880-1-gvozd188@mail.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-5cc8b577fd-hcqcf; auth=pass smtp.auth=gvozd188@mail.ru smtp.mailfrom=gvozd188@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD960A32E02787845123C321558CF4C036251223D188490A1AB182A05F53808504033DB28EF86568F8E3DE06ABAFEAF6705A3D293A29633E220861817D778526D998ACF784BD97B3DAF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE792C68BF9CD4C0E9EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669BFFA6ABF9D5DBB931815D8B9B40E3675776F37D5D114482C0BFD38D9EF459EA8EEF46B7454FC60B9742502CCDD46D0DD2DCF9CF1F528DBCF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0B27420F9988F54058941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B630908C26FC17074C76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CE1AEB6AF2DA18B6243847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A596672647538B6FEE5002B1117B3ED696E95D453CD075B09992212597CCBD6D77823CB91A9FED034534781492E4B8EEAD1A3F3A3731258CC5BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659290526FDBC30468A2B0214D9C5E5D32DC749A5A8261127A618C1805660F274C77AA40E424DA1315BB8341EE9D5BE9A0A9C28CB25B55143ADD9893E7B6C8DC0539C696F041636E13252EE4E5D9E54FDA4A7285BF96B6084FCFBA54DA8216DA934F6C4A2408CBCF31D24A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWOZpY/ZR+DFRAP+qXqN/L60=
X-Mailru-Sender: A47ED0EA96B79D3129134CB94CD97376CB0DAB1D9284FA65B951B70A5BD4BD8E3AE51C5AC609F25A3796AF590E5454F153148BAE84F7D0213DDE9B364B0DF2894C9083906008D79F5EA11F3C5F3A97E80D4ABDE8C577C2ED
X-Mras: Ok

Hello Szymon, Bjorn, and PCI maintainers,

I have successfully tested the complete VMD Second Root Bus v10
patch series on my MSI Vector 17 HX AI laptop with Intel Arrow Lake
and VMD controller 8086:ad0b.

I would also like to provide some background on the original problems,
the previously developed workaround, and the relationship between this
series and the ARL004 interrupt-ordering fix.

The original investigation is documented here:

https://bugs.launchpad.net/bugs/2166325

Hardware:
- Laptop: MSI Vector 17 HX AI A2XWIG
- CPU: Intel Core Ultra 9 275HX
- VMD controller: Intel 8086:ad0b
- VMD PCI address: 0000:00:0e.0
- NVMe: Phison 1TB ESR01TBYCCA4-EDJ-2MS
- Operating system: Ubuntu 26.04
- Secure Boot: enabled

1. Original problem: NVMe device not detected

With the stock Ubuntu 7.0.0-30/31 VMD driver, the internal NVMe SSD
was not detected.

The kernel reported:

  vmd 0000:00:0e.0: Unknown Bus Offset Setting (3)

As a result, the NVMe device behind Intel VMD was not enumerated.

The laptop firmware does not provide a usable option to disable
Intel VMD/RST.

I initially integrated an earlier revision of your Second Root Bus
patch series into the Ubuntu VMD driver.

This successfully restored NVMe enumeration, but exposed a second
hardware-related problem.

2. Second problem: ARL004 interrupt-ordering erratum

After restoring NVMe enumeration, storage operations experienced
repeated stalls of approximately 30 seconds.

The kernel reported:

  nvme nvme0: I/O tag ... timeout, completion polled

A diagnostic sequential read of 1 GiB required approximately
121.339 seconds, corresponding to about 8.8 MB/s.

The investigation identified the Intel Arrow Lake ARL004 erratum:

  MSI from VMD-Owned Device May Pass Memory Write

An MSI may reach the processor before preceding posted writes from
a VMD-owned device become visible in memory.

This can cause the NVMe interrupt handler to observe stale
completion-queue data.

An experimental workaround was implemented by performing a PCI
configuration-space read from the MSI-initiating device before
dispatching the corresponding interrupt.

With this workaround, the same diagnostic read completed in
approximately 0.882 seconds.

A subsequent 10 GiB read also completed normally, without the
previously observed NVMe completion timeouts.

3. Upstream ARL004 fix

Following the initial investigation, I submitted an upstream patch
enabling the existing VMD interrupt-ordering quirk for Intel
Arrow Lake VMD device 0xad0b.

The patch was accepted by Bjorn Helgaas under the title:

  PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake

Upstream commit:

  2c88c2dc1852

The accepted implementation uses the existing
VMD_FEAT_INTERRUPT_QUIRK mechanism.

This is separate from the Second Root Bus feature.

The original Ubuntu investigation and test results are available
in Launchpad bug #2166325.

4. Testing the Second Root Bus v10 series

I have now tested all seven patches from your v10 series,
based on Linux 7.4-rc1.

To preserve my working Ubuntu installation, I compiled the patched
vmd.c as an external module against the Ubuntu 7.0.0-43-generic
kernel headers.

The only source compatibility adjustment was replacing
PCI_DEVICE_ID_INTEL_VMD_28C1 with its numeric value, 0x28c1,
because the identifier was unavailable in the Ubuntu headers.

The resulting module was signed using an enrolled MOK and loaded
through a separate test initramfs.

The test therefore used:
- Ubuntu kernel 7.0.0-43-generic
- VMD source from Linux 7.4-rc1
- All seven Second Root Bus v10 patches
- The upstream ARL004 interrupt-ordering quirk already present
  in the 7.4-rc1 base

No additional local ARL004 workaround was applied to the v10 source.

The loaded module was verified using srcversion:

  45EF68AF5A6E01AAA2882CF

5. Test results

The system booted successfully.

Both VMD PCI domains were created:

  vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  vmd 0000:00:0e.0: PCI host bridge to bus 10001:e1
  vmd 0000:00:0e.0: Bound to PCI domains 10000 and 10001

The NVMe controller was successfully detected behind BUS1:

  nvme nvme0: pci function 10001:f1:00.0

The NVMe controller initialized successfully, and the Ubuntu
root filesystem mounted normally.

Sequential read performance:

  Command:
  dd if=/dev/nvme0n1 of=/dev/null bs=4M count=1024 iflag=direct

  Data read: 4 GiB
  Duration: 4.16695 seconds
  Throughput: approximately 983 MiB/s

This is comparable to the approximately 984 MiB/s previously
observed with my working ARL004-specific driver.

Hardware MSI-X interrupts were active.

During a separate 1 GiB direct-read test, the aggregate VMD
interrupt count increased:

  Before: 134377
  After:  138680
  Difference: +4303

One observation worth mentioning:

The virtual NVMe interrupt counters (nvme0q*) remained at zero
in /proc/interrupts, while the underlying physical VMD MSI-X
counters were active.

Despite this, NVMe I/O completed successfully, and no VMD/NVMe
errors or timeouts were found in the checked kernel logs.

6. Test limitations

This was a test of the v10 VMD source built as an external module
against Ubuntu 7.0.0-43, not a boot test of the complete
Linux 7.4-rc1 kernel.

The completed testing covered boot, device enumeration,
read-only NVMe I/O, and interrupt activity.

Dedicated write stress testing, suspend/resume, and long-term
stability testing have not yet been performed.

7. Conclusion

The Second Root Bus v10 series successfully resolves the NVMe
enumeration problem on this Intel Arrow Lake VMD 8086:ad0b platform.

Combined with the previously accepted upstream ARL004
interrupt-ordering fix, the system boots successfully, detects
the NVMe controller behind BUS1, and achieves normal sequential
read performance.

No functional regressions were observed during the completed tests.

Thank you for your continued work on Second Root Bus support.

Tested-by: Vladimir Nedoshivin <gvozd188@mail.ru>

Best regards,
Vladimir Nedoshivin
