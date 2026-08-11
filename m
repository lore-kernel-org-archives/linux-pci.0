Received: from out-2z4y-a152.jellyfish.systems (out-2z4y-a152.jellyfish.systems [198.54.127.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A126339364
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419814; cv=none; b=BZsg6rAd05dv7+hlFsLiZVBBZ5QIM/02ICcUsIBE6gwKxtY6uLY2207KMVsDze4lfXlGKxomzaoT/sbi/TJ8fRAeGUIKd3Qskskq7K4tUJqpSxfKytVIQihJOvvV9uIf4LBrcd160o7nc3eWoH/ouopoAFwKVrA6mvyXWDGaB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419814; c=relaxed/simple;
	bh=c65XIVxzPDmXYhnOxu+4CLneYCx/NqC4hsUWY6xFDsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ht5/c12CVq4hA6HrF2YSnx9m0ups3yGjP/4qFIHPisa9WRmKLGNqGc+D0/JwgEoNUYd5Tp4scnnwYX8iXj0X81Y/8lg8OB5aDevNJ20tSBMeoaOyOGuHoIr32mguavK/ETKrZeW/DUhpMuNx3p6/5g6bTf7lqVaKKcPegGTUoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axtjblog.cc; spf=pass smtp.mailfrom=axtjblog.cc; dkim=pass (2048-bit key) header.d=axtjblog.cc header.i=@axtjblog.cc header.b=ArYuoPq6; arc=none smtp.client-ip=198.54.127.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axtjblog.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axtjblog.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axtjblog.cc header.i=@axtjblog.cc header.b="ArYuoPq6"
Received: from [192.168.1.93] (unknown [23.165.40.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hJyC25PpTz8sXP;
	Tue, 11 Aug 2026 03:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtjblog.cc;
	s=spacemail; t=1786419809;
	bh=i6vgXLPGsSOC07hEfww41Is1KbSJ6qOQkiOxh3WOy+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ArYuoPq60b2VmRF7j5gBZfdirUnQluDPo8LyL3nDRaASLmgnMWrKPdH/nPGNAkzun
	 0xhcQsAtYktkSGbZZ3jGForEh1NGIJM4OjHjAVBnZyvKCBoiem7wsDX3y3k2RbUSCF
	 hHISv40RrbLEfmoEYIKg1z9AqeRtZWr8jrpxOvWUdCtT/JzTT5OTptJhrjthUdNXpg
	 cQBXjfeVDcm9luztJ/8vX7u5r1mivQoY6JtIgZJuOYhblXFdY1YPK3LF+D/5rIhFKy
	 /bLoKG4eDnAJz/7rqJx0Z9yNaiGaM+kuagRJe+177hiuEbfqyEZ2t2skPIa7wiSGpQ
	 O2ZxwSmP/s1lg==
Message-ID: <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc>
Date: Tue, 11 Aug 2026 11:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Andreas Wild <andiwild@gmail.com>, Aoxtj <aoxtj@axtjblog.cc>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-kernel@vger.kernel.org
References: <20260801201244.4421-1-andiwild@gmail.com>
 <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
 <20260808063103.10940-1-andiwild@gmail.com>
Content-Language: en-US
From: Aoxtj <aoxiangtianji@axtjblog.cc>
In-Reply-To: <20260808063103.10940-1-andiwild@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Envelope-From: aoxiangtianji@axtjblog.cc


On 2026/8/8 14:31, Andreas Wild wrote:
> Expected output:
>
> - "diag: pre" gives the error the retrain returned and whether the
>    link was already down at that point.
> - "diag: post DLLLA=1 after <n>ms" would mean the link does come back,
>    just not before pci_device_add() returns and the bus below is
>    scanned.  That would point at the error path needing to wait for
>    DLLLA rather than only for the Link Training bit to clear.
> - "diag: post DLLLA=0 after 1000ms" would mean the link is genuinely
>    down and staying down, which is a different problem and
>    probably a worse one.
>
> One caveat: the poll loop waits up to a second in the error path, so it
> changes timing.  If the diagnostic build happens to boot reliably where
> the plain v3 build did not, that is also worth reporting.
Diagnostic result: link is genuinely down, not recovering.

Tested 7.0.14-8-pve++ (v3 patch + diagnostic patch) on the same machine. 
Boot fails: SK hynix never enumerates on bus 07.

[0.542354] pci 0000:00:02.4: removing 2.5GT/s downstream link speed 
restriction
[1.623696] pci 0000:00:02.4: retraining failed
[1.623701] diag: pre  ret=-110 DLLLA=0 sta=0x9023 ctl2=0x0023
[3.734697] diag: post DLLLA=0 after 1010ms sta=0x9823
[3.734702] diag: post ctl2=0x0021

Sorry for taking so long to reply; I've been a little busy this week. 
Happy to test anything else.
