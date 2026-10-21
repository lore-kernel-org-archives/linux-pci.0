Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584072;
	b=pqmgiZTDFVlvDL/LrOMAygxE0Bih6QRsIUfNf8+We4Bz9gnOZlaxPD6KFznTIKTlEhHL
	 0Riga48VwskNQKpfGtEQ1jwtnKemHqu5svjyCI4vY4T9SUJmhP+9BwG5fyLch6yceXUL3
	 y+kMuHF9UV5GKGWISgfznmJs9HLh15rr9lR2FuR27wpw5XQwXaUdKTlhtF7GmnWIqdj88
	 UPpkEEWC3qJZfPHUNJO+pv9lqDfa1ftHXgWO1n6iQCsCoNd387bGjFAoE78CUVf1u6SL/
	 oWZqfM0AAJkq1nJ5el0rCW9jubdupOhU+tEUzBeOFrckgo4DqKby1m1I4bK3CJVZY6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=lEKtq91QrqvW3Y2km0i9GPLG+sCH8OJnOIVvLe8oxAo=;
	b=3uLv0zV+BHf+mbAdy1m7qCIVu6u53K4+gz8gBw6euYPycv+/H1hTUqrmWWcB3ULCAN60
	 b4l6vcFCCRtbkk7o2TDPe9SAPo2vFE4maccun6BA+leILqo0oGZvZbbyouQca1V+skAZE
	 VaHMiuu+CsRjll6zWjPtY5NORtQq0Nlqg+5IPvxvPkXepquu46mCYdcC5dRXJrcmkBih6
	 X6KCxIAmEDBtNy2bHUDzM9kTPjRGRKA2yzHdI5tZQdUKPUHI6OYEDfceyff8UhTaHpcgj
	 mQJsvHLlUzreHXqmccVAR5pdLmsykTwzQoqrwoxmxtWj8t6D0aZiugZDNeietmLFRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=JuNK4Alj;
	arc=none smtp.remote-ip=188.68.63.162
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55640606A31A;
	Wed, 21 Oct 2026 12:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55640606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=JuNK4Alj
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8nrp2T1Yz46Dx;
	Wed, 21 Oct 2026 13:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792583978;
	bh=H0hq2a/UVp8Z892AiKOsOR/W8WmDxGDNugcwl0/Ckvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JuNK4Alj6qETyCJVmxBrSYv3GK3aInz/r4M+5LCoJa7gtbld3iW9vx7ghBIvuJ9Gg
	 COO3AXu4Vgkj/vTD3NwXjTh9WqyM0iKp+LhLNwLtNs+g0CC1KSBmF1kI2bcX/lW+Mu
	 eyWncwScxd+/NKmTbagxJvjr+kMpd3do7cFeDCPqI7fjtk/XjYgpKsd02BCkX1oh+U
	 0YMoyFNujC/Azh10P+yXm+1QdCrqbXBKz9MxK7V43XLjU12vByypJMQbyhon3J+D6E
	 AlkJBh35QY5Une6wGwIX9PDRkUQcILzD3A4nLw1N5V2KMiajnmOy8fkjIiag7Yy+I0
	 5pyrNV5ZEgVdg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8nrp1k7Pz46DN;
	Wed, 21 Oct 2026 13:59:38 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j8nrn3s5zz8sgW;
	Wed, 21 Oct 2026 13:59:37 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A49885F9B7;
	Wed, 21 Oct 2026 13:59:32 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <144f19b5-7adf-4168-be8c-e82fedfe13a9@leemhuis.info>
Date: Wed, 21 Oct 2026 13:59:31 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Edward Malik <edwardmalik95@icloud.com>, Andreas Wild <andiwild@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, M M <restafvalendergelijke@outlook.com>,
 blaat windows <blaaaat@hotmail.com>
References: <20260801201244.4421-1-andiwild@gmail.com>
 <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
 <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
 <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
 <20260929080109.53944-1-andiwild@gmail.com>
 <c5ee9a34c6b7d3ca96538c9cc2914b603b0dce7e.camel@icloud.com>
 <f9ab8a2d-966f-4e96-b905-116919c5ac7b@leemhuis.info>
 <672f06a2cd0bb380fafeacc5f1731e1f4030f329.camel@icloud.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <672f06a2cd0bb380fafeacc5f1731e1f4030f329.camel@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179258397315.3889052.6744945320187028587@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A49885F9B7
X-NC-CID: EvU9xDEa6hIMWP/5UnQ8mRqDxHOhTZJB0sJFcZ8+hexNBEIVqbU=

On 10/21/26 13:43, Edward Malik wrote:
> On Wed, 2026-10-21 at 10:24 +0200, Thorsten Leemhuis wrote:
>> On 10/21/26 04:23, Edward Malik wrote:
>>> I noticed another reported incident on the CachyOS Discord server:
>>> [1.278083] pci 0000:00:1c.0: retraining failed
>>> System information: https://paste.cachyos.org/p/35d9bd0.log
>>> I'm sharing this in case it helps with investigating the PCIe
>>> retraining regression maybe there is a common denominator among the
>>> hardware 
>>>
>>> Probably will see more now that ubuntu has moved to the new kernel
>>> i
>>> think
>>
>> I don't known about the others, but if you ask me this thread always
>> was
>> confusing, as we ended up discussing two different problems; over
>> time
>> it became even more confusing.  And one of the issues was fixed for
>> 7.3
>> iirc.

I was wrong here, sorry -- the fix for one of the issues discussed in
this thread is still just in next as ff8a969f7dc8e7 ("PCI: Skip Target
Speed quirk on clamped ports with no link").

>> So if you ask me I think it's overdue someone tests if *vanilla* 7.3
>> (not a vendor kernel) is still affected and reports any remaining
>> problems separately anew (e.g. in a new thread) in a way that can be
>> read without reading this thread -- while still briefly dropping a
>> link
>> to this thread for completeness. Afterwards reply here with a link to
>> the new thread.
>
> i think i understand you want to seperate the threads 

I think it's time we get new mailing list threads for any problems that
still remain with ff8a969f7dc8e7, because when you wrote "I noticed
another report" earlioer at least I have no idea which of the two
problems discussed in this thread you mean; but maybe it's better to
start new threads only once 7.4-rc1 is out with testing based on that,
as that will contain the aforementioned and other fixes and likely is a
good new starting point for further discussions.

Ciao, Thorsten
