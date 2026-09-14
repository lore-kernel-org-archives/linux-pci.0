Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073D480353
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396262; cv=none; b=OZeZgWrDRs3ud2TRkSL+i2vBboevxwxhm1B5dBAoM2ZQkONafm2wtHCFoTW9JG0nVBjCIvRPxLrP8lJBBWajrWpqet0dS/SRRv4ntBk596hSFDN1Fk/GS40yxQJUkq/c2ibHpuZq1yqRQ81ym8Snkg76UqXf2CR7G7Ijr4U1UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396262; c=relaxed/simple;
	bh=FcziOCCsytCcib3oM9S/q9gH2GMgiWKKT0G6/MmLl5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sU005lw9e6Ac2PCV2BinY5OaHzYVpSqicTbbeew7IvEjXEnRafzZp0WlSowt+MQhZ6ChTZuerwsc3X6mP0U0KeXLQU86pbygjqp0h5UtHW8vcJ7mqCuaBDdaE8Fkqfdc4Dv8UocFbHKst8Wq7VqU85ZWhGqRk5y1szLBncmUuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jJU2mYMN; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jJU2mYMN"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hk6yL4M2pz44sD;
	Mon, 14 Sep 2026 16:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789396250;
	bh=FcziOCCsytCcib3oM9S/q9gH2GMgiWKKT0G6/MmLl5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jJU2mYMNysSTPazrYTE4tRT0dgNoXJAcR16SD9ePKtLCnfzPoCEQxSTOTpVy/plhA
	 av+IrFliwOtrvcLea07dCdYuxlG52CrPtgDszFM2SZlHlixiaRaDY8dlTSD1jSn+D1
	 35S8IDBK2S2agzM3iv3xkLvp7c4rovkZLtRtnCnwPl05YKusuYPuzKAaYeu2NoOsCn
	 BVGIYDPmRRkXvzDu3gO4Hnvo/Hwo3SlwYOepQA6xxioNHzMUkj6Xm6MmlfHIE7iVjd
	 +mlQwOnzEGkQj+f5LIZ4IlLAyDF+1NKaT7ik47kBI247ozyjgvfPY6HIZniR1ZQxLX
	 Iui0uWd11epTA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hk6yL3bxrz42Wm;
	Mon, 14 Sep 2026 16:30:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hk6yG3tP6z8tdf;
	Mon, 14 Sep 2026 16:30:46 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id EDD525FAA9;
	Mon, 14 Sep 2026 16:30:37 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <012b3ebc-62f0-402e-afa9-02712e67e72a@leemhuis.info>
Date: Mon, 14 Sep 2026 16:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI BAR allocation/D3cold failure: NVIDIA MX250
 inaccessible since Kernel 6.x on Acer Swift 3 (SF314-56G)
To: lxuser <dittrich.m@gmx.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20260501165542.GA491695@bhelgaas>
 <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
 <5f716613-d996-46db-96ec-6c0251219922@gmx.net>
 <449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info>
 <81ac70ae-c51e-4960-8dd3-bed47ceafafb@gmx.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <81ac70ae-c51e-4960-8dd3-bed47ceafafb@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178939623830.3044871.3318525723028977191@mxe9fb.netcup.net>
X-NC-CID: 4lZ9Jka4kHAB8Z3Kf0cGKN/GcN12YEJtihW5pU3kM/iil8zoXZ4=

On 9/7/26 13:11, lxuser wrote:
> Dear Kernel Team,
> 
> I tested everything again with the result, that the regression is still
> in the current kernel. This time I found the bug report from THUNDEROBOT
> ZERO (https://bugzilla.kernel.org/show_bug.cgi?id=221087).
> 
> I tested the same patch from THUNDEROBOT ZERO  but changed the model to
> my laptop:
> +            DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +            DMI_MATCH(DMI_PRODUCT_NAME, "Swift SF314-56G"),
> (from dmidecode -s system-product-name and dmidecode -s system-manufacturer)
> 
> As an result everything works perfect. Please find the kernel patch
> attached (acer-swift3-quirk-final.patch).

Please submit this properly in a new thread, referencing this one via a
Link: tag, as it likely needs to go through the ACPI code, just like
cd7ef20ba8c6e9 ("ACPI: PM: Add unused power resource quirk for
THUNDEROBOT ZERO") (aka
https://lore.kernel.org/all/d0785a7c-7e4c-434b-af31-4ec6f690ed89@126.com/
) did -- so with similar To and CC values (and not as html!).

And this looks odd, as this is both you, isn't it?

  Signed-off-by: dittrich.m@gmx.net
  Signed-off-by: lxuser <lxuser@local>

> Tested with Kernel 7.2.3-1-cachyos.

Even if its "just" a quick, test with vanilla next time please.

Ciao, Thorsten

> For further information I added
> the log from sudo dmesg | grep -i "nvidia\|acpi.*power\|D3cold\|64-bit\|
> BAR" from the original kernel and the patched kernel.



> Am 16.05.26 um 16:29 schrieb Thorsten Leemhuis:
>> On 5/16/26 12:16, Matthias Dittrich wrote:
>>> I completed the bisect test between kernel 5.15 und 5.16 and found the
>>> commit and now have reproducible revert-test results. I used the
>>> bisect.sh (attached ) for automation. Testing criteria was status rev ff
>>> (bad) or rev a1 (good).  As it was the first indicator for me on Ubuntu.
>>> I also used olddefconfig as I know this config worked before.
>>>
>>> The identified commit (see final-bisect-log.txt) is:
>>> # first bad commit: [a1224f34d72a103829d6953935d6c6621f135b83] ACPI: PM:
>>> Check states of power resources during initialization
>> Thx for the bisection. Not my area of expertise, so the following might
>> send everyone in the wrong direction, nevertheless FWIW:
>>
>> That commit caused trouble on two other machines and DMI quirks were
>> added to make them work again; see 9b04d99788cf47 ("ACPI: PM: Do not
>> turn of unused power resources on the Toshiba Click Mini") [v6.4-rc1]
>> and cd7ef20ba8c6e9 ("ACPI: PM: Add unused power resource quirk for
>> THUNDEROBOT ZERO") [v7.0-rc1] for details. Wonder if the problem on your
>> machine is similar.
>>
>> Ciao, Thorsten
>>
>>> Additionally testing (see Abschlusstest.txt):
>>>
>>>   * Verification with Parent commit test: git checkout
>>>     a1224f34d72a103829d6953935d6c6621f135b83~1
>>>       o lspci reports `rev a1` and  `nvidia-smi` works correctly
>>>   * Revert test on 5.16 with git revert --no-commit
>>>     a1224f34d72a103829d6953935d6c6621f135b83
>>>       o     lspci reports `rev a1` and  `nvidia-smi` works correctly
>>>   * Revert test on 6.1 with git revert --no-commit
>>>     a1224f34d72a103829d6953935d6c6621f135b83
>>>       o lspci reports `rev a1` and  `nvidia-smi` works correctly
>>>
>>> With kernels like 6.2 and newer "git revert" result in an error and
>>> stops (transleted to english):
>>>
>>> git revert --no-commit a1224f34d72a103829d6953935d6c6621f135b83 Auto-
>>> merging drivers/acpi/power.c CONFLICT (content): Merge conflict in
>>> drivers/acpi/power.c error: could not revert a1224f34d72a... (ACPI: PM:
>>> Check states of power resources during initialization) Hint: After
>>> resolving the conflicts, mark the corrected paths with: Hint: 'git add
>>> <paths>' or 'git rm <paths>'
>>>
>>> All tests have been done with Ubuntu 22.04. 
>>>
>>> Let me know if I can test anything further.
>>>
>>>
>>> Test summary Ubuntu:
>>>
>>> Test Case
>>>
>>> 	
>>>
>>> Kernel / Commit
>>>
>>> 	
>>>
>>> Modification
>>>
>>> 	
>>>
>>> PCI State
>>>
>>> 	
>>>
>>> |Nvidia-smi/
>>> NVIDIA Driver|
>>>
>>> 	
>>>
>>> Result
>>>
>>> Baseline good
>>> Ubuntu 22.04
>>>
>>> 	
>>>
>>> Linux 5.15
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> works
>>>
>>> 	
>>>
>>> GOOD
>>>
>>> Baseline bad
>>>
>>> 	
>>>
>>> Linux 5.16
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev ff|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> Bisect parent
>>>
>>> 	
>>>
>>> |a1224f34...~1|
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> works
>>>
>>> 	
>>>
>>> GOOD
>>>
>>> First bad commit
>>>
>>> 	
>>>
>>> |a1224f34...|
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev ff|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> Revert verification
>>>
>>> 	
>>>
>>> |a1224f34...|
>>>
>>> 	
>>>
>>> reverted
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> works
>>>
>>> 	
>>>
>>> GOOD
>>>
>>> Forward revert test
>>>
>>> 	
>>>
>>> Linux 6.1
>>>
>>> 	
>>>
>>> reverted
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> works
>>>
>>> 	
>>>
>>> GOOD
>>>
>>> Ubuntu 22.04 (standard)
>>>
>>> 	
>>>
>>> Linux 6.8
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev ff|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> Modern revert attempt
>>>
>>> 	
>>>
>>> Linux 6.2
>>>
>>> 	
>>>
>>> revert attempted
>>>
>>> 	
>>>
>>> conflict in |drivers/acpi/power.c|
>>>
>>> 	
>>>
>>> n/a
>>>
>>> 	
>>>
>>> not testable
>>>
>>> *Linux 5.15 is the standard in Ubuntu 20.04 but also available as
>>> downgrade in Ubuntu 22.04
>>>
>>> Test summary CachyOS:
>>>
>>> Test Case
>>>
>>> 	
>>>
>>> Kernel / Commit
>>>
>>> 	
>>>
>>> Modification
>>>
>>> 	
>>>
>>> PCI State
>>>
>>> 	
>>>
>>> |Nvidia-smi/
>>> NVIDIA Driver|
>>>
>>> 	
>>>
>>> Result
>>>
>>> Standard
>>>
>>> 	
>>>
>>> Linux 7.0.2
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> LTS
>>>
>>> 	
>>>
>>> Linux 6.18
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>> |rev a1|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> Start parameter
>>>
>>> 	
>>>
>>> |Linux ||7.0.2|
>>>
>>> 	
>>>
>>> start parameter
>>>
>>> 	
>>>
>>> |-|
>>>
>>> 	
>>>
>>> fails
>>>
>>> 	
>>>
>>> BAD
>>>
>>> git
>>>
>>> 	
>>>
>>> |Linux ||5.15|
>>>
>>> 	
>>>
>>> none
>>>
>>> 	
>>>
>>>
>>> 	
>>>
>>>
>>> 	
>>>
>>> not testable system freeze
>>>
>>> git
>>>
>>> 	
>>>
>>> |Linux ||7.0.2|
>>>
>>> 	
>>>
>>> revert attempted
>>>
>>> 	
>>>
>>>
>>> 	
>>>
>>>
>>> 	
>>>
>>> not testable
>>>
>>>
>>> Kind regards,
>>> Matthias
>>>
>>> Am 11.05.2026 um 11:34 schrieb Matthias Dittrich:
>>>> Dear Bjorn,
>>>>
>>>> Thank you for the quick response. For transparency, I used the AI tool
>>>> Gemini during the bug-fixing and testing process. I am not an IT
>>>> specialist and therefore cannot fully verify all of the AI’s
>>>> conclusions in my last mail.
>>>>
>>>> All kernels were tested manually by installing the OS and kernel. The
>>>> recommended boot parameters were also tested manually. The logs sent
>>>> previously and in this mail are raw terminal outputs generated from
>>>> the commands listed in the "Skript" file.
>>>>
>>>>
>>>> The dmesg and |lspci|output from the newest CachyOS kernel is
>>>> attached. Additionally, the following commands were also run for the
>>>> Ubuntu 5.15 kernel for comparison:
>>>>
>>>> dmesg
>>>> sudo lspci -vv > lspci-vv-ubuntu2205-K515-good.txt
>>>> sudo lspci -vvv > lspci-vvv-ubuntu2205-K515-good.txt
>>>> sudo lspci -vvxxxx > lspci-vvxxxx-ubuntu2205-K515-good.txt
>>>> sudo lspci -s 02:00.0 -vvxxxx > lspci_gpu_$(uname -r).txt
>>>> sudo lspci -t > lspci_tree_$(uname -r).txt
>>>>
>>>>
>>>> Gemini recommended performing a git bisect with optimized parameters
>>>> to reduce compilation time.
>>>>
>>>>   * Before starting the bisect tests, I tested different kernel
>>>>     revisions. The "git" kernel 5.15 (with localmodconfig) appears to
>>>>     work just like the newer Ubuntu 5.15 kernel, as the graphics card
>>>>     status is shown as |(rev a1)|. The earliest kernel revision where
>>>>     the status changes to |(rev ff)|starts with kernel 5.16 (tested
>>>>     with localmodconfig). However, the NVIDIA driver itself could not
>>>>     be tested.
>>>>   * The bisect between 5.15 and 5.16 result in|
>>>>      [342a67f0884293639bd17ea44df754ead799e669]|| NFS: Label the
>>>>     dentry with a verifier in nfs_link(), nfs_symlink()|, which seems
>>>>     incorrect, as the verification using |git checkout
>>>>     342a67f0884293639bd17ea44df754ead799e669~1|also failed.
>>>>   * An automated bisect was attempted without localmodconfig, but
>>>>     there were technical issues and I have not yet been able to
>>>>     complete the testing.
>>>>
>>>> I also noticed that the |lspci|results differ between CachyOS and Ubuntu:
>>>>
>>>> 02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev a1)
>>>>
>>>>   * |(rev a1)|— Ubuntu 22.04 Kernel 5.15 (works), CachyOS Kernel 6.1
>>>>     LTS and Kernel 7, but NVIDIA MX150 does not work
>>>>   * |(rev ff)|— Ubuntu 22.04 Kernel 5.16 and newer (localmodconfig)
>>>>     and Kernel 6.8 and NVIDIA MX150 does not work
>>>>
>>>> Kind regards,
>>>> Matthias
>>>>
>>>>
>>>>
>>>> Am 01.05.2026 um 18:55 schrieb Bjorn Helgaas:
>>>>> [+cc Ilpo]
>>>>>
>>>>> On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
>>>>>> Dear Kernel Developers,
>>>>>>
>>>>>> I found a regression and did my best to identify the issue and find a
>>>>>> workaround, but I am not a developer. I also published the regression in the
>>>>>> NVIDIA Linux Developer Forum, but it appears to be a kernel regression and
>>>>>> not a driver issue, as the latest drivers work on older kernels (e.g., 5.15)
>>>>>> but fail on anything 6.x+. I did not perform a git bisect as compiling on
>>>>>> this i5-8265U - because of its low performance I can only compile one kernel
>>>>>> over night.
>>>>>>
>>>>>> **Description:**
>>>>>> The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is inaccessible
>>>>>> on any Linux distribution using Kernel 6.x or 7.x. The device fails to
>>>>>> initialize during the driver probe routine.
>>>>> Thanks for the report.  With the newest kernel available to you, can
>>>>> you please capture the complete dmesg and output of "sudo lspci -vv"?
>>>>> Don't filter out things that don't seem relevant; we can easily do
>>>>> that.
>>>>>
>>>>> Bjorn

