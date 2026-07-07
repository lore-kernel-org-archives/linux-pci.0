Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AC23183F;
	Tue,  7 Jul 2026 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399671; cv=none; b=bgVlrb1aNjeGz4Ibfa3C5E5Wys5Sk1W3gIuSlE9FwCxWxRn4wTXwwvlgR84esvrseZq2ZldnwINwl4L95x3VfGKiHDPuenTQMbtj30tq9WjAvkOkTzWzCCJjnFDrSI36ltDYanVGp4l38Krk4OQZ8fm5spe+YLFKidbc+VigoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399671; c=relaxed/simple;
	bh=ifFGdeqY00HVOr2v9BqDKzA6ZY8Sie+nu/tWUYqyiQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uScV3syaVp+vnnj3DdR2Shv+ma7AjcRAxjPR3K7I40FQIwnYLn3ybqeDz3BPxbGzBbd1AnApaYSWrwDOVjwH7Y12MT8MNVJvCOq/n8k5Alj8hkee+ar4NZGvriIRUuVvqHO2Ah6ItpjEz/ZmFzuZBI5IyEdGRSQUbBJ1f9pAbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2DeJlnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2DeJlnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746651F000E9;
	Tue,  7 Jul 2026 04:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399670;
	bh=oabd+djVBa49YUb4bAeaTeD/TLGv7UcX0wBT2L42zV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W2DeJlnx6U237Jmyo6MQNih9be/MjniTaNWO3d2y9lhRfgiAIQY8gJAjhj1gFn7/5
	 /1pvD1Edfd+J/iuC1CKCDThmnhwgy/sGNAaKd0vzuyLmwERhCiXVsuScxHTdTkpt+X
	 u6h7uGKdyxUhjf1UMS0VUMVaoISEy0tQ0mIJSPG9SXnOnOWFR6mOAndk+hsLyB7qZl
	 ior50dRDn4ygWYFKXQ4ODm0OiaC1i+cEnKkWicqIiJZ2JRVBWSQr/5gy+mvuRikory
	 VxNCEjRG9DqzL4L6wjfX40o0PYd+rgl+t0QL7bI5MtSElpUKJNqRXsQxLXvobyB93l
	 H52gosCqhmFDQ==
Message-ID: <f87df9b4-fd6e-45c3-aea7-e76a7995c050@kernel.org>
Date: Mon, 6 Jul 2026 23:47:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Thomas Gleixner <tglx@kernel.org>,
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
 <e002b48f-fda8-45b3-bff7-07f1318f2d67@kernel.org>
 <20260707041852.GBakx-LFXxLiouBLwg@fat_crate.local>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707041852.GBakx-LFXxLiouBLwg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 23:18, Borislav Petkov wrote:
> On Mon, Jul 06, 2026 at 11:02:04PM -0500, Mario Limonciello wrote:
>> Those systems use the existing boot_vga sysfs file (which is unchanged).
>>
>> Userspace recognizes both boot_vga for those systems and boot_display for
>> modern systems depending upon the use.
> 
> You're "explaining" as if I were someone who actually knows anything about
> display gunk. But you need to dumb it down for me so that I can actually
> understand why we're fine here and we don't need to fallback to
> vga_default_device() here, as the LLM has "inferred".
> 
> Thx.
> 

OK, let me try.

So a long time ago there was this sysfs attribute introduced for telling 
which device in the system was used for displaying pre-OS.  It mattered 
when you had multi GPU systems.

It wasn't perfect, but there were enough heuristics put in place that it 
was good enough.

Userspace would take this as a hint and try to set what it thought was 
the primary GPU.  This has implications for power consumption, what is 
used for rendering, all sorts of stuff.

Well the heuristics started to break when we started having display 
adapters that were no longer VGA and those were in multi GPU systems.

Rather than change the heuristics for boot_vga we introduced a new 
attribute boot_display that indicated which device was used for 
displaying.  This is semantically very similar to boot_vga; but it can 
apply to any display adapter.

Because userspace has used boot_vga forever and boot_display was new 
userspace effectively has to support both for two reasons:

1) so that users can mix and match kernels and userspace
2) For the ancient hardware the LLM is complaining about.

So my point here is that even if boot_display fails to be populated on 
anything in your system (such as reasons the LLM called out) you will 
still have boot_vga, and userspace still uses boot_vga.

