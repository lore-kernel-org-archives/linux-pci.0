Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.228.49.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704826;
	b=xExN1CC3RDBJqECDjFXWmfFNVaK/nmYTSTtQTZpmHyTRXYKsj1mW5wf/TaRlyt5RM6Ea
	 oXzolal7QoWBjEz8/f1YidcVVVhv4YSBT6T3rAK8As0bvD2Heoqs1iS3O18M58SXZGsFm
	 oo0pSANHwHE5/aWYCawK9zrEG1vzGpFR8UCR51aat6/J42473N/MX5PNmqp0is1nznZa8
	 cBFQ9bHsqMj0yiecUi2wVEaYvlxZojC37G1s7ji5LT2DeWMrf6R3InWDHqeuEbnJ2qKf1
	 oqNEwuTEUodL9H7xb0uOZvxmlt+Ak39NZxFf8Jh5ng30kV9qb1wU5LaqmGFQFulQHCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704826;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OA8yOrEANNCZu56sSd9JYjgN50cvw4DjNJaBB5S0Tvc=;
	b=2c0xnMagQQuNDmWzrzFlMoChX57RFQrwJWNdafoItqX4fb1VlVs1TG2b2YrAD4pV+UZa
	 u0vDiNyaU9WzuVTrILcyyooP9jZ3/ZRQWcRIWN1yly4tazZdhKEz6o1JBGUKAT/EhucS/
	 F7T4pa8LB0eT0PrWR4VTj9H4ZKzxEUXwyi4/qarqW1QQ+4zNVKGyVEIk1RBvotmozaOJZ
	 n51YjsuYmj7vjeLPc/CULSwhcn0NmbEFt8NkX5jkNw68yJf5PS63Pw1yodYg35SvyI/11
	 eu0PGfriA2t3gxHyTDa0+5cKOAT2naGZoyBNQLf87WFrWvYzeLPJLpOLT8Pgqse1fMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6bit.com;
	spf=pass smtp.mailfrom=6bit.com;
	dkim=pass header.d=6bit.com header.i=@6bit.com header.a=rsa-sha256 header.s=dkim header.b=aQ5Ui8f4;
	arc=none smtp.remote-ip=66.228.49.9
Received: from mail.6bit.com (www.6bit.com [66.228.49.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE728606A31A;
	Thu, 22 Oct 2026 21:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE728606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6bit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6bit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=6bit.com header.i=@6bit.com header.a=rsa-sha256 header.s=dkim header.b=aQ5Ui8f4
Received: from [10.146.177.138] (unknown [74.254.6.145])
	by mail.6bit.com (Postfix) with ESMTPSA id CAB49971BF;
	Thu, 22 Oct 2026 15:33:42 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=6bit.com; s=dkim;
	t=1792704824; bh=6Cd/Xe4NfX+m0FOiI+Xy8hUp0pMn8cKZbrC+FVnkUCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aQ5Ui8f4s3VCGvckwt4EKdSdXL/X0VGTVYtOkpPCkDCQQnTOZkAIhZHvOVO20D9+H
	 ZPbhx0Mnn63a6j4XlfhsWaexhMjUIPvYUrqLH49UOpTjKkC+ZR4qzNaH4olsWT+ogm
	 oP/ovDkOiaabj080F6dVMIE9pZtAPBJnfSfnCtNU=
Message-ID: <c9672648-d01d-4063-b0e2-df38c3868eea@6bit.com>
Date: Thu, 22 Oct 2026 15:33:40 -0600
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_6=2E16=5D_r8169_RTL8168h/8111h_fails_?=
 =?UTF-8?Q?to_probe_=E2=80=94_=22Unable_to_change_power_state_from_D3cold_to?=
 =?UTF-8?Q?_D0=22_=E2=80=94_bisected_to_4d4c10f763d7?=
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, hkallweit1@gmail.com,
 nic_swsd@realtek.com, linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 regressions@lists.linux.dev
References: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
 <b859285b-e43e-43f2-a4f7-af82705d3513@6bit.com>
 <CAJZ5v0h8ke_CE1Y_nesgOU8L-R6WcPaoxFjjRp0rfyRdg+Lj1Q@mail.gmail.com>
Content-Language: en-US
From: Josh Perry <josh@6bit.com>
In-Reply-To: <CAJZ5v0h8ke_CE1Y_nesgOU8L-R6WcPaoxFjjRp0rfyRdg+Lj1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 04:50, Rafael J. Wysocki (Intel) wrote:
> On Thu, Oct 22, 2026 at 3:37 AM Josh Perry <josh@6bit.com> wrote:
>>
>> On 6/11/26 19:07, Josh Perry wrote:
>>> #regzbot introduced: 4d4c10f763d7
>>>
>>> Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fails
>>> to probe on boot; the device drops to D3cold and the driver can't bring
>>> it back:
>>>
>>>     r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID 541,
>>> IRQ 137
>>>     r8169 0000:04:00.0: Unable to change power state from D3cold to D0,
>>> device inaccessible
>>>     r8169 0000:04:00.0: Mem-Wr-Inval unavailable
>>>     r8169 0000:04:00.0: error -EIO: PCI read failed
>>>     r8169 0000:04:00.0: probe with driver r8169 failed with error -5
>>>
>>> The board has two identical RTL8168h NICs (both XID 541): 0000:02:00.0
>>> and 0000:04:00.0. Only 04:00.0 fails — its sibling 02:00.0, on a
>>> different root port, probes and works normally on the very same kernel
>>> and boot. The failing NIC then does not appear (no enp4s0), taking the
>>> machine's WAN offline. This strongly suggests the problem is port/
>>> topology-specific rather than device- or driver-specific: the upstream
>>> port behind 04:00.0 is placed in D3cold and the endpoint cannot be
>>> resumed to D0.
>>>
>>> Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
>>> Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A
>>> (2026-03-25, latest available). Firmware is current, so this is not a
>>> platform-firmware issue.
>>>
>>> Bisection: v6.15 good, v6.16 bad (verified by booting both). I then
>>> reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
>>> initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: Set up
>>> runtime PM even for devices without PCI PM") on top of 6.16.7: the NIC
>>> probes and links at 1Gbps/Full normally, with no workaround:
>>>
>>>     r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID 541,
>>> IRQ 138
>>>     r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>>
>>> Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=off
>>> also restores the NIC, which is consistent with the upstream port being
>>> placed in D3cold and the device failing to resume to D0 after the
>>> explicit-D0 init change.
>>>
>>> The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 is
>>> still affected (retested today on current firmware).
>>>
>>> Happy to test patches or provide full dmesg / lspci.
>>
>>
>> Hey guys,
>>
>> Thanks, and apologies for the slow follow-up. Multiple of you asked me
>> to test on the latest mainline.
>>
>> I had a chance to do just that today with the latest mainline v7.3.
>> Verdict is that it's still broken, same messages as in the original
>> report. pcie_port_pm=off on the same build still works around it.
>>
>> dmesg, "sudo lspci -vvv" and the sysfs PM state for both boots (same
>> v7.3 build, only the command line differs) are attached here:
>>
>>     https://bugzilla.kernel.org/show_bug.cgi?id=222179
>>
>> New detail from the failing boot: the root port above the dead NIC
>> (00:1d.3) is in D0 but its link shows DLActive-, and the endpoint's
>> config space reads all-ones ("Unknown header type 7f"). With
>> pcie_port_pm=off the port shows DLActive+ and the NIC is in D0 at
>> 2.5GT/s x1. So the port seems to come back but the link to 04:00.0
>> doesn't retrain.
>>
>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=222179
> 
> Please also try v7.3 with this patch applied:
> 
> https://lore.kernel.org/linux-pci/20261015020811.1132314-1-keng-yu.lin@hpe.com/raw

No dice, unfortunately. Same issue:

   r8169 0000:04:00.0: Unable to change power state from D3cold to D0, 
device inaccessible
   r8169 0000:04:00.0: Mem-Wr-Inval unavailable
   r8169 0000:04:00.0: error -EIO: PCI read failed
   r8169 0000:04:00.0: probe with driver r8169 failed with error -5

Same state as unpatched v7.3: root port 00:1d.3 in D0 with LnkSta
DLActive- and ASPM L1 enabled, 04:00.0 config space reads all-ones
("Unknown header type 7f"), and the correctable RxErr on 00:1d.3 at
~9.7s. The PCI/r8169 dmesg lines match the unpatched boot line for line.

I attached the same info for the the patch run to the bugzilla ticket.

Josh
