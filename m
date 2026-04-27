Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D810329E6A;
	Mon, 27 Apr 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303189; cv=none; b=uziTuXAzP27OYEP/9kAi8Rp7qnWGukIbDrWt0PoyBV72GLwC4zbGEjboyY+UYUQMxY3nu41r1ygSACf32wgxUazIvERm0prhutqIihTue2kFvQ44akoR/s0Gs2vENN33ROT8LbQdz7djZpyOJDd5gKhJLtbyIhL9eApXSxfRXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303189; c=relaxed/simple;
	bh=+CCNia6QLRVu4q++2o3gSVUUyVRer3bzJMWRMD6aj6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gjod9o5fn9A1TGf1mWzaw9XX7gt/vpDAULyGBQbBNJx938QbRK96grF0+3j6mMPO8VM0qDQzVz+hcRhKmw9UaygogmLRh7AhzO13qRmlH+c9jkAWysukG+EL7UbZtVFsxp2A3u4523l09YmHz1y56j8bWj+uXXz8O2HfDV9wchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhMND0/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhMND0/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7CC2BCB7;
	Mon, 27 Apr 2026 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777303188;
	bh=+CCNia6QLRVu4q++2o3gSVUUyVRer3bzJMWRMD6aj6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PhMND0/pOK7Lep7lrLm/mVJfhd15Hlx5aI5iMC0HPY+bDmj3B2sJTJhOtDNS3LZ1V
	 +2xavLag9Iwa/cqGgftaZlQBJ7k0lp0Bkm8AXznJY0N2jKGCEVAnoE1R4iT46AWz5d
	 mBC+1fnNMD9UdJN+2LepCqBaCEpYkpKMukR3oPOdfNDSbdd4ODoVILLvCmwZKmEk6r
	 t4iE/tR2nGnG5ixGXzYe8wq01s7M5kz1DC7328Izk0jhsBoD+h8rznKl8/rreYyNR5
	 bEk/QVP23rC/EBRt0HK/iGQ5icbdBq9Lq6zvc+xwlIFbMHopgbRhsiN+7X4l2C1zU9
	 FchmKbGaQuXvg==
Message-ID: <286b39c3-f368-4477-bb67-2ce53f62d6a3@kernel.org>
Date: Mon, 27 Apr 2026 10:19:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20260427035341.1425576-1-superm1@kernel.org>
 <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
 <ca274454-b58b-4837-a3fd-14ef30c24510@kernel.org>
 <CAJZ5v0haau7219McDX8d1KhS_ig_nPDVNEV-w0HWMe_nMCjkpg@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0haau7219McDX8d1KhS_ig_nPDVNEV-w0HWMe_nMCjkpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/27/26 10:09, Rafael J. Wysocki wrote:
> On Mon, Apr 27, 2026 at 4:14 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 4/27/26 07:20, Rafael J. Wysocki wrote:
>>> On Mon, Apr 27, 2026 at 5:53 AM Mario Limonciello (AMD)
>>> <superm1@kernel.org> wrote:
>>>>
>>>> A few cycles ago I sent out a kernel series for using the S4 paths when
>>>> the system goes to S5.  Some parts of it got merged, and Rafael suggested
>>>> to split the other parts into smaller pieces across multiple kernel cycles
>>>> to make bisecting easier.
>>>>
>>>> This fell into my backlog behind other things, so I wanted to try again
>>>> this cycle for the PCI pieces. I have been carrying it, rebasing it and
>>>> personally using it for a while now though.
>>>>
>>>> This series attempts to unify the PCI suspend and hibernate paths and to
>>>> fix some things that I observed to be wrong with how I expect hibernate
>>>> to work.
>>>>
>>>> It is based off 7.1-rc1 + Lukas' patch:
>>>> "PCI: Stop setting cached power state to "unknown" on unbind"
>>>>
>>>> Mario Limonciello (AMD) (5):
>>>>     PCI/PM: Disable device wakeups when halting or powering off system
>>>>     PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>>>>     PCI/PM: Run bridge power up actions as part of restore phase
>>>>     PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>>>>     PCI: Put PCIe bridges with downstream devices into D3 at hibernate
>>>>
>>>>    drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-------------
>>>>    1 file changed, 69 insertions(+), 34 deletions(-)
>>>>
>>>> --
>>>
>>> It would be good to CC this to linux-pm.
>>
>> Sure thing - if there is a need for a v2, I will include linux-pm in CC.
> 
> The thing is, you may not know if there's a need for a v2 without resending.

I would think Lukas and Bjorn will at least have some comments and I 
want to give them some time before cluttering inboxes with a second copy 
of the series at the start of the dev cycle.

How about if it looks good to them as is I'll send a v2 with their tags 
added for linux-pm to get a chance to see and review as well.

And if they have feedback I'll incorporate and v2 will also go to linux-pm.
