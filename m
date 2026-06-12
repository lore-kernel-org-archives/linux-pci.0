Received: from mail.6bit.com (www.6bit.com [66.228.49.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB930F534;
	Fri, 12 Jun 2026 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.49.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226929; cv=none; b=Lai9gH2vXX9URw37mI6X2fSkmtGY4A0sAhPQ0rL5unCMo+/Dwi/4psl7VM9oQNyIOaqzHDAfZQQ4Y6h1X1QKvTbckH4CImigm+ylKq5orS5F/jro17SCFC2to1c2oVKUX7YsUKSY9kYsFY8e89xtc1TjSt1fWE0Fu4XcQSk8Sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226929; c=relaxed/simple;
	bh=D2EVce6TIMiWfURdmqZ0DLPM5kJjXsnUmdjcT7l8h9U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QSDhGqfFWOaifiO4A+fAd42cqFCa/6UYePDD6xcujzJWLAE/NOdb+m5sleGsRRRoh8QoFJG52TlBLHd5uMHCxsKHHDhuHh4XDBFRNRE1QVKr0tv5SErttBUH6hyIuIY47iS0fac7giGAl8k7O6QgcVNAK/JB68lHzp/WaCieQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6bit.com; spf=pass smtp.mailfrom=6bit.com; dkim=pass (1024-bit key) header.d=6bit.com header.i=@6bit.com header.b=RKWInkeM; arc=none smtp.client-ip=66.228.49.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6bit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6bit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6bit.com header.i=@6bit.com header.b="RKWInkeM"
Received: from [10.22.241.53] (unknown [74.253.16.1])
	by mail.6bit.com (Postfix) with ESMTPSA id 5DDEB945CD;
	Thu, 11 Jun 2026 19:07:24 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=6bit.com; s=dkim;
	t=1781226445; bh=D2EVce6TIMiWfURdmqZ0DLPM5kJjXsnUmdjcT7l8h9U=;
	h=Date:To:Cc:From:Subject;
	b=RKWInkeMCGeNrVZoVyjL0Eqx/qBF5+A+bJ9QnjNNrdETHs7i9QSyW7wBe2bhiwhD+
	 Qa2JMeQXEV0J1vQ17f44zdTpW2LGexlUTTDictdgnet4Bpc8uprMAq+LXcBYfRODAj
	 St0LxapnKhkQg93GX+9wgTx2EPRd9bBoQiZ38IqE=
Message-ID: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
Date: Thu, 11 Jun 2026 19:07:23 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mario.limonciello@amd.com, bhelgaas@google.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 regressions@lists.linux.dev
From: Josh Perry <josh@6bit.com>
Subject: =?UTF-8?Q?=5BREGRESSION_6=2E16=5D_r8169_RTL8168h/8111h_fails_to_pro?=
 =?UTF-8?Q?be_=E2=80=94_=22Unable_to_change_power_state_from_D3cold_to_D0=22?=
 =?UTF-8?Q?_=E2=80=94_bisected_to_4d4c10f763d7?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot introduced: 4d4c10f763d7

Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fails 
to probe on boot; the device drops to D3cold and the driver can't bring 
it back:

   r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID 541, 
IRQ 137
   r8169 0000:04:00.0: Unable to change power state from D3cold to D0, 
device inaccessible
   r8169 0000:04:00.0: Mem-Wr-Inval unavailable
   r8169 0000:04:00.0: error -EIO: PCI read failed
   r8169 0000:04:00.0: probe with driver r8169 failed with error -5

The board has two identical RTL8168h NICs (both XID 541): 0000:02:00.0 
and 0000:04:00.0. Only 04:00.0 fails — its sibling 02:00.0, on a 
different root port, probes and works normally on the very same kernel 
and boot. The failing NIC then does not appear (no enp4s0), taking the 
machine's WAN offline. This strongly suggests the problem is 
port/topology-specific rather than device- or driver-specific: the 
upstream port behind 04:00.0 is placed in D3cold and the endpoint cannot 
be resumed to D0.

Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A 
(2026-03-25, latest available). Firmware is current, so this is not a 
platform-firmware issue.

Bisection: v6.15 good, v6.16 bad (verified by booting both). I then 
reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when 
initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: Set up 
runtime PM even for devices without PCI PM") on top of 6.16.7: the NIC 
probes and links at 1Gbps/Full normally, with no workaround:

   r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID 541, 
IRQ 138
   r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx

Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=off 
also restores the NIC, which is consistent with the upstream port being 
placed in D3cold and the device failing to resume to D0 after the 
explicit-D0 init change.

The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 is 
still affected (retested today on current firmware).

Happy to test patches or provide full dmesg / lspci.
