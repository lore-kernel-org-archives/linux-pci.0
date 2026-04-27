Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC536D500;
	Mon, 27 Apr 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322183; cv=none; b=s9IzgfIL98fz0BM4nQxTeP596Ekf6+kBPMAqfMHN9MGfYaZMfNUOGaYG7WSr38y8UxYnzjE7xkzL3Z1q/fwkuDj1iQu/FI1knw9I9AK1DSKRTHrYCktVY9L5nd+HuMG0Qng2reoXher6tgTXeZIoMqsZ3J3XQsSyfBA2TKF5xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322183; c=relaxed/simple;
	bh=gXVCxCp29EvKmAmHIXJVi8WyJGgDq+yAJEyEZZQ7G0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU2ryujlRwdO+OsJwGvpGgzAaZiCPwn0BWsT8YW8tAombjQncxVwh71wjJq3SSMsXHS1idL3SAhjkMD4ixKiT10hRsSOwo9ZnlDHPFpQShfBf0lZN+b0Agm3XQy4kkjopRZwUw/TuCjM0WH7UovN/9bszn7ljbvdZ9ZvuLCSth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/zpUJn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/zpUJn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C968C19425;
	Mon, 27 Apr 2026 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777322182;
	bh=gXVCxCp29EvKmAmHIXJVi8WyJGgDq+yAJEyEZZQ7G0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n/zpUJn3nhwyt5IZIgsSStvJ8vjQGK3BKpiQL/Oyt1CnoFmGsLKAH03FAAWOw0rXB
	 B9HJpDuuSwBckIaxNfHJFaNdrdvcOe+/se+6w0GIME4a35g5hEqX9zJoHxVkHPeINp
	 wO3rpcubuTX5zBkpNA8USjwa+yij3u+wW7jd+q2PQo8LSTjh7arp+GulqK094eVJRM
	 dW2wQ+zqXWLRUdxJwmAcO3ccmVVV6whMGfYt4vbvRPRkRryzpP1sSBDDr37AFXBz9k
	 3DltREpj04ysCogrG2Ow1JgQRb/YJYLpZ1IH/qO9JEbE6BBp4PYyDxiko+Bsq4z1Fn
	 p3AZMN6KkveWQ==
Message-ID: <548b719f-a98f-452f-98d7-1f2b184e0eb3@kernel.org>
Date: Mon, 27 Apr 2026 15:36:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20260427203404.GA182096@bhelgaas>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260427203404.GA182096@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/26 15:34, Bjorn Helgaas wrote:
> On Sun, Apr 26, 2026 at 10:53:36PM -0500, Mario Limonciello (AMD) wrote:
>> A few cycles ago I sent out a kernel series for using the S4 paths when
>> the system goes to S5.  Some parts of it got merged, and Rafael suggested
>> to split the other parts into smaller pieces across multiple kernel cycles
>> to make bisecting easier.
>>
>> This fell into my backlog behind other things, so I wanted to try again
>> this cycle for the PCI pieces. I have been carrying it, rebasing it and
>> personally using it for a while now though.
>>
>> This series attempts to unify the PCI suspend and hibernate paths and to
>> fix some things that I observed to be wrong with how I expect hibernate
>> to work.
>>
>> It is based off 7.1-rc1 + Lukas' patch:
>> "PCI: Stop setting cached power state to "unknown" on unbind"
> 
> Hi Mario, would you mind posting a v2 that includes Lukas' patch, so
> the whole series applies cleanly so Sashiko can go through it?
> 
> I already applied Lukas' patch on pci/pm, but I guess Sashiko can't
> parse that dependency.

Bjorn,

Sure.  I'll repost with his patch front-loaded.  I assume you'll just 
drop that when applying if/when everything else looks good right?

FWIW, I did run review-prompts offline on the series already with Claude 
models so hopefully no new surprises when it runs with Google's models :P

Thanks,

> 
>> Mario Limonciello (AMD) (5):
>>    PCI/PM: Disable device wakeups when halting or powering off system
>>    PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>>    PCI/PM: Run bridge power up actions as part of restore phase
>>    PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>>    PCI: Put PCIe bridges with downstream devices into D3 at hibernate
>>
>>   drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-------------
>>   1 file changed, 69 insertions(+), 34 deletions(-)
>>
>> -- 
>> 2.43.0
>>

