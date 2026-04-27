Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846E3B388F;
	Mon, 27 Apr 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299271; cv=none; b=r0RGFXlHXtLblkNG8kBdJ35g5WWOOnNs5C+ha7IABHhD70y3o2RY0huDL9CGxdcPN1/XLolMMscyViR2bGS/GlbA8zJp0+Jo8b7PEmd/Ar2JWiJYH9ZbvATNHJkhiwgzNQ6ocYd/QC37jLxJ9rU57n+WILjL0ZSEujKzP0Zla8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299271; c=relaxed/simple;
	bh=On7qwBANiqEaPQGbTVETe24hmuBF1r9IigiTMeiamL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0aRtDsNwk1jEo+qRjyhHg2PDImNmqVgc1nb0U8HbXjkicvQzY1P0hCstZJ14nQmLvuCYUk+j3B01RCPgsP7hAV4McgaDqPbSwQ/6MkmLozFL5cas4AG5Fbg3v/WEHuqXlpApLu2j56AcK9Vez/91Og1VOdrdIrLUq9NwlB/PlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW117Hex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW117Hex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3FDC19425;
	Mon, 27 Apr 2026 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777299270;
	bh=On7qwBANiqEaPQGbTVETe24hmuBF1r9IigiTMeiamL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eW117Hexek8S0yFBftTL9eFMoR4R7yUw52gw0nvs3tz3R0OPyMKRkpt30Q7YFenWD
	 gfzaJaEIT8RDuM1mCCQN5Oe8vhf+xcEcHZiJGf5PxzfZIB5FR/LsbOrGLmOzldvuDe
	 O0jCUT/WnRqVVDvMnm9QgEhNYhOFqAvhx9ZTc/hIMIAZhjD2EYxMLDUJLXSxtZSwXp
	 Y8dFcXw3zkqzisjgo/Qig1PgUA9MIaQ1JtIa1wcuCOs4wHu5qz43XaaX73HeQwHxo/
	 9NYBLx6lIzEgzg/2EDDnFJIF52VC+qxp0yRrGpG5cwiVE7i+upBzvW5A2/EyhiDjQ1
	 Wy78HIgjCcARQ==
Message-ID: <ca274454-b58b-4837-a3fd-14ef30c24510@kernel.org>
Date: Mon, 27 Apr 2026 09:14:29 -0500
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
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/27/26 07:20, Rafael J. Wysocki wrote:
> On Mon, Apr 27, 2026 at 5:53 AM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
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
>>
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
> 
> It would be good to CC this to linux-pm.

Sure thing - if there is a need for a v2, I will include linux-pm in CC.
