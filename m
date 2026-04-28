Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED2283FDD;
	Tue, 28 Apr 2026 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413739; cv=none; b=JNrDzSFeeGxz6PzbiFkNd96iPULJsnBykWSreUjonAplmfkIh4v9R6TlXPasJaZ8rvc6XSgMlp+kcqimCljgwdbgnI+C1gVFYgeo2OB4iOrbqFsOBUGsII3/2uJv4weNDl+gFlPLRchvkehyVvEZZImaxVVq+tbRGA9qddfuiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413739; c=relaxed/simple;
	bh=reyyH5wwWq8MlG3vVwAF0alJYCosTgYwmMI8qLdZkI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFvkynoMO2xpER5M54FTLo7btllgwjQvVZ6rEusQDzHhPGQGGbb0yZPs7dWk4RCqh70nHS1GQvEnMMxCtHjYGjcRBES19nhu6++Z/bNTYEIUOIodnL9O2RTrfW/izpHSClqJ/i1uiN5yUE3qNqe22wi0uziftcPo6dFzsybQnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3r697v0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3r697v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAE3C2BCAF;
	Tue, 28 Apr 2026 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777413738;
	bh=reyyH5wwWq8MlG3vVwAF0alJYCosTgYwmMI8qLdZkI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r3r697v08N9SEH2MNnhR+MDa0+rDzUjV/cgrOe+PbhzvR5+dn7+E5tZPBeHWMWSCc
	 /E2Db/n/iv7oPZPMZeixGVkhLx8u6byv+ohISUfsbM0gWX4GA6Q5poGRjIkmdLHSJl
	 MTTL/sVuJPlVee8y6igxNOl7AfPlK3CmWCkxNpp7OOJowgYxKIZQhiVnHflob9C5Rl
	 b9YAUmjbqKTUJs51AdDGNAdzIKU2HTYt9CLTcGN9+djzCcEmmynMrHDDs8EexgZUmH
	 EKUzJ4SizC4zvAdZop/QQCmclqIRVVVffd7PIqH+xX9m4mZXeBxN3Qy9/uBa3E++zv
	 LkEAeUMZsd1RA==
Message-ID: <ad2c9c0e-96e8-4416-97b2-08f98c2b2d6b@kernel.org>
Date: Tue, 28 Apr 2026 17:02:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Improvements to PCI hibernate path
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pm@vger.kernel.org
References: <20260428215148.GA257618@bhelgaas>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260428215148.GA257618@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 16:51, Bjorn Helgaas wrote:
> On Mon, Apr 27, 2026 at 03:50:18PM -0500, Mario Limonciello (AMD) wrote:
>> A few cycles ago I sent out a kernel series for using the S4 paths when
>> the system goes to S5.  Some parts of it got merged, and Rafael suggested
>> to split the other parts into smaller pieces across multiple kernel cycles
>> to make bisecting easier.
> 
> Thanks for posting this again.  Sashiko had a few questions:
> https://sashiko.dev/#/patchset/20260427205024.254677-1-superm1%40kernel.org
> 
> I didn't look at them in detail, although I did think the ACPI r6.5
> sec 16.1.5 reference was a little bit obscure.  The diagram in sec
> 16.1 certainly implies that wakeups only occur in S1-S4 and not in S5.
> 
> Sec 16.1.5 does mention "Remote Start", which is completely undefined
> by the spec but searching does find sec 7.4.2.6, which clearly says
> the system requires a complete boot when awakened.  Possibly a little
> misleading to refer to Remote Start as "awakening" when it's
> apparently not a "wakeup".
> 
> That section also says "OSPM does not disable wake events
> before setting the SLP_EN bit when entering the S5 system state."

Yeah; especially the comments on patch #2 I'm not in agreement with it.

How exactly do you want to handle the rest of the Sashiko comments?  I 
suppose one option is to copy and paste them all to refute the ones I 
agree or disagree with.

But I was thinking let you and Lukas provide comments and then I'll rev 
for your comments (if necessary) and then ones that I agree with 
Sashiko, ignore the rest.
