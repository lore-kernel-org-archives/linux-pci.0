Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E2314B76
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513476; cv=none; b=se1qLS3kJiAE8nUnB1rD/+XI8nF87uOrNDiimFfCuDlHcU1yBf6X8ctdU8K4sYJ05qnn+XUXc70HFROi7T5GR8oZwP7frvCuBI/LQhnQHtD0HfSnEmMsqqWZlXtmGhl4Mi+jLzk8OHn7XpEv0aClAFjKuQypJQyd/ayRnN7U2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513476; c=relaxed/simple;
	bh=lP97fpcUPSo5lAFF4vcUd4Px6yMGTgeamXJsQM0ZhIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFOOMn4Vlc9UHMao+kdJ7ZelQpTIeCvaDYwLsl8tC6O8ZIf1UHwnTrO7SfBethuG3soQURnbYcnQJrrS0UubvdxAq9jsKkhoDh8ylMr/Uud5Agt9FWd3KgVO8Q0nkqE18TCe9dCXw5YbhY8ewPQw0dy/1VmFSVzyBfVLtNLG3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn86+Lha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn86+Lha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E04E1F00893;
	Wed,  3 Jun 2026 19:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513474;
	bh=s4JlhYxypqtc4ecf1nhhYqKLLdnrs7R/mBPWl9CWdEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Dn86+LhacOC2YWUtV4PI/VsWgH+ZcM4KMzzPjvg/V+mtz7Mc+4C+ZnJdCMrdoDN4T
	 W5rjyYtHvm+GEey4wWdY/fCA72YAD5tRCtlUDecAL21xxkIl1q1dVmXEyPwbYPlINf
	 MFbnMsjvLIRemb2xPX6damNGp0Ba68SxRApUMJ7h+HTTMVB6q+UsAUgNGbIpZ0aS10
	 NE2fbvu2venDsoQxsDRl5f9BGMy/N6K1YFoNbgGLihgmAUILXal22WVRxz0DAUTBC+
	 hfkU6R3R8Ne9cxTUgKETiBZmFVxCqsSkLtVPZtkOBt5KOQzHGbrpYxGY6hjMhDXM+E
	 mdrCo4Ao1ZqIQ==
Message-ID: <43545019-221c-45af-b646-3b3d4ea86718@kernel.org>
Date: Wed, 3 Jun 2026 14:04:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
 <afuAjeWepSkzO12O@wunner.de> <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>
 <afwUkP1P-HNfMulV@wunner.de> <8a7cf3f6-07e4-4d12-a2ac-72de02a03eb9@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <8a7cf3f6-07e4-4d12-a2ac-72de02a03eb9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/26 00:03, Mario Limonciello wrote:
> 
> 
> On 5/6/26 23:26, Lukas Wunner wrote:
>> On Wed, May 06, 2026 at 02:16:10PM -0500, Mario Limonciello wrote:
>>> On 5/6/26 12:55, Lukas Wunner wrote:
>>>> Moreover there are products where Presence Detect is hardwired to zero,
>>>> see commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect 
>>>> hardwired
>>>> to zero").  So we have to rely on a link change to detect that a new 
>>>> device
>>>> has been plugged in after slot poweroff.  That won't work if the 
>>>> link is
>>>> disabled.
>>>
>>> How would you feel about turning off link detect somewhere specific 
>>> to the
>>> shutdown path?
>>
>> I *think* shutdown is performed bottom-up in the hierarchy and so
>> this might work.  But it's not great to introduce such a change
>> for everyone just because a single product needs it. 
> 
> Generally speaking I'm not a fan of Linux changing hardware state and 
> not cleaning up after itself at shutdown.  This can lead to weird 
> behaviors for power consumption, wakeups, or inconsistent init across a 
> kexec vs warm reboot vs cold reboot (that BIOS had a chance to swing 
> it's hammer).
> 
>> It would
>> be better to root-cause the issue. 
> 
> I'll see if we can figure out what's happening with traces on a USB 
> analyzer.  But FWIW it's a Linux only issue :/
> 
>> Maybe the vendor is able to
>> provide a BIOS update which resolves it?
>>
> 
> Given it's Linux only issue; unlikely.

I'm happy to share that we figured out why it was only happening on 
Linux by comparing the traces.  The USB4 CM on Windows issues issues a 
downstream port reset during the tear down process.  This is missing 
from Linux.

This patch helps it.

https://lore.kernel.org/linux-usb/20260603180146.3949001-1-Basavaraj.Natikar@amd.com/
