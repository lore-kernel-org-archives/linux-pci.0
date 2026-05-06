Received: from outbound.st.icloud.com (p-east2-cluster5-host7-snip4-2.eps.apple.com [57.103.79.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84E36D9F6
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107302; cv=none; b=J1kxTLFCl68FSymL+EAmz2gABxn65k6Zw6/LSuGSOmqnud6jTUHk+fT/AWKeGh6YNfzDMAco3jbOzk6m7b+nPVXtJyWF6pLpLsXCqta0xmpuEB59OQ7lPdCLWDmF1k6Aygjt/7Xw2bXvxTRd1O5rekN4L0hplpOGHqXQ+GFaQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107302; c=relaxed/simple;
	bh=hPdMkn450JuWKRS500xthFH8G5AslwJaPVUwStQFl1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILv1g40P2Zm1XrlxHk8PHfOK6F83afrEv5Pa3zt+sEZBGoaTmRPzLp1ktEZy7dhUcBEwyT//mbpUD9HsKPuacsQxJEvQKvntae9hMpzx/oKvGctt3arI/es2kmpt03eaMXQ7CJ1Tuj5dnwUzg4+RBcsjY+Mar9A0B/H/FMXGPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LxeYSjvR; arc=none smtp.client-ip=57.103.79.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LxeYSjvR"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPS id E028B18004B1;
	Wed, 06 May 2026 22:41:34 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhMHVsARQNFDFYEVBcOVk1RDUEfTgZTHgtKAl93AlEcVg1XQ1QEX1BfHA4FQhlACVQZXV8FWgAwUBtfAkIPHBNWFRMfVFYDRBkQVgFYVl0FTRpcGFkPHANNVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0xaT1ddUl1RRBRJUFtURgZDCx0eVAcOVl1fSAVdA18CQV1OClx3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778107299; x=1780699299; bh=0BTeNMLLcELYMuGSlXLUYA9M1ni+3fr3kGQGAJ5jpBM=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=LxeYSjvRrSZG/hp9QW9OHkvT8TaXCfil0z4g3CMRpYwPMZTXK5j67qlo6XSFZqfrSTtC8OOeKfXKYA+vzsgtK4rcQV3sU2bBTq0Q3/tcRITg+cc0iAcbqfkBSH5nX/1PBlvFEhfMAkOcvdNw8oQgIGiP3sze0SNAXCFUdc8RrWostLCst6UBUooGuV1Zyp16bm+1sBAIdSmTS3XQJX/ewbG7iLTLymdaMDV1ioZzz2UYfH9rWoYXWbR6AVLm9QGh7YqcRDIUu13M8qhtJ3B8sWikIVOKJbCRTSzlEY6UnjrO163rjo6P+XkvoPBVl8GsOc1KRp3GJWqOUxROrOtO4w==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPSA id EEB601800844;
	Wed, 06 May 2026 22:41:30 +0000 (UTC)
Message-ID: <c7d0e6c4-1c6c-432e-90ed-f0604401d691@icloud.com>
Date: Thu, 7 May 2026 07:41:28 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
To: Michal Pecio <michal.pecio@gmail.com>, Jihong Min
 <hurryman2212@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
 <20260506233332.664f220c.michal.pecio@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <20260506233332.664f220c.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIyMiBTYWx0ZWRfX0ublysw7nm2x
 kxlrXQ+eE10ezs6Lmug1sxnWjioJ53BlXSk3ygGFUwQ6zIrfZiTN00NPd7en0hAvSWtrRWdoGUO
 Ot5d2djdvbjZe9kzf973SelEW335v0ZrtrgdY7yzYoT4acSeI7fz7QOELUVGUkvTTdU1AzaPHcI
 EzUCBR1E3z+5QpeZ4pMacgtzMXCMaw9w7ncV66snaYxaXTuzL/tfwAw0T5tUxMhg7tp/2UEzFTi
 ykvSfDkaRlz2rRuvo6lA6aFYqwasxtL78rlr2dWcmfD9NH7neMk076Qn8756XCxqVjCFZqPwXHv
 CxtUZ/LBvfpFFFC9c4fDWSQ+gHLyEeWKsVMJ/W0X3aGJHTKayJ/0J5knKkjVEw=
X-Proofpoint-ORIG-GUID: U0eIAQgGkDMrj7bbadnyiFptVJ61-VoO
X-Proofpoint-GUID: U0eIAQgGkDMrj7bbadnyiFptVJ61-VoO
X-Authority-Info-Out: v=2.4 cv=ZbYQ98VA c=1 sm=1 tr=0 ts=69fbc3a0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=QLJJKwC4gHwXwWTYzIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=MienORt8HT0FiJ1vGQZ6:22

 > I think this commit message and certainly the Kconfig help text should
 > include full name of the chip and perhaps its official marketing names
 > too, so that people better understand what hardware is supported.
 >
 > So: "AMD Promontory 21 chipset" and "AM5 6xx/8xx series chipsets", or
 > whatever they are called by AMD and motherboard vendors.

Addressed locally for v3. I changed the commit message, Kconfig prompt/help
text, and hwmon documentation to use the full name, "AMD Promontory 21
(PROM21)".

I avoided putting chipset marketing names directly into the Kconfig text and
commit subject because some AMD 6xx/8xx series chipsets can be built 
from more
than one PROM21 IP in a daisy-chained configuration, including more than one
PROM21 xHCI controller. I described that relationship in the hwmon
documentation instead.

 > Is there any documentation of the index/data registers themselves?

I am not aware of public AMD documentation for the PROM21 vendor index/data
registers or the temperature selector.

For my initial validation on an X870E system with two PROM21 xHCI 
controllers,
I passed one PROM21 xHCI controller through to a Windows VM, left USB 
traffic
idle, and let a Windows monitoring utility poll the controller temperature.
 From the Linux host I monitored that controller's PCI MMIO BAR with 
read-only
accesses. The vendor index register repeatedly held the same selector value,
and the adjacent data register exposed a stable low 8-bit value. That value
matched the reported PROM21 xHCI temperature after the conversion formula
below.

 > Any potential danger that something else (FW? SMM?) uses them too?

I did not find any other in-kernel user of this PROM21 vendor index/data
register pair or the temperature selector.

The driver only serializes its own accesses. It saves the previous index,
selects the temperature register, reads the data register, restores the
previous index, and keeps the sequence short. This avoids leaving the vendor
index/data pair in a different state for other OS code.

This cannot synchronize against firmware or SMM. I cannot rule out such 
access
without AMD documentation or confirmation, so I would appreciate AMD 
feedback
on whether this PROM21 vendor index/data register pair is safe for OS 
polling.

I also tested concurrent temperature reads while USB traffic was active 
on the
same controller, including fio against an external USB storage device and
isochronous USB audio playback/capture. I did not observe USB transfer 
errors
or audio glitches in those tests.

 > Could make sense to describe methodology, particularly in case some
 > people would come and question the formula.
 >
 > How was actual chip temperature measured?
 > Was the output compared with any other (Windows?) utilities?
 >
 > People will be comparing these results and possibly trying to draw
 > some conclusions, like OMG Linux runs this chip 8°C hotter, should
 > I demand a full refund of my free Ubuntu download????!!!?

After identifying the register pair, I used the same validation setup to 
derive
the conversion formula by comparing the observed raw MMIO register value
against HWiNFO64's reported PROM21 xHCI temperature on Windows.

This worked because the PROM21 xHCI temperature is very stable at idle 
and the
sensor appears to have low resolution, so the value usually stays unchanged
long enough to compare both sides reliably.

 > Is such behavior useful?
 >
 > Maybe the driver could just disable runtime PM while it's loaded.

and:

 > I'd encourage what we do in amdgpu for dGPUs. The hwmon files will
 > return an error code (I forget which code) when the device is in runtime
 > PM when called.  Don't explicitly wake it otherwise.
 >
 > This prevents someone installing a sensor monitoring application and
 > that application "being the only thing" keeping the dGPU awake.  If it's
 > awake already for other reasons (like being used) then return valid data
 > to the applications.

I changed the local v3 branch to follow the amdgpu-style behavior by 
default.
The driver now does not wake the xHCI PCI device for a normal hwmon read. If
the device is already active, the read returns valid data. If the device is
suspended, the read returns -EPERM, matching the error code currently 
returned
by amdgpu's pm_runtime_get_if_active() based path. I used -EPERM to 
match the
current amdgpu precedent, but I can change the errno if maintainers prefer a
different one for this driver.

I kept the allow_pm_switch module parameter for now, but changed its 
default to
false. With the default setting, hwmon reads do not change the device 
runtime PM
state. Setting allow_pm_switch=Y explicitly opts into waking the xHCI PCI
device for temperature reads.

Thank you,
Jihong Min

On 5/7/26 06:33, Michal Pecio wrote:
> On Thu,  7 May 2026 05:40:34 +0900, Jihong Min wrote:
>> AMD PROM21 xHCI controllers expose an 8-bit temperature value
> I think this commit message and certainly the Kconfig help text should
> include full name of the chip and perhaps its official marketing names
> too, so that people better understand what hardware is supported.
>
> So: "AMD Promontory 21 chipset" and "AM5 6xx/8xx series chipsets", or
> whatever they are called by AMD and motherboard vendors.
>
>> through a vendor-specific index/data register pair in the xHCI PCI
>> MMIO BAR region. Add an auxiliary hwmon driver for AMD 1022:43fd
>> controllers and bind it to the xhci_pci.hwmon auxiliary device
>> created by xhci-pci.
>>
>> The read path verifies the parent PCI function and uses the
>> initialized xHCI HCD MMIO mapping. The vendor index register is at
>> byte offset 0x3000 from the xHCI MMIO BAR base and the vendor data
>> register is at byte offset 0x3008. The driver writes register selector
>> 0x0001e520 to the index register, reads the raw temperature value from
>> the low 8 bits of the data register, and restores the previous index
>> before returning. Expose temp1_input and an xHCI label through hwmon.
>>
>> Register the hwmon device under the parent PCI function so userspace
>> reports it as a PCI adapter, while the auxiliary driver still owns the
>> hwmon lifetime and unregisters it from the auxiliary remove path.
>>
>> No public AMD reference is available for this value.
> Is there any documentation of the index/data registers themselves?
>
> Any potential danger that something else (FW? SMM?) uses them too?
>
>> The conversion formula is derived from observed temperature readings:
>>
>>    temp[C] = raw * 0.9066 - 78.624
> Could make sense to describe methodology, particularly in case some
> people would come and question the formula.
>
> How was actual chip temperature measured?
> Was the output compared with any other (Windows?) utilities?
>
> People will be comparing these results and possibly trying to draw
> some conclusions, like OMG Linux runs this chip 8°C hotter, should
> I demand a full refund of my free Ubuntu download????!!!?
>
>> The temperature register did not return a valid value while the xHCI
>> PCI function was suspended in testing. Keep the existing behavior by
>> default and allow temperature reads to wake the xHCI PCI device. Add an
>> allow_pm_switch module parameter so users can disable that behavior;
>> when disabled, reads do not wake the device and return -EAGAIN if it is
>> suspended.
> Is such behavior useful?
>
> Maybe the driver could just disable runtime PM while it's loaded.
>
>> Document the supported device, register access, conversion formula,
>> module parameter, sysfs attributes, and sysfs lookup method.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
