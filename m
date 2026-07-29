Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AD43B3C5
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314641; cv=none; b=VIdRLKud+nQ/+3q+hQgrVUcatYuZJ9/G1KztZcV6TZFFIKRXPZlq+hzat8/hnDkMhTUnqW/zAWWsh629uxzxv26IB9iKkEUuAPkWcMcQh/mh4SE0nfhd9ghuc8P7nGgY9rBjUDt0xNTvjJnjgSWWRmB7dKiQr15OeRb7fY09FSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314641; c=relaxed/simple;
	bh=XXFud7v8AXULerWpVGaAdB1EdJtvHoXt/WeNoTBHa/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/zbz1YOGwGPF3+vJKfqvf6BdFyJKIJ5OHsjqdl9tnOIsmQ6wNkPgAivs9XsoVzdS4lIrtU2CDaDSJ1RMoa9j6oliCBRTLnfOAK80yiFiM86Akys9frn2FLA6xsiKEiFC9mYAFPaeJmDyW1B/EkAsjxQa2bz/xR8gt+zyZKXsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=berXSRlL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="berXSRlL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785314627; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MYN3S1/3DyN+1xX1yAYta2LY58ThMmvp0iQe2ml4kZ4=;
	b=berXSRlLTy8z/NhQdJNhR2qaHl76GpzEJ+AkteVIlcoqhX72H/8mXgV8jbXufthB7/wtroKB6bRtgUhkyThIiuQ+/kcWSyZvfHw3giMuKL7Ne3Bn0uconn3rkFT90rVUENY+WuqVb/95GbKjNcsjmDToobFudn8F8s3dRu0TwjA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X81cSgc_1785313688;
Received: from 30.178.84.37(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X81cSgc_1785313688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 16:28:09 +0800
Message-ID: <d8280f27-782d-4d82-b38d-7b48af4912d3@linux.alibaba.com>
Date: Wed, 29 Jul 2026 16:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] PCI: Add pci=nobwctrl to disable the PCIe
 bandwidth controller
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-pci@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
 <ammlZzv7QSxLm9LC@wunner.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ammlZzv7QSxLm9LC@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/7/29 15:01, Lukas Wunner 写道:
> On Wed, Jul 29, 2026 at 11:45:03AM +0800, Guixin Liu wrote:
>> Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
>> Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
>> (LABIE) bits.  On some (typically old) platforms this has been observed to
>> cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
>> on Intel P45 using a quirk") works around one such platform with a
>> per-device quirk.
>>
>> A per-device quirk only helps once the offending device is identified and
>> a quirk has shipped, which is awkward for a boot hang since the machine
>> cannot be booted to report the culprit.  The only existing escape hatch,
>> pcie_ports=compat, is a blunt instrument that also disables AER, PME,
>> hotplug and DPC.
> Ideally we want to identify all devices that have problems if the
> bandwidth controller is enabled and add quirks for every one of them.
>
> In a sense, a command line option disincentivizes reporting and
> fixing affected devices because users can just work around the problem.
>
> Additionally, there is a general dislike in the community for
> adding new command line options.
>
> Are you seeing issues on different devices than the one that's
> already been quirked?  If so, a patch to add quirks for them
> would be welcome.
>
> Thanks,
>
> Lukas
Thanks Lukas, that's fair - I fully agree that per-device quirks are
the right long-term fix, and I'll gladly send quirks for any device I
can reproduce this on.

I'd argue this option isn't really an alternative to quirks, though.
It's what lets you *get to* a quirk in the first place, and it closes
a gap that is specific to bwctrl:

- To write a bwctrl quirk you first have to prove bwctrl is the
   culprit. pcie_ports=compat can get a hung machine booted, but it
   tears down *all* port services at once, so it can't tell you whether
   the offender was bwctrl, AER, PME or hotplug. pci=nobwctrl isolates
   exactly one variable, which is precisely the information a quirk
   needs. In that sense it feeds the quirk pipeline rather than
   discouraging reports.

- compat is also too blunt as a workaround on modern systems: losing
   native AER/DPC/hotplug just to silence bwctrl is a large regression
   in error handling. A surgical switch keeps everything else native.

- bwctrl is currently the only PCIe port service with neither a
   native/_OSC gate nor a disable of its own. hotplug, AER and PME are
   all gated on pcie_ports_native || host->native_*, and pci=noaer
   already exists as precedent. This mostly brings bwctrl up to parity
   rather than inventing a new class of knob.

If the command-line parameter itself is the sticking point, I'm happy
to implement this in whatever form you prefer - e.g. gating bwctrl
registration the same way the other services are gated, or a per-port
sysfs runtime control. My goal is to close the gap; the mechanism is
negotiable.

Best Regards,
Guixin Liu

