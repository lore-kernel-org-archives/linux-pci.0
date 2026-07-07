Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C915A79B;
	Tue,  7 Jul 2026 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396927; cv=none; b=mpG7wchanOHGC/KIFjT0LYAYHmbzPS0Vc7pxuqA5VUo6rVF6ItmuR5Zx7MPFwb3lB6CWv+V4ZpmBrnUYmdgM00ORthM9RacnaJiYtbjNr3cz2aRPMQzd0fmlIBd7ctRXiFJg64Yj7bX7Xm2WtZrJsIExpO9vr0zCNkU2RCFGUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396927; c=relaxed/simple;
	bh=rrTjPaS2VuGX2EX0QEgMe0jJyJevVf6CcWTwUy6ynvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4KEQlw9ZhERnnTYRM41H4gUhb6I2k7PXITsJvjLjZQdF5IkTLjNPC9RPlJjj7sbUs20dt+r70u2z02JgMHGeHwm95DlUb2PZDzTii1HCeL9NHp6l44l8MaDcHm+0HtedIGmxPloh3xkxBaWwjxhmW2bT6xWAjV3PzeV9Ln9Xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN0puGmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN0puGmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D38F1F000E9;
	Tue,  7 Jul 2026 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783396926;
	bh=UlXKPBRNLT/eZizFXK8AS9t1rNfqyZVjlnEjM4Ka4Zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WN0puGmZfnwSrJJhoEzSkG/IxbcSwIJxflswk9MKjmWh6pB0x9E3q5t8IlARrGj0u
	 n5QgEvGx92Vls5TBUX89gw3lfTG7ShkhiYX1qbsZjN26CqRZNm1YnNyg6qvdO8cPUM
	 paP6dVUj6qYyZAvHpMGqn5IZWeTj3npQrULaSz2W84mo7+QA9qDNHERgz4mBf7Or99
	 6PEuF3KxVa+ARUuK4ZuU9Vd8AeECxWSAlJq70sI5MKiv4Pr6xVgcUlmTkYyGTIMwbV
	 pxr3VE8iucTZXSfctQkRC1VAzo0wpl7ZGutYshIebbKhnLQ/hbO1idarwz4dIJp7lb
	 8f7SPvPZtIDaA==
Message-ID: <e002b48f-fda8-45b3-bff7-07f1318f2d67@kernel.org>
Date: Mon, 6 Jul 2026 23:02:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
To: Borislav Petkov <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Aaron Ma <aaron.ma@canonical.com>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
 <5ef1c84d-729e-4b9d-a3e4-dc20d8242982@amd.com>
 <a23f2003-4ceb-4307-a469-dc683e6eb0f0@amd.com>
 <20260707035645.GAakx4_XEpHpSFBYzn@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707035645.GAakx4_XEpHpSFBYzn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/26 10:56 PM, Borislav Petkov wrote:
> On Mon, Jul 06, 2026 at 12:47:39PM -0500, Mario Limonciello wrote:
>> Boris or Bjron,
>>
>> Can you pick this up for fixes?  Here is the lore link.
>>
>> https://lore.kernel.org/linux-pci/20260623141505.1816786-1-mario.limonciello@amd.com/
> 
> Sashiko has a question and now that I read it, I wanna know too:
> 
> https://sashiko.dev/#/patchset/20260623141505.1816786-1-mario.limonciello%40amd.com
> 
> :-)
Those systems use the existing boot_vga sysfs file (which is unchanged).

Userspace recognizes both boot_vga for those systems and boot_display 
for modern systems depending upon the use.
