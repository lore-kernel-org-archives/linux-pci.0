Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C081A23A6;
	Tue,  7 Jul 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428727; cv=none; b=mztm4DDW341DK8wzMLjrF7r6zDpnZgnQ4w9z98whxQiJpf82SCjnovqrH/lwQ4PfM5bV7I6Fu4b9NYza/XOEEA9gjolKsV4FZ9WHJSKsskr9tpC94GcgTqXc3dXElTpL7usEWtfjDVWzgsoEa5XJsEx5gFxK6BSZPAPKoXqslgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428727; c=relaxed/simple;
	bh=tMhbYfnkkoHVjpXmUFo4+iC/xbEwsP4aNJSMWACKQXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4RrIhpK5vEtDr3oPdbaG+AJN/JM5qcrD3nNaibakCmjtm9ni3GWE5KkqkoXZ++iiEoqGzSEbYIjOVa8vTTMq7jgo2mkWUuz1yTw63cjMkeGYZgEjepvkcFxIyPffWoDEjaIMecMFejcbaDJAFvXZ+t4p2nRDRBuZidVoggyDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpIwn08e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpIwn08e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A9D1F000E9;
	Tue,  7 Jul 2026 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783428726;
	bh=3Q2YjIpeM4H+Mpe53uITmAO7KAAh3Uc6jZwsOHJdNHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MpIwn08eevhywwY+WeWLWmHCkh6gpkd9MPauoiLWArBLdIhAm2TJOcd5QFJFQ6sWQ
	 Ekbh9vRgmWixJumF8d1evkrVacrn1bPBqARx1C+xQuPh1igF2tKXY+0cAPNca22fx0
	 YNXF0oQG1anRPiQPpZNjK/2wCt4+6BgarkOEArgTEMHna7fz3BfHJOcTwsz0F8H3RD
	 zGyzMQY01Bbb9Qe88iqA+89CLHoM4lV8haDxzuYqmqtE7P7SxnKGVv1sSl1JlYNdfz
	 C2jrlVRfRYQ8IFrp74xKw+hI01TdWL6giyOf8VRwS3XbS4lemZjrmXGk8iaHNSS6CP
	 OVKkhs8jxhOvg==
Message-ID: <192c46c7-dcab-432b-a2bf-191c8729bb6e@kernel.org>
Date: Tue, 7 Jul 2026 07:52:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
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
 <f87df9b4-fd6e-45c3-aea7-e76a7995c050@kernel.org>
 <20260707050104.GCakyIEMSp5SXvf52F@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707050104.GCakyIEMSp5SXvf52F@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/26 12:01 AM, Borislav Petkov wrote:
> On Mon, Jul 06, 2026 at 11:47:48PM -0500, Mario Limonciello wrote:
>> So my point here is that even if boot_display fails to be populated on
>> anything in your system (such as reasons the LLM called out) you will still
>> have boot_vga, and userspace still uses boot_vga.
> 
> Aha, ok. Thanks for taking the time - that does make more sense.
> 
> So looking at Fixes: I presume you want me to send this to Linus now so that
> it goes to stable too?
> 

Yes, please.
