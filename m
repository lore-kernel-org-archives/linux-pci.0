Received: from outbound.st.icloud.com (p-east2-cluster5-host11-snip4-10.eps.apple.com [57.103.79.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D3410D34
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261992; cv=none; b=fv3TaM4lHeMhTph+nT5DM0h96e85M5rfL5G7M8PABn/kQLg53wmGfy4DvRIn6KHATnaFW06nqRol2n2VyPqQauvkjKmrxMTipZp3boTilbCwBIXORd8A/sBNZjggL/ZPU8rXqdcpr7VwCSioQl6r+qrU7tWgmM7ofl3ziYeQ1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261992; c=relaxed/simple;
	bh=0EURHIsFgCyVja3VOrKVbeYiF9MJWb5R4FOm8jIdF7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6l0RjBD7bEZq9qmDYKiM926af8B/8fzfRK3zr09zkgm5FUN+CJOTqnonp2liYkILQQGoI0D6LOgZuuopeN4bFly5R5xZurRDBcxSnn0aAQvNGkFgKXDI3kpsLlJuLaYgPkP/5OWfv8Ml2k36hin03MsO9Bs8jtlTyLkJidv3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=w202iOzK; arc=none smtp.client-ip=57.103.79.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w202iOzK"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 09323180048C;
	Fri, 08 May 2026 17:39:49 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkBdTQJVU18CXVxKAFQaX1ZJClULCABaH0BdSlZcA1tUQAkbUi1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778261990; x=1780853990; bh=0EURHIsFgCyVja3VOrKVbeYiF9MJWb5R4FOm8jIdF7E=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=w202iOzKaKsEGaG6G1FXZW2E4d474yhBKQevajALtN3aCI/wpm01OuVjEj2IpAVKJ5fnZ95SwoGgPgM4i1qs+A0sWCo5Ee3aRoXHHjn6P2Ezi9qS9Al3rlK0FmO52c2u6/skWjBLQ8e9eadgXPIZx5YcpurVy1vJavfydIL24knAcG8nMPIZBtjv8roc6VW6G2R0HGkVocmXvK70AZEysxWwm8dnRl/1RdAEkDFBLF04Ln7fu6VNGIPjm9oj2++nkg/URKiehYS8c7g2C77aTDNiL/E/u/X6LfJVI01ENaJGOxHdo9SouzKJzflyGmc/LaYQPW++2iOrkb47zz4fbw==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 0B84A1800334;
	Fri, 08 May 2026 17:39:46 +0000 (UTC)
Message-ID: <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
Date: Sat, 9 May 2026 02:39:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3NiBTYWx0ZWRfXzpmF9wrpzXTu
 tKBf77DhhCB1nYMVNDDZuQeaVROUmEBwh1picBLd97Q7N3PxRCwJk0cVS8FUWn+CPtM0n/FPTpT
 qnW1OK4Mb6kD7pYEToaxwujvE4uyxo1IEa76s4sL1eg+3gBCIW6j/wa482AKWV4AfQSsBZ/WgA4
 kEsHMZ3bq3cXrAPsgbqzeCFp6Hrj0Jk1C8tMGwNDaYN+eeaFWYdyCw5Eo2zc7z0sKC4h0khRHtq
 WMLP7kQ9JaNfaGh/QzZ/cSnV6px58e6aShM4xysHe9U28gPV2zr68uTMW/WRtmC9EKQ7qYqu7/l
 4E0ldtbKBEHjiR/lft3pQkvSt4x/iGJasA118PPvlJMFWlM7TwmUyoSdn1mP7Y=
X-Authority-Info-Out: v=2.4 cv=Sbb6t/Ru c=1 sm=1 tr=0 ts=69fe1fe6
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=c1yG8o5ftu5EqDgq3rYA:9 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22
 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-GUID: BMNQUzgsUv3Sd3p2K5uLoLAzvfwkxk6T
X-Proofpoint-ORIG-GUID: BMNQUzgsUv3Sd3p2K5uLoLAzvfwkxk6T

 > This define should be in a common header used by xhci-pci.c and
 > xhci-pci-prom21.c both.

Agreed. I moved PCI_DEVICE_ID_AMD_PROM21_XHCI to xhci-pci.h so both
xhci-pci.c and xhci-pci-prom21.c use the same definition.

Sincerely,
Jihong Min

