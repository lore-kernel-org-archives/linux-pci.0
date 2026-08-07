Received: from out-93wp-a35.jellyfish.systems (out-93wp-a35.jellyfish.systems [104.207.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE434CFC6
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132805; cv=none; b=IAh4kfgB80R1/2db/+d2WwvuztB7HsR4QNWfbyRj+7anQsXXkK640d03yTMafLVHrfc9jPoy34FoedeFJB0h+m7h+cxF/ClBjgdbAjMWjZjPwXBFgi+4/bOcIOfGPjyclBBP3ApzV8BI11o5QoytQ44qDzzogmCI+FCG7zLdGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132805; c=relaxed/simple;
	bh=2SmEyu5gopBmdDUwyzZQK9jt1sIm3VcImzQ6fWSzql8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orlHyXCRO6hWg7JN+wOFJkSX6tS3nfQk1+7yYpAHqBy6Xp5jnt/cYtJIuMqvomPiXcCr3gA2JLp96m95/3Y7SyGqL7GLcRcDqgjZrM6GDYTD+eBeL1DkMB5m3htdBjfnrlBvEmwdBPIr9jyOYz60voZaweLmCBKqwvRtaWRfXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axtjblog.cc; spf=pass smtp.mailfrom=axtjblog.cc; dkim=pass (2048-bit key) header.d=axtjblog.cc header.i=@axtjblog.cc header.b=auwJO49L; arc=none smtp.client-ip=104.207.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axtjblog.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axtjblog.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axtjblog.cc header.i=@axtjblog.cc header.b="auwJO49L"
Received: from [192.168.1.44] (unknown [23.165.40.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hGw3R38m7z2x98;
	Fri, 07 Aug 2026 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtjblog.cc;
	s=spacemail; t=1786132791;
	bh=98vhWhukpc/bHhQROl78ymnN7dOiWhWAvk2LpT6Y78g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auwJO49L8EcFppRW8dT1VL4eM6cQJylCbWmB4g7WH0kbd6bbm3mwdxVdgUBUjgEFv
	 7U2BXV1thLrPDgQ2kjCk9etazFRdVZilrp9t61ZAdWdxwkCDkiO8dPSNcUP/LW3VEZ
	 2u+A1jyI145YUy+pbrWwDkxxkUfdNFbGMwtPOEX7zc1usC0H8VuOsj2bOp59WD3lyW
	 vHsvZzB2Eg7D8dqQFSpmjMSS0dZnAF8oZFdj6NmNqNESEQ8H5cChIleWOiX9kHz350
	 o0vvF6JeM1TtYkTIbDCtGTUrTUlAp4+l+7/DEuSIv6hdlLKsra0/ryfX7LpHvPpado
	 chSFgMgtcxU/Q==
Message-ID: <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
Date: Sat, 8 Aug 2026 03:59:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Andreas Wild <andiwild@gmail.com>, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, macro@orcam.me.uk, linux-kernel@vger.kernel.org
References: <20260801201244.4421-1-andiwild@gmail.com>
Content-Language: en-US
From: Aoxtj <aoxtj@axtjblog.cc>
In-Reply-To: <20260801201244.4421-1-andiwild@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Envelope-From: aoxtj@axtjblog.cc

Hi,

I'm the one who reported a PCIe/NVMe boot regression on the Proxmox forum:

  
https://forum.proxmox.com/threads/7-0-14-7-kernel-breaks-pci-link-training.185549/

A Proxmox dev pointed me here and asked me to try this patch. I'm not a 
kernel developer and did most of the debugging with AI help, so please 
bear with me.

TL;DR:
- Proxmox Kernel 7.0.14-6 to 7.0.14-8: SK hynix system drive disappears 
during boot.
- Narrowed down to commit 72780f796468 and verified by reverting it.
- 7.0.14-8 + revert 72780f796468: boots reliably.
- 7.0.14-8 + this v3 patch: only boots sometimes; failed boots lose the 
drive the same way.

Machine: ASRock B450M Pro4-F, SK hynix PE4010 NVMe system drive on a 
passive PCIe bifurcation card.

   AMD Renoir PCIe GPP Bridge 0000:00:02.4 [1022:1633]
   -> bus 07 -> SK hynix PE4010 0000:07:00.0 [1c5c:2527]

Initramfs dmesg from a failed v3 boot:

   [    0.555805] pci 0000:00:02.4: [1022:1633] type 01 class 0x060400 
PCIe Root Port
   [    0.555828] pci 0000:00:02.4: PCI bridge to [bus 07]
   [    0.555871] pci 0000:00:02.4: removing 2.5GT/s downstream link 
speed restriction
   [    1.636965] pci 0000:00:02.4: retraining failed

Nothing shows up on bus 07 afterwards, so my system drive is gone.

With the revert instead, the working link reports:

   Root Port 0000:00:02.4:
     LnkCap:  Speed 8GT/s, Width x4
     LnkSta:  Speed 2.5GT/s, Width x2, DLActive+
     LnkCtl2: Target Link Speed: 2.5GT/s, SpeedDis+
     LnkSta2: EqualizationComplete-, EqualizationPhase1/2/3-

   Endpoint 0000:07:00.0:
     LnkCap:  Speed 8GT/s, Width x4
     LnkSta:  Speed 2.5GT/s (downgraded), Width x2 (downgraded)
     LnkCtl2: Target Link Speed: 8GT/s
     LnkSta2: EqualizationComplete-, EqualizationPhase1/2/3-

My guess: this motherboard supports different PCIe generations depending 
on which CPU is installed, and with this CPU the link just can't run at 
the advertised 8GT/s — which would explain why the 8GT/s retrain fails.

Tested on a locally rebuilt Proxmox/Ubuntu 7.0.14-8 backport, not 
mainline. Also replied in kernel Bugzilla #221801:

   https://bugzilla.kernel.org/show_bug.cgi?id=221801

Happy to test a diagnostic patch.

Best regards,
Aoxtj

