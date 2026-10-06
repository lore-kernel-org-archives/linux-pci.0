Received: from mta1.migadu.com (out-95.mta1.migadu.com [95.215.58.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A43E3C4D
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275513; cv=none; b=rBRsALSd3lzfwI1zrMg23hQWwwodBEl0libEPsWK24dW5yNl6mF0lIMSlzJaM7D3Mc7Lk1NgBbaCgA5TjfLR0Zco9cXQ/k+KTrFbh4fz5CYDowTDHcGFfiZuWByElV8pPFJ8lL+1kT72sAFGmYofry+kxoGHs2LxXwaitD4vy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275513; c=relaxed/simple;
	bh=mrxxhjgfLG4fO8TQooJhD2gAhvLlp5A6uxEF95+CYjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbS041Pen27lS1aLm4ruySKJOq66dwgxRH0eyRaSVbXG3ifs7SVT0AdEfU/eR0e3PHX0QGqlhzH9kmA5FStY+mgEo8wo0OXmquxV95toWH7dQaqTfY8M91o3TXm19wEmpT7jCUqSuy+phcgtlQkr8K+JNsiFs6fE4vfLopJAhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3fxBX5Q; arc=none smtp.client-ip=95.215.58.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3fxBX5Q"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mrxxhjgfLG4fO8TQooJhD2gAhvLlp5A6uxEF95+CYjc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791275508; v=1; x=1791880308;
 b=F3fxBX5Qaatpwc5AtyFCybTIC+AVKzDEbOqtvVyHSF3CfhmezLC2xv4ThtuMgYusdc1I51Nd
 6a1oFMt15C0MZNtZ95fVzRiFDdq4gOSYrexmKLqF/gHwetHdyANnGalpltxEVg51ABYSXtIsK3R
 zWvKiljteDDRSbMI8Ueh/pMc=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6aed73ae62c501ef;
	Tue, 06 Oct 2026 08:31:48 +0000
X-Mizu-Trace-ID: 6aed73ae62c501ef
X-Migadu-Flow: FLOW_OUT
Message-ID: <2a7a97cc-7ad0-4e6f-845a-dd841d36079b@linux.dev>
Date: Tue, 6 Oct 2026 14:01:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Lukas Wunner <lukas@wunner.de>, "Perlow, Jason" <jperlow@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Alex Deucher <alexdeucher@gmail.com>
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
 <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>
 <asRjch1fMBslk07D@wunner.de>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <asRjch1fMBslk07D@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06-10-2026 08:26 am, Lukas Wunner wrote:
> On Mon, Oct 05, 2026 at 08:17:12PM -0400, Perlow, Jason wrote:
>>>> My guess, and it is
>>>> only a guess: treating a possible Advisory Non-Fatal Error as
>>>> non-Advisory and recovering through the uncorrectable path resets or
>>>> disturbs a T2 function, and the T2 then powers the machine down.
> 
> Advisory Non-Fatal Errors aren't handled through the Uncorrectable
> Error code path.  The kernel just reports and clears the errors.
> 
> And if the device has a driver and that driver implements the
> ->cor_error_detected callback() in struct pci_error_handlers,
> that callback is invoked.  (Currently only the CXL driver
> implements the callback.)
> 
>>   masked only on 04:00.2 (Apple T2 Secure Enclave, 106b:1802):
>>       stays up (120 s)
> [...]
>> So here the trigger is unmasking Advisory Non-Fatal Errors on that
>> one function.
> 
> That's quite unexpected.  Maybe there's a bug in the PCIe IP which
> Apple used for the T2 Secure Enclave device (which I believe is a
> fully-fledged arm64 CPU with a PCIe port in Endpoint mode).
> 
> Another explanation might be that there's a watchdog on the T2 device
> which monitors its Config Space and triggers a poweroff whenever
> some suspicious register mutation is detected.  I'm just guessing
> here because this is really weird.
> 
> macOS likely never unmasks the bit and so they never saw this during
> validation testing.  Is the T2 device visible on Windows?  If it is,
> it seems Windows doesn't support and unmask Advisory Non-Fatal Errors
> either.

T2 device is visible on Windows as well as "System Device"

PS C:\Users\Aditya> Get-PnpDevice -Class 'System' -PresentOnly | Where-Object {$_.InstanceId -like "*PCI*"} | Format-Table -AutoSize FriendlyName, InstanceId

FriendlyName                                                                              InstanceId
------------                                                                              ----------
Intel(R) Xeon(R) E3 - 1200/1500 v5/6th Gen Intel(R) Core(TM) PCIe Controller (x4) - 1909  PCI\VEN_8086&DEV_1909&SUBSYS_72708086&REV_07\3&11583659&0&0A
Intel(R) PCI Express Root Port #1 - A338                                                  PCI\VEN_8086&DEV_A338&SUBSYS_72708086&REV_F0\3&11583659&0&E0
Intel(R) Serial IO UART Host Controller - A328                                            PCI\VEN_8086&DEV_A328&SUBSYS_72708086&REV_10\3&11583659&0&F0
AMD PCI Express Upstream Switch Port                                                      PCI\VEN_1002&DEV_1478&SUBSYS_00000000&REV_43\4&D48CA2C&0&0008
Intel(R) PCI Express Root Port #17 - A340                                                 PCI\VEN_8086&DEV_A340&SUBSYS_72708086&REV_F0\3&11583659&0&D8
Intel(R) Xeon(R) E3 - 1200/1500 v5/6th Gen Intel(R) Core(TM) PCIe Controller (x8) - 1905  PCI\VEN_8086&DEV_1905&SUBSYS_72708086&REV_07\3&11583659&0&09
Intel(R) LPC Controller/eSPI Controller - A313                                            PCI\VEN_8086&DEV_A313&SUBSYS_72708086&REV_10\3&11583659&0&F8
High Definition Audio Bus                                                                 PCI\VEN_1002&DEV_AB38&SUBSYS_AB381002&REV_00\6&16883A51&0&01000008
Intel(R) SPI (flash) Controller - A324                                                    PCI\VEN_8086&DEV_A324&SUBSYS_72708086&REV_10\3&11583659&0&FD
System Device                                                                             PCI\VEN_106B&DEV_1802&SUBSYS_1802106B&REV_01\4&3AC8FC3&0&02D8
Intel(R) Host Bridge/DRAM Registers - 3EC4                                                PCI\VEN_8086&DEV_3EC4&SUBSYS_72708086&REV_07\3&11583659&0&00
Intel(R) Management Engine Interface #1                                                   PCI\VEN_8086&DEV_A360&SUBSYS_72708086&REV_10\3&11583659&0&B0
AMD PCI Express Downstream Switch Port                                                    PCI\VEN_1002&DEV_1479&SUBSYS_14791002&REV_00\5&130BE3BB&0&000008
Intel(R) Thermal Subsystem - A379                                                         PCI\VEN_8086&DEV_A379&SUBSYS_72708086&REV_10\3&11583659&0&90
Apple USB Virtual Host Controller                                                         PCI\VEN_106B&DEV_1801&SUBSYS_1801106B&REV_01\4&3AC8FC3&0&01D8
PCI standard RAM Controller                                                               PCI\VEN_8086&DEV_A36F&SUBSYS_00000000&REV_10\3&11583659&0&A2
Intel(R) SMBus - A323                                                                     PCI\VEN_8086&DEV_A323&SUBSYS_72708086&REV_10\3&11583659&0&FC
Intel(R) Xeon(R) E3 - 1200/1500 v5/6th Gen Intel(R) Core(TM) PCIe Controller (x16) - 1901 PCI\VEN_8086&DEV_1901&SUBSYS_72708086&REV_07\3&11583659&0&08

> 
>> Would you accept a quirk that keeps the bit masked on Apple
>> 106b:1802?
> [...]
>> I am happy to write and test that, or any other patch you
>> would like tried on this machine, and I can send lspci -vvv and the
>> journals.
> 
> A quirk does sound like the only possible solution.  However I'd
> really like to see lspci and dmesg output with the bit unmasked
> shortly before poweroff to get a full understanding.
> 
> Thanks!
> 
> Lukas

