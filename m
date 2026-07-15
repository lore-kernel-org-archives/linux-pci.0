Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7D2989B0;
	Wed, 15 Jul 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122650; cv=none; b=IuUJ7EryJ+6hw9lo7UNC5g27z6yLl+K6VZ9vsxhULbxWAVAEUSayIgBQepU0uIkq2S16PpZzXICLAfSoMBWy8G9mVfIECh/nhXBpzk1xUvVlnO4VTCftjcKk+k4Pas+mGKXW/Z7msDGFU6mryux2JA+e+xYPIpYm2BEecutR0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122650; c=relaxed/simple;
	bh=C8qL6bot7qQj89yjqrUqfibJA625H6Bwp6pXWCvXhb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cQUUjys+BEnICD1+WOfZRzDGKEzw0gLif0w/seCoSCgRfQ6c7MjpxzGdcCIH4z1KhLt+Re1rGb9caf9myvEZxbAj4uu5KtivQC9gat+0NbtrWj2hDJHzZPSuYT/MBj3ZAnS2FbdtE0E6Rr6rxUvG9APmnUmwPD7hfwkCrP+CCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIXB3t4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIXB3t4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73CC1F000E9;
	Wed, 15 Jul 2026 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784122648;
	bh=yckDuS97heWYk7WOhp8ZperAys9yhtGo+sXu4RbSfh0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=eIXB3t4x+OvL+vU6yYVyNP1hyQtkrBdEWti484RF85k/6GEdK0uk8lVJQ+WARYQFB
	 pHAJqVQZL4LYvk2ANawR0VEmMmoL5ZPylQ0jzEXfCZo1hI5qKaGAGTgtFyNfBpPlpD
	 OKbdrZL1ShTn0TONJBZczzIsP2GZ5pC3DxWeAuYdDbxsMHhqE6nqiujEiQkMKQNJbI
	 4x3lBYEtbBROY6z2VbbXRvCpVexxJK3eW0lzeNlMEGN0ZuQ2pWNsH1C/0f1Ou/dH7f
	 kItua5Y4j8BA2PlBalhXiLHKKfw6LaZ9JGMF20kNBsfpZSyWghL7hBWJh28dw5oIUl
	 1NXUPkwHkCx9g==
Message-ID: <b000fdcb-37ca-4a53-a45e-ea74589f7d63@kernel.org>
Date: Wed, 15 Jul 2026 08:37:26 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] thunderbolt: Quiesce AMD NHI during suspend
Content-Language: en-US
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Yo-Jung Leo Lin <Leo.Lin@amd.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 "S, Sanath" <sanath.s@amd.com>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20260706023422.3647320-1-acelan.kao@canonical.com>
 <2ff2d9b9-12fb-4908-8738-2498b2927571@kernel.org>
 <albapl82ioSBPbp6@acelan-Precision-5480>
 <e78152a9-c6d3-47d9-8657-f5efc2fe69f7@kernel.org>
 <alccavxbVnZGtVU5@acelan-Precision-5480>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <alccavxbVnZGtVU5@acelan-Precision-5480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/26 00:42, Chia-Lin Kao (AceLan) wrote:

>> Thanks for checking.  That code ended up not helping the original issue it
>> was for, a different solution for that issue is being provided.
>>
>> But I'm wondering, is this issue you're working on something to do with
>> pm_async?  Could you turn that off and see if it improves anything?
> 1. echo 0 | sudo /sys/power/pm_async
> 2. sudo systemctl suspend
> 3. plug in the tbt dock
> 4. power indicator shows 3A5W lights and hard hang

I'm not sure what 3A5W lights means.  You'll probably need to check with 
ODM if that's a post code or what it is.  It certainly sounds useful to 
someone.

Are you sure the hang is during resume?  It /sounds/ like it's during 
suspend.

> 
>>
>> Any chance you can get UART output from the system using a debug board over
>> suspend/resume in case there is a panic happening that doesn't flush to
>> NVME?
> No, there is no UART port on the machine for debugging.
> 
Can you please check with ODM about this?  For pre-production systems 
there should be a debug card that can provide UART output so we can 
cross reference that.

Also; does this only happen on this system or you can reproduce on a 
reference system?  If you can reproduce on a reference system UART is 
very easily accessible which would make this easier to debug.
